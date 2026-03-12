import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Users, Mail, GraduationCap, Search, X } from 'lucide-react';

const ListaProfessores = () => {
    const navigate = useNavigate();
    const [professores, setProfessores] = useState([]);
    const [todasTurmas, setTodasTurmas] = useState([]);
    const [filtro, setFiltro] = useState('');
    const [loading, setLoading] = useState(true);

    // Modal State
    const [showTurmasModal, setShowTurmasModal] = useState(false);
    const [profSelecionado, setProfSelecionado] = useState(null);
    const [turmasDoProf, setTurmasDoProf] = useState([]);
    const [loadingTurmas, setLoadingTurmas] = useState(false);

    useEffect(() => {
        setLoading(true);
        // Agora busca apenas a lista de professores geral, o modal busca as turmas sob demanda
        api.get('/professores/geral')
        .then(res => setProfessores(res.data))
        .catch(err => console.error(err))
        .finally(() => setLoading(false));
    }, []);

    const profsFiltrados = professores.filter(p =>
        p.nome_completo.toLowerCase().includes(filtro.toLowerCase()) ||
        p.email_institucional?.toLowerCase().includes(filtro.toLowerCase())
    );

    const handleOpenTurmas = async (prof) => {
        setProfSelecionado(prof);
        setShowTurmasModal(true);
        setLoadingTurmas(true);
        
        try {
            // Usa a nova rota que acabamos de criar no backend
            const res = await api.get(`/professores/${prof.usuario_id}/turmas`);
            setTurmasDoProf(res.data || []);
        } catch (error) {
            console.error("Erro ao buscar turmas:", error);
            setTurmasDoProf([]);
        } finally {
            setLoadingTurmas(false);
        }
    };

    return (
        <div className="p-6 max-w-7xl mx-auto space-y-6 animate-fade-in">
            <div className="flex flex-col md:flex-row justify-between items-center gap-4">
                <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                    <Users className="text-purple-600" /> Corpo Docente
                </h1>
                <div className="relative w-full md:w-72">
                    <Search className="absolute left-3 top-2.5 text-gray-400" size={20} />
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
                        <div key={prof.id} className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all flex flex-col items-center text-center h-full">
                            
                            {/* Bloco de Informações - Estica para empurrar o rodapé */}
                            <div className="flex-1 flex flex-col items-center w-full">
                                <div className="w-20 h-20 bg-purple-100 text-purple-600 rounded-full flex items-center justify-center text-2xl font-bold mb-4">
                                    {prof.nome_completo.charAt(0)}
                                </div>

                                <h3 className="font-bold text-gray-800 text-lg">{prof.nome_completo}</h3>

                                <div className="flex items-center justify-center gap-2 text-gray-500 text-xs mt-1 mb-6 w-full px-2">
                                    <Mail size={12} className="shrink-0" />
                                    <span className="truncate" title={prof.email_institucional}>
                                        {prof.email_institucional}
                                    </span>
                                </div>
                            </div>

                            {/* Rodapé - Sempre alinhado à base */}
                            <div className="w-full pt-4 mt-auto border-t border-gray-50 flex justify-between items-center bg-white">
                                <button
                                    onClick={() => handleOpenTurmas(prof)}
                                    className="flex items-center gap-1 text-sm font-bold text-purple-600 bg-purple-50 hover:bg-purple-100 px-3 py-1.5 rounded-full transition-colors"
                                    title="Ver Turmas deste Professor"
                                >
                                    <GraduationCap size={16} /> {prof.total_turmas} Turmas
                                </button>
                                <button
                                    onClick={() => window.location.hash = `#/app/professores/${prof.usuario_id}/planos`}
                                    className="text-xs font-bold text-white bg-purple-600 hover:bg-purple-700 px-4 py-1.5 rounded-lg transition-colors shadow-sm whitespace-nowrap"
                                >
                                    Ver Planos
                                </button>
                            </div>
                        </div>
                    ))}
                    {profsFiltrados.length === 0 && (
                        <p className="col-span-full text-center py-10 text-gray-400">Nenhum professor encontrado com esse filtro.</p>
                    )}
                </div>
            )}

            {/* Modal de Turmas do Professor */}
            {showTurmasModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
                    <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[90vh]">
                        <div className="bg-purple-50 px-6 py-4 border-b border-purple-100 flex justify-between items-center">
                            <div>
                                <h2 className="text-lg font-bold text-purple-900">Turmas Vinculadas</h2>
                                <p className="text-xs text-purple-600 font-medium">Docente: {profSelecionado?.nome_completo}</p>
                            </div>
                            <button onClick={() => setShowTurmasModal(false)} className="text-purple-400 hover:text-purple-600 transition-colors">
                                <X size={24} />
                            </button>
                        </div>

                        <div className="p-6 overflow-y-auto w-full">
                            {loadingTurmas ? (
                                <div className="text-center py-8">
                                    <div className="w-8 h-8 border-4 border-purple-200 border-t-purple-600 rounded-full animate-spin mx-auto mb-3"></div>
                                    <p className="text-purple-600 font-bold text-sm">Buscando turmas...</p>
                                </div>
                            ) : turmasDoProf.length > 0 ? (
                                <ul className="space-y-3 w-full">
                                    {turmasDoProf.map(turma => (
                                        <li key={turma.id} className="p-4 bg-gray-50 border border-gray-100 rounded-xl hover:shadow-sm transition-all flex flex-col cursor-pointer" onClick={() => { setShowTurmasModal(false); navigate(`/app/turmas/${turma.id}`); }}>
                                            <div className="flex justify-between items-start w-full">
                                                <div className="flex-1 w-full">
                                                    <span className="text-[10px] font-bold uppercase tracking-wider text-purple-600 bg-purple-100 px-2 py-0.5 rounded">{turma.nome_projeto || 'Projeto Geral'}</span>
                                                    <h4 className="font-bold text-gray-800 mt-2 text-base leading-tight break-words pr-2">{turma.nome}</h4>
                                                </div>
                                                {!turma.ativo && <span className="text-[10px] font-bold uppercase text-gray-500 bg-gray-200 px-2 py-1 rounded shrink-0 ml-2">Encerrada</span>}
                                            </div>
                                            <div className="flex flex-wrap gap-2 text-xs text-gray-500 mt-3 font-medium">
                                              <span className="bg-white border border-gray-200 px-2 py-1 rounded shadow-sm">{turma.periodo}</span>
                                              <span className="bg-white border border-gray-200 px-2 py-1 rounded shadow-sm">{turma.turno}</span>
                                            </div>
                                        </li>
                                    ))}
                                </ul>
                            ) : (
                                <div className="text-center py-8">
                                    <GraduationCap size={48} className="mx-auto text-purple-200 mb-3" />
                                    <p className="text-gray-500 text-sm">O professor não possui turmas alocadas.</p>
                                </div>
                            )}
                        </div>

                        <div className="p-4 bg-gray-50 border-t border-gray-100 flex justify-end">
                            <button onClick={() => setShowTurmasModal(false)} className="px-5 py-2 font-bold text-gray-600 hover:bg-gray-200 rounded-lg transition-colors">Fechar</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default ListaProfessores;