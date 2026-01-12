import { useEffect, useState, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { api } from '../services/api';
import { AuthContext } from '../contexts/auth';
import { ArrowLeft, Calendar, UserCheck, Save, BookOpen, CheckCircle, XCircle, AlertCircle } from 'lucide-react';

export default function DiarioClasse() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useContext(AuthContext);

  const [turma, setTurma] = useState(null);
  const [alunos, setAlunos] = useState([]);
  const [loading, setLoading] = useState(true);

  // Estados do Formulário
  const [conteudo, setConteudo] = useState("");
  const [dataAula, setDataAula] = useState(new Date().toISOString().split('T')[0]);
  
  // Agora o mapa guarda STRINGS: 'Presente' | 'Ausente' | 'Justificado'
  const [mapaPresenca, setMapaPresenca] = useState({});

  useEffect(() => {
    carregarDados();
  }, [id]);

  async function carregarDados() {
    try {
      const [dadosTurma, dadosMatriculas, dadosBeneficiarios] = await Promise.all([
        api.getTurmaById(id),
        api.getMatriculasTurma(id),
        api.getBeneficiarios()
      ]);

      let objTurma = dadosTurma.data || dadosTurma;
      if (Array.isArray(objTurma)) objTurma = objTurma[0];
      setTurma(objTurma);

      const listaMatriculas = Array.isArray(dadosMatriculas) ? dadosMatriculas : (dadosMatriculas.data || []);
      const listaBenef = Array.isArray(dadosBeneficiarios.data) ? dadosBeneficiarios.data : [];

      const alunosCruzados = listaMatriculas.map(mat => {
        const info = listaBenef.find(b => Number(b.id) === Number(mat.aluno_id));
        return {
          ...mat,
          nome: info?.pessoa?.nome_completo || "Aluno Desconhecido"
        };
      });

      setAlunos(alunosCruzados);

      // Inicializa todo mundo como 'Presente'
      const presencaInicial = {};
      alunosCruzados.forEach(a => presencaInicial[a.id] = 'Presente');
      setMapaPresenca(presencaInicial);

    } catch (error) {
      alert("Erro ao carregar dados.");
    } finally {
      setLoading(false);
    }
  }

  async function handleSalvar() {
    if (!conteudo) return alert("Por favor, informe o conteúdo da aula.");

    try {
      // Monta a lista com o STATUS correto
      const listaFinal = Object.keys(mapaPresenca).map(matriculaId => ({
        matricula_id: matriculaId,
        status: mapaPresenca[matriculaId] // 'Presente', 'Ausente' ou 'Justificado'
      }));

      const payload = {
        professor_id: user.id,
        data_aula: dataAula,
        conteudo: conteudo,
        lista_presenca: listaFinal
      };

      await api.registrarAula(id, payload);
      
      alert("✅ Aula registrada com sucesso!");
      navigate(-1);

    } catch (error) {
      alert(`Erro: ${error.message}`);
    }
  }

  // Função para mudar o status ao clicar nos botões
  function setStatusAluno(matriculaId, status) {
    setMapaPresenca(prev => ({ ...prev, [matriculaId]: status }));
  }

  if (loading) return <div className="p-8 text-center">Carregando Diário...</div>;

  return (
    <div className="animate-fade-in max-w-5xl mx-auto pb-10">
      
      {/* Header */}
      <div className="mb-6">
        <button onClick={() => navigate(-1)} className="flex items-center text-gray-500 hover:text-blue-600 mb-2 transition-colors">
          <ArrowLeft size={20} className="mr-1"/> Voltar
        </button>
        <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
          <BookOpen className="text-blue-600" />
          Diário de Classe: {turma?.nome}
        </h1>
        <p className="text-gray-500 text-sm mt-1 ml-9">
          Professor: {user?.pessoa?.nome_completo}
        </p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        {/* LADO ESQUERDO: Dados da Aula */}
        <div className="lg:col-span-1 space-y-4">
          <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100">
            <h3 className="font-bold text-gray-700 mb-4 flex items-center gap-2">
              <Calendar size={18}/> Detalhes da Aula
            </h3>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-600 mb-1">Data</label>
                <input 
                  type="date" 
                  className="w-full border p-2 rounded focus:ring-2 ring-blue-500 outline-none"
                  value={dataAula}
                  onChange={e => setDataAula(e.target.value)}
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600 mb-1">Conteúdo Ministrado</label>
                <textarea 
                  rows="8"
                  className="w-full border p-2 rounded focus:ring-2 ring-blue-500 outline-none resize-none"
                  placeholder="Descreva o que foi ensinado hoje..."
                  value={conteudo}
                  onChange={e => setConteudo(e.target.value)}
                />
              </div>
            </div>
          </div>
          
          <button 
            onClick={handleSalvar}
            className="w-full bg-green-600 hover:bg-green-700 text-white py-3 rounded-xl font-bold shadow-lg shadow-green-200 flex items-center justify-center gap-2 transition-all transform active:scale-95"
          >
            <Save size={20}/> Salvar Diário
          </button>
        </div>

        {/* LADO DIREITO: Lista de Chamada */}
        <div className="lg:col-span-2">
          <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col h-full">
            <div className="p-4 border-b bg-gray-50 flex justify-between items-center">
              <h3 className="font-bold text-gray-700 flex items-center gap-2">
                <UserCheck size={18} className="text-blue-600"/> Chamada
              </h3>
              <div className="flex gap-2 text-xs font-bold">
                 <span className="flex items-center gap-1 text-green-700 bg-green-50 px-2 py-1 rounded">
                    P = Presente
                 </span>
                 <span className="flex items-center gap-1 text-red-700 bg-red-50 px-2 py-1 rounded">
                    F = Falta
                 </span>
                 <span className="flex items-center gap-1 text-yellow-700 bg-yellow-50 px-2 py-1 rounded">
                    J = Justificado
                 </span>
              </div>
            </div>

            <div className="p-2 overflow-y-auto max-h-[600px] space-y-2">
              {alunos.length === 0 ? (
                <div className="text-center py-10 text-gray-400">Nenhum aluno matriculado.</div>
              ) : (
                alunos.map(aluno => {
                  const status = mapaPresenca[aluno.id]; // 'Presente', 'Ausente', 'Justificado'
                  
                  return (
                    <div key={aluno.id} className="flex items-center justify-between p-3 rounded-lg border bg-white hover:border-blue-200 transition-colors">
                      <div className="flex items-center gap-3">
                        {/* Ícone Indicativo */}
                        {status === 'Presente' && <CheckCircle size={20} className="text-green-500" />}
                        {status === 'Ausente' && <XCircle size={20} className="text-red-500" />}
                        {status === 'Justificado' && <AlertCircle size={20} className="text-yellow-500" />}
                        
                        <span className={`font-medium ${status === 'Ausente' ? 'text-gray-400 line-through' : 'text-gray-700'}`}>
                          {aluno.nome}
                        </span>
                      </div>
                      
                      {/* BOTÕES DE AÇÃO */}
                      <div className="flex bg-gray-100 p-1 rounded-lg">
                        <button 
                          onClick={() => setStatusAluno(aluno.id, 'Presente')}
                          className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${
                            status === 'Presente' ? 'bg-white text-green-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'
                          }`}
                        >
                          P
                        </button>
                        <button 
                          onClick={() => setStatusAluno(aluno.id, 'Ausente')}
                          className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${
                            status === 'Ausente' ? 'bg-white text-red-500 shadow-sm' : 'text-gray-400 hover:text-gray-600'
                          }`}
                        >
                          F
                        </button>
                        <button 
                          onClick={() => setStatusAluno(aluno.id, 'Justificado')}
                          className={`px-3 py-1 rounded-md text-xs font-bold transition-all ${
                            status === 'Justificado' ? 'bg-white text-yellow-600 shadow-sm' : 'text-gray-400 hover:text-gray-600'
                          }`}
                        >
                          J
                        </button>
                      </div>
                    </div>
                  );
                })
              )}
            </div>
          </div>
        </div>

      </div>
    </div>
  );
}