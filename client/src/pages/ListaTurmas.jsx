import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Search, BookOpen, Filter, ArrowLeft } from 'lucide-react';

const ListaTurmas = () => {
  const navigate = useNavigate();
  const [turmas, setTurmas] = useState([]);
  const [filtro, setFiltro] = useState('');
  const [statusFiltro, setStatusFiltro] = useState('todos'); // todos, ativos, encerrados
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/turmas')
      .then(res => setTurmas(res.data))
      .finally(() => setLoading(false));
  }, []);

  // Lógica de Filtragem Local
  const turmasFiltradas = turmas.filter(t => {
      const matchTexto = t.nome.toLowerCase().includes(filtro.toLowerCase()) || 
                         t.nome_projeto?.toLowerCase().includes(filtro.toLowerCase());
      
      const matchStatus = statusFiltro === 'todos' 
          ? true 
          : statusFiltro === 'ativos' ? t.ativo : !t.ativo;

      return matchTexto && matchStatus;
  });

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6 animate-fade-in">
      
      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-center gap-4">
        <div className="flex items-center gap-2">
            <button onClick={() => navigate('/app/gestao-turmas')} className="p-2 hover:bg-gray-100 rounded-full text-gray-500">
                <ArrowLeft size={20}/>
            </button>
            <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                <BookOpen className="text-blue-600"/> Todas as Turmas
            </h1>
        </div>
        
        {/* Barra de Filtros */}
        <div className="flex gap-2 w-full md:w-auto">
            <div className="relative flex-1 md:w-64">
                <Search className="absolute left-3 top-2.5 text-gray-400" size={20}/>
                <input 
                    type="text" 
                    className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                    placeholder="Buscar turma ou projeto..."
                    value={filtro}
                    onChange={e => setFiltro(e.target.value)}
                />
            </div>
            <select 
                className="border rounded-lg px-4 py-2 bg-white outline-none focus:ring-2 focus:ring-blue-500"
                value={statusFiltro}
                onChange={e => setStatusFiltro(e.target.value)}
            >
                <option value="todos">Todos</option>
                <option value="ativos">Ativos</option>
                <option value="encerrados">Encerrados</option>
            </select>
        </div>
      </div>

      {/* Grid */}
      {loading ? <p className="text-center py-10 text-gray-400">Carregando...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmasFiltradas.map(turma => (
            <div key={turma.id} onClick={() => navigate(`/app/turmas/${turma.id}`)} className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all cursor-pointer group relative overflow-hidden">
               <div className={`absolute left-0 top-0 bottom-0 w-1 transition-colors ${turma.ativo ? 'bg-blue-500 group-hover:bg-blue-600' : 'bg-gray-400'}`}></div>
               <div className="pl-3">
                   <div className="flex justify-between">
                       <span className="text-[10px] font-bold uppercase text-gray-500">{turma.nome_projeto || 'Geral'}</span>
                       {!turma.ativo && <span className="text-[10px] bg-gray-100 px-2 rounded text-gray-500">Encerrada</span>}
                   </div>
                   <h3 className="font-bold text-lg text-gray-800 mt-1 group-hover:text-blue-600 transition-colors">{turma.nome}</h3>
                   <div className="flex gap-3 text-sm text-gray-500 mt-2">
                      <span>{turma.periodo}</span>
                      <span>•</span>
                      <span>{turma.turno}</span>
                   </div>
               </div>
            </div>
          ))}
          {turmasFiltradas.length === 0 && (
              <p className="col-span-full text-center py-10 text-gray-400">Nenhuma turma encontrada.</p>
          )}
        </div>
      )}
    </div>
  );
};

export default ListaTurmas;