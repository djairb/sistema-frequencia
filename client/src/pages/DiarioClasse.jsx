import { useState, useEffect, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import ModalHistoricoAluno from '../components/ModalHistoricoAluno';
import { AuthContext } from '../contexts/auth';
import {
  getTurmaById, getAlunosMatriculados, registrarAula,
  getHistoricoAulas, deleteAula, updateAula, getFrequenciaAula, getTurmaEstatisticas
} from '../services/sysconex';
import {
  ArrowLeft, Calendar, UserCheck, Save, BookOpen,
  CheckCircle, XCircle, AlertCircle, Clock, Trash2, Edit, X, BarChart2,
  Image as ImageIcon, UploadCloud
} from 'lucide-react';
import { useDropzone } from 'react-dropzone';
import imageCompression from 'browser-image-compression';
import { uploadFotosAula, getFotosAula, deleteFotoAula } from '../services/sysconex';

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

  // --- ESTADOS DE ESTATÍSTICAS ---
  const [estatisticas, setEstatisticas] = useState(null);

  // --- ESTADOS DE FOTOS ---
  const [fotosNovas, setFotosNovas] = useState([]); // Array de Files para upload
  const [galeria, setGaleria] = useState([]); // Array de fotos vindas do banco
  const [uploading, setUploading] = useState(false);

  // --- HANDLERS DE FOTOS ---
  const onDrop = async (acceptedFiles) => {
    const options = {
      maxSizeMB: 1,
      maxWidthOrHeight: 1920,
      useWebWorker: true
    };

    const compressedFiles = await Promise.all(acceptedFiles.map(async (file) => {
      try {
        return await imageCompression(file, options);
      } catch (error) {
        console.error("Erro na compressão:", error);
        return file; // Se falhar, usa o original
      }
    }));

    // Se estiver no MODAL (editando), já sobe direto
    if (modalOpen) {
      await handleUploadDireto(compressedFiles);
    } else {
      // Se estiver criando, guarda no state para subir depois
      setFotosNovas(prev => [...prev, ...compressedFiles]);
    }
  };

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: { 'image/*': [] },
    multiple: true
  });

  async function handleUploadDireto(files) {
    if (!aulaEditando) return;
    setUploading(true);
    try {
      for (const file of files) {
        const formData = new FormData();
        formData.append('foto', file);
        await uploadFotosAula(aulaEditando, formData);
      }
      // Atualiza a galeria
      const novasFotos = await getFotosAula(aulaEditando);
      setGaleria(novasFotos);
      alert("Fotos enviadas com sucesso!");
    } catch (error) {
      console.error(error);
      alert("Erro ao enviar fotos.");
    } finally {
      setUploading(false);
    }
  }

  async function handleDeleteFoto(fotoId) {
    if (!confirm("Deseja excluir esta foto permanentemente?")) return;
    try {
      await deleteFotoAula(fotoId);
      setGaleria(prev => prev.filter(f => f.id !== fotoId));
    } catch (error) {
      alert("Erro ao excluir foto.");
    }
  }

  // Remove da lista temporária (antes de subir)
  function removeFotoNova(index) {
    setFotosNovas(prev => prev.filter((_, i) => i !== index));
  }

  useEffect(() => {
    if (abaAtiva === 'estatisticas') {
      carregarEstatisticas();
    }
  }, [abaAtiva]);

  async function carregarEstatisticas() {
    try {
      const dados = await getTurmaEstatisticas(id);
      setEstatisticas(dados);
    } catch (error) {
      console.error("Erro ao carregar estatísticas", error);
    }
  }

  // Ordenar alunos por NOME (Alfabética)
  const alunosOrdenados = estatisticas?.alunos
    ? [...estatisticas.alunos].sort((a, b) => a.nome_completo.localeCompare(b.nome_completo))
    : [];

  const totalRegistros = estatisticas ? (estatisticas.total_presencas + estatisticas.total_faltas) : 0;
  const percPresencaGeral = totalRegistros > 0
    ? ((estatisticas.total_presencas / totalRegistros) * 100).toFixed(1)
    : 0;


  // --- ESTADOS DE EDIÇÃO/VISUALIZAÇÃO (Modal) ---
  const [modalOpen, setModalOpen] = useState(false);
  const [modalMode, setModalMode] = useState('view'); // 'view' or 'edit'
  const [aulaEditando, setAulaEditando] = useState(null); // ID da aula

  const [alunoHistorico, setAlunoHistorico] = useState(null); // Para modal de histórico individual

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

      const novaAula = await registrarAula(id, payload);

      // --- UPLOAD DAS FOTOS ---
      if (fotosNovas.length > 0) {
        setUploading(true);
        try {
          for (const file of fotosNovas) {
            const formData = new FormData();
            formData.append('foto', file);
            await uploadFotosAula(novaAula.id, formData);
          }
        } catch (uploadError) {
          console.error("Erro no upload de fotos:", uploadError);
          alert("Aula criada, mas houve erro ao enviar algumas fotos.");
        } finally {
          setUploading(false);
        }
      }

      alert("✅ Aula registrada com sucesso!");
      // Limpa form ou redireciona pro histórico
      setConteudo("");
      setFotosNovas([]); // Limpa fotos
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

  // Estado para lista combinada (ativos + históricos)
  const [alunosParaEdicao, setAlunosParaEdicao] = useState([]);

  async function handleOpenModal(aula, mode) {
    setAulaEditando(aula.id);
    setModalMode(mode);
    setEditDataAula(aula.data_aula.split('T')[0]);
    setEditConteudo(aula.conteudo);
    setModalOpen(true);
    setAlunosParaEdicao([]); // Reset

    // Carrega frequência dessa aula
    try {
      const frequencia = await getFrequenciaAula(aula.id);

      const novoMapa = {};
      const novaObs = {};

      // 1. Identificar alunos extras (que têm registro mas não estão na lista de ativos 'alunos')
      const idsAtivos = new Set(alunos.map(a => a.id));
      const alunosExtras = [];

      frequencia.forEach(f => {
        // O endpoint retorna: { matricula_id, nome_completo, cpf, status, observacao }
        // Se não estiver na lista de ativos, é um aluno histórico
        if (!idsAtivos.has(f.matricula_id)) {
          alunosExtras.push({
            id: f.matricula_id,
            nome: f.nome_completo || "Aluno Histórico", // ListaChamada usa .nome
            nome_completo: f.nome_completo,
            cpf: f.cpf,
            status_matricula: 'Inativo' // Flag visual
          });
        }

        novoMapa[f.matricula_id] = f.status;
        novaObs[f.matricula_id] = f.observacao;
      });

      // 2. Mesclar listas: Alunos Ativos + Alunos Extras
      // Ordenar por nome para ficar bonitinho
      const listaCompleta = [...alunos.map(a => ({ ...a, status_matricula: 'Ativo' })), ...alunosExtras]
        .sort((a, b) => (a.nome || a.nome_completo || "").localeCompare(b.nome || b.nome_completo || ""));

      setAlunosParaEdicao(listaCompleta);

      // 3. Garantir defaults para quem não tinha registro (ativos novos)
      listaCompleta.forEach(a => {
        if (!novoMapa[a.id]) novoMapa[a.id] = 'Presente';
      });

      setEditMapaPresenca(novoMapa);
      setEditObservacoes(novaObs);

    } catch (error) {
      console.error("Erro ao carregar frequência", error);
    }

    // Carrega fotos
    try {
      const fotos = await getFotosAula(aula.id);
      setGaleria(fotos);
    } catch (error) {
      console.error("Erro ao carregar fotos", error);
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
          <div className="bg-gray-100 p-1 rounded-lg flex space-x-1 overflow-x-auto">
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
            <button
              onClick={() => setAbaAtiva('estatisticas')}
              className={`px-4 py-2 rounded-md text-sm font-bold transition-all flex items-center gap-2
                    ${abaAtiva === 'estatisticas' ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
            >
              <BarChart2 size={16} /> Desempenho
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

            {/* ÁREA DE UPLOAD (NOVO) */}
            <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100">
              <h3 className="font-bold text-gray-700 mb-4 flex items-center gap-2">
                <ImageIcon size={18} /> Fotos
              </h3>

              <div {...getRootProps()} className={`border-2 border-dashed rounded-lg p-6 text-center cursor-pointer transition-colors ${isDragActive ? 'border-blue-500 bg-blue-50' : 'border-gray-300 hover:border-blue-400'}`}>
                <input {...getInputProps()} />
                <UploadCloud className="mx-auto text-gray-400 mb-2" />
                <p className="text-sm text-gray-500">Arraste fotos aqui ou clique para selecionar</p>
              </div>

              {/* PREVIEW FOTOS NOVAS */}
              {fotosNovas.length > 0 && (
                <div className="mt-4 grid grid-cols-3 gap-2">
                  {fotosNovas.map((file, i) => (
                    <div key={i} className="relative group aspect-square bg-gray-100 rounded-lg overflow-hidden">
                      <img src={URL.createObjectURL(file)} alt="preview" className="w-full h-full object-cover" />
                      <button onClick={() => removeFotoNova(i)} className="absolute top-1 right-1 bg-red-500 text-white p-1 rounded-full opacity-0 group-hover:opacity-100 transition-opacity">
                        <X size={12} />
                      </button>
                    </div>
                  ))}
                </div>
              )}
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
      )
      }

      {/* CONTEÚDO DA ABA: HISTÓRICO */}
      {
        abaAtiva === 'historico' && (
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
                        <UserCheck size={12} /> {aula.presentes} Presentes / {aula.ausentes} Ausentes / {aula.justificados} Justificados
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
        )
      }

      {/* CONTEÚDO DA ABA: ESTATÍSTICAS */}
      {
        abaAtiva === 'estatisticas' && estatisticas && (
          <div className="animate-fade-in grid grid-cols-1 md:grid-cols-3 gap-6">

            {/* CARTÃO DE MÉTRICAS GERAIS */}
            <div className="md:col-span-1 space-y-6">
              <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                <h3 className="font-bold text-gray-700 mb-6 flex items-center gap-2">
                  <BarChart2 className="text-blue-600" /> Visão Geral da Turma
                </h3>

                {/* GRÁFICO DE PIZZA SIMPLIFICADO CSS */}
                <div className="flex justify-center mb-6 relative">
                  <div className="w-48 h-48 rounded-full relative"
                    style={{
                      background: `conic-gradient(#22c55e 0% ${percPresencaGeral}%, #ef4444 ${percPresencaGeral}% 100%)`
                    }}
                  >
                    <div className="absolute inset-4 bg-white rounded-full flex flex-col items-center justify-center">
                      <span className="text-3xl font-bold text-gray-800">{percPresencaGeral}%</span>
                      <span className="text-xs text-gray-500 uppercase font-bold">Presença Total</span>
                    </div>
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-4 text-center">
                  <div className="p-3 bg-green-50 rounded-lg">
                    <p className="text-2xl font-bold text-green-600">{estatisticas.total_presencas}</p>
                    <p className="text-xs text-green-800 font-bold uppercase">Presenças</p>
                  </div>
                  <div className="p-3 bg-red-50 rounded-lg">
                    <p className="text-2xl font-bold text-red-600">{estatisticas.total_faltas}</p>
                    <p className="text-xs text-red-800 font-bold uppercase">Faltas</p>
                  </div>
                </div>

                <div className="mt-4 p-4 bg-blue-50 rounded-lg flex items-center justify-between">
                  <span className="text-sm text-blue-800 font-bold">Total de Aulas Dadas:</span>
                  <span className="text-xl font-black text-blue-600">{estatisticas.total_aulas_registradas}</span>
                </div>
              </div>
            </div>

            {/* TABELA DE ALUNOS (RISCO) */}
            <div className="md:col-span-2">
              <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                <div className="p-5 border-b bg-gray-50">
                  <h3 className="font-bold text-gray-700 flex items-center gap-2">
                    <AlertCircle className="text-orange-500" /> Monitoramento de Risco
                  </h3>
                  <p className="text-xs text-gray-500 mt-1">Ordenado por menor frequência (maior risco)</p>
                </div>

                <div className="overflow-x-auto">
                  <table className="w-full text-sm text-left">
                    <thead className="bg-gray-50 text-gray-600 uppercase text-xs font-bold">
                      <tr>
                        <th className="px-6 py-3">Aluno</th>
                        <th className="px-6 py-3 text-center">Aulas</th>
                        <th className="px-6 py-3 text-center">Faltas</th>
                        <th className="px-6 py-3 w-1/3">Frequência</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-100">
                      {alunosOrdenados.map((aluno) => {
                        const isCritical = aluno.frequencia_percent < 75;
                        const isWarning = aluno.frequencia_percent >= 75 && aluno.frequencia_percent < 85;
                        const colorBar = isCritical ? 'bg-red-500' : isWarning ? 'bg-yellow-500' : 'bg-green-500';

                        return (
                          <tr
                            key={aluno.matricula_id}
                            className="hover:bg-blue-50 transition-colors cursor-pointer group"
                            onClick={() => setAlunoHistorico({ id: aluno.matricula_id, nome: aluno.nome_completo })}
                          >
                            <td className="px-6 py-4 font-medium text-gray-800">
                              {aluno.nome_completo}
                              {isCritical && <span className="ml-2 inline-block px-2 py-0.5 rounded text-[10px] bg-red-100 text-red-700 font-bold">CRÍTICO</span>}
                            </td>
                            <td className="px-6 py-4 text-center text-gray-600">{aluno.total_aulas}</td>
                            <td className="px-6 py-4 text-center font-bold text-red-500">{aluno.faltas}</td>
                            <td className="px-6 py-4">
                              <div className="flex items-center gap-3">
                                <span className={`text-xs font-bold w-10 text-right ${isCritical ? 'text-red-600' : 'text-gray-600'}`}>
                                  {aluno.frequencia_percent}%
                                </span>
                                <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                                  <div
                                    className={`h-full rounded-full ${colorBar}`}
                                    style={{ width: `${aluno.frequencia_percent}%` }}
                                  />
                                </div>
                              </div>
                            </td>
                          </tr>
                        )
                      })}
                    </tbody>
                  </table>
                  {alunosOrdenados.length === 0 && (
                    <div className="p-8 text-center text-gray-400">Sem dados de frequência ainda.</div>
                  )}
                </div>
              </div>
            </div>
          </div>
        )
      }

      {/* MODAL DE EDIÇÃO / VISUALIZAÇÃO */}
      {
        modalOpen && (
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

                    {/* GALERIA NO MODAL */}
                    <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 mt-4">
                      <h3 className="font-bold text-gray-700 mb-4 flex items-center gap-2">
                        <ImageIcon size={18} /> Galeria de Fotos
                      </h3>

                      {/* Dropzone no Modal (Só habilita se estiver no modo edit) */}
                      {modalMode === 'edit' && (
                        <div {...getRootProps()} className={`border-2 border-dashed rounded-lg p-4 text-center cursor-pointer mb-4 transition-colors ${isDragActive ? 'border-blue-500 bg-blue-50' : 'border-gray-300 hover:border-blue-400'}`}>
                          <input {...getInputProps()} />
                          {uploading ? <p className="text-sm text-blue-600 font-bold">Enviando...</p> : <p className="text-xs text-gray-500">Adicionar mais fotos</p>}
                        </div>
                      )}

                      <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                        {galeria.map(foto => (
                          <div key={foto.id} className="relative group aspect-square bg-gray-100 rounded-lg overflow-hidden border">
                            <img
                              src={`http://localhost:10000${foto.caminho_foto}`}
                              alt="Evidência"
                              className="w-full h-full object-cover cursor-pointer"
                              onClick={() => window.open(`http://localhost:10000${foto.caminho_foto}`, '_blank')}
                            />
                            {modalMode === 'edit' && (
                              <button onClick={() => handleDeleteFoto(foto.id)} className="absolute top-1 right-1 bg-red-600 text-white p-1.5 rounded-full opacity-0 group-hover:opacity-100 transition-opacity shadow-sm">
                                <Trash2 size={14} />
                              </button>
                            )}
                          </div>
                        ))}
                        {galeria.length === 0 && <p className="text-xs text-gray-400 col-span-3 text-center py-2">Sem fotos registradas.</p>}
                      </div>
                    </div>
                  </div>
                  <div className="lg:col-span-2">
                    <ListaChamada
                      alunos={alunosParaEdicao.length > 0 ? alunosParaEdicao : alunos}
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
          </div >
        )
      }

      {/* MODAL HISTÓRICO INDIVIDUAL */}
      {
        alunoHistorico && (
          <ModalHistoricoAluno
            matriculaId={alunoHistorico.id}
            alunoNome={alunoHistorico.nome}
            onClose={() => setAlunoHistorico(null)}
          />
        )
      }

    </div >
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
                        {aluno.nome || aluno.nome_completo}
                        {aluno.status_matricula === 'Inativo' && (
                          <span className="ml-2 text-[10px] bg-gray-200 text-gray-500 px-1.5 py-0.5 rounded font-bold uppercase tracking-wider">
                            Histórico
                          </span>
                        )}
                      </span>
                    </div>
                  </div>

                  <div className={`flex bg-gray-100 p-1 rounded-lg ${readOnly ? 'opacity-70 pointer-events-none' : ''}`}>
                    <button onClick={() => setStatus(aluno.id, 'Presente')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Presente' ? 'bg-white text-green-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>P</button>
                    <button onClick={() => setStatus(aluno.id, 'Ausente')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Ausente' ? 'bg-white text-red-500 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>F</button>
                    <button onClick={() => setStatus(aluno.id, 'Justificado')} className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${status === 'Justificado' ? 'bg-white text-yellow-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'}`}>J</button>
                  </div>
                </div>
                {(status === 'Justificado' || (observacoes[aluno.id] && observacoes[aluno.id].length > 0)) && (
                  <div className="px-3 pb-3 pl-10">
                    <input
                      type="text"
                      placeholder={readOnly ? "Sem motivo informado" : (status === 'Justificado' ? "Informe o motivo..." : "Observação...")}
                      className="w-full text-sm border-b border-gray-300 focus:border-yellow-500 outline-none py-1 bg-transparent text-gray-700 placeholder-gray-400 disabled:text-gray-600 disabled:border-transparent"
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
