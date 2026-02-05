import { useState, useEffect } from 'react';
import { api, getTurmaEstatisticas, getHistoricoAulas } from '../services/sysconex';
import {
    BarChart2, AlertCircle, Search, Filter, Folder, Users,
    ArrowRight, PieChart, ChevronDown, CheckCircle
} from 'lucide-react';
import ModalHistoricoAluno from '../components/ModalHistoricoAluno';

export default function Relatorios() {
    const [projetos, setProjetos] = useState([]);
    const [turmas, setTurmas] = useState([]);
    const [loading, setLoading] = useState(true);

    const [filtroProjeto, setFiltroProjeto] = useState('');
    const [turmaSelecionada, setTurmaSelecionada] = useState(null);
    const [estatisticas, setEstatisticas] = useState(null);

    // Modal de Histórico Individual
    const [alunoHistorico, setAlunoHistorico] = useState(null);

    useEffect(() => {
        carregarDadosIniciais();
    }, []);

    useEffect(() => {
        if (turmaSelecionada) {
            carregarStatsTurma(turmaSelecionada.id);
        } else {
            setEstatisticas(null);
        }
    }, [turmaSelecionada]);

    async function carregarDadosIniciais() {
        try {
            const [resProj, resTurmas] = await Promise.all([
                api.get('/projetos'),
                api.get('/turmas') // Traz todas
            ]);
            setProjetos(resProj.data);
            setTurmas(resTurmas.data);
        } catch (error) {
            console.error(error);
            // alert("Erro ao carregar dados.");
        } finally {
            setLoading(false);
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

    // Filtros
    const turmasFiltradas = turmas.filter(t => {
        if (filtroProjeto && t.projeto_id !== Number(filtroProjeto)) return false;
        return true;
    });

    const alunosOrdenados = estatisticas?.alunos
        ? [...estatisticas.alunos].sort((a, b) => a.nome_completo.localeCompare(b.nome_completo))
        : [];

    const totalRegistros = estatisticas ? (estatisticas.total_presencas + estatisticas.total_faltas) : 0;
    const percPresencaGeral = totalRegistros > 0
        ? ((estatisticas.total_presencas / totalRegistros) * 100).toFixed(1)
        : 0;


    return (
        <div className="animate-fade-in max-w-7xl mx-auto pb-10">
            <h1 className="text-2xl font-bold text-gray-800 mb-6 flex items-center gap-2">
                <BarChart2 className="text-blue-600" /> Relatórios de Desempenho
            </h1>

            {/* SELEÇÃO DE TURMA */}
            <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-8">
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

            {/* CONTEÚDO DO RELATÓRIO */}
            {turmaSelecionada && estatisticas && (
                <div className="animate-fade-in grid grid-cols-1 md:grid-cols-3 gap-6">

                    {/* CARTÃO DE MÉTRICAS GERAIS */}
                    <div className="md:col-span-1 space-y-6">
                        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                            <h3 className="font-bold text-gray-700 mb-6 flex items-center gap-2">
                                <PieChart className="text-blue-600" /> Visão Geral
                            </h3>

                            {/* GRÁFICO DE PIZZA SIMPLIFICADO CSS */}
                            <div className="flex justify-center mb-6 relative">
                                <div className="w-48 h-48 rounded-full relative"
                                    style={{
                                        background: `conic-gradient(#22c55e 0% ${percPresencaGeral}%, #ef4444 ${percPresencaGeral}% 100%)`
                                    }}
                                >
                                    <div className="absolute inset-4 bg-white rounded-full flex flex-col items-center justify-center">
                                        <span className="text-3xl font-bold text-gray-800">{percPresencaGeral}%</span>
                                        <span className="text-xs text-gray-500 uppercase font-bold">Presença Total</span>
                                    </div>
                                </div>
                            </div>

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

                            <div className="mt-4 p-4 bg-blue-50 rounded-lg flex items-center justify-between">
                                <span className="text-sm text-blue-800 font-bold">Total de Aulas:</span>
                                <span className="text-xl font-black text-blue-600">{estatisticas.total_aulas_registradas}</span>
                            </div>
                        </div>
                    </div>

                    {/* TABELA DE ALUNOS (RISCO) */}
                    <div className="md:col-span-2">
                        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                            <div className="p-5 border-b bg-gray-50 flex justify-between items-center">
                                <div>
                                    <h3 className="font-bold text-gray-700 flex items-center gap-2">
                                        <AlertCircle className="text-orange-500" /> Monitoramento de Alunos
                                    </h3>
                                    <p className="text-xs text-gray-500 mt-1">Clique no aluno para ver o histórico detalhado.</p>
                                </div>
                            </div>

                            <div className="overflow-x-auto">
                                <table className="w-full text-sm text-left">
                                    <thead className="bg-gray-50 text-gray-600 uppercase text-xs font-bold">
                                        <tr>
                                            <th className="px-6 py-3">Aluno</th>
                                            <th className="px-6 py-3 text-center">Aulas</th>
                                            <th className="px-6 py-3 text-center">Faltas</th>
                                            <th className="px-6 py-3 w-1/3">Frequência</th>
                                        </tr>
                                    </thead>
                                    <tbody className="divide-y divide-gray-100">
                                        {alunosOrdenados.map((aluno) => {
                                            const isCritical = aluno.frequencia_percent < 75;
                                            const isWarning = aluno.frequencia_percent >= 75 && aluno.frequencia_percent < 85;
                                            const colorBar = isCritical ? 'bg-red-500' : isWarning ? 'bg-yellow-500' : 'bg-green-500';

                                            return (
                                                <tr
                                                    key={aluno.matricula_id}
                                                    className="hover:bg-blue-50 transition-colors cursor-pointer group"
                                                    onClick={() => setAlunoHistorico({ id: aluno.matricula_id, nome: aluno.nome_completo })}
                                                >
                                                    <td className="px-6 py-4 font-medium text-gray-800 group-hover:text-blue-600 transition-colors">
                                                        {aluno.nome_completo}
                                                        {isCritical && <span className="ml-2 inline-block px-2 py-0.5 rounded text-[10px] bg-red-100 text-red-700 font-bold">CRÍTICO</span>}
                                                    </td>
                                                    <td className="px-6 py-4 text-center text-gray-600">{aluno.total_aulas}</td>
                                                    <td className="px-6 py-4 text-center font-bold text-red-500">{aluno.faltas}</td>
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
                                            )
                                        })}
                                    </tbody>
                                </table>
                                {alunosOrdenados.length === 0 && (
                                    <div className="p-8 text-center text-gray-400">Sem dados de frequência nesta turma.</div>
                                )}
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {/* MODAL HISTÓRICO INDIVIDUAL */}
            {alunoHistorico && (
                <ModalHistoricoAluno
                    matriculaId={alunoHistorico.id}
                    alunoNome={alunoHistorico.nome}
                    onClose={() => setAlunoHistorico(null)}
                />
            )}
        </div>
    );
}
