import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { api } from '../services/api';
import { 
  ArrowLeft, Users, Calendar, Plus, Search, Trash2, Loader2, GraduationCap 
} from 'lucide-react';

export default function DetalhesTurma() {
  const { id } = useParams();
  const navigate = useNavigate();

  // Estados da Turma e Alunos
  const [turma, setTurma] = useState(null);
  const [alunosMatriculados, setAlunosMatriculados] = useState([]);
  const [todosBeneficiarios, setTodosBeneficiarios] = useState([]); 
  
  // Estados dos Professores
  const [professoresVinculados, setProfessoresVinculados] = useState([]);
  const [todosUsuarios, setTodosUsuarios] = useState([]); // Mock de Usuarios (pra pegar professores)

  // Modais
  const [modalAlunoOpen, setModalAlunoOpen] = useState(false);
  const [modalProfOpen, setModalProfOpen] = useState(false);
  
  const [busca, setBusca] = useState("");
  const [loading, setLoading] = useState(true);

  // --- CARREGAMENTO DE DADOS ---
  async function loadData() {
    try {
      setLoading(true);
      
      // Busca TUDO em paralelo
      const [
        dadosTurma, 
        dadosMatriculas, 
        dadosProfsVinculados,
        dadosBeneficiarios,
        dadosUsuarios
      ] = await Promise.all([
        api.getTurmaById(id),
        api.getMatriculasTurma(id),
        api.getProfessoresTurma(id), // <--- Novo
        api.getBeneficiarios(),
        api.getUsuariosPorPerfil() // <--- Novo (Traz todos usuários do mock)
      ]);

      // 1. Tratamento da Turma
      let objTurma = dadosTurma.data || dadosTurma;
      if (Array.isArray(objTurma)) objTurma = objTurma.length > 0 ? objTurma[0] : null;
      setTurma(objTurma);

      // 2. Mock de Pessoas e Usuários
      const listaBenef = Array.isArray(dadosBeneficiarios.data) ? dadosBeneficiarios.data : [];
      setTodosBeneficiarios(listaBenef);

      const listaUsers = Array.isArray(dadosUsuarios.data) ? dadosUsuarios.data : [];
      console.log(listaUsers)
      setTodosUsuarios(listaUsers);

      // 3. Cruzamento: Alunos
      const listaMatriculas = Array.isArray(dadosMatriculas) ? dadosMatriculas : (dadosMatriculas.data || []);
      const alunosCruzados = listaMatriculas.map(mat => {
        const info = listaBenef.find(b => Number(b.id) === Number(mat.aluno_id));
        const pessoa = info?.pessoa || {};
        return {
          ...mat,
          nome: pessoa.nome_completo || pessoa.nome || "Nome Desconhecido",
          cpf: pessoa.cpf || "---"
        };
      });
      setAlunosMatriculados(alunosCruzados);

      // 4. Cruzamento: Professores (ATUALIZADO)
      const listaProfsBanco = Array.isArray(dadosProfsVinculados.data) ? dadosProfsVinculados.data : dadosProfsVinculados;
      
      const profsCruzados = listaProfsBanco.map(vinculo => {
        // Acha o usuário no mock pelo ID
        const infoUser = listaUsers.find(u => Number(u.id) === Number(vinculo.professor_id));
        
        // --- CORREÇÃO AQUI ---
        // Entra em 'pessoa' para pegar o nome e 'colaborador' para o email
        return {
          ...vinculo,
          nome: infoUser?.pessoa?.nome_completo || infoUser?.login || "Professor não encontrado",
          email: infoUser?.colaborador?.email_institucional || "---"
        };
      });
      
      setProfessoresVinculados(profsCruzados);

    } catch (error) {
      console.error("Erro loadData:", error);
      alert("Erro ao carregar dados.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => { loadData(); }, [id]);

  // --- AÇÕES ---
  async function handleVincularAluno(alunoId) {
    try {
      await api.matricularAluno(id, alunoId);
      setModalAlunoOpen(false);
      setBusca("");
      setTimeout(loadData, 100);
    } catch (error) {
      alert(`Erro: ${error.message}`);
    }
  }

  async function handleVincularProfessor(profId) {
    try {
      await api.vincularProfessor(id, profId);
      setModalProfOpen(false);
      alert("Professor vinculado!");
      setTimeout(loadData, 100);
    } catch (error) {
      alert(`Erro: ${error.message}`);
    }
  }

  // --- FILTROS ---
  
  // Filtra alunos para o modal
  const alunosDisponiveis = todosBeneficiarios.filter(b => {
    const pessoa = b.pessoa || {};
    const nome = (pessoa.nome_completo || pessoa.nome || "").toLowerCase();
    const jaTem = alunosMatriculados.some(m => Number(m.aluno_id) === Number(b.id));
    return nome.includes(busca.toLowerCase()) && !jaTem;
  });

  // Filtra APENAS PROFESSORES para o modal
  const professoresDisponiveis = todosUsuarios.filter(u => {
    // 1. ACESSA A DESCRIÇÃO DENTRO DO OBJETO PERFIL
    // O ?. previne erro se o perfil vier nulo
    const descPerfil = u.perfil?.descricao || ""; 
    
    // 2. Verifica se contém "Professor" (ignorando maiúsculas/minúsculas)
    const ehProfessor = descPerfil.toLowerCase().includes('professor');
    
    // 3. Verifica se já está vinculado pra não duplicar
    const jaTem = professoresVinculados.some(p => Number(p.professor_id) === Number(u.id));
    
    return ehProfessor && !jaTem;
  });

  if (loading) return <div className="p-8 text-center"><Loader2 className="animate-spin inline"/> Carregando...</div>;
  if (!turma) return <div className="p-8 text-center">Turma não encontrada.</div>;

  return (
    <div className="animate-fade-in space-y-8 pb-10">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)} className="p-2 hover:bg-gray-100 rounded-full text-gray-600">
          <ArrowLeft size={24} />
        </button>
        <div>
          <h1 className="text-2xl font-bold text-gray-800">{turma.nome || "Turma sem nome"}</h1>
          <div className="flex gap-3 text-sm text-gray-500 mt-1">
            <span className="flex items-center gap-1"><Calendar size={14}/> {turma.periodo}</span>
            <span className="px-2 py-0.5 bg-blue-50 text-blue-700 rounded text-xs font-bold uppercase">{turma.turno}</span>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        
        {/* === SEÇÃO 1: ALUNOS === */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col h-full">
          <div className="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/50">
            <h2 className="font-bold text-gray-800 flex items-center gap-2">
              <Users className="text-blue-600" size={20}/> 
              Alunos ({alunosMatriculados.length})
            </h2>
            <button onClick={() => setModalAlunoOpen(true)} className="text-blue-600 hover:bg-blue-50 px-3 py-1.5 rounded-lg text-sm font-medium transition-colors border border-blue-100">
              + Aluno
            </button>
          </div>
          <div className="overflow-y-auto max-h-[400px]">
            <table className="w-full text-left">
              <tbody className="divide-y divide-gray-100">
                {alunosMatriculados.map(mat => (
                  <tr key={mat.id} className="hover:bg-gray-50">
                    <td className="p-4 py-3">
                      <p className="font-medium text-gray-800 text-sm">{mat.nome}</p>
                      <p className="text-xs text-gray-400">{mat.cpf}</p>
                    </td>
                    <td className="p-4 py-3 text-right">
                      <span className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded-full">{mat.status}</span>
                    </td>
                  </tr>
                ))}
                {alunosMatriculados.length === 0 && <tr className="text-center text-gray-400 text-sm"><td colSpan="2" className="p-6">Nenhum aluno.</td></tr>}
              </tbody>
            </table>
          </div>
        </div>

        {/* === SEÇÃO 2: PROFESSORES === */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col h-full">
          <div className="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/50">
            <h2 className="font-bold text-gray-800 flex items-center gap-2">
              <GraduationCap className="text-purple-600" size={20}/> 
              Corpo Docente ({professoresVinculados.length})
            </h2>
            <button onClick={() => setModalProfOpen(true)} className="text-purple-600 hover:bg-purple-50 px-3 py-1.5 rounded-lg text-sm font-medium transition-colors border border-purple-100">
              + Professor
            </button>
          </div>
          <div className="overflow-y-auto max-h-[400px]">
             <table className="w-full text-left">
              <tbody className="divide-y divide-gray-100">
                {professoresVinculados.map(prof => (
                  <tr key={prof.id} className="hover:bg-gray-50">
                    <td className="p-4 py-3">
                      <p className="font-medium text-gray-800 text-sm">{prof.nome}</p>
                      <p className="text-xs text-gray-400">{prof.email}</p>
                    </td>
                    <td className="p-4 py-3 text-right">
                      <button className="text-red-300 hover:text-red-500"><Trash2 size={16}/></button>
                    </td>
                  </tr>
                ))}
                {professoresVinculados.length === 0 && <tr className="text-center text-gray-400 text-sm"><td colSpan="2" className="p-6">Nenhum professor vinculado.</td></tr>}
              </tbody>
            </table>
          </div>
        </div>

      </div>

      {/* === MODAL ALUNOS === */}
      {modalAlunoOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="bg-white rounded-xl shadow-2xl w-full max-w-md overflow-hidden flex flex-col max-h-[80vh]">
            <div className="p-4 border-b flex justify-between items-center bg-blue-50">
              <h3 className="font-bold text-blue-900">Vincular Aluno</h3>
              <button onClick={() => setModalAlunoOpen(false)}><ArrowLeft size={20} className="rotate-180 text-blue-900"/></button>
            </div>
            <div className="p-3 border-b bg-white">
              <input 
                autoFocus placeholder="Buscar aluno..." 
                className="w-full bg-gray-100 p-2 rounded outline-none border focus:border-blue-300"
                value={busca} onChange={e => setBusca(e.target.value)}
              />
            </div>
            <div className="overflow-y-auto p-2 space-y-1 flex-1 bg-white">
              {alunosDisponiveis.map(a => {
                 const p = a.pessoa || {};
                 return (
                  <div key={a.id} className="flex justify-between p-3 hover:bg-gray-50 rounded border border-transparent hover:border-gray-200">
                    <div>
                      <p className="font-medium text-sm">{p.nome_completo || p.nome}</p>
                      <p className="text-xs text-gray-400">{p.cpf}</p>
                    </div>
                    <button onClick={() => handleVincularAluno(a.id)} className="text-blue-600 font-bold text-xs px-2 py-1 bg-blue-50 rounded">ADD</button>
                  </div>
                 )
              })}
            </div>
          </div>
        </div>
      )}

      {/* === MODAL PROFESSORES === */}
      {modalProfOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="bg-white rounded-xl shadow-2xl w-full max-w-md overflow-hidden flex flex-col max-h-[80vh]">
            <div className="p-4 border-b flex justify-between items-center bg-purple-50">
              <h3 className="font-bold text-purple-900">Adicionar Professor</h3>
              <button onClick={() => setModalProfOpen(false)}><ArrowLeft size={20} className="rotate-180 text-purple-900"/></button>
            </div>
            <div className="overflow-y-auto p-2 space-y-1 flex-1 bg-white">
              {professoresDisponiveis.length === 0 ? <p className="p-4 text-center text-gray-400">Nenhum professor disponível.</p> :
               professoresDisponiveis.map(u => {
                  // AQUI O SEGREDO: Pegamos os dados das gavetas certas
                  const nome = u.pessoa?.nome_completo || u.login || "Sem Nome";
                  const email = u.colaborador?.email_institucional || "---";

                  return (
                    <div key={u.id} className="flex justify-between p-3 hover:bg-gray-50 rounded border border-transparent hover:border-gray-200">
                      <div>
                        <p className="font-medium text-sm">{nome}</p>
                        <p className="text-xs text-gray-400">{email}</p>
                      </div>
                      <button onClick={() => handleVincularProfessor(u.id)} className="text-purple-600 font-bold text-xs px-2 py-1 bg-purple-50 rounded">ADD</button>
                    </div>
                  );
               })
              }
            </div>
          </div>
        </div>
      )}

    </div>
  );
}