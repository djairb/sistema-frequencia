import React, { useState, useEffect, useContext } from 'react';
import { AuthContext } from '../contexts/auth';
import { uploadPlanoTrabalho, getPlanosTrabalho, deletePlanoTrabalho } from '../services/sysconex';
import {
    FileText, Upload, Plus, X, AlertCircle, FileCheck, CheckCircle, Loader2, Trash2, Edit
} from 'lucide-react';

const RelatoriosColaborador = () => {
    const { user } = useContext(AuthContext);

    const [isModalOpen, setIsModalOpen] = useState(false);
    const [pdfModalOpen, setPdfModalOpen] = useState(false);
    const [currentPdfUrl, setCurrentPdfUrl] = useState('');
    const [selectedAno, setSelectedAno] = useState(2026);
    const [selectedMes, setSelectedMes] = useState(new Date().getMonth() + 1);
    const [relatorioFile, setRelatorioFile] = useState(null);
    const [relatoriosList, setRelatoriosList] = useState([]);
    const [loadingRelatorios, setLoadingRelatorios] = useState(true);
    const [isEditing, setIsEditing] = useState(false);

    useEffect(() => {
        carregarRelatorios();
    }, []);

    const carregarRelatorios = async () => {
        try {
            setLoadingRelatorios(true);
            const data = await getPlanosTrabalho();

            const sortedData = data.sort((a, b) => {
                const anoA = Number(a.ano);
                const anoB = Number(b.ano);
                const mesA = Number(a.mes);
                const mesB = Number(b.mes);

                if (anoA !== anoB) return anoB - anoA;
                return mesA - mesB;
            });
            setRelatoriosList(sortedData);
        } catch (error) {
            console.error("Erro ao carregar relatórios", error);
        } finally {
            setLoadingRelatorios(false);
        }
    };

    const handleUploadRelatorio = async (e) => {
        e.preventDefault();
        if (!relatorioFile) {
            alert("Selecione o arquivo de Relatório Mensal.");
            return;
        }

        try {
            const formData = new FormData();
            formData.append('ano', selectedAno);
            formData.append('mes', selectedMes);
            formData.append('relatorio', relatorioFile);

            await uploadPlanoTrabalho(formData);

            setIsModalOpen(false);
            setRelatorioFile(null);
            carregarRelatorios();
            alert("Relatório mensal salvo com sucesso!");
        } catch (error) {
            console.error("Erro no upload", error);
            alert("Erro ao enviar arquivo.");
        }
    };

    const handleDeleteRelatorio = async (relatorioId) => {
        if (window.confirm("Certeza que deseja excluir este relatório? Esta ação não pode ser desfeita.")) {
            try {
                await deletePlanoTrabalho(relatorioId);
                carregarRelatorios();
                alert("Relatório excluído com sucesso!");
            } catch (error) {
                console.error("Erro ao excluir relatório", error);
                alert(error.response?.data?.error || "Erro ao excluir o relatório.");
            }
        }
    };

    const handleOpenEdit = (relatorio) => {
        setSelectedAno(relatorio.ano);
        setSelectedMes(relatorio.mes);
        setRelatorioFile(null);
        setIsEditing(true);
        setIsModalOpen(true);
    };

    return (
        <div className="p-6 max-w-7xl mx-auto animate-fade-in space-y-8">
            {/* HEADER */}
            <div className="bg-gradient-to-r from-indigo-600 to-purple-700 p-8 rounded-2xl shadow-lg relative overflow-hidden text-white">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                    <FileText size={150} />
                </div>
                <div className="relative z-10">
                    <h1 className="text-3xl font-bold mb-2">Relatórios Mensais</h1>
                    <p className="text-indigo-100 max-w-xl">
                        Gerencie e envie seus relatórios mensais de forma centralizada.
                    </p>
                </div>
            </div>

            {/* LISTAGEM DE RELATÓRIOS */}
            <div>
                <div className="flex justify-between items-center mb-6">
                    <h2 className="text-xl font-bold text-gray-800 flex items-center gap-2">
                        <FileText className="text-indigo-600" /> Meus Relatórios Mensais
                    </h2>
                    <button
                        onClick={() => {
                            setSelectedAno(2026);
                            setSelectedMes(new Date().getMonth() + 1);
                            setRelatorioFile(null);
                            setIsEditing(false);
                            setIsModalOpen(true);
                        }}
                        className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 transition-colors shadow-sm"
                    >
                        <Plus size={20} /> Adicionar Relatório
                    </button>
                </div>

                {loadingRelatorios ? (
                    <div className="flex justify-center p-8"><Loader2 className="animate-spin text-indigo-600" size={30} /></div>
                ) : relatoriosList.length === 0 ? (
                    <div className="bg-white p-8 rounded-xl text-center shadow-sm border border-gray-100">
                        <p className="text-gray-500">Nenhum relatório mensal enviado ainda.</p>
                    </div>
                ) : (
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                        <div className="overflow-x-auto">
                            <table className="min-w-full divide-y divide-gray-200">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Mês / Ano</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Relatório</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Enviado em</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Feedback da Coordenação</th>
                                        <th className="px-6 py-3 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">Ações</th>
                                    </tr>
                                </thead>
                                <tbody className="bg-white divide-y divide-gray-200">
                                    {relatoriosList.map(rel => (
                                        <tr key={rel.id}>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900 border-l-4 border-l-indigo-500 bg-indigo-50/20">
                                                {String(rel.mes).padStart(2, '0')} / {rel.ano}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {rel.caminho_relatorio ? (
                                                    <button onClick={() => { setCurrentPdfUrl(`https://somosconexaosocial.org${rel.caminho_relatorio}`); setPdfModalOpen(true); }} className="flex items-center gap-1 text-green-600 hover:text-green-800 font-medium bg-green-50 px-3 py-1.5 rounded-lg w-max border border-green-100 transition-colors">
                                                        <FileCheck size={16} /> Ver PDF
                                                    </button>
                                                ) : <span className="text-gray-400 text-[10px] uppercase tracking-wider font-bold bg-gray-100 px-2 py-1 rounded">Pendente</span>}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 font-medium">
                                                {new Date(rel.created_at).toLocaleDateString('pt-BR')}
                                            </td>
                                            <td className="px-6 py-4 text-sm text-gray-500 max-w-xs">
                                                <div className="flex-1">
                                                    {rel.feedback_coordenador ? (
                                                        <div className="bg-indigo-50 border border-indigo-100 p-3 rounded-lg text-indigo-800 shadow-sm text-xs leading-relaxed">
                                                            <span className="font-bold flex items-center gap-1 mb-1"><FileText size={12} /> Observação:</span>
                                                            {rel.feedback_coordenador}
                                                        </div>
                                                    ) : (
                                                        <span className="text-gray-400 italic text-xs">Aguardando Avaliação</span>
                                                    )}
                                                </div>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                                <div className="flex justify-center gap-2">
                                                    <button
                                                        onClick={() => handleOpenEdit(rel)}
                                                        className="text-blue-600 hover:text-blue-900 bg-blue-50 p-2 rounded-lg transition-colors border border-blue-100"
                                                        title="Substituir Arquivo"
                                                    >
                                                        <Edit size={16} />
                                                    </button>
                                                    {!rel.feedback_coordenador ? (
                                                        <button
                                                            onClick={() => handleDeleteRelatorio(rel.id)}
                                                            className="text-red-600 hover:text-red-900 bg-red-50 p-2 rounded-lg transition-colors border border-red-100"
                                                            title="Excluir Relatório"
                                                        >
                                                            <Trash2 size={16} />
                                                        </button>
                                                    ) : (
                                                        <button
                                                            disabled
                                                            className="text-gray-400 bg-gray-50 p-2 rounded-lg cursor-not-allowed border border-gray-100"
                                                            title="Não é possível excluir relatório com feedback"
                                                        >
                                                            <Trash2 size={16} />
                                                        </button>
                                                    )}
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}
            </div>

            {/* MODAL DE UPLOAD DE RELATÓRIO */}
            {isModalOpen && (
                <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50 animate-fade-in">
                    <div className="bg-white rounded-2xl w-full max-w-lg shadow-2xl overflow-hidden animate-slide-up">
                        <div className="flex justify-between items-center p-6 border-b border-gray-100 bg-gray-50/50">
                            <h2 className="text-xl font-bold flex items-center gap-2 text-gray-800">
                                <Upload className="text-indigo-600" /> {isEditing ? "Substituir" : "Upload de"} Relatório Mensal
                            </h2>
                            <button onClick={() => setIsModalOpen(false)} className="text-gray-400 hover:text-red-500 transition-colors bg-white p-1 rounded-full shadow-sm">
                                <X size={24} />
                            </button>
                        </div>

                        <form onSubmit={handleUploadRelatorio} className="p-6 space-y-6">

                            <div className="grid grid-cols-2 gap-4">
                                <div>
                                    <label className="block text-sm font-semibold text-gray-700 mb-1">Ano</label>
                                    <select
                                        value={selectedAno}
                                        onChange={e => setSelectedAno(Number(e.target.value))}
                                        disabled={isEditing}
                                        className={`w-full border border-gray-300 rounded-lg p-2.5 outline-none focus:ring-2 focus:ring-indigo-500/50 focus:border-indigo-500 transition-all font-medium ${isEditing ? 'bg-gray-100 text-gray-500 cursor-not-allowed' : 'text-gray-700'}`}
                                    >
                                        <option value={2025}>2025</option>
                                        <option value={2026}>2026</option>
                                        <option value={2027}>2027</option>
                                    </select>
                                </div>
                                <div>
                                    <label className="block text-sm font-semibold text-gray-700 mb-1">Mês</label>
                                    <select
                                        value={selectedMes}
                                        onChange={e => setSelectedMes(Number(e.target.value))}
                                        disabled={isEditing}
                                        className={`w-full border border-gray-300 rounded-lg p-2.5 outline-none focus:ring-2 focus:ring-indigo-500/50 focus:border-indigo-500 transition-all font-medium ${isEditing ? 'bg-gray-100 text-gray-500 cursor-not-allowed' : 'text-gray-700'}`}
                                    >
                                        <option value={1}>Janeiro</option>
                                        <option value={2}>Fevereiro</option>
                                        <option value={3}>Março</option>
                                        <option value={4}>Abril</option>
                                        <option value={5}>Maio</option>
                                        <option value={6}>Junho</option>
                                        <option value={7}>Julho</option>
                                        <option value={8}>Agosto</option>
                                        <option value={9}>Setembro</option>
                                        <option value={10}>Outubro</option>
                                        <option value={11}>Novembro</option>
                                        <option value={12}>Dezembro</option>
                                    </select>
                                </div>
                            </div>

                            <div className="space-y-4">
                                <div className="relative border-2 border-dashed border-gray-300 rounded-xl p-4 hover:border-indigo-400 transition-colors bg-gray-50/50 group">
                                    <label className="block text-sm font-bold text-gray-700 mb-1">Relatório Mensal (PDF)</label>
                                    <p className="text-xs text-gray-500 mb-2">Tamanho máximo: 7MB.</p>
                                    <input
                                        type="file"
                                        accept="application/pdf"
                                        onChange={e => {
                                            const file = e.target.files[0];
                                            if (file && file.size > 7 * 1024 * 1024) {
                                                alert("O arquivo de Relatório excede o limite de 7MB!");
                                                e.target.value = null;
                                                setRelatorioFile(null);
                                            } else {
                                                setRelatorioFile(file);
                                            }
                                        }}
                                        className="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-bold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100 cursor-pointer transition-colors"
                                    />
                                </div>
                            </div>

                            <div className="flex justify-end pt-4 border-t border-gray-100 mt-6 gap-3">
                                <button type="button" onClick={() => setIsModalOpen(false)} className="px-5 py-2.5 text-gray-600 bg-gray-100 hover:bg-gray-200 rounded-lg font-bold transition-colors">
                                    Cancelar
                                </button>
                                <button type="submit" className="px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold flex items-center gap-2 transition-all shadow-sm shadow-indigo-200">
                                    <CheckCircle size={18} /> Salvar Relatório
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}

            {/* MODAL DE VISUALIZAÇÃO DE PDF */}
            {pdfModalOpen && (
                <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50 animate-fade-in">
                    <div className="bg-white rounded-2xl w-full max-w-4xl h-[85vh] shadow-2xl flex flex-col overflow-hidden animate-slide-up">
                        <div className="flex justify-between items-center p-4 border-b bg-gray-50/50">
                            <h2 className="text-xl font-bold flex items-center gap-2 text-gray-800">
                                <FileText className="text-indigo-600" /> Visualizar Documento
                            </h2>
                            <div className="flex items-center gap-3">
                                <a href={currentPdfUrl} download target="_blank" rel="noreferrer" className="text-sm font-bold bg-indigo-100 text-indigo-700 px-4 py-2 rounded-lg hover:bg-indigo-200 transition-colors flex items-center gap-2 shadow-sm">
                                    Baixar
                                </a>
                                <button onClick={() => setPdfModalOpen(false)} className="text-gray-400 hover:text-red-500 transition-colors bg-white p-1.5 rounded-full shadow-sm">
                                    <X size={24} />
                                </button>
                            </div>
                        </div>
                        <div className="flex-1 bg-gray-100 p-2">
                            <iframe src={currentPdfUrl} className="w-full h-full rounded-xl border border-gray-200 shadow-inner" title="Visualizador de PDF" />
                        </div>
                    </div>
                </div>
            )}

        </div>
    );
};

export default RelatoriosColaborador;
