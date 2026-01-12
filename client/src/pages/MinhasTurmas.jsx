import { useEffect, useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/api';
import { AuthContext } from '../contexts/auth'; // <--- IMPORTANTE: O Contexto que o Sidebar usa
import { BookOpen, Calendar, ArrowRight, AlertCircle } from 'lucide-react';

export default function MinhasTurmas() {
  const navigate = useNavigate();
  
  // 1. Pega o usuário direto do Contexto (Igualzinho ao Sidebar)
  const { user } = useContext(AuthContext); 
  
  const [turmas, setTurmas] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Só busca se o usuário já estiver carregado e tiver ID
    if (user && user.id) {
      console.log("👤 USUÁRIO (VIA CONTEXTO):", user);
      carregarTurmas(user.id);
    } else if (!user) {
       // Se não tiver usuário no contexto, talvez ainda esteja carregando ou não logou
       // O AuthContext gerencia isso, mas por garantia paramos o loading aqui
       setLoading(false);
    }
  }, [user]); // <--- Roda de novo assim que o 'user' chegar do Contexto

  async function carregarTurmas(idProf) {
    try {
      setLoading(true);
      const response = await api.getTurmasDoProfessor(idProf);
      setTurmas(response.data || []);
    } catch (error) {
      console.error("Erro ao buscar turmas:", error);
    } finally {
      setLoading(false);
    }
  }

  // Se ainda estiver carregando a API, mostra aviso
  if (loading && turmas.length === 0) return <div className="p-8 text-center text-gray-500">Carregando suas turmas...</div>;

  return (
    <div className="animate-fade-in space-y-6">
      <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
        <BookOpen className="text-blue-600" />
        Minhas Turmas
      </h1>

      {/* Header simples com feedback */}
      <p className="text-gray-500">
        Professor: <span className="font-semibold text-gray-700">{user?.pessoa?.nome_completo || user?.login || "Carregando..."}</span>
      </p>

      {turmas.length === 0 ? (
        <div className="bg-white p-10 rounded-xl shadow-sm border border-gray-100 text-center flex flex-col items-center gap-3">
          <div className="bg-gray-100 p-4 rounded-full text-gray-400">
            <BookOpen size={32} />
          </div>
          <h3 className="text-lg font-medium text-gray-800">Nenhuma turma encontrada</h3>
          <p className="text-gray-500 max-w-md">
            Você ainda não está vinculado a nenhuma turma.
          </p>
          {/* Debug discreto pra garantir */}
          <p className="text-xs text-gray-300 mt-2">ID Buscado: {user?.id || 'Nenhum'}</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmas.map(turma => (
            <div key={turma.id} className="bg-white rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all overflow-hidden flex flex-col group">
              <div className="p-5 flex-1">
                <div className="flex justify-between items-start mb-2">
                  <span className={`text-xs font-bold px-2 py-1 rounded uppercase ${
                    turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                  }`}>
                    {turma.ativo ? 'Em Andamento' : 'Encerrada'}
                  </span>
                  <span className="bg-blue-50 text-blue-700 text-xs font-bold px-2 py-1 rounded uppercase">
                    {turma.turno}
                  </span>
                </div>
                <h3 className="font-bold text-lg text-gray-800 mb-1 group-hover:text-blue-600 transition-colors">
                  {turma.nome}
                </h3>
                <div className="text-sm text-gray-500 flex items-center gap-2 mb-4">
                  <Calendar size={14}/> {turma.periodo}
                </div>
              </div>
              
              <div className="bg-gray-50 p-4 border-t border-gray-100">
                <button 
                  onClick={() => navigate(`/app/turmas/${turma.id}/diario`)}
                  className="w-full bg-white border border-gray-200 text-blue-600 font-bold py-2 rounded-lg hover:bg-blue-600 hover:text-white transition-all flex justify-center items-center gap-2 shadow-sm"
                >
                  Acessar Diário <ArrowRight size={16}/>
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}