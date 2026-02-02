import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { 
    Plus, Users, GraduationCap, BookOpen, Archive, LayoutGrid, 
    AlertTriangle, Clock, ArrowRight, Activity 
} from 'lucide-react';

const GestaoTurmas = () => {
  const navigate = useNavigate();
  
  // Estados
  const [resumo, setResumo] = useState({ 
      counters: { turmas_ativas: 0, turmas_encerradas: 0, alunos_matriculados: 0, professores_alocados: 0 },
      alertas: [],
      recentes: []
  });
  const [projetos, setProjetos] = useState([]); // Para o modal
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);

  // Form State (Mantive igual)
  const [novaTurma, setNovaTurma] = useState({
    projeto_id: '', nome: '', turno: 'Manhã', periodo: '', 
    data_inicio: '', data_fim: '', dias_aula: []
  });
  const diasOpcoes = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

  useEffect(() => { carregarDados(); }, []);

  const carregarDados = async () => {
    setLoading(true);
    try {
      const [resDashboard, resProjetos] = await Promise.all([
        api.get('/dashboard/resumo'),
        api.get('/projetos')
      ]);
      setResumo(resDashboard.data);
      setProjetos(resProjetos.data);
    } catch (error) { console.error(error); } 
    finally { setLoading(false); }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
        await api.post('/turmas', novaTurma);
        alert("Turma criada!");
        setShowModal(false);
        carregarDados();
        setNovaTurma({ projeto_id: '', nome: '', turno: 'Manhã', periodo: '', data_inicio: '', data_fim: '', dias_aula: [] });
    } catch (error) { alert("Erro ao criar turma."); }
  };

  const handleDiaChange = (dia) => {
    setNovaTurma(prev => {
      const dias = prev.dias_aula;
      return dias.includes(dia) ? { ...prev, dias_aula: dias.filter(d => d !== dia) } : { ...prev, dias_aula: [...dias, dia] };
    });
  };

  const StatCard = ({ icon: Icon, label, value, color }) => (
      <div className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 flex items-center gap-4 hover:shadow-md transition-shadow">
          <div className={`p-3 rounded-full ${color} text-white shadow-sm`}>
              <Icon size={24} />
          </div>
          <div>
              <p className="text-gray-500 text-xs font-bold uppercase tracking-wide">{label}</p>
              <h3 className="text-2xl font-bold text-gray-800">{loading ? '...' : value}</h3>
          </div>
      </div>
  );

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-8 animate-fade-in">
      
      {/* 1. HEADER E BOTÃO AÇÃO PRINCIPAL */}
      <div className="flex flex-col md:flex-row justify-between items-center gap-4">
        <div>
            <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
                <LayoutGrid className="text-blue-600"/> Painel de Controle
            </h1>
            <p className="text-gray-500 text-sm">Visão geral do sistema e pendências.</p>
        </div>
        <div className="flex gap-2">
            <button onClick={() => navigate('/app/turmas')} className="bg-white text-gray-700 border border-gray-200 px-4 py-2 rounded-lg hover:bg-gray-50 font-medium shadow-sm transition-all flex items-center gap-2">
              <BookOpen size={18} /> Ver Todas as Turmas
            </button>
            <button onClick={() => setShowModal(true)} className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 shadow-lg shadow-blue-500/30 transition-all flex items-center gap-2 font-medium">
              <Plus size={20} /> Nova Turma
            </button>
        </div>
      </div>

      {/* 2. STATS CARDS */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard icon={BookOpen} label="Turmas Ativas" value={resumo.counters.turmas_ativas} color="bg-blue-500" />
        <StatCard icon={GraduationCap} label="Alunos Ativos" value={resumo.counters.alunos_matriculados} color="bg-green-500" />
        <StatCard icon={Users} label="Professores" value={resumo.counters.professores_alocados} color="bg-purple-500" />
        <StatCard icon={Archive} label="Encerradas" value={resumo.counters.turmas_encerradas} color="bg-gray-400" />
      </div>

      {/* 3. COLUNAS DE INFORMAÇÃO */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          
          {/* ESQUERDA: ALERTAS (Crítico) */}
          <div className="lg:col-span-1 space-y-4">
              <div className="flex items-center gap-2 mb-2">
                  <AlertTriangle className="text-orange-500" size={20}/>
                  <h2 className="font-bold text-gray-800">Atenção Necessária</h2>
              </div>
              
              {loading ? <p>Carregando...</p> : (
                  resumo.alertas.length === 0 ? (
                      <div className="bg-green-50 border border-green-100 p-4 rounded-xl text-center">
                          <p className="text-green-700 font-medium text-sm">Tudo certo! Nenhuma pendência.</p>
                      </div>
                  ) : (
                      resumo.alertas.map(alerta => (
                          <div key={alerta.id} className="bg-white p-4 rounded-xl border-l-4 border-orange-400 shadow-sm flex flex-col gap-1">
                              <span className="text-[10px] font-bold text-gray-400 uppercase">Turma sem Professor</span>
                              <h4 className="font-bold text-gray-800">{alerta.nome}</h4>
                              <p className="text-xs text-gray-500">{alerta.projeto}</p>
                              <button 
                                onClick={() => navigate(`/app/turmas/${alerta.id}`)}
                                className="text-blue-600 text-xs font-bold mt-2 hover:underline self-start"
                              >
                                Resolver Agora →
                              </button>
                          </div>
                      ))
                  )
              )}
          </div>

          {/* DIREITA: ÚLTIMAS ATIVIDADES */}
          <div className="lg:col-span-2 space-y-4">
              <div className="flex items-center gap-2 mb-2">
                  <Clock className="text-blue-500" size={20}/>
                  <h2 className="font-bold text-gray-800">Criadas Recentemente</h2>
              </div>

              <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                  {loading ? <div className="p-8 text-center text-gray-400">Carregando...</div> : (
                      <div className="divide-y divide-gray-50">
                          {resumo.recentes.map(turma => (
                              <div key={turma.id} className="p-4 flex items-center justify-between hover:bg-gray-50 transition-colors">
                                  <div className="flex items-center gap-4">
                                      <div className="w-10 h-10 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center">
                                          <Activity size={18}/>
                                      </div>
                                      <div>
                                          <h4 className="font-bold text-gray-800 text-sm">{turma.nome}</h4>
                                          <p className="text-xs text-gray-500">{turma.projeto} • {turma.periodo}</p>
                                      </div>
                                  </div>
                                  <button onClick={() => navigate(`/app/turmas/${turma.id}`)} className="text-gray-400 hover:text-blue-600">
                                      <ArrowRight size={18}/>
                                  </button>
                              </div>
                          ))}
                          {resumo.recentes.length === 0 && (
                              <p className="text-center p-6 text-gray-400">Nenhuma atividade recente.</p>
                          )}
                      </div>
                  )}
                  <div className="bg-gray-50 p-3 text-center border-t border-gray-100">
                      <button onClick={() => navigate('/app/turmas')} className="text-xs font-bold text-blue-600 hover:text-blue-700">VER TODAS AS TURMAS</button>
                  </div>
              </div>
          </div>
      </div>

      {/* MODAL DE CRIAÇÃO (Mantenha o código do modal que você já tem aqui...) */}
      {showModal && (
          /* ... Código do modal ... */
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[90vh]">
                <div className="bg-gray-50 px-6 py-4 border-b border-gray-100 flex justify-between items-center">
                    <h2 className="text-lg font-bold text-gray-800">Nova Turma</h2>
                    <button onClick={() => setShowModal(false)} className="text-gray-400 hover:text-gray-600 text-2xl leading-none">&times;</button>
                </div>
                
                <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto">
                    <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1">Projeto <span className="text-red-500">*</span></label>
                        <select className="w-full border p-2.5 rounded-lg bg-white" value={novaTurma.projeto_id} onChange={e => setNovaTurma({...novaTurma, projeto_id: e.target.value})} required>
                            <option value="">Selecione...</option>
                            {projetos.map(p => <option key={p.id} value={p.id}>{p.titulo}</option>)}
                        </select>
                    </div>

                    <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1">Nome da Turma <span className="text-red-500">*</span></label>
                        <input type="text" placeholder="Ex: Informática Básica A" className="w-full border p-2.5 rounded-lg" value={novaTurma.nome} onChange={e => setNovaTurma({...novaTurma, nome: e.target.value})} required />
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1">Turno <span className="text-red-500">*</span></label>
                            <select className="w-full border p-2.5 rounded-lg bg-white" value={novaTurma.turno} onChange={e => setNovaTurma({...novaTurma, turno: e.target.value})}>
                                <option>Manhã</option><option>Tarde</option><option>Noite</option>
                            </select>
                        </div>
                        <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1">Período <span className="text-red-500">*</span></label>
                            <input type="text" placeholder="Ex: 2026.1" className="w-full border p-2.5 rounded-lg" value={novaTurma.periodo} onChange={e => setNovaTurma({...novaTurma, periodo: e.target.value})} required />
                        </div>
                    </div>

                    <div className="border-t border-gray-100 my-2"></div>
                    <p className="text-xs font-bold text-gray-400 uppercase">Opcionais</p>

                    <div className="grid grid-cols-2 gap-4">
                         <div><label className="block text-sm text-gray-600 mb-1">Início</label><input type="date" className="w-full border p-2 rounded-lg" value={novaTurma.data_inicio} onChange={e => setNovaTurma({...novaTurma, data_inicio: e.target.value})} /></div>
                         <div><label className="block text-sm text-gray-600 mb-1">Fim</label><input type="date" className="w-full border p-2 rounded-lg" value={novaTurma.data_fim} onChange={e => setNovaTurma({...novaTurma, data_fim: e.target.value})} /></div>
                    </div>

                    <div>
                        <label className="block text-sm text-gray-600 mb-2">Dias de Aula</label>
                        <div className="flex flex-wrap gap-2">
                            {diasOpcoes.map(dia => (
                                <label key={dia} className={`cursor-pointer px-3 py-1.5 rounded text-sm border transition-all ${novaTurma.dias_aula.includes(dia) ? 'bg-blue-50 border-blue-500 text-blue-700 font-bold' : 'bg-white border-gray-200'}`}>
                                    <input type="checkbox" className="hidden" checked={novaTurma.dias_aula.includes(dia)} onChange={() => handleDiaChange(dia)} />{dia}
                                </label>
                            ))}
                        </div>
                    </div>

                    <div className="flex justify-end gap-3 pt-4">
                        <button type="button" onClick={() => setShowModal(false)} className="px-5 py-2 text-gray-600 hover:bg-gray-100 rounded-lg">Cancelar</button>
                        <button type="submit" className="px-5 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-bold shadow-lg">Criar Turma</button>
                    </div>
                </form>
            </div>
        </div>
      )}
    </div>
  );
};
export default GestaoTurmas;