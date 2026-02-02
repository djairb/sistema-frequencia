import { useState, useEffect } from 'react';
import api from '../services/sysconex';
import { Users, Mail, GraduationCap, Search } from 'lucide-react';

const ListaProfessores = () => {
  const [professores, setProfessores] = useState([]);
  const [filtro, setFiltro] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Chama a rota nova que criamos
    api.get('/professores/geral')
      .then(res => setProfessores(res.data))
      .catch(err => console.error(err))
      .finally(() => setLoading(false));
  }, []);

  const profsFiltrados = professores.filter(p => 
    p.nome_completo.toLowerCase().includes(filtro.toLowerCase()) ||
    p.email_institucional?.toLowerCase().includes(filtro.toLowerCase())
  );

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6 animate-fade-in">
        <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                <Users className="text-purple-600"/> Corpo Docente
            </h1>
            <div className="relative w-full md:w-72">
                <Search className="absolute left-3 top-2.5 text-gray-400" size={20}/>
                <input 
                    type="text" 
                    className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 outline-none"
                    placeholder="Buscar professor..."
                    value={filtro}
                    onChange={e => setFiltro(e.target.value)}
                />
            </div>
        </div>

        {loading ? <p className="text-center py-10 text-gray-400">Carregando equipe...</p> : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {profsFiltrados.map(prof => (
                    <div key={prof.id} className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all flex flex-col items-center text-center">
                        <div className="w-20 h-20 bg-purple-100 text-purple-600 rounded-full flex items-center justify-center text-2xl font-bold mb-4">
                            {prof.nome_completo.charAt(0)}
                        </div>
                        
                        <h3 className="font-bold text-gray-800 text-lg">{prof.nome_completo}</h3>
                        
                        <div className="flex items-center justify-center gap-2 text-gray-500 text-xs mt-1 mb-4 w-full px-2">
    <Mail size={12} className="shrink-0" /> {/* shrink-0 pro ícone não esmagar */}
    <span className="truncate" title={prof.email_institucional}>
        {prof.email_institucional}
    </span>
</div>

                        <div className="w-full pt-4 border-t border-gray-50 flex justify-between items-center">
                            {/* <span className="text-xs text-gray-400 font-mono">ID: {prof.id}</span> */}
                            <span className="flex items-center gap-1 text-sm font-bold text-purple-600 bg-purple-50 px-3 py-1 rounded-full">
                                <GraduationCap size={16}/> {prof.total_turmas} Turmas
                            </span>
                        </div>
                    </div>
                ))}
            </div>
        )}
    </div>
  );
};

export default ListaProfessores;