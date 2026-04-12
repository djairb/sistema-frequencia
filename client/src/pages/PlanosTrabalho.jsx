import React, { useState, useEffect, useContext } from 'react';
import { useParams } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import { uploadPlanoTrabalho, getPlanosTrabalho, getPlanosTrabalhoUsuario, salvarFeedbackPlano, deletePlanoTrabalho } from '../services/sysconex';
import {
    FileText, Upload, Plus, X, AlertCircle, FileCheck, CheckCircle, Loader2, Trash2, Edit
} from 'lucide-react';

const PlanosTrabalho = () => {
    const { user } = useContext(AuthContext);
    const { id: professorId } = useParams(); // Para coordenador

    const [isPlanoModalOpen, setIsPlanoModalOpen] = useState(false);
    const [pdfModalOpen, setPdfModalOpen] = useState(false);
    const [currentPdfUrl, setCurrentPdfUrl] = useState('');
    const [selectedAno, setSelectedAno] = useState(2026);
    const [selectedMes, setSelectedMes] = useState(new Date().getMonth() + 1);
    const [planejamentoFile, setPlanejamentoFile] = useState(null);
    const [relatorioFile, setRelatorioFile] = useState(null);
    const [planosList, setPlanosList] = useState([]);
    const [loadingPlanos, setLoadingPlanos] = useState(true);
    const [professorNome, setProfessorNome] = useState('');
    const [editFeedbackId, setEditFeedbackId] = useState(null);
    const [tempFeedback, setTempFeedback] = useState('');
    const [isEditingPlano, setIsEditingPlano] = useState(false);
    const [salvandoPlano, setSalvandoPlano] = useState(false);


    useEffect(() => {
        carregarPlanos();
    }, []);

    const carregarPlanos = async () => {
        try {
            setLoadingPlanos(true);
            let data = [];
            if (professorId) {
                const response = await getPlanosTrabalhoUsuario(professorId);
                data = response.planos || [];
                setProfessorNome(response.professorNome || 'Professor');
            } else {
                data = await getPlanosTrabalho();
            }

            const sortedData = data.sort((a, b) => {
                const anoA = Number(a.ano);
                const anoB = Number(b.ano);
                const mesA = Number(a.mes);
                const mesB = Number(b.mes);
                
                if (anoA !== anoB) return anoB - anoA; // descendente (mais recentes no topo)
                return mesA - mesB; // ascendente (ordem mensal cronológica 1, 2, 3...)
            });
            setPlanosList(sortedData);
        } catch (error) {
            console.error("Erro ao carregar planos", error);
        } finally {
            setLoadingPlanos(false);
        }
    };

    const handleEditFeedback = (plano) => {
        setEditFeedbackId(plano.id);
        setTempFeedback(plano.feedback_coordenador || '');
    };

    const handleSaveFeedback = async (planoId) => {
        try {
            await salvarFeedbackPlano(planoId, tempFeedback);
            setEditFeedbackId(null);
            carregarPlanos();
            alert("Feedback salvo com sucesso!");
        } catch (error) {
            console.error("Erro ao salvar feedback", error);
            alert("Erro ao salvar feedback.");
        }
    };

    const handleUploadPlano = async (e) => {
        e.preventDefault();
        if (!planejamentoFile && !relatorioFile) {
            alert("Selecione pelo menos um arquivo (Planejamento ou Relatório).");
            return;
        }
        if (salvandoPlano) return;
        setSalvandoPlano(true);
        try {
            const formData = new FormData();
            formData.append('ano', selectedAno);
            formData.append('mes', selectedMes);
            if (planejamentoFile) formData.append('planejamento', planejamentoFile);
            if (relatorioFile) formData.append('relatorio', relatorioFile);

            await uploadPlanoTrabalho(formData);

            setIsPlanoModalOpen(false);
            setPlanejamentoFile(null);
            setRelatorioFile(null);
            carregarPlanos();
            alert("Plano de trabalho salvo com sucesso!");
        } catch (error) {
            console.error("Erro no upload", error);
            alert("Erro ao enviar arquivos.");
        } finally {
            setSalvandoPlano(false);
        }
    };

    const handleDeletePlano = async (planoId) => {
        if (window.confirm("Certeza que deseja excluir este plano de trabalho e seus anexos? Esta ação não pode ser desfeita.")) {
            try {
                await deletePlanoTrabalho(planoId);
                carregarPlanos();
                alert("Plano excluído com sucesso!");
            } catch (error) {
                console.error("Erro ao excluir plano", error);
                alert(error.response?.data?.error || "Erro ao excluir o plano de trabalho.");
            }
        }
    };

    const handleOpenEdit = (plano) => {
        setSelectedAno(plano.ano);
        setSelectedMes(plano.mes);
        setPlanejamentoFile(null);
        setRelatorioFile(null);
        setIsEditingPlano(true);
        setIsPlanoModalOpen(true);
    };

    return (
        <div className="p-6 max-w-7xl mx-auto animate-fade-in space-y-8">
            {/* HEADER */}
            <div className="bg-gradient-to-r from-indigo-600 to-purple-700 p-8 rounded-2xl shadow-lg relative overflow-hidden text-white">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                    <FileText size={150} />
                </div>
                <div className="relative z-10">
                    <h1 className="text-3xl font-bold mb-2">
                        {professorId ? `Planos de Trabalho: ${professorNome}` : "Planos de Trabalho"}
                    </h1>
                    <p className="text-indigo-100 max-w-xl">
                        {professorId
                            ? "Visualize os planejamentos e relatórios mensais enviados por este professor."
                            : "Gerencie e envie seus planejamentos e relatórios mensais de forma centralizada."}
                    </p>
                </div>
            </div>

            {/* GESTÃO DE PLANOS DE TRABALHO */}
            <div>
                <div className="flex justify-between items-center mb-6">
                    <h2 className="text-xl font-bold text-gray-800 flex items-center gap-2">
                        <FileText className="text-indigo-600" /> {professorId ? `Planos de ${professorNome}` : "Meus Planos de Trabalho"}
                    </h2>
                    {!professorId && (
                        <button
                            onClick={() => {
                                setSelectedAno(2026);
                                setSelectedMes(new Date().getMonth() + 1);
                                setPlanejamentoFile(null);
                                setRelatorioFile(null);
                                setIsEditingPlano(false);
                                setIsPlanoModalOpen(true);
                            }}
                            className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 transition-colors shadow-sm"
                        >
                            <Plus size={20} /> Adicionar Plano
                        </button>
                    )}
                </div>

                {loadingPlanos ? (
                    <div className="flex justify-center p-8"><Loader2 className="animate-spin text-indigo-600" size={30} /></div>
                ) : planosList.length === 0 ? (
                    <div className="bg-white p-8 rounded-xl text-center shadow-sm border border-gray-100">
                        <p className="text-gray-500">Nenhum plano de trabalho enviado ainda.</p>
                    </div>
                ) : (
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                        <div className="overflow-x-auto">
                            <table className="min-w-full divide-y divide-gray-200">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Mês / Ano</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Plano de Trabalho</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Relatório</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Enviado em</th>
                                        <th className="px-6 py-3 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">Feedback da Coordenação</th>
                                        {!professorId && <th className="px-6 py-3 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">Ações</th>}
                                    </tr>
                                </thead>
                                <tbody className="bg-white divide-y divide-gray-200">
                                    {planosList.map(plano => (
                                        <tr key={plano.id}>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900 border-l-4 border-l-indigo-500 bg-indigo-50/20">
                                                {String(plano.mes).padStart(2, '0')} / {plano.ano}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {plano.caminho_planejamento ? (
                                                    <button onClick={() => { setCurrentPdfUrl(`https://somosconexaosocial.org${plano.caminho_planejamento}`); setPdfModalOpen(true); }} className="flex items-center gap-1 text-blue-600 hover:text-blue-800 font-medium bg-blue-50 px-3 py-1.5 rounded-lg w-max border border-blue-100 transition-colors">
                                                        <FileCheck size={16} /> Ver PDF
                                                    </button>
                                                ) : <span className="text-gray-400 text-[10px] uppercase tracking-wider font-bold bg-gray-100 px-2 py-1 rounded">Pendente</span>}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {plano.caminho_relatorio ? (
                                                    <button onClick={() => { setCurrentPdfUrl(`https://somosconexaosocial.org${plano.caminho_relatorio}`); setPdfModalOpen(true); }} className="flex items-center gap-1 text-green-600 hover:text-green-800 font-medium bg-green-50 px-3 py-1.5 rounded-lg w-max border border-green-100 transition-colors">
                                                        <FileCheck size={16} /> Ver PDF
                                                    </button>
                                                ) : <span className="text-gray-400 text-[10px] uppercase tracking-wider font-bold bg-gray-100 px-2 py-1 rounded">Pendente</span>}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 font-medium">
                                                {new Date(plano.created_at).toLocaleDateString('pt-BR')}
                                            </td>
                                            <td className="px-6 py-4 text-sm text-gray-500 max-w-xs">
                                                {editFeedbackId === plano.id ? (
                                                    <div className="flex flex-col gap-2">
                                                        <textarea
                                                            className="w-full border border-indigo-200 rounded-lg p-2 text-sm outline-none focus:ring-2 focus:ring-indigo-500"
                                                            rows="3"
                                                            value={tempFeedback}
                                                            onChange={(e) => setTempFeedback(e.target.value)}
                                                            placeholder="Adicione o feedback aqui..."
                                                        />
                                                        <div className="flex justify-end gap-2">
                                                            <button
                                                                onClick={() => setEditFeedbackId(null)}
                                                                className="text-xs text-gray-500 hover:text-gray-700 px-2 py-1"
                                                            >
                                                                Cancelar
                                                            </button>
                                                            <button
                                                                onClick={() => handleSaveFeedback(plano.id)}
                                                                className="text-xs bg-indigo-600 text-white hover:bg-indigo-700 px-3 py-1 rounded-md"
                                                            >
                                                                Salvar
                                                            </button>
                                                        </div>
                                                    </div>
                                                ) : (
                                                    <div className="flex justify-between items-start gap-2">
                                                        <div className="flex-1">
                                                            {plano.feedback_coordenador ? (
                                                                <div className="bg-indigo-50 border border-indigo-100 p-3 rounded-lg text-indigo-800 shadow-sm text-xs leading-relaxed">
                                                                    <span className="font-bold flex items-center gap-1 mb-1"><FileText size={12} /> Observação:</span>
                                                                    {plano.feedback_coordenador}
                                                                </div>
                                                            ) : (
                                                                <span className="text-gray-400 italic text-xs">Aguardando Avaliação</span>
                                                            )}
                                                        </div>
                                                        {professorId && (
                                                            <button
                                                                onClick={() => handleEditFeedback(plano)}
                                                                className="text-xs text-indigo-600 hover:text-indigo-800 font-medium underline shrink-0 cursor-pointer"
                                                            >
                                                                {plano.feedback_coordenador ? "Editar" : "Avaliar"}
                                                            </button>
                                                        )}
                                                    </div>
                                                )}
                                            </td>
                                            {!professorId && (
                                                <td className="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                                    <div className="flex justify-center gap-2">
                                                        <button
                                                            onClick={() => handleOpenEdit(plano)}
                                                            className="text-blue-600 hover:text-blue-900 bg-blue-50 p-2 rounded-lg transition-colors border border-blue-100"
                                                            title="Substituir Arquivos"
                                                        >
                                                            <Edit size={16} />
                                                        </button>
                                                        {!plano.feedback_coordenador ? (
                                                            <button
                                                                onClick={() => handleDeletePlano(plano.id)}
                                                                className="text-red-600 hover:text-red-900 bg-red-50 p-2 rounded-lg transition-colors border border-red-100"
                                                                title="Excluir Plano"
                                                            >
                                                                <Trash2 size={16} />
                                                            </button>
                                                        ) : (
                                                            <button
                                                                disabled
                                                                className="text-gray-400 bg-gray-50 p-2 rounded-lg cursor-not-allowed border border-gray-100"
                                                                title="Não é possível excluir plano com feedback"
                                                            >
                                                                <Trash2 size={16} />
                                                            </button>
                                                        )}
                                                    </div>
                                                </td>
                                            )}
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}
            </div>

            {/* MODAL DE UPLOAD DE PLANO DE TRABALHO */}
            {isPlanoModalOpen && (
                <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50 animate-fade-in">
                    <div className="bg-white rounded-2xl w-full max-w-lg shadow-2xl overflow-hidden animate-slide-up">
                        <div className="flex justify-between items-center p-6 border-b border-gray-100 bg-gray-50/50">
                            <h2 className="text-xl font-bold flex items-center gap-2 text-gray-800">
                                <Upload className="text-indigo-600" /> {isEditingPlano ? "Substituir" : "Upload de"} Plano de Trabalho
                            </h2>
                            <button onClick={() => setIsPlanoModalOpen(false)} className="text-gray-400 hover:text-red-500 transition-colors bg-white p-1 rounded-full shadow-sm">
                                <X size={24} />
                            </button>
                        </div>

                        <form onSubmit={handleUploadPlano} className="p-6 space-y-6">

                            <div className="grid grid-cols-2 gap-4">
                                <div>
                                    <label className="block text-sm font-semibold text-gray-700 mb-1">Ano</label>
                                    <select
                                        value={selectedAno}
                                        onChange={e => setSelectedAno(Number(e.target.value))}
                                        disabled={isEditingPlano}
                                        className={`w-full border border-gray-300 rounded-lg p-2.5 outline-none focus:ring-2 focus:ring-indigo-500/50 focus:border-indigo-500 transition-all font-medium ${isEditingPlano ? 'bg-gray-100 text-gray-500 cursor-not-allowed' : 'text-gray-700'}`}
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
                                        disabled={isEditingPlano}
                                        className={`w-full border border-gray-300 rounded-lg p-2.5 outline-none focus:ring-2 focus:ring-indigo-500/50 focus:border-indigo-500 transition-all font-medium ${isEditingPlano ? 'bg-gray-100 text-gray-500 cursor-not-allowed' : 'text-gray-700'}`}
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
                                    <label className="block text-sm font-bold text-gray-700 mb-1">1. Planejamento Mensal (PDF)</label>
                                    <p className="text-xs text-gray-500 mb-2">Tamanho máximo: 7MB.</p>
                                    <input
                                        type="file"
                                        accept="application/pdf"
                                        onChange={e => {
                                            const file = e.target.files[0];
                                            if (file && file.size > 7 * 1024 * 1024) {
                                                alert("O arquivo de Planejamento excede o limite de 7MB!");
                                                e.target.value = null; // reseta o input visualmente
                                                setPlanejamentoFile(null);
                                            } else {
                                                setPlanejamentoFile(file);
                                            }
                                        }}
                                        className="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-bold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100 cursor-pointer transition-colors"
                                    />
                                </div>

                                <div className="relative border-2 border-dashed border-gray-300 rounded-xl p-4 hover:border-indigo-400 transition-colors bg-gray-50/50 group">
                                    <label className="block text-sm font-bold text-gray-700 mb-1">2. Relatório Mensal (PDF)</label>
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

                            <div className="bg-blue-50 text-blue-800 p-3 rounded-lg flex items-start gap-2 text-sm border border-blue-100">
                                <AlertCircle size={20} className="shrink-0 text-blue-500" />
                                <p className="font-medium">Você pode enviar os dois arquivos de uma vez ou atualizar um deles separadamente.</p>
                            </div>

                            <div className="flex justify-end pt-4 border-t border-gray-100 mt-6 gap-3">
                                <button type="button" onClick={() => setIsPlanoModalOpen(false)} className="px-5 py-2.5 text-gray-600 bg-gray-100 hover:bg-gray-200 rounded-lg font-bold transition-colors">
                                    Cancelar
                                </button>
                                <button type="submit" disabled={salvandoPlano} className={`px-5 py-2.5 text-white rounded-lg font-bold flex items-center gap-2 transition-all shadow-sm ${salvandoPlano ? 'bg-indigo-400 cursor-not-allowed' : 'bg-indigo-600 hover:bg-indigo-700 shadow-indigo-200'}`}>
                                    <CheckCircle size={18} /> {salvandoPlano ? 'Salvando...' : 'Salvar Arquivos'}
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

export default PlanosTrabalho;
