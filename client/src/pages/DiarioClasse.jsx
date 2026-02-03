import { useEffect, useState, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import {
  getTurmaById, getAlunosMatriculados, registrarAula,
  getHistoricoAulas, deleteAula, updateAula, getFrequenciaAula
} from '../services/sysconex';
import {
  ArrowLeft, Calendar, UserCheck, Save, BookOpen,
  CheckCircle, XCircle, AlertCircle, Clock, Trash2, Edit, X
} from 'lucide-react';

export default function DiarioClasse() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useContext(AuthContext);

  const [turma, setTurma] = useState(null);
  const [alunos, setAlunos] = useState([]);
  const [loading, setLoading] = useState(true);

  // ABAS: 'novo' | 'historico'
  const [abaAtiva, setAbaAtiva] = useState('novo');

  // --- ESTADOS DE NOVO REGISTRO ---
  const [conteudo, setConteudo] = useState("");
  const [dataAula, setDataAula] = useState(new Date().toISOString().split('T')[0]);
  const [mapaPresenca, setMapaPresenca] = useState({});
  const [observacoes, setObservacoes] = useState({});

  // --- ESTADOS DE HISTÓRICO ---
  const [historico, setHistorico] = useState([]);

  // --- ESTADOS DE EDIÇÃO/VISUALIZAÇÃO (Modal) ---
  const [modalOpen, setModalOpen] = useState(false);
  const [modalMode, setModalMode] = useState('view'); // 'view' or 'edit'
  const [aulaEditando, setAulaEditando] = useState(null); // ID da aula

  const [editConteudo, setEditConteudo] = useState("");
  const [editDataAula, setEditDataAula] = useState("");
  const [editMapaPresenca, setEditMapaPresenca] = useState({});
  const [editObservacoes, setEditObservacoes] = useState({});


  useEffect(() => {
    carregarDadosIniciais();
  }, [id]);

  useEffect(() => {
    if (abaAtiva === 'historico') {
      carregarHistorico();
    }
  }, [abaAtiva]);

  async function carregarDadosIniciais() {
    try {
      const [dadosTurma, dadosMatriculas] = await Promise.all([
        getTurmaById(id),
        getAlunosMatriculados(id)
      ]);

      setTurma(dadosTurma);
      const listaMatriculas = dadosMatriculas.data || [];

      const alunosFormatados = listaMatriculas.map(item => ({
        id: item.matricula_id,
        nome: item.nome_completo,
        cpf: item.cpf,
        beneficiario_id: item.beneficiario_id
      }));

      setAlunos(alunosFormatados);

      // Inicializa Presença Default
      const presencaInicial = {};
      alunosFormatados.forEach(a => presencaInicial[a.id] = 'Presente');
      setMapaPresenca(presencaInicial);

    } catch (error) {
      console.error(error);
      alert("Erro ao carregar dados da turma.");
    } finally {
      setLoading(false);
    }
  }

  async function carregarHistorico() {
    try {
      const dados = await getHistoricoAulas(id);
      // A API de histórico retorna { data: [...], pagination... }
      setHistorico(dados.data || []);
    } catch (error) {
      console.error("Erro ao carregar histórico", error);
    }
  }

  // --- AÇÕES DE REGISTRO (NOVA AULA) ---
  async function handleSalvarNovo() {
    if (!conteudo) return alert("Por favor, informe o conteúdo da aula.");

    try {
      const listaFinal = Object.keys(mapaPresenca).map(matriculaId => ({
        matricula_id: Number(matriculaId),
        status: mapaPresenca[matriculaId],
        observacao: observacoes[matriculaId] || null
      }));

      const payload = {
        professor_id: user.id || user.user?.id,
        data_aula: dataAula,
        conteudo: conteudo,
        lista_presenca: listaFinal
      };

      await registrarAula(id, payload);

      alert("✅ Aula registrada com sucesso!");
      // Limpa form ou redireciona pro histórico
      setConteudo("");
      setMapaPresenca(prev => {
        const reset = {};
        alunos.forEach(a => reset[a.id] = 'Presente');
        return reset;
      });
      setObservacoes({});
      setAbaAtiva('historico'); // Vai para o histórico ver a aula criada

    } catch (error) {
      alert(`Erro: ${error.message || "Erro ao salvar"}`);
    }
  }

  // --- AÇÕES DO HISTÓRICO ---
  async function handleDelete(aulaId) {
    if (!confirm("Tem certeza que deseja excluir esta aula? Isso apagará o registro de frequência também.")) return;
    try {
      await deleteAula(aulaId);
      alert("Aula excluída.");
      carregarHistorico();
    } catch (error) {
      alert("Erro ao excluir aula.");
    }
  }

  async function handleOpenModal(aula, mode) {
    setAulaEditando(aula.id);
    setModalMode(mode);
    setEditDataAula(aula.data_aula.split('T')[0]); // Ajusta data
    setEditConteudo(aula.conteudo);
    setModalOpen(true);

    // Carrega frequência dessa aula
    try {
      const frequencia = await getFrequenciaAula(aula.id);
      // frequencia é array [{ status, nome_completo, cpf }]...
      // Mas precisamos mapear para matricula_id -> status.
      // O endpoint getFrequenciaAula NÃO RETORNA matricula_id no SELECT atual (linha 640 do server).
      // PRECISAREMOS AJUSTAR O BACKEND OU o frontend service.
      // VAMOS SUPOR QUE JÁ VEM 'matricula_id' (Vou verificar e ajustar se precisar, mas vamos assumir que farei map pelo cpf ou nome se falhar, ou melhor, corrigir backend depois).
      // CORREÇÃO IMEDIATA: O endpoint getFrequenciaAula precisa retornar matricula_id.

      // Mapeando com o que temos (alunos da turma atual x nome/cpf da frequencia)
      // Isso é frágil se houver homônimos, mas vamos tentar. 
      // O ideal é a query retornar matricula_id. O endpoint server linha 640 traz: f.status, p.nome_completo, p.cpf. Faltou m.id as matricula_id.

      // Vou assumir que vou corrigir o backend rapidinho ou usar o que tem. 
      // Vamos fazer o match por CPF com a lista de alunos 'alunos'.

      const novoMapa = {};
      const novaObs = {}; // Endpoint tbm nao traz observacao linha 640.

      // Como o backend atual não devolve matricula_id nem observacao na rota de detalhes frequencia, 
      // a edição vai ficar capenga se eu não corrigir a rota GET /aulas/:id/frequencia.
      // VOU INCLUIR NO PLANO CORRIGIR ISSO AGORA.

      // Mas para não travar, vou montar a lógica esperando os campos certos.
      frequencia.forEach(f => {
        // Encontra aluno pelo CPF
        const alunoEncontrado = alunos.find(a => a.cpf === f.cpf);
        if (alunoEncontrado) {
          novoMapa[alunoEncontrado.id] = f.status;
          novaObs[alunoEncontrado.id] = f.observacao; // Precisa vir do back
        }
      });

      // Quem não estava na lista da aula (ex: entrou depois), defino como presente ou ausente? 
      // Melhor deixar null ou presente padrão.
      alunos.forEach(a => {
        if (!novoMapa[a.id]) novoMapa[a.id] = 'Presente';
      });

      setEditMapaPresenca(novoMapa);
      setEditObservacoes(novaObs);

    } catch (error) {
      console.error("Erro ao carregar frequência", error);
    }
  }

  async function handleSalvarEdicao() {
    try {
      const listaFinal = Object.keys(editMapaPresenca).map(matriculaId => ({
        matricula_id: Number(matriculaId),
        status: editMapaPresenca[matriculaId],
        observacao: editObservacoes[matriculaId] || null
      }));

      const payload = {
        data_aula: editDataAula,
        conteudo: editConteudo,
        lista_presenca: listaFinal
      };

      await updateAula(aulaEditando, payload);
      alert("Aula atualizada!");
      setModalOpen(false);
      carregarHistorico();

    } catch (error) {
      alert("Erro ao atualizar: " + error.message);
    }
  }


  if (loading) return <div className="p-8 text-center"><div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-600 mx-auto"></div></div>;

  return (
    <div className="animate-fade-in max-w-6xl mx-auto pb-10">

      {/* HEADER E TABS */}
      <div className="mb-6">
        <button onClick={() => navigate('/app/minhas-turmas')} className="flex items-center text-gray-500 hover:text-blue-600 mb-4 transition-colors text-sm font-medium">
          <ArrowLeft size={18} className="mr-1" /> Voltar para Minhas Turmas
        </button>

        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
              <BookOpen className="text-blue-600" />
              Diário de Classe: {turma?.nome}
            </h1>
            <p className="text-gray-500 text-sm mt-1">
              Professor: {user?.pessoa?.nome_completo || user?.nome}
            </p>
          </div>

          {/* TABS */}
          <div className="bg-gray-100 p-1 rounded-lg flex space-x-1">
            <button
              onClick={() => setAbaAtiva('novo')}
              className={`px-4 py-2 rounded-md text-sm font-bold transition-all flex items-center gap-2
                    ${abaAtiva === 'novo' ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
            >
              <Edit size={16} /> Novo Registro
            </button>
            <button
              onClick={() => setAbaAtiva('historico')}
              className={`px-4 py-2 rounded-md text-sm font-bold transition-all flex items-center gap-2
                    ${abaAtiva === 'historico' ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
            >
              <Clock size={16} /> Histórico de Aulas
            </button>
          </div>
        </div>
      </div>

      {/* CONTEÚDO DA ABA: NOVO REGISTRO */}
      {abaAtiva === 'novo' && (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 animate-fade-in">
          {/* Formuário Lateral */}
          <div className="lg:col-span-1 space-y-4">
            <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100">
              <h3 className="font-bold text-gray-700 mb-4 flex items-center gap-2">
                <Calendar size={18} /> Detalhes da Aula
              </h3>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-600 mb-1">Data</label>
                  <input
                    type="date"
                    className="w-full border p-2 rounded focus:ring-2 ring-blue-500 outline-none text-gray-700"
                    value={dataAula}
                    onChange={e => setDataAula(e.target.value)}
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-600 mb-1">Conteúdo Ministrado</label>
                  <textarea
                    rows="8"
                    className="w-full border p-2 rounded focus:ring-2 ring-blue-500 outline-none resize-none text-gray-700"
                    placeholder="Descreva o que foi ensinado hoje..."
                    value={conteudo}
                    onChange={e => setConteudo(e.target.value)}
                  />
                </div>
              </div>
            </div>

            <button
              onClick={handleSalvarNovo}
              className="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-xl font-bold shadow-lg shadow-blue-200 flex items-center justify-center gap-2 transition-all transform active:scale-95"
            >
              <Save size={20} /> Salvar Diário
            </button>
          </div>

          {/* Lista de Chamada */}
          <div className="lg:col-span-2">
            <ListaChamada
              alunos={alunos}
              mapaPresenca={mapaPresenca}
              setMapaPresenca={setMapaPresenca}
              observacoes={observacoes}
              setObservacoes={setObservacoes}
            />
          </div>
        </div>
      )}

      {/* CONTEÚDO DA ABA: HISTÓRICO */}
      {abaAtiva === 'historico' && (
        <div className="animate-fade-in space-y-4">
          {historico.length === 0 ? (
            <div className="bg-white p-12 rounded-xl text-center shadow-sm border border-gray-100">
              <Clock size={48} className="mx-auto text-gray-300 mb-4" />
              <p className="text-gray-500">Nenhuma aula registrada nesta turma ainda.</p>
            </div>
          ) : (
            historico.map(aula => (
              <div key={aula.id} className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 flex flex-col md:flex-row justify-between items-start md:items-center gap-4 hover:shadow-md transition-shadow">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-1">
                    <span className="bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded">
                      {new Date(aula.data_aula).toLocaleDateString('pt-BR')}
                    </span>
                    <span className="text-gray-400 text-xs flex items-center gap-1">
                      <UserCheck size={12} /> {aula.presentes} Presentes / {aula.ausentes} Ausentes
                    </span>
                  </div>
                  <p className="text-gray-800 font-medium line-clamp-2 md:line-clamp-1">{aula.conteudo}</p>
                  <p className="text-xs text-gray-500 mt-1">Registrado por: {aula.professor_nome}</p>
                </div>
                <div className="flex items-center gap-2 self-end md:self-auto">
                  <button
                    onClick={() => handleOpenModal(aula, 'view')}
                    className="p-2 text-gray-600 hover:bg-gray-100 rounded-lg transition-colors flex items-center gap-1 text-sm font-bold"
                    title="Visualizar"
                  >
                    <BookOpen size={18} />
                  </button>
                  <button
                    onClick={() => handleOpenModal(aula, 'edit')}
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors flex items-center gap-1 text-sm font-bold"
                  >
                    <Edit size={16} /> Editar
                  </button>
                  <button
                    onClick={() => handleDelete(aula.id)}
                    className="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors"
                    title="Excluir aula"
                  >
                    <Trash2 size={18} />
                  </button>
                </div>
              </div>
            ))
          )}
        </div>
      )}

      {/* MODAL DE EDIÇÃO / VISUALIZAÇÃO */}
      {modalOpen && (
        <div className="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4 backdrop-blur-sm animate-fade-in">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-5xl h-[90vh] flex flex-col overflow-hidden">
            <div className="p-5 border-b flex justify-between items-center bg-gray-50">
              <h3 className="font-bold text-xl text-gray-800 flex items-center gap-2">
                {modalMode === 'edit' ? <Edit className="text-blue-600" /> : <BookOpen className="text-gray-600" />}
                {modalMode === 'edit' ? 'Editando Aula' : 'Detalhes da Aula'}
              </h3>
              <button onClick={() => setModalOpen(false)} className="p-2 hover:bg-gray-200 rounded-full transition-colors">
                <X size={24} className="text-gray-500" />
              </button>
            </div>

            <div className="flex-1 overflow-y-auto p-6 bg-gray-50/50">
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div className="lg:col-span-1 space-y-4">
                  <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100">
                    <label className="block text-sm font-medium text-gray-600 mb-1">Data</label>
                    <input
                      type="date"
                      className="w-full border p-2 rounded mb-4 disabled:bg-gray-100 disabled:text-gray-500"
                      value={editDataAula}
                      onChange={e => setEditDataAula(e.target.value)}
                      disabled={modalMode === 'view'}
                    />
                    <label className="block text-sm font-medium text-gray-600 mb-1">Conteúdo</label>
                    <textarea
                      rows="10"
                      className="w-full border p-2 rounded resize-none disabled:bg-gray-100 disabled:text-gray-500"
                      value={editConteudo}
                      onChange={e => setEditConteudo(e.target.value)}
                      disabled={modalMode === 'view'}
                    />
                  </div>
                </div>
                <div className="lg:col-span-2">
                  <ListaChamada
                    alunos={alunos}
                    mapaPresenca={editMapaPresenca}
                    setMapaPresenca={setEditMapaPresenca}
                    observacoes={editObservacoes}
                    setObservacoes={setEditObservacoes}
                    readOnly={modalMode === 'view'}
                  />
                </div>
              </div>
            </div>

            <div className="p-5 border-t bg-white flex justify-end gap-3">
              <button onClick={() => setModalOpen(false)} className="px-5 py-2 text-gray-600 font-bold hover:bg-gray-100 rounded-lg">
                Fechar
              </button>
              {modalMode === 'edit' && (
                <button onClick={handleSalvarEdicao} className="px-5 py-2 bg-blue-600 text-white font-bold rounded-lg hover:bg-blue-700 shadow-lg shadow-blue-200">
                  Salvar Alterações
                </button>
              )}
            </div>
          </div>
        </div>
      )}

    </div>
  );
}

// Sub-componente para Lista de Chamada (Reutilizável)
function ListaChamada({ alunos, mapaPresenca, setMapaPresenca, observacoes, setObservacoes, readOnly = false }) {
  function setStatus(id, status) {
    if (readOnly) return;
    setMapaPresenca(prev => ({ ...prev, [id]: status }));
  }

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col h-full">
      <div className="p-4 border-b bg-gray-50 flex justify-between items-center sticky top-0 z-1">
        <h3 className="font-bold text-gray-700 flex items-center gap-2">
          <UserCheck size={18} className="text-blue-600" /> Chamada
        </h3>
        <div className="flex gap-2 text-[10px] md:text-xs font-bold">
          <span className="flex items-center gap-1 text-green-700 bg-green-50 px-2 py-1 rounded">P=Presente</span>
          <span className="flex items-center gap-1 text-red-700 bg-red-50 px-2 py-1 rounded">F=Falta</span>
          <span className="flex items-center gap-1 text-yellow-700 bg-yellow-50 px-2 py-1 rounded">J=Justific</span>
        </div>
      </div>

      <div className="p-2 overflow-y-auto max-h-[600px] space-y-2">
        {alunos.length === 0 ? (
          <div className="text-center py-10 text-gray-400">Nenhum aluno matriculado.</div>
        ) : (
          alunos.map(aluno => {
            const status = mapaPresenca[aluno.id];
            return (
              <div key={aluno.id} className={`flex flex-col border rounded-lg bg-white mb-2 ${!readOnly && 'hover:border-blue-200'} transition-colors`}>
                <div className="flex items-center justify-between p-3">
                  <div className="flex items-center gap-3">
                    {status === 'Presente' && <CheckCircle size={20} className="text-green-500" />}
                    {status === 'Ausente' && <XCircle size={20} className="text-red-500" />}
                    {status === 'Justificado' && <AlertCircle size={20} className="text-yellow-500" />}

                    <div className="flex flex-col">
                      <span className={`font-medium text-sm md:text-base ${status === 'Ausente' ? 'text-gray-400 line-through' : 'text-gray-700'}`}>
                        {aluno.nome}
                      </span>
                    </div>
                  </div>

                  <div className={`flex bg-gray-100 p-1 rounded-lg ${readOnly ? 'opacity-70 pointer-events-none' : ''}`}>
                    <button onClick={() => setStatus(aluno.id, 'Presente')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Presente' ? 'bg-white text-green-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>P</button>
                    <button onClick={() => setStatus(aluno.id, 'Ausente')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Ausente' ? 'bg-white text-red-500 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>F</button>
                    <button onClick={() => setStatus(aluno.id, 'Justificado')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Justificado' ? 'bg-white text-yellow-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>J</button>
                  </div>
                </div>
                {status === 'Justificado' && (
                  <div className="px-3 pb-3 pl-10">
                    <input
                      type="text"
                      placeholder="Motivo..."
                      className="w-full text-sm border-b border-gray-300 focus:border-yellow-500 outline-none py-1 bg-transparent text-gray-600 placeholder-gray-400 disabled:text-gray-500"
                      value={observacoes[aluno.id] || ''}
                      onChange={(e) => setObservacoes(prev => ({ ...prev, [aluno.id]: e.target.value }))}
                      disabled={readOnly}
                    />
                  </div>
                )}
              </div>
            );
          })
        )}
      </div>
    </div>
  );
}
