import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getPlanosTrabalhoColaborador, salvarFeedbackPlano } from '../services/sysconex';
import {
    FileText, X, FileCheck, Loader2, ArrowLeft, CheckCircle, AlertCircle
} from 'lucide-react';

const MESES = ['', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

const RelatoriosColaboradorView = () => {
    const { id: colaboradorId } = useParams();
    const navigate = useNavigate();

    const [relatoriosList, setRelatoriosList] = useState([]);
    const [loadingRelatorios, setLoadingRelatorios] = useState(true);
    const [colaboradorNome, setColaboradorNome] = useState('Colaborador');
    const [pdfModalOpen, setPdfModalOpen] = useState(false);
    const [currentPdfUrl, setCurrentPdfUrl] = useState('');
    const [editFeedbackId, setEditFeedbackId] = useState(null);
    const [tempFeedback, setTempFeedback] = useState('');
    const [savingFeedback, setSavingFeedback] = useState(false);

    useEffect(() => {
        carregarRelatorios();
    }, [colaboradorId]);

    const carregarRelatorios = async () => {
        try {
            setLoadingRelatorios(true);
            const response = await getPlanosTrabalhoColaborador(colaboradorId);
            const data = response.planos || [];
            setColaboradorNome(response.professorNome || 'Colaborador');

            const sorted = data.sort((a, b) => {
                const anoA = Number(a.ano), anoB = Number(b.ano);
                const mesA = Number(a.mes), mesB = Number(b.mes);
                if (anoA !== anoB) return anoB - anoA;
                return mesA - mesB;
            });
            setRelatoriosList(sorted);
        } catch (error) {
            console.error('Erro ao carregar relatórios do colaborador', error);
        } finally {
            setLoadingRelatorios(false);
        }
    };

    const handleEditFeedback = (relatorio) => {
        setEditFeedbackId(relatorio.id);
        setTempFeedback(relatorio.feedback_coordenador || '');
    };

    const handleSaveFeedback = async (relatorioId) => {
        try {
            setSavingFeedback(true);
            await salvarFeedbackPlano(relatorioId, tempFeedback);
            setEditFeedbackId(null);
            carregarRelatorios();
            alert('Feedback salvo com sucesso!');
        } catch (error) {
            console.error('Erro ao salvar feedback', error);
            alert('Erro ao salvar feedback.');
        } finally {
            setSavingFeedback(false);
        }
    };

    const handleOpenPdf = (url) => {
        setCurrentPdfUrl(`https://somosconexaosocial.org${url}`);
        setPdfModalOpen(true);
    };

    const pendentes = relatoriosList.filter(r => !r.feedback_coordenador).length;
    const avaliados = relatoriosList.filter(r => r.feedback_coordenador).length;

    return (
        <div className="p-6 max-w-7xl mx-auto animate-fade-in space-y-8">

            {/* Botão Voltar */}
            <button
                onClick={() => navigate('/app/colaboradores')}
                className="flex items-center gap-2 text-sm font-medium text-gray-500 hover:text-indigo-600 transition-colors group"
            >
                <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
                Voltar para Colaboradores
            </button>

            {/* HEADER */}
            <div className="bg-gradient-to-r from-indigo-600 to-purple-700 p-8 rounded-2xl shadow-lg relative overflow-hidden text-white">
                <div className="absolute top-0 right-0 p-4 opacity-10">
                    <FileText size={150} />
                </div>
                <div className="relative z-10">
                    <p className="text-indigo-200 text-sm font-semibold uppercase tracking-widest mb-1">Relatórios Mensais</p>
                    <h1 className="text-3xl font-bold mb-2">{colaboradorNome}</h1>
                    <p className="text-indigo-100 max-w-xl">
                        Visualize os relatórios mensais enviados por este colaborador e registre seu feedback.
                    </p>
                </div>
            </div>

            {/* CARDS DE RESUMO */}
            {!loadingRelatorios && relatoriosList.length > 0 && (
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div className="bg-white rounded-xl p-5 border border-gray-100 shadow-sm flex items-center gap-4">
                        <div className="w-12 h-12 rounded-full bg-indigo-50 flex items-center justify-center text-indigo-600 font-bold text-xl">{relatoriosList.length}</div>
                        <div>
                            <p className="text-xs text-gray-500 uppercase font-bold tracking-wider">Total Enviados</p>
                            <p className="text-sm font-semibold text-gray-700">Relatórios</p>
                        </div>
                    </div>
                    <div className="bg-white rounded-xl p-5 border border-gray-100 shadow-sm flex items-center gap-4">
                        <div className="w-12 h-12 rounded-full bg-yellow-50 flex items-center justify-center text-yellow-600 font-bold text-xl">{pendentes}</div>
                        <div>
                            <p className="text-xs text-gray-500 uppercase font-bold tracking-wider">Aguardando</p>
                            <p className="text-sm font-semibold text-gray-700">Avaliação</p>
                        </div>
                    </div>
                    <div className="bg-white rounded-xl p-5 border border-gray-100 shadow-sm flex items-center gap-4">
                        <div className="w-12 h-12 rounded-full bg-green-50 flex items-center justify-center text-green-600 font-bold text-xl">{avaliados}</div>
                        <div>
                            <p className="text-xs text-gray-500 uppercase font-bold tracking-wider">Avaliados</p>
                            <p className="text-sm font-semibold text-gray-700">Com Feedback</p>
                        </div>
                    </div>
                </div>
            )}

            {/* LISTAGEM */}
            <div>
                <div className="flex justify-between items-center mb-6">
                    <h2 className="text-xl font-bold text-gray-800 flex items-center gap-2">
                        <FileText className="text-indigo-600" /> Relatórios Mensais
                    </h2>
                </div>

                {loadingRelatorios ? (
                    <div className="flex justify-center p-12">
                        <Loader2 className="animate-spin text-indigo-600" size={32} />
                    </div>
                ) : relatoriosList.length === 0 ? (
                    <div className="bg-white p-12 rounded-xl text-center shadow-sm border border-gray-100">
                        <FileText size={48} className="mx-auto text-gray-200 mb-4" />
                        <h3 className="text-lg font-semibold text-gray-700 mb-1">Nenhum relatório enviado</h3>
                        <p className="text-gray-400 text-sm">Este colaborador ainda não enviou nenhum relatório mensal.</p>
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
                                    </tr>
                                </thead>
                                <tbody className="bg-white divide-y divide-gray-200">
                                    {relatoriosList.map(rel => (
                                        <tr key={rel.id} className="hover:bg-gray-50/50 transition-colors">
                                            <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900 border-l-4 border-l-indigo-500 bg-indigo-50/20">
                                                <span className="block">{MESES[Number(rel.mes)]}</span>
                                                <span className="text-xs text-gray-400 font-medium">{rel.ano}</span>
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                {rel.caminho_relatorio ? (
                                                    <button
                                                        onClick={() => handleOpenPdf(rel.caminho_relatorio)}
                                                        className="flex items-center gap-1.5 text-green-600 hover:text-green-800 font-medium bg-green-50 px-3 py-1.5 rounded-lg w-max border border-green-100 transition-colors"
                                                    >
                                                        <FileCheck size={16} /> Ver PDF
                                                    </button>
                                                ) : (
                                                    <span className="text-gray-400 text-[10px] uppercase tracking-wider font-bold bg-gray-100 px-2 py-1 rounded">
                                                        Pendente
                                                    </span>
                                                )}
                                            </td>
                                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 font-medium">
                                                {new Date(rel.created_at).toLocaleDateString('pt-BR')}
                                            </td>
                                            <td className="px-6 py-4 text-sm text-gray-500 max-w-xs">
                                                {editFeedbackId === rel.id ? (
                                                    <div className="flex flex-col gap-2">
                                                        <textarea
                                                            className="w-full border border-indigo-200 rounded-lg p-2 text-sm outline-none focus:ring-2 focus:ring-indigo-500 min-w-[240px]"
                                                            rows="3"
                                                            value={tempFeedback}
                                                            onChange={(e) => setTempFeedback(e.target.value)}
                                                            placeholder="Adicione seu feedback aqui..."
                                                            autoFocus
                                                        />
                                                        <div className="flex justify-end gap-2">
                                                            <button
                                                                onClick={() => setEditFeedbackId(null)}
                                                                className="text-xs text-gray-500 hover:text-gray-700 px-3 py-1.5 rounded-md border border-gray-200 hover:bg-gray-100 transition-colors"
                                                                disabled={savingFeedback}
                                                            >
                                                                Cancelar
                                                            </button>
                                                            <button
                                                                onClick={() => handleSaveFeedback(rel.id)}
                                                                className="text-xs bg-indigo-600 text-white hover:bg-indigo-700 px-3 py-1.5 rounded-md flex items-center gap-1 transition-colors disabled:opacity-70"
                                                                disabled={savingFeedback}
                                                            >
                                                                {savingFeedback ? (
                                                                    <Loader2 size={12} className="animate-spin" />
                                                                ) : (
                                                                    <CheckCircle size={12} />
                                                                )}
                                                                Salvar
                                                            </button>
                                                        </div>
                                                    </div>
                                                ) : (
                                                    <div className="flex justify-between items-start gap-2">
                                                        <div className="flex-1">
                                                            {rel.feedback_coordenador ? (
                                                                <div className="bg-indigo-50 border border-indigo-100 p-3 rounded-lg text-indigo-800 shadow-sm text-xs leading-relaxed">
                                                                    <span className="font-bold flex items-center gap-1 mb-1">
                                                                        <FileText size={12} /> Observação:
                                                                    </span>
                                                                    {rel.feedback_coordenador}
                                                                </div>
                                                            ) : (
                                                                <span className="text-gray-400 italic text-xs flex items-center gap-1">
                                                                    <AlertCircle size={12} className="text-yellow-400" />
                                                                    Aguardando Avaliação
                                                                </span>
                                                            )}
                                                        </div>
                                                        <button
                                                            onClick={() => handleEditFeedback(rel)}
                                                            className="text-xs text-indigo-600 hover:text-indigo-800 font-semibold underline shrink-0 cursor-pointer whitespace-nowrap"
                                                        >
                                                            {rel.feedback_coordenador ? 'Editar' : 'Avaliar'}
                                                        </button>
                                                    </div>
                                                )}
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}
            </div>

            {/* MODAL DE VISUALIZAÇÃO DE PDF */}
            {pdfModalOpen && (
                <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50 animate-fade-in">
                    <div className="bg-white rounded-2xl w-full max-w-4xl h-[85vh] shadow-2xl flex flex-col overflow-hidden">
                        <div className="flex justify-between items-center p-4 border-b bg-gray-50/50">
                            <h2 className="text-xl font-bold flex items-center gap-2 text-gray-800">
                                <FileText className="text-indigo-600" /> Visualizar Documento
                            </h2>
                            <div className="flex items-center gap-3">
                                <a
                                    href={currentPdfUrl}
                                    download
                                    target="_blank"
                                    rel="noreferrer"
                                    className="text-sm font-bold bg-indigo-100 text-indigo-700 px-4 py-2 rounded-lg hover:bg-indigo-200 transition-colors flex items-center gap-2 shadow-sm"
                                >
                                    Baixar
                                </a>
                                <button
                                    onClick={() => setPdfModalOpen(false)}
                                    className="text-gray-400 hover:text-red-500 transition-colors bg-white p-1.5 rounded-full shadow-sm"
                                >
                                    <X size={24} />
                                </button>
                            </div>
                        </div>
                        <div className="flex-1 bg-gray-100 p-2">
                            <iframe
                                src={currentPdfUrl}
                                className="w-full h-full rounded-xl border border-gray-200 shadow-inner"
                                title="Visualizador de PDF"
                            />
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default RelatoriosColaboradorView;
