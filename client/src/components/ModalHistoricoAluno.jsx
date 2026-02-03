import { useState, useEffect } from 'react';
import { X, Calendar, MessageSquare, CheckCircle, XCircle, AlertCircle } from 'lucide-react';
import { getHistoricoFrequenciaAluno } from '../services/sysconex';

export default function ModalHistoricoAluno({ matriculaId, alunoNome, onClose }) {
    const [historico, setHistorico] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if (matriculaId) {
            carregarHistorico();
        }
    }, [matriculaId]);

    async function carregarHistorico() {
        try {
            setLoading(true);
            const data = await getHistoricoFrequenciaAluno(matriculaId);
            setHistorico(data);
        } catch (error) {
            console.error(error);
            alert("Erro ao carregar histórico.");
        } finally {
            setLoading(false);
        }
    }

    if (!matriculaId) return null;

    return (
        <div className="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4 backdrop-blur-sm animate-fade-in">
            <div className="bg-white rounded-2xl shadow-xl w-full max-w-2xl overflow-hidden flex flex-col max-h-[90vh]">

                {/* Header */}
                <div className="p-5 border-b bg-gray-50 flex justify-between items-center">
                    <div>
                        <h3 className="font-bold text-lg text-gray-800">Histórico de Frequência</h3>
                        <p className="text-sm text-gray-500">{alunoNome}</p>
                    </div>
                    <button onClick={onClose} className="p-2 hover:bg-gray-200 rounded-full transition-colors">
                        <X size={20} className="text-gray-500" />
                    </button>
                </div>

                {/* Content */}
                <div className="flex-1 overflow-y-auto p-0">
                    {loading ? (
                        <div className="p-10 text-center text-gray-400">Carregando...</div>
                    ) : historico.length === 0 ? (
                        <div className="p-10 text-center text-gray-400">Nenhum registro de aula para este aluno.</div>
                    ) : (
                        <table className="w-full text-sm text-left">
                            <thead className="bg-gray-50 text-gray-600 font-bold sticky top-0 border-b">
                                <tr>
                                    <th className="px-5 py-3">Data / Aula</th>
                                    <th className="px-5 py-3 text-center">Status</th>
                                    <th className="px-5 py-3">Observação / Justificativa</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-gray-100">
                                {historico.map((item, idx) => (
                                    <tr key={idx} className="hover:bg-gray-50">
                                        <td className="px-5 py-4">
                                            <div className="font-bold text-gray-700 flex items-center gap-2">
                                                <Calendar size={14} className="text-blue-500" />
                                                {new Date(item.data_aula).toLocaleDateString('pt-BR')}
                                            </div>
                                            <p className="text-xs text-gray-500 mt-1 line-clamp-1">{item.conteudo}</p>
                                            <p className="text-[10px] text-gray-400 mt-1">Prof. {item.professor}</p>
                                        </td>
                                        <td className="px-5 py-4 text-center">
                                            {item.status === 'Presente' && (
                                                <span className="inline-flex items-center gap-1 bg-green-100 text-green-700 px-2 py-1 rounded-full text-xs font-bold">
                                                    <CheckCircle size={12} /> Presente
                                                </span>
                                            )}
                                            {item.status === 'Ausente' && (
                                                <span className="inline-flex items-center gap-1 bg-red-100 text-red-700 px-2 py-1 rounded-full text-xs font-bold">
                                                    <XCircle size={12} /> Falta
                                                </span>
                                            )}
                                            {item.status === 'Justificado' && (
                                                <span className="inline-flex items-center gap-1 bg-yellow-100 text-yellow-700 px-2 py-1 rounded-full text-xs font-bold">
                                                    <AlertCircle size={12} /> Justificado
                                                </span>
                                            )}
                                        </td>
                                        <td className="px-5 py-4">
                                            {item.observacao ? (
                                                <div className="flex items-start gap-2 text-gray-600">
                                                    <MessageSquare size={14} className="mt-0.5 text-gray-400 flex-shrink-0" />
                                                    <span className="italic">"{item.observacao}"</span>
                                                </div>
                                            ) : (
                                                <span className="text-gray-300">-</span>
                                            )}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    )}
                </div>

                <div className="p-4 border-t bg-gray-50 text-right">
                    <button onClick={onClose} className="px-4 py-2 bg-gray-200 hover:bg-gray-300 rounded-lg text-sm font-bold text-gray-700 transition-colors">
                        Fechar
                    </button>
                </div>
            </div>
        </div>
    );
}
