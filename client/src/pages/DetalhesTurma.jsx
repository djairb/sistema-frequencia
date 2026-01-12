import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { api } from '../services/api';
import { 
  ArrowLeft, Users, Calendar, Plus, Search, Trash2, Loader2, AlertCircle 
} from 'lucide-react';

export default function DetalhesTurma() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [turma, setTurma] = useState(null);
  const [alunosMatriculados, setAlunosMatriculados] = useState([]);
  const [todosBeneficiarios, setTodosBeneficiarios] = useState([]); 
  
  // Modal e Busca
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [buscaAluno, setBuscaAluno] = useState("");
  const [loading, setLoading] = useState(true);

  // Carrega tudo
  // Carregar Dados Iniciais (VERSÃO DEBUG)
  // Função Completa de Carregamento de Dados
  async function loadData() {
    try {
      setLoading(true);
      
      console.log(`📡 Iniciando busca para Turma ID: ${id}`);

      // 1. Busca tudo em paralelo (Turma, Matrículas e Mock de Pessoas)
      const [dadosTurma, dadosMatriculas, dadosMock] = await Promise.all([
        api.getTurmaById(id),
        api.getMatriculasTurma(id),
        api.getBeneficiarios()
      ]);

      // --- LOGS PARA DEBUG (Olhe no Console F12) ---
      console.log("📦 TURMA (Bruto):", dadosTurma);
      console.log("📦 MATRÍCULAS (Bruto):", dadosMatriculas);

      // 2. TRATAMENTO INTELIGENTE DA TURMA
      // Passo A: Tenta pegar o dado direto ou dentro de .data
      let objTurma = dadosTurma.data || dadosTurma;

      // Passo B: Se o Backend mandou uma lista [ {nome...} ], pega o primeiro item
      if (Array.isArray(objTurma)) {
        objTurma = objTurma.length > 0 ? objTurma[0] : null;
      }

      // Passo C: Validação Final
      if (!objTurma || (!objTurma.nome && !objTurma.projeto_id)) {
         console.error("❌ O objeto Turma está vazio ou inválido!", objTurma);
         // Opcional: setTurma({ nome: "Erro ao carregar", periodo: "--" });
      } else {
         console.log("✅ Turma processada com sucesso:", objTurma);
      }

      setTurma(objTurma); // Salva no estado

      // 3. PREPARAÇÃO DAS LISTAS DE ALUNOS
      const listaMatriculas = Array.isArray(dadosMatriculas) 
        ? dadosMatriculas 
        : (dadosMatriculas.data || []);
      
      const listaBeneficiarios = Array.isArray(dadosMock.data) 
        ? dadosMock.data 
        : (dadosMock || []);
      
      setTodosBeneficiarios(listaBeneficiarios);

      // 4. CRUZAMENTO DE DADOS (Matrícula + Dados Pessoais)
      const listaCompleta = listaMatriculas.map(mat => {
        // Acha o aluno no mock pelo ID
        const infoAluno = listaBeneficiarios.find(b => Number(b.id) === Number(mat.aluno_id));
        
        // Extrai os dados da gaveta 'pessoa' (onde vimos que está o nome)
        const dadosPessoa = infoAluno?.pessoa || {};

        return {
          ...mat, // Mantém ID da matrícula, status, data...
          // Tenta pegar o nome completo, ou nome simples, ou avisa erro
          nome: dadosPessoa.nome_completo || dadosPessoa.nome || "Nome Desconhecido",
          cpf: dadosPessoa.cpf || "---"
        };
      });

      setAlunosMatriculados(listaCompleta);

    } catch (error) {
      console.error("❌ ERRO FATAL NO LOADDATA:", error);
      alert("Ocorreu um erro ao carregar os dados. Verifique o Console.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadData();
  }, [id]);

  async function handleMatricular(alunoId) {
    try {
      // 1. Manda o Backend gravar
      await api.matricularAluno(id, alunoId);
      
      // 2. Fecha o modal pra dar feedback visual
      setIsModalOpen(false);
      
      // 3. Limpa a busca pra facilitar adicionar o próximo
      setBuscaAluno(""); 

      // 4. Pequeno delay de segurança (100ms) pro MySQL garantir a gravação
      // antes da gente ler de novo
      setTimeout(() => {
          loadData(); 
          alert("Aluno matriculado com sucesso!");
      }, 100);

    } catch (error) {
      alert(`❌ ERRO: ${error.message}`);
    }
  }

  // Filtro Seguro
  // Filtro Seguro (Considerando o objeto 'pessoa')
  const alunosDisponiveis = todosBeneficiarios.filter(b => {
    const dadosPessoa = b.pessoa || {};
    const nomeReal = dadosPessoa.nome_completo || dadosPessoa.nome || "";
    
    const termo = buscaAluno.toLowerCase();
    const matchBusca = nomeReal.toLowerCase().includes(termo);
    const jaMatriculado = alunosMatriculados.some(m => m.aluno_id === b.id);
    
    return matchBusca && !jaMatriculado;
  });

  if (loading) {
    return (
      <div className="flex flex-col justify-center items-center h-64 text-blue-600 gap-2">
        <Loader2 className="animate-spin" size={40} />
        <p>Carregando dados da turma...</p>
      </div>
    );
  }

  if (!turma) return <div className="p-8 text-center text-gray-500">Turma não encontrada.</div>;

  return (
    <div className="animate-fade-in space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)} className="p-2 hover:bg-gray-100 rounded-full text-gray-600">
          <ArrowLeft size={24} />
        </button>
        <div>
          {/* AQUI ESTÁ O NOME DA TURMA - Agora protegido com ? */}
          <h1 className="text-2xl font-bold text-gray-800">
            {turma?.nome || "Nome Indisponível"}
          </h1>
          <div className="flex gap-3 text-sm text-gray-500 mt-1">
            <span className="flex items-center gap-1">
              <Calendar size={14}/> {turma?.periodo || "---"}
            </span>
            <span className="px-2 py-0.5 bg-blue-50 text-blue-700 rounded text-xs font-bold uppercase">
              {turma?.turno || "---"}
            </span>
            <span className="text-xs text-gray-400 border px-1 rounded">
                Projeto ID: {turma?.projeto_id}
            </span>
          </div>
        </div>
      </div>

      {/* Tabela de Alunos */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-6 border-b border-gray-100 flex justify-between items-center">
          <h2 className="font-bold text-gray-800 flex items-center gap-2">
            <Users className="text-blue-600" size={20}/> 
            Alunos Matriculados ({alunosMatriculados.length})
          </h2>
          <button 
            onClick={() => setIsModalOpen(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium flex items-center gap-2 transition-colors"
          >
            <Plus size={16} /> Adicionar Aluno
          </button>
        </div>

        <table className="w-full text-left">
          <thead className="bg-gray-50 text-gray-500 text-xs uppercase">
            <tr>
              <th className="p-4">Nome do Aluno</th>
              <th className="p-4">CPF</th>
              <th className="p-4">Status</th>
              <th className="p-4 text-right">Ações</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {alunosMatriculados.length === 0 ? (
              <tr><td colSpan="4" className="p-8 text-center text-gray-400">Nenhum aluno nesta turma ainda.</td></tr>
            ) : (
              alunosMatriculados.map(mat => (
                <tr key={mat.id} className="hover:bg-gray-50 transition-colors">
                  <td className="p-4 font-medium text-gray-800">{mat.nome}</td>
                  <td className="p-4 text-gray-500 text-sm">{mat.cpf}</td>
                  <td className="p-4">
                    <span className={`px-2 py-1 rounded-full text-xs font-bold ${
                      mat.status === 'Ativo' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'
                    }`}>
                      {mat.status}
                    </span>
                  </td>
                  <td className="p-4 text-right">
                    <button className="text-red-400 hover:text-red-600 p-2 rounded hover:bg-red-50 transition-colors">
                      <Trash2 size={16}/>
                    </button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 animate-fade-in">
          <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[80vh]">
            <div className="p-4 border-b flex justify-between items-center bg-gray-50">
              <h3 className="font-bold text-gray-700">Vincular Aluno</h3>
              <button onClick={() => setIsModalOpen(false)} className="text-gray-400 hover:text-gray-600">
                <ArrowLeft size={20} className="rotate-180"/>
              </button>
            </div>
            
            <div className="p-4 border-b">
              <div className="flex items-center gap-2 bg-gray-100 px-3 py-2 rounded-lg focus-within:ring-2 ring-blue-500/20 transition-all">
                <Search size={18} className="text-gray-400"/>
                <input 
                  autoFocus
                  placeholder="Buscar por nome..." 
                  className="bg-transparent outline-none w-full text-gray-700"
                  value={buscaAluno}
                  onChange={e => setBuscaAluno(e.target.value)}
                />
              </div>
            </div>

            <div className="overflow-y-auto p-2 space-y-1 flex-1">
              {alunosDisponiveis.map(aluno => {
                // AQUI A MÁGICA: Extraímos os dados de dentro de 'pessoa'
                const dadosPessoa = aluno.pessoa || {};
                const nomeMostravel = dadosPessoa.nome_completo || dadosPessoa.nome || "Sem Nome";
                const cpfMostravel = dadosPessoa.cpf || "CPF Indisponível";

                return (
                  <div key={aluno.id} className="flex items-center justify-between p-3 hover:bg-blue-50 rounded-lg group transition-colors">
                    <div>
                      <p className="font-medium text-gray-800">
                        {nomeMostravel}
                      </p>
                      <p className="text-xs text-gray-500">
                        CPF: {cpfMostravel}
                      </p>
                    </div>
                    <button 
                      onClick={() => handleMatricular(aluno.id)}
                      className="bg-white border border-blue-200 text-blue-600 hover:bg-blue-600 hover:text-white px-3 py-1.5 rounded text-sm font-medium opacity-0 group-hover:opacity-100 transition-all shadow-sm"
                    >
                      Vincular
                    </button>
                  </div>
                );
              })}
              {alunosDisponiveis.length === 0 && (
                <div className="flex flex-col items-center justify-center py-8 text-gray-400 gap-2">
                  <AlertCircle size={32} className="opacity-20"/>
                  <p>Nenhum aluno encontrado.</p>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}