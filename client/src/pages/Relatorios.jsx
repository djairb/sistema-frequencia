// ... imports ...
import { useState } from 'react';
import {
    api, getTurmaEstatisticas, getHistoricoAulas,
    searchBeneficiarios, getHistoricoGeral
} from '../services/sysconex';
import {
    BarChart2, AlertCircle, Search, Filter, Folder, Users,
    ArrowRight, PieChart, ChevronDown, CheckCircle, X, Printer, User, FileText, Calendar
} from 'lucide-react';
import { useEffect } from 'react';
// ... (ModalHistoricoAluno import removed or kept if needed, but we make a new general one)

export default function Relatorios() {
    const [abaAtiva, setAbaAtiva] = useState('turmas'); // 'turmas' | 'busca'

    // Dados Turmas
    const [projetos, setProjetos] = useState([]);
    const [turmas, setTurmas] = useState([]);

    // Filtros Turma
    const [filtroProjeto, setFiltroProjeto] = useState('');
    const [turmaSelecionada, setTurmaSelecionada] = useState(null);
    const [estatisticas, setEstatisticas] = useState(null);

    // Dados Busca
    const [termoBusca, setTermoBusca] = useState('');
    const [resultadosBusca, setResultadosBusca] = useState([]);
    const [buscando, setBuscando] = useState(false);

    // Modal Histórico Geral
    const [historicoGeral, setHistoricoGeral] = useState(null); // Dados completos do aluno
    const [modalHistoricoOpen, setModalHistoricoOpen] = useState(false);

    useEffect(() => {
        carregarDadosIniciais();
    }, []);

    useEffect(() => {
        if (turmaSelecionada && abaAtiva === 'turmas') {
            carregarStatsTurma(turmaSelecionada.id);
        } else {
            setEstatisticas(null);
        }
    }, [turmaSelecionada, abaAtiva]);

    // ... carregarDadosIniciais e carregarStatsTurma (iguais) ...
    async function carregarDadosIniciais() {
        try {
            const [resProj, resTurmas] = await Promise.all([
                api.get('/projetos'),
                api.get('/turmas')
            ]);
            setProjetos(resProj.data);
            setTurmas(resTurmas.data);
        } catch (error) {
            console.error(error);
        }
    }

    async function carregarStatsTurma(turmaId) {
        try {
            const dados = await getTurmaEstatisticas(turmaId);
            setEstatisticas(dados);
        } catch (error) {
            console.error(error);
        }
    }

    // --- FUNÇÕES DE BUSCA ---
    async function handleBuscar(e) {
        e.preventDefault();
        if (termoBusca.length < 3) return;
        setBuscando(true);
        try {
            const res = await searchBeneficiarios(termoBusca);
            setResultadosBusca(res);
        } catch (error) {
            console.error(error);
        } finally {
            setBuscando(false);
        }
    }

    async function abrirHistoricoGeral(idBeneficiario) {
        try {
            const dados = await getHistoricoGeral(idBeneficiario);
            setHistoricoGeral(dados);
            setModalHistoricoOpen(true);
        } catch (error) {
            alert("Erro ao carregar histórico.");
        }
    }

    // Filtros Turma
    const turmasFiltradas = turmas.filter(t => {
        if (filtroProjeto && t.projeto_id !== Number(filtroProjeto)) return false;
        return true;
    });

    // ... helpers de estatisticas ...

    return (
        <div className="animate-fade-in max-w-7xl mx-auto pb-10">
            {/* Header e Abas */}
            <div className="flex flex-col md:flex-row justify-between items-center mb-6 gap-4">
                <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                    <BarChart2 className="text-blue-600" /> Relatórios de Desempenho
                </h1>

                <div className="bg-white p-1 rounded-lg border border-gray-200 flex shadow-sm">
                    <button
                        onClick={() => setAbaAtiva('turmas')}
                        className={`px-4 py-2 text-sm font-medium rounded-md transition-colors flex items-center gap-2 ${abaAtiva === 'turmas' ? 'bg-blue-50 text-blue-700' : 'text-gray-500 hover:text-gray-700'
                            }`}
                    >
                        <Folder size={16} /> Por Turma
                    </button>
                    <button
                        onClick={() => setAbaAtiva('busca')}
                        className={`px-4 py-2 text-sm font-medium rounded-md transition-colors flex items-center gap-2 ${abaAtiva === 'busca' ? 'bg-blue-50 text-blue-700' : 'text-gray-500 hover:text-gray-700'
                            }`}
                    >
                        <Search size={16} /> Busca Individual
                    </button>
                </div>
            </div>

            {/* --- ABA TURMAS --- */}
            {abaAtiva === 'turmas' && (
                <>
                    {/* SELEÇÃO DE TURMA (Filtros existentes) */}
                    <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-8">
                        {/* ... Código dos selects de projeto e turma ... */}
                        {/* REPETINDO A LOGICA DE RENDERIZAÇÃO DOS SELECTS AQUI PARA NÃO QUEBRAR O LAYOUT ANTERIOR */}
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div>
                                <label className="block text-sm font-medium text-gray-600 mb-1">Filtrar por Projeto</label>
                                <div className="relative">
                                    <Folder className="absolute left-3 top-3 text-gray-400" size={18} />
                                    <select
                                        className="w-full pl-10 pr-4 py-2.5 border rounded-lg appearance-none bg-white focus:ring-2 focus:ring-blue-500 outline-none text-gray-700"
                                        value={filtroProjeto}
                                        onChange={e => {
                                            setFiltroProjeto(e.target.value);
                                            setTurmaSelecionada(null);
                                        }}
                                    >
                                        <option value="">Todos os Projetos</option>
                                        {projetos.map(p => (
                                            <option key={p.id} value={p.id}>{p.titulo}</option>
                                        ))}
                                    </select>
                                    <ChevronDown size={16} className="absolute right-3 top-3.5 text-gray-400 pointer-events-none" />
                                </div>
                            </div>

                            <div className="lg:col-span-2">
                                <label className="block text-sm font-medium text-gray-600 mb-1">Selecione uma Turma</label>
                                <div className="relative">
                                    <Users className="absolute left-3 top-3 text-gray-400" size={18} />
                                    <select
                                        className="w-full pl-10 pr-4 py-2.5 border rounded-lg appearance-none bg-white focus:ring-2 focus:ring-blue-500 outline-none text-gray-700 disabled:bg-gray-100"
                                        disabled={turmasFiltradas.length === 0}
                                        value={turmaSelecionada?.id || ''}
                                        onChange={e => {
                                            const t = turmas.find(x => x.id === Number(e.target.value));
                                            setTurmaSelecionada(t);
                                        }}
                                    >
                                        <option value="">-- Selecione a Turma --</option>
                                        {turmasFiltradas.map(t => (
                                            <option key={t.id} value={t.id}>
                                                {t.nome} ({t.nome_projeto}) - {t.turno}
                                            </option>
                                        ))}
                                    </select>
                                    <ChevronDown size={16} className="absolute right-3 top-3.5 text-gray-400 pointer-events-none" />
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* CONTEÚDO DO RELATÓRIO DE TURMA */}
                    {turmaSelecionada && estatisticas && (
                        <PainelEstatisticasTurma estatisticas={estatisticas} />
                    )}
                </>
            )}

            {/* --- ABA BUSCA --- */}
            {abaAtiva === 'busca' && (
                <div className="animate-fade-in">
                    <div className="bg-white p-8 rounded-xl shadow-sm border border-gray-100 mb-8 flex flex-col items-center">
                        <h2 className="text-xl font-bold text-gray-700 mb-4">Busca Individual de Aluno</h2>
                        <form onSubmit={handleBuscar} className="w-full max-w-2xl relative">
                            <input
                                type="text"
                                placeholder="Digite o nome do aluno ou CPF..."
                                className="w-full pl-5 pr-14 py-4 rounded-full border border-gray-300 focus:ring-4 focus:ring-blue-100 focus:border-blue-500 outline-none text-lg shadow-sm"
                                value={termoBusca}
                                onChange={e => setTermoBusca(e.target.value)}
                            />
                            <button
                                type="submit"
                                disabled={buscando || termoBusca.length < 3}
                                className="absolute right-2 top-2 bottom-2 bg-blue-600 hover:bg-blue-700 text-white px-6 rounded-full font-bold transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                {buscando ? <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div> : <Search size={20} />}
                            </button>
                        </form>
                        <p className="text-gray-400 text-sm mt-3">Busque por qualquer aluno, mesmo que já tenha saído de alguma turma.</p>
                    </div>

                    {resultadosBusca.length > 0 && (
                        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden max-w-4xl mx-auto">
                            <div className="p-4 bg-gray-50 border-b font-medium text-gray-600">
                                Resultados da Busca ({resultadosBusca.length})
                            </div>
                            <div className="divide-y divide-gray-100">
                                {resultadosBusca.map(r => (
                                    <div
                                        key={r.id}
                                        onClick={() => abrirHistoricoGeral(r.id)}
                                        className="p-4 hover:bg-blue-50 cursor-pointer transition-colors flex justify-between items-center group"
                                    >
                                        <div>
                                            <p className="font-bold text-gray-800 group-hover:text-blue-700">{r.nome_completo}</p>
                                            <p className="text-sm text-gray-500">CPF: {r.cpf || 'Não informado'}</p>
                                        </div>
                                        <ArrowRight size={20} className="text-gray-300 group-hover:text-blue-500" />
                                    </div>
                                ))}
                            </div>
                        </div>
                    )}
                </div>
            )}

            {/* MODAL HISTORICO GERAL */}
            {modalHistoricoOpen && historicoGeral && (
                <ModalHistoricoGeral
                    dados={historicoGeral}
                    onClose={() => setModalHistoricoOpen(false)}
                />
            )}
        </div>
    );
}

