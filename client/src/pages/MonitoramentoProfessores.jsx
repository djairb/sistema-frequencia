import { useState, useEffect } from 'react';
import { getProfessoresGeral, getMonitoramentoPlanos, getMonitoramentoAulas, salvarFeedbackPlano } from '../services/sysconex';
import { Search, FileText, MonitorPlay, Save, Calendar, CheckCircle } from 'lucide-react';

export default function MonitoramentoProfessores() {
    const [professores, setProfessores] = useState([]);
    const [loadingProfs, setLoadingProfs] = useState(true);

    // Filtros
    const [selectedProfId, setSelectedProfId] = useState('');
    const [selectedUsuarioId, setSelectedUsuarioId] = useState(''); // para os Planos
    const [selectedAno, setSelectedAno] = useState(new Date().getFullYear().toString());
    const [selectedMes, setSelectedMes] = useState((new Date().getMonth() + 1).toString().padStart(2, '0'));

    // Dados carregados
    const [plano, setPlano] = useState(null);
    const [feedback, setFeedback] = useState('');
    const [aulas, setAulas] = useState([]);
    const [loadingData, setLoadingData] = useState(false);
    const [dataFetched, setDataFetched] = useState(false);

    useEffect(() => {
        carregarProfessores();
    }, []);

    async function carregarProfessores() {
        try {
            const data = await getProfessoresGeral();
            setProfessores(data);
        } catch (error) {
            console.error(error);
        } finally {
            setLoadingProfs(false);
        }
    }

    const handleBuscar = async () => {
        if (!selectedProfId || !selectedUsuarioId) return alert('Selecione um professor.');

        setLoadingData(true);
        setDataFetched(false);

        try {
            // Busca planos e aulas paralelamente
            const [planosData, aulasData] = await Promise.all([
                getMonitoramentoPlanos(selectedUsuarioId, selectedAno, selectedMes),
                getMonitoramentoAulas(selectedProfId, selectedAno, selectedMes) // selectedProfId é o colaborador_id
            ]);

            setPlano(planosData);
            setFeedback(planosData?.feedback_coordenador || '');
            setAulas(aulasData || []);
            setDataFetched(true);
        } catch (error) {
            console.error(error);
            alert('Erro ao buscar dados de monitoramento.');
        } finally {
            setLoadingData(false);
        }
    };

    const handleProfChange = (e) => {
        const profId = e.target.value;
        setSelectedProfId(profId);

        // Procura o respectivo usuario_id
        const prof = professores.find(p => p.id.toString() === profId);
        if (prof) {
            setSelectedUsuarioId(prof.usuario_id);
        } else {
            setSelectedUsuarioId('');
        }
        // Reseta view
        setDataFetched(false);
    };

    const handleSalvarFeedback = async () => {
        if (!plano) return;
        try {
            await salvarFeedbackPlano(plano.id, feedback);
            alert('Feedback salvo com sucesso!');
        } catch (error) {
            console.error(error);
            alert('Erro ao salvar feedback.');
        }
    };

    const mesAtualNome = new Date(selectedAno, parseInt(selectedMes) - 1).toLocaleString('pt-BR', { month: 'long' });

    return (
        <div className="animate-fade-in max-w-7xl mx-auto pb-10">

            <div className="mb-6">
                <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                    <MonitorPlay className="text-blue-600" /> Monitoramento de Professores
                </h1>
                <p className="text-gray-500 mt-1">Acompanhe os planos de trabalho e auditorias de aulas ministradas pelos professores.</p>
            </div>

            {/* PAINEL DE FILTROS */}
            <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 mb-8 mt-2 flex flex-col md:flex-row gap-4 md:items-end">

                <div className="flex-[2] min-w-[250px]">
                    <label className="block text-sm font-semibold text-gray-700 mb-2">Professor</label>
                    <select
                        className="w-full border-gray-200 border p-3 rounded-xl focus:ring-2 ring-blue-500 outline-none text-gray-700 transition-all font-medium bg-gray-50 focus:bg-white"
                        value={selectedProfId}
                        onChange={handleProfChange}
                        disabled={loadingProfs}
                    >
                        <option value="">Selecione um Professor...</option>
                        {professores.map(p => (
                            <option key={p.id} value={p.id}>{p.nome_completo}</option>
                        ))}
                    </select>
                </div>

                <div className="w-full md:w-32">
                    <label className="block text-sm font-semibold text-gray-700 mb-2">Ano</label>
                    <select
                        className="w-full border-gray-200 border p-3 rounded-xl focus:ring-2 ring-blue-500 outline-none text-gray-700 transition-all font-medium bg-gray-50 focus:bg-white"
                        value={selectedAno}
                        onChange={e => { setSelectedAno(e.target.value); setDataFetched(false); }}
                    >
                        {Array.from({ length: 5 }).map((_, i) => {
                            const ano = 2026 + i;
                            return <option key={ano} value={ano}>{ano}</option>
                        })}
                    </select>
                </div>

                <div className="w-full md:w-48">
                    <label className="block text-sm font-semibold text-gray-700 mb-2">Mês</label>
                    <select
                        className="w-full border-gray-200 border p-3 rounded-xl focus:ring-2 ring-blue-500 outline-none text-gray-700 transition-all font-medium bg-gray-50 focus:bg-white"
                        value={selectedMes}
                        onChange={e => { setSelectedMes(e.target.value); setDataFetched(false); }}
                    >
                        <option value="01">Janeiro</option>
                        <option value="02">Fevereiro</option>
                        <option value="03">Março</option>
                        <option value="04">Abril</option>
                        <option value="05">Maio</option>
                        <option value="06">Junho</option>
                        <option value="07">Julho</option>
                        <option value="08">Agosto</option>
                        <option value="09">Setembro</option>
                        <option value="10">Outubro</option>
                        <option value="11">Novembro</option>
                        <option value="12">Dezembro</option>
                    </select>
                </div>

                <button
                    onClick={handleBuscar}
                    disabled={!selectedProfId || loadingData}
                    className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-xl flex items-center justify-center gap-2 transition-all transform active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed shadow-md shadow-blue-200 h-[50px]"
                >
                    {loadingData ? <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div> : <><Search size={18} /> Consultar</>}
                </button>

            </div>

            {/* ÁREA DE RESULTADOS */}
            {dataFetched && (
                <div className="space-y-8 animate-fade-in">

                    <div className="flex items-center gap-3">
                        <div className="h-px bg-gray-300 flex-1"></div>
                        <span className="text-gray-500 font-semibold text-sm uppercase px-4 bg-gray-50 rounded-full py-1">Desempenho de {mesAtualNome} de {selectedAno}</span>
                        <div className="h-px bg-gray-300 flex-1"></div>
                    </div>

                    {/* SESSÃO 1: PLANOS DE TRABALHO */}
                    <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                        <h2 className="text-xl font-bold text-gray-800 mb-6 flex items-center gap-2">
                            <FileText className="text-indigo-600" /> Planos e Relatórios
                        </h2>

                        {!plano ? (
                            <div className="p-8 text-center border-2 border-dashed border-gray-200 rounded-xl bg-gray-50">
                                <p className="text-gray-500 font-medium">Nenhum plano de trabalho enviado para este mês.</p>
                            </div>
                        ) : (
                            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                {/* Visualização de PDFs */}
                                <div className="space-y-6">

                                    <div>
                                        <h3 className="font-bold text-gray-700 mb-3 flex items-center gap-2"><CheckCircle size={16} className="text-green-500" /> Planejamento Mensal</h3>
                                        {plano.caminho_planejamento ? (
                                            <div className="h-96 w-full border rounded-xl overflow-hidden shadow-sm bg-gray-100">
                                                <iframe
                                                    src={`https://somosconexaosocial.org${plano.caminho_planejamento}`}
                                                    className="w-full h-full"
                                                    title="Planejamento"
                                                />
                                            </div>
                                        ) : <p className="text-sm text-gray-400 italic">Arquivo não anexado.</p>}
                                    </div>

                                    <div>
                                        <h3 className="font-bold text-gray-700 mb-3 flex items-center gap-2"><CheckCircle size={16} className="text-green-500" /> Relatório Mensal</h3>
                                        {plano.caminho_relatorio ? (
                                            <div className="h-96 w-full border rounded-xl overflow-hidden shadow-sm bg-gray-100">
                                                <iframe
                                                    src={`https://somosconexaosocial.org${plano.caminho_relatorio}`}
                                                    className="w-full h-full"
                                                    title="Relatorio"
                                                />
                                            </div>
                                        ) : <p className="text-sm text-gray-400 italic">Arquivo não anexado.</p>}
                                    </div>

                                </div>

                                {/* Área de Feedback */}
                                <div className="bg-indigo-50/50 p-6 rounded-2xl border border-indigo-100 flex flex-col h-full">
                                    <h3 className="font-bold text-indigo-900 mb-4 flex items-center gap-2">
                                        Feedback da Coordenação
                                    </h3>
                                    <p className="text-sm text-indigo-700 mb-4">
                                        Faça observações sobre os arquivos de plano de trabalho e relatório para manter o histórico de acompanhamento.
                                    </p>
                                    <textarea
                                        className="w-full flex-1 min-h-[200px] border border-indigo-200 p-4 rounded-xl focus:ring-2 ring-indigo-500 outline-none resize-none text-gray-700 bg-white"
                                        placeholder="Adicione um comentário avaliativo ou nota de auditoria..."
                                        value={feedback}
                                        onChange={(e) => setFeedback(e.target.value)}
                                    />
                                    <button
                                        onClick={handleSalvarFeedback}
                                        className="mt-4 w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3 rounded-xl flex items-center justify-center gap-2 transition-transform active:scale-95 shadow-lg shadow-indigo-200"
                                    >
                                        <Save size={18} /> Salvar Feedback
                                    </button>
                                </div>

                            </div>
                        )}
                    </div>

                    {/* SESSÃO 2: AUDITORIA DE AULAS P/ DIA */}
                    <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 mt-8">
                        <h2 className="text-xl font-bold text-gray-800 mb-6 flex items-center gap-2">
                            <Calendar className="text-orange-500" /> Histórico de Aulas e Evidências
                        </h2>

                        {aulas.length === 0 ? (
                            <div className="p-8 text-center border-2 border-dashed border-gray-200 rounded-xl bg-gray-50">
                                <p className="text-gray-500 font-medium">Nenhuma aula registrada pelo professor neste mês.</p>
                            </div>
                        ) : (
                            <div className="space-y-6">
                                {aulas.map((aula, i) => (
                                    <div key={aula.id} className="border border-gray-200 rounded-xl overflow-hidden hover:shadow-md transition-shadow bg-gray-50/30">

                                        <div className="bg-gray-100 px-5 py-3 border-b border-gray-200 flex flex-wrap items-center justify-between gap-4">
                                            <span className="font-bold text-gray-700 bg-white px-3 py-1 rounded text-sm shadow-sm">
                                                {new Date(aula.data_aula).toLocaleDateString('pt-BR')}
                                            </span>
                                            <span className="text-sm font-semibold text-blue-800">
                                                Turma: {aula.turma_nome}
                                            </span>
                                        </div>

                                        <div className="p-5 grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div>
                                                <h4 className="font-bold text-gray-800 mb-1">{aula.titulo_aula || 'Sem título registrado'}</h4>
                                                <p className="text-gray-600 text-sm whitespace-pre-line">{aula.conteudo}</p>
                                            </div>

                                            {/* Visualização de fotos / Evidências */}
                                            <div className="border-t md:border-t-0 md:border-l border-gray-200 pt-4 md:pt-0 md:pl-6">
                                                <h5 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">Evidências (Fotos)</h5>
                                                {aula.fotos && aula.fotos.length > 0 ? (
                                                    <div className="grid grid-cols-3 sm:grid-cols-4 gap-2">
                                                        {aula.fotos.map(foto => (
                                                            <a
                                                                key={foto.id}
                                                                href={`https://somosconexaosocial.org${foto.caminho_foto}`}
                                                                target="_blank"
                                                                rel="noreferrer"
                                                                className="aspect-square rounded-lg overflow-hidden border border-gray-200 hover:opacity-80 transition-opacity block bg-gray-100"
                                                            >
                                                                <img src={`https://somosconexaosocial.org${foto.caminho_foto}`} alt="Evidencia" className="w-full h-full object-cover" />
                                                            </a>
                                                        ))}
                                                    </div>
                                                ) : (
                                                    <p className="text-sm text-red-400/80 italic font-medium">Sem nenhuma foto anexada.</p>
                                                )}
                                            </div>
                                        </div>

                                    </div>
                                ))}
                            </div>
                        )}
                    </div>

                </div>
            )}

        </div>
    );
}
