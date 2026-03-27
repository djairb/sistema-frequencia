import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Users, Mail, Briefcase, Search, FileText } from 'lucide-react';

const ListaColaboradores = () => {
    const navigate = useNavigate();
    const [colaboradores, setColaboradores] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchColaboradores = async () => {
            try {
                // Chama a rota do back-end que lista todos os colaboradores
                const response = await api.get('/colaboradores'); 
                setColaboradores(response.data);
            } catch (error) {
                console.error("Erro ao buscar colaboradores:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchColaboradores();
    }, []);

    // Filtro em tempo real pela barra de pesquisa
    const filteredColaboradores = colaboradores.filter(colab => 
        colab.nome_completo?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        colab.email_institucional?.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="p-6 max-w-7xl mx-auto">
            {/* Header e Barra de Busca */}
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                <div>
                    <h1 className="text-3xl font-bold text-gray-800 flex items-center gap-3">
                        <Users className="text-blue-600" size={32} />
                        Equipe de Colaboradores
                    </h1>
                    <p className="text-gray-500 mt-2">
                        Acesse e avalie os relatórios de todos os membros do projeto.
                    </p>
                </div>

                <div className="relative w-full md:w-96">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={20} />
                    <input
                        type="text"
                        placeholder="Buscar por nome ou email..."
                        className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all shadow-sm"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
            </div>

            {/* Grid de Cards */}
            {loading ? (
                <div className="flex justify-center items-center h-64">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
                </div>
            ) : filteredColaboradores.length === 0 ? (
                 <div className="text-center py-12 bg-white rounded-xl border border-gray-100 shadow-sm">
                    <Users className="mx-auto text-gray-300 mb-4" size={48} />
                    <h3 className="text-lg font-medium text-gray-900">Nenhum colaborador encontrado</h3>
                    <p className="text-gray-500 mt-1">Tente ajustar os termos da sua busca.</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {filteredColaboradores.map((colaborador) => (
                        <div 
                            key={colaborador.id}
                            className="bg-white rounded-2xl p-6 border border-gray-100 shadow-sm hover:shadow-md transition-all flex flex-col"
                        >
                            {/* Info do Colaborador */}
                            <div className="flex items-start gap-4 mb-6">
                                <div className="w-16 h-16 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 font-bold text-xl flex-shrink-0 border border-blue-100">
                                    {colaborador.nome_completo?.charAt(0).toUpperCase()}
                                </div>
                                <div className="flex-1 min-w-0 pt-1">
                                    <h3 className="text-lg font-bold text-gray-900 truncate" title={colaborador.nome_completo}>
                                        {colaborador.nome_completo}
                                    </h3>
                                    <div className="flex items-center gap-1.5 text-sm text-gray-500 mt-1.5">
                                        <Briefcase size={16} className="flex-shrink-0 text-gray-400" />
                                        <span className="truncate">{colaborador.cargo || 'Colaborador'}</span>
                                    </div>
                                    <div className="flex items-center gap-1.5 text-sm text-gray-500 mt-1">
                                        <Mail size={16} className="flex-shrink-0 text-gray-400" />
                                        <span className="truncate">{colaborador.email_institucional}</span>
                                    </div>
                                </div>
                            </div>

                            {/* Botão de Ação Único */}
                            <div className="mt-auto pt-4 border-t border-gray-50">
                                <button
                                    onClick={() => navigate(`/app/colaboradores/${colaborador.usuario_id}/relatorios`)}
                                    className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white rounded-xl font-medium transition-colors"
                                >
                                    <FileText size={18} />
                                    Ver Relatórios
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default ListaColaboradores;