// ----------------------------------------------------------------------------------
// SUB-COMPONENTES
// ----------------------------------------------------------------------------------

function PainelEstatisticasTurma({ estatisticas }) {
    // Calcular totais
    const totalRegistros = estatisticas.total_presencas + estatisticas.total_faltas;
    const percPresencaGeral = totalRegistros > 0
        ? ((estatisticas.total_presencas / totalRegistros) * 100).toFixed(1)
        : 0;

    const alunosOrdenados = [...estatisticas.alunos].sort((a, b) => a.nome_completo.localeCompare(b.nome_completo));

    return (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {/* CARTÃO DE MÉTRICAS (Igual ao original) */}
            <div className="md:col-span-1 space-y-6">
                <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                    <h3 className="font-bold text-gray-700 mb-6 flex items-center gap-2">
                        <PieChart className="text-blue-600" /> Visão Geral
                    </h3>
                    {/* Gráfico Pizza */}
                    <div className="flex justify-center mb-6 relative">
                        <div className="w-48 h-48 rounded-full relative"
                            style={{ background: `conic-gradient(#22c55e 0% ${percPresencaGeral}%, #ef4444 ${percPresencaGeral}% 100%)` }}
                        >
                            <div className="absolute inset-4 bg-white rounded-full flex flex-col items-center justify-center">
                                <span className="text-3xl font-bold text-gray-800">{percPresencaGeral}%</span>
                                <span className="text-xs text-gray-500 uppercase font-bold">Presença Total</span>
                            </div>
                        </div>
                    </div>
                    {/* Legenda números */}
                    <div className="grid grid-cols-2 gap-4 text-center">
                        <div className="p-3 bg-green-50 rounded-lg">
                            <p className="text-2xl font-bold text-green-600">{estatisticas.total_presencas}</p>
                            <p className="text-xs text-green-800 font-bold uppercase">Presenças</p>
                        </div>
                        <div className="p-3 bg-red-50 rounded-lg">
                            <p className="text-2xl font-bold text-red-600">{estatisticas.total_faltas}</p>
                            <p className="text-xs text-red-800 font-bold uppercase">Faltas</p>
                        </div>
                    </div>
                </div>
            </div>

            {/* TABELA ALUNOS */}
            <div className="md:col-span-2">
                <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                    <div className="p-5 border-b bg-gray-50">
                        <h3 className="font-bold text-gray-700"><Users className="inline mr-2" /> Alunos da Turma</h3>
                    </div>
                    <div className="overflow-x-auto">
                        <table className="w-full text-sm text-left">
                            <thead className="bg-gray-50 text-gray-600 uppercase text-xs font-bold">
                                <tr>
                                    <th className="px-6 py-3">Aluno</th>
                                    <th className="px-6 py-3 text-center">Aulas</th>
                                    <th className="px-6 py-3 text-center">Faltas</th>
                                    <th className="px-6 py-3 w-1/3">Freq.</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-gray-100">
                                {alunosOrdenados.map(aluno => {
                                    const isCritical = aluno.frequencia_percent < 75;
                                    const isWarning = aluno.frequencia_percent >= 75 && aluno.frequencia_percent < 85;
                                    const colorBar = isCritical ? 'bg-red-500' : isWarning ? 'bg-yellow-500' : 'bg-green-500';

                                    return (
                                        <tr key={aluno.matricula_id} className="hover:bg-blue-50 transition-colors">
                                            <td className="px-6 py-4 font-medium">{aluno.nome_completo}</td>
                                            <td className="px-6 py-4 text-center">{aluno.total_aulas}</td>
                                            <td className="px-6 py-4 text-center text-red-500 font-bold">{aluno.faltas}</td>
                                            <td className="px-6 py-4">
                                                <div className="flex items-center gap-3">
                                                    <span className={`text-xs font-bold w-10 text-right ${isCritical ? 'text-red-600' : 'text-gray-600'}`}>
                                                        {aluno.frequencia_percent}%
                                                    </span>
                                                    <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                                                        <div
                                                            className={`h-full rounded-full ${colorBar}`}
                                                            style={{ width: `${aluno.frequencia_percent}%` }}
                                                        />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    );
}

// COMPONENTE: MODAL HISTÓRICO GERAL (COM IMPRESSÃO)
function ModalHistoricoGeral({ dados, onClose }) {
    const { beneficiario, matriculas, frequencia, resumo } = dados;

    const handlePrint = () => {
        window.print();
    };

    return (
        <div className="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4 backdrop-blur-sm animate-fade-in print:p-0 print:bg-white">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-5xl h-[90vh] flex flex-col overflow-hidden print:h-auto print:shadow-none print:max-w-none print:w-full print:rounded-none">

                {/* Header Modal */}
                <div className="p-6 border-b flex justify-between items-center bg-gray-50 print:bg-white print:border-b-2 print:border-black">
                    <div className="flex items-center gap-4">
                        <div className="h-12 w-12 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 font-bold text-xl print:hidden">
                            {beneficiario.nome_completo.charAt(0)}
                        </div>
                        <div>
                            <h2 className="text-2xl font-bold text-gray-800">{beneficiario.nome_completo}</h2>
                            <p className="text-gray-500 text-sm">Prontuário Acadêmico Completo</p>
                        </div>
                    </div>
                    <div className="flex gap-2 print:hidden">
                        <button onClick={handlePrint} className="p-2 bg-blue-50 text-blue-600 hover:bg-blue-100 rounded-lg flex items-center gap-2 font-bold transition-colors">
                            <Printer size={20} /> Imprimir
                        </button>
                        <button onClick={onClose} className="p-2 hover:bg-gray-200 rounded-full transition-colors">
                            <X size={24} className="text-gray-500" />
                        </button>
                    </div>
                </div>

                {/* Conteúdo Scrollável */}
                <div className="flex-1 overflow-y-auto p-8 space-y-8 bg-gray-50/50 print:overflow-visible print:bg-white">

                    {/* 1. Resumo Estatístico */}
                    <section className="print:mb-6">
                        <h3 className="text-lg font-bold text-gray-700 mb-4 pb-2 border-b flex items-center gap-2">
                            <BarChart2 size={20} /> Resumo Geral
                        </h3>
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                            <div className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 print:border print:shadow-none">
                                <p className="text-gray-500 text-xs uppercase font-bold">Total Aulas</p>
                                <p className="text-2xl font-black text-gray-800">{resumo.total_aulas}</p>
                            </div>
                            <div className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 print:border print:shadow-none">
                                <p className="text-gray-500 text-xs uppercase font-bold">Presenças</p>
                                <p className="text-2xl font-black text-green-600">{resumo.total_presencas}</p>
                            </div>
                            <div className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 print:border print:shadow-none">
                                <p className="text-gray-500 text-xs uppercase font-bold">Faltas</p>
                                <p className="text-2xl font-black text-red-600">{resumo.total_faltas}</p>
                            </div>
                            <div className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 print:border print:shadow-none">
                                <p className="text-gray-500 text-xs uppercase font-bold">Frequência Global</p>
                                <p className={`text-2xl font-black ${Number(resumo.percentual_geral) < 75 ? 'text-red-500' : 'text-blue-600'}`}>
                                    {resumo.percentual_geral}%
                                </p>
                            </div>
                        </div>
                    </section>

                    {/* 2. Matrículas (Turmas) */}
                    <section className="print:mb-6">
                        <h3 className="text-lg font-bold text-gray-700 mb-4 pb-2 border-b flex items-center gap-2">
                            <Folder size={20} /> Histórico de Matrículas
                        </h3>
                        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden print:border print:shadow-none">
                            <table className="w-full text-sm text-left">
                                <thead className="bg-gray-50 text-gray-600 font-bold print:bg-gray-100">
                                    <tr>
                                        <th className="p-3">Data Matrícula</th>
                                        <th className="p-3">Turma</th>
                                        <th className="p-3">Projeto</th>
                                        <th className="p-3">Status</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-gray-100">
                                    {matriculas.map(m => (
                                        <tr key={m.matricula_id}>
                                            <td className="p-3">{new Date(m.data_matricula).toLocaleDateString('pt-BR')}</td>
                                            <td className="p-3 font-medium">{m.turma_nome} ({m.turno})</td>
                                            <td className="p-3">{m.projeto_nome}</td>
                                            <td className="p-3">
                                                <span className={`px-2 py-1 rounded-full text-xs font-bold ${m.status_matricula === 'Ativo' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                                                    }`}>
                                                    {m.status_matricula}
                                                </span>
                                            </td>
                                        </tr>
                                    ))}
                                    {matriculas.length === 0 && <tr><td colSpan="4" className="p-4 text-center text-gray-400">Sem matrículas.</td></tr>}
                                </tbody>
                            </table>
                        </div>
                    </section>

                    {/* 3. Diário de Frequência (Timeline) */}
                    <section>
                        <h3 className="text-lg font-bold text-gray-700 mb-4 pb-2 border-b flex items-center gap-2">
                            <Calendar size={20} /> Registro de Frequência
                        </h3>
                        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden print:border print:shadow-none">
                            <table className="w-full text-sm text-left">
                                <thead className="bg-gray-50 text-gray-600 font-bold print:bg-gray-100">
                                    <tr>
                                        <th className="p-3 w-32">Data</th>
                                        <th className="p-3 w-48">Turma</th>
                                        <th className="p-3">Conteúdo</th>
                                        <th className="p-3 w-32 text-center">Status</th>
                                        <th className="p-3 w-48">Observação</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-gray-100">
                                    {frequencia.map((f, idx) => (
                                        <tr key={idx} className="hover:bg-gray-50 print:hover:bg-transparent">
                                            <td className="p-3">{new Date(f.data_aula).toLocaleDateString('pt-BR')}</td>
                                            <td className="p-3 text-xs text-gray-500">{f.turma_nome}</td>
                                            <td className="p-3">{f.conteudo}</td>
                                            <td className="p-3 text-center">
                                                <span className={`px-2 py-1 rounded text-xs font-bold inline-block w-20 ${f.status === 'Presente' ? 'bg-green-100 text-green-700' :
                                                    f.status === 'Justificado' ? 'bg-yellow-100 text-yellow-700' :
                                                        'bg-red-100 text-red-700'
                                                    }`}>
                                                    {f.status}
                                                </span>
                                            </td>
                                            <td className="p-3 text-gray-500 italic text-xs">
                                                {f.observacao || '-'}
                                            </td>
                                        </tr>
                                    ))}
                                    {frequencia.length === 0 && <tr><td colSpan="5" className="p-4 text-center text-gray-400">Sem registros de frequência.</td></tr>}
                                </tbody>
                            </table>
                        </div>
                    </section>

                    {/* Footer Impressão */}
                    <div className="hidden print:block mt-8 text-center text-xs text-gray-400 border-t pt-4">
                        Documento gerado em {new Date().toLocaleString('pt-BR')} - Sistema SysConex
                    </div>
                </div>
            </div>

            {/* Print Styles */}
            <style>{`
                @media print {
                    @page { margin: 1cm; size: A4; }
                    body * { visibility: hidden; }
                    .fixed.inset-0, .fixed.inset-0 * { visibility: visible; }
                    .fixed.inset-0 { position: absolute; left: 0; top: 0; width: 100%; height: auto; background: white; padding: 0; }
                    .animate-fade-in { animation: none !important; }
                    .overflow-y-auto { overflow: visible !important; height: auto !important; }
                }
            `}</style>
        </div>
    );
}
