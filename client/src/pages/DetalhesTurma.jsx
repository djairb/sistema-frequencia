import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { 
    Trash2, UserPlus, Users, GraduationCap, ArrowLeft, 
    Search, CheckSquare, Square, X, ChevronLeft, ChevronRight, Loader2,
    CalendarCheck, Eye, Edit2 // <--- Adicionamos o Edit2 aqui
} from 'lucide-react';

const DetalhesTurma = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  
  // Dados Principais
  const [turma, setTurma] = useState(null);
  const [loading, setLoading] = useState(true);
  const [abaAtiva, setAbaAtiva] = useState('alunos');

  // Listas Paginadas
  const [alunosData, setAlunosData] = useState({ list: [], total: 0, page: 1, totalPages: 1 });
  const [profsData, setProfsData] = useState({ list: [], total: 0, page: 1, totalPages: 1 });
  const [aulasData, setAulasData] = useState({ list: [], total: 0, page: 1, totalPages: 1 });

  // Modais e Buscas
  const [modalOpen, setModalOpen] = useState(false);
  const [termoBusca, setTermoBusca] = useState('');
  const [modalBuscaData, setModalBuscaData] = useState({ list: [], total: 0, page: 1, totalPages: 0 });
  const [selecionados, setSelecionados] = useState([]);
  const [loadingBusca, setLoadingBusca] = useState(false);

  // Modal de Detalhes da Aula (Auditoria)
  const [modalAulaOpen, setModalAulaOpen] = useState(false);
  const [aulaSelecionada, setAulaSelecionada] = useState(null);
  const [frequenciaAula, setFrequenciaAula] = useState([]);

  // --- NOVOS ESTADOS PARA EDIÇÃO DA TURMA ---
  const [modalEditarOpen, setModalEditarOpen] = useState(false);
  const [dadosEdicao, setDadosEdicao] = useState({});

  
  // --- INICIALIZAÇÃO ---
  useEffect(() => {
    carregarTurma();
    carregarAlunos(1);
    carregarProfessores(1);
    carregarAulas(1);
  }, [id]);

  const carregarTurma = async () => {
      try {
          const res = await api.get(`/turmas/${id}`);
          setTurma(res.data);
          setLoading(false);
      } catch (e) { navigate('/app/gestao-turmas'); }
  };

  const carregarAlunos = async (page = 1) => {
      try {
          const res = await api.get(`/turmas/${id}/matriculas?page=${page}&limit=10`);
          setAlunosData({ list: res.data.data, total: res.data.pagination.total, page: res.data.pagination.page, totalPages: res.data.pagination.totalPages });
      } catch (error) { console.error("Erro alunos"); }
  };

  const carregarProfessores = async (page = 1) => {
      try {
          const res = await api.get(`/turmas/${id}/professores?page=${page}&limit=10`);
          setProfsData({ list: res.data.data, total: res.data.pagination.total, page: res.data.pagination.page, totalPages: res.data.pagination.totalPages });
      } catch (error) { console.error("Erro profs"); }
  };

  const carregarAulas = async (page = 1) => {
      try {
          const res = await api.get(`/turmas/${id}/aulas?page=${page}&limit=10`);
          setAulasData({ list: res.data.data, total: res.data.pagination.total, page: res.data.pagination.page, totalPages: res.data.pagination.totalPages });
      } catch (error) { console.error("Erro aulas"); }
  };

  // --- FUNÇÕES DE EDIÇÃO DA TURMA ---
  const handleAbrirEdicao = () => {
      setDadosEdicao({
          ...turma,
          // Garante que dias_aula seja array
          dias_aula: typeof turma.dias_aula === 'string' ? JSON.parse(turma.dias_aula) : (turma.dias_aula || []),
          // Formata datas para o input type="date"
          data_inicio: turma.data_inicio ? turma.data_inicio.split('T')[0] : '',
          data_fim: turma.data_fim ? turma.data_fim.split('T')[0] : ''
      });
      setModalEditarOpen(true);
  };

  const handleSalvarEdicao = async (e) => {
      e.preventDefault();
      try {
          await api.put(`/turmas/${id}`, dadosEdicao);
          alert("Turma atualizada com sucesso!");
          setModalEditarOpen(false);
          carregarTurma(); // Atualiza o header
      } catch (error) {
          alert("Erro ao atualizar turma.");
      }
  };

  const toggleDiaEdicao = (dia) => {
      setDadosEdicao(prev => {
          const dias = prev.dias_aula || [];
          return dias.includes(dia) 
            ? { ...prev, dias_aula: dias.filter(d => d !== dia) }
            : { ...prev, dias_aula: [...dias, dia] };
      });
  };

  // --- AUDITORIA DE AULA ---
  const abrirDetalhesAula = async (aula) => {
      setAulaSelecionada(aula);
      setModalAulaOpen(true);
      setFrequenciaAula([]);
      try {
          const res = await api.get(`/aulas/${aula.id}/frequencia`);
          setFrequenciaAula(res.data);
      } catch (error) { alert("Erro ao carregar frequência."); }
  };

  // --- LÓGICA DE BUSCA E SELEÇÃO ---
  const realizarBusca = async (termo, page = 1) => {
      setLoadingBusca(true);
      try {
          let url = abaAtiva === 'alunos' ? `/beneficiarios/busca?q=${termo}&page=${page}&limit=10` : `/colaboradores/busca?q=${termo}&page=${page}&limit=10`;
          const res = await api.get(url);
          setModalBuscaData({ list: res.data.data, total: res.data.pagination?.total, page: res.data.pagination?.page, totalPages: res.data.pagination?.totalPages });
      } catch (error) { } finally { setLoadingBusca(false); }
  };
  const handleInputBusca = (e) => {
      const termo = e.target.value;
      setTermoBusca(termo);
      if (termo.length >= 3) realizarBusca(termo, 1);
      else setModalBuscaData({ list: [], total: 0, page: 1, totalPages: 0 });
  };
  const handlePaginaModal = (p) => realizarBusca(termoBusca, p);
  const toggleSelecao = (id) => setSelecionados(prev => prev.includes(id) ? prev.filter(x => x !== id) : [...prev, id]);
  
  const handleSalvarSelecionados = async () => {
    if (selecionados.length === 0) return alert("Selecione um item.");
    try {
        if (abaAtiva === 'alunos') {
            await api.post(`/turmas/${id}/matriculas`, { aluno_id: selecionados });
            alert("✅ Alunos matriculados!");
            await carregarAlunos(1);
        } else {
            for (const pid of selecionados) await api.post(`/turmas/${id}/professores`, { professor_id: pid }).catch(()=>{});
            alert("✅ Professores vinculados!");
            await carregarProfessores(1);
        }
        setModalOpen(false); setSelecionados([]); setTermoBusca(''); setModalBuscaData({ list: [], total: 0, page: 1, totalPages: 0 });
    } catch (error) { 
        const msg = error.response?.data?.detalhes ? error.response.data.detalhes.join('\n') : (error.response?.data?.error || "Erro ao salvar.");
        alert("⚠️ Atenção:\n" + msg); 
    }
  };
  
  const handleRemover = async (itemId, tipo) => {
      if(!confirm("Tem certeza?")) return;
      try {
          if (tipo === 'aluno') { await api.delete(`/matriculas/${itemId}`); carregarAlunos(alunosData.page); }
          else { await api.delete(`/turma-professores/${itemId}`); carregarProfessores(profsData.page); }
      } catch (error) { alert("Erro ao remover."); }
  };

  // --- RENDERIZAÇÃO ---
  if (loading || !turma) return <div className="flex h-screen items-center justify-center"><Loader2 className="animate-spin text-blue-600" size={40}/></div>;

  const Pagination = ({ data, onChangePage, simple = false }) => {
      if (data.total === 0) return null;
      return (
          <div className={`flex items-center justify-between border-t border-gray-100 p-3 ${simple ? 'bg-white' : 'bg-gray-50 rounded-b-xl'}`}>
              <span className="text-xs text-gray-500">Total: {data.total}</span>
              <div className="flex gap-2 items-center">
                  <button onClick={() => onChangePage(data.page - 1)} disabled={data.page === 1} className="p-1.5 hover:bg-gray-200 rounded disabled:opacity-30"><ChevronLeft size={18}/></button>
                  <span className="text-xs font-bold">{data.page} / {data.totalPages}</span>
                  <button onClick={() => onChangePage(data.page + 1)} disabled={data.page >= data.totalPages} className="p-1.5 hover:bg-gray-200 rounded disabled:opacity-30"><ChevronRight size={18}/></button>
              </div>
          </div>
      );
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6 animate-fade-in p-6">
       
       {/* HEADER DA TURMA */}
       <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 relative overflow-hidden">
            <div className="absolute top-0 left-0 w-1 h-full bg-blue-500"></div>
            <button onClick={() => navigate('/app/gestao-turmas')} className="flex items-center text-sm text-gray-500 hover:text-blue-600 mb-4">
                <ArrowLeft size={16} className="mr-1"/> Voltar
            </button>
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                <div>
                    {/* AQUI ESTÁ O TÍTULO COM O BOTÃO DE EDITAR */}
                    <div className="flex items-center gap-3">
                        <h1 className="text-3xl font-bold text-gray-800">{turma.nome}</h1>
                        <button 
                            onClick={handleAbrirEdicao}
                            className="text-gray-400 hover:text-blue-600 transition-colors p-1.5 rounded-full hover:bg-blue-50"
                            title="Editar Turma"
                        >
                            <Edit2 size={20} />
                        </button>
                    </div>
                    
                    <div className="flex gap-3 mt-2 text-sm text-gray-600">
                        <span className="bg-blue-50 text-blue-700 px-2 py-0.5 rounded font-medium">{turma.turno}</span>
                        <span className="bg-gray-100 px-2 py-0.5 rounded border border-gray-200">{turma.periodo}</span>
                    </div>
                </div>
                <div className={`px-4 py-1.5 rounded-full text-xs font-bold uppercase ${turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                    {turma.ativo ? 'Ativo' : 'Encerrado'}
                </div>
            </div>
       </div>

       {/* Abas */}
       <div className="flex gap-2 bg-gray-100 p-1 rounded-lg w-fit overflow-x-auto">
            {[
                { id: 'alunos', icon: GraduationCap, count: alunosData.total },
                { id: 'professores', icon: Users, count: profsData.total },
                { id: 'aulas', icon: CalendarCheck, count: aulasData.total }
            ].map(tab => (
                <button 
                    key={tab.id}
                    onClick={() => setAbaAtiva(tab.id)}
                    className={`flex items-center gap-2 px-6 py-2 rounded-md text-sm font-medium transition-all capitalize whitespace-nowrap ${abaAtiva === tab.id ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
                >
                    <tab.icon size={18} /> {tab.id}
                    <span className="bg-blue-100 text-blue-700 px-1.5 rounded text-xs ml-2">{tab.count}</span>
                </button>
            ))}
       </div>

       {/* Conteúdo das Abas */}
       <div className="bg-white rounded-xl shadow-sm border border-gray-100 min-h-[400px] flex flex-col">
            <div className="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/30">
                <h2 className="text-lg font-bold text-gray-800 capitalize">
                    {abaAtiva === 'aulas' ? 'Histórico de Aulas' : `Gerenciar ${abaAtiva}`}
                </h2>
                {abaAtiva !== 'aulas' && (
                    <button onClick={() => { setModalOpen(true); setTermoBusca(''); setSelecionados([]); }} className="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 flex gap-2">
                        <UserPlus size={18} /> Adicionar
                    </button>
                )}
            </div>

            <div className="flex-1 p-2">
                {abaAtiva === 'aulas' ? (
                    aulasData.list.length === 0 ? (
                        <div className="flex flex-col items-center justify-center h-48 text-gray-400"><CalendarCheck size={40} className="mb-2 opacity-20"/><p>Nenhuma aula registrada.</p></div>
                    ) : (
                        <div className="divide-y divide-gray-100">
                            {aulasData.list.map((aula) => (
                                <div key={aula.id} className="p-4 flex justify-between items-start hover:bg-gray-50 rounded-lg group">
                                    <div className="flex gap-4">
                                        <div className="flex flex-col items-center justify-center bg-blue-50 text-blue-700 w-14 h-14 rounded-lg border border-blue-100">
                                            <span className="text-xs font-bold uppercase">{new Date(aula.data_aula).toLocaleDateString('pt-BR', { month: 'short' }).replace('.','')}</span>
                                            <span className="text-xl font-bold">{new Date(aula.data_aula).getDate()}</span>
                                        </div>
                                        <div>
                                            <h4 className="font-bold text-gray-800 line-clamp-1">{aula.conteudo}</h4>
                                            <div className="flex gap-3 text-xs text-gray-500 mt-1">
                                                <span className="flex items-center gap-1"><Users size={12}/> Prof. {aula.professor_nome?.split(' ')[0]}</span>
                                                <span className="text-green-600 font-medium">P: {aula.presentes}</span>
                                                <span className="text-red-500 font-medium">A: {aula.ausentes}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <button onClick={() => abrirDetalhesAula(aula)} className="text-gray-400 hover:text-blue-600 p-2"><Eye size={20} /></button>
                                </div>
                            ))}
                        </div>
                    )
                ) : (
                    (abaAtiva === 'alunos' ? alunosData.list : profsData.list).length === 0 ? (
                        <div className="flex flex-col items-center justify-center h-48 text-gray-400"><p>Nenhum registro.</p></div>
                    ) : (
                        <div className="divide-y divide-gray-100">
                            {(abaAtiva === 'alunos' ? alunosData.list : profsData.list).map((item) => (
                                <div key={item.matricula_id || item.vinculo_id} className="p-4 flex justify-between items-center hover:bg-gray-50 rounded-lg group">
                                    <div className="flex items-center gap-4">
                                        <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-white shadow-sm ${abaAtiva === 'alunos' ? 'bg-green-500' : 'bg-indigo-500'}`}>{item.nome_completo?.charAt(0)}</div>
                                        <div><p className="font-bold text-gray-800">{item.nome_completo}</p><p className="text-xs text-gray-500 font-mono">{item.cpf ? `CPF: ${item.cpf}` : `Email: ${item.email_institucional}`}</p></div>
                                    </div>
                                    <button onClick={() => handleRemover(item.matricula_id || item.vinculo_id, abaAtiva === 'alunos' ? 'aluno' : 'prof')} className="text-gray-300 hover:text-red-500 p-2 opacity-0 group-hover:opacity-100 transition-opacity"><Trash2 size={18} /></button>
                                </div>
                            ))}
                        </div>
                    )
                )}
            </div>
            
            <Pagination data={abaAtiva === 'aulas' ? aulasData : (abaAtiva === 'alunos' ? alunosData : profsData)} onChangePage={abaAtiva === 'aulas' ? carregarAulas : (abaAtiva === 'alunos' ? carregarAlunos : carregarProfessores)} />
       </div>

       {/* --- MODAL DE DETALHES DA AULA --- */}
       {modalAulaOpen && aulaSelecionada && (
           <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
               <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[85vh]">
                   <div className="px-6 py-4 bg-blue-600 text-white flex justify-between items-center">
                       <div><h3 className="text-lg font-bold">Frequência Registrada</h3><p className="text-blue-100 text-sm">{new Date(aulaSelecionada.data_aula).toLocaleDateString()} • Prof. {aulaSelecionada.professor_nome}</p></div>
                       <button onClick={() => setModalAulaOpen(false)}><X className="text-white/80 hover:text-white" /></button>
                   </div>
                   <div className="p-4 border-b bg-gray-50"><p className="text-xs font-bold text-gray-600 uppercase mb-1">Conteúdo</p><p className="text-gray-800 bg-white p-3 rounded border border-gray-200 text-sm">{aulaSelecionada.conteudo}</p></div>
                   <div className="flex-1 overflow-y-auto p-2">
                       {frequenciaAula.length===0?<p className="text-center py-8 text-gray-400">Carregando...</p>:
                       <table className="w-full text-sm text-left"><tbody className="divide-y divide-gray-100">{frequenciaAula.map((freq,idx)=>(<tr key={idx} className="hover:bg-gray-50"><td className="px-4 py-3 font-medium text-gray-800">{freq.nome_completo}</td><td className="px-4 py-3 text-right"><span className={`px-2 py-1 rounded text-xs font-bold ${freq.status==='Presente'?'bg-green-100 text-green-700':'bg-red-100 text-red-700'}`}>{freq.status}</span></td></tr>))}</tbody></table>}
                   </div>
               </div>
           </div>
       )}

       {/* --- MODAL DE BUSCA (ALUNO E PROFESSOR) --- */}
       {modalOpen && (
           <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
               <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[85vh]">
                   <div className="px-6 py-4 bg-gray-50 border-b border-gray-100 flex justify-between items-center">
                       <h3 className="text-lg font-bold text-gray-800">{abaAtiva === 'alunos' ? 'Matricular Alunos' : 'Vincular Professores'}</h3>
                       <button onClick={() => setModalOpen(false)}><X className="text-gray-400 hover:text-red-500" /></button>
                   </div>
                   <div className="p-4 border-b border-gray-100">
                       <div className="relative"><Search className="absolute left-3 top-2.5 text-gray-400" size={20} /><input type="text" className="w-full border border-gray-300 pl-10 p-2 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Buscar..." value={termoBusca} onChange={handleInputBusca} autoFocus /></div>
                   </div>
                   <div className="flex-1 overflow-y-auto bg-gray-50 p-2 space-y-2">
                       {loadingBusca && <div className="text-center py-4 text-blue-500"><Loader2 className="animate-spin inline"/></div>}
                       {modalBuscaData.list.map(item => (
                           <div key={item.id} onClick={() => toggleSelecao(item.id)} className={`p-3 rounded-lg flex items-center justify-between cursor-pointer border ${selecionados.includes(item.id) ? 'bg-blue-50 border-blue-200' : 'bg-white hover:border-gray-200'}`}>
                               <div className="flex items-center gap-3">
                                   <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white text-xs font-bold ${abaAtiva==='alunos'?'bg-green-400':'bg-indigo-400'}`}>{item.nome_completo?.charAt(0)}</div>
                                   <div><p className="font-bold text-gray-800 text-sm">{item.nome_completo}</p><p className="text-xs text-gray-500">{item.cpf ? `CPF: ${item.cpf}` : `Email: ${item.email_institucional}`}</p></div>
                               </div>
                               <div className={selecionados.includes(item.id) ? "text-blue-600" : "text-gray-300"}>{selecionados.includes(item.id) ? <CheckSquare size={20}/> : <Square size={20}/>}</div>
                           </div>
                       ))}
                   </div>
                   {modalBuscaData.total > 0 && <div className="bg-white border-t border-gray-100"><Pagination data={modalBuscaData} onChangePage={handlePaginaModal} simple={true} /></div>}
                   <div className="p-4 border-t border-gray-100 bg-white flex justify-end gap-2">
                       <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg text-sm">Cancelar</button>
                       <button onClick={handleSalvarSelecionados} className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-bold shadow-lg disabled:opacity-50 text-sm" disabled={selecionados.length === 0}>Salvar</button>
                   </div>
               </div>
           </div>
       )}

       {/* --- MODAL DE EDIÇÃO DA TURMA (NOVO) --- */}
       {modalEditarOpen && (
           <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
               <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[90vh]">
                   <div className="px-6 py-4 bg-gray-50 border-b border-gray-100 flex justify-between items-center">
                       <h3 className="text-lg font-bold text-gray-800">Editar Turma</h3>
                       <button onClick={() => setModalEditarOpen(false)}><X className="text-gray-400 hover:text-red-500" /></button>
                   </div>
                   
                   <form onSubmit={handleSalvarEdicao} className="p-6 overflow-y-auto">
                       <div className="space-y-4">
                           <div>
                               <label className="block text-sm font-bold text-gray-700 mb-1">Nome</label>
                               <input type="text" className="w-full border p-2 rounded" value={dadosEdicao.nome} onChange={e => setDadosEdicao({...dadosEdicao, nome: e.target.value})} required />
                           </div>
                           <div className="grid grid-cols-2 gap-4">
                               <div>
                                   <label className="block text-sm font-bold text-gray-700 mb-1">Turno</label>
                                   <select className="w-full border p-2 rounded" value={dadosEdicao.turno} onChange={e => setDadosEdicao({...dadosEdicao, turno: e.target.value})}>
                                       <option>Manhã</option><option>Tarde</option><option>Noite</option>
                                   </select>
                               </div>
                               <div>
                                   <label className="block text-sm font-bold text-gray-700 mb-1">Período</label>
                                   <input type="text" className="w-full border p-2 rounded" value={dadosEdicao.periodo} onChange={e => setDadosEdicao({...dadosEdicao, periodo: e.target.value})} required />
                               </div>
                           </div>
                           <div className="bg-yellow-50 p-3 rounded border border-yellow-200">
                               <label className="block text-sm font-bold text-gray-800 mb-2">Situação</label>
                               <div className="flex gap-4">
                                   <label className="flex items-center gap-2 cursor-pointer"><input type="radio" name="ativo" checked={dadosEdicao.ativo == 1} onChange={() => setDadosEdicao({...dadosEdicao, ativo: 1})} /><span className="text-sm">Ativa</span></label>
                                   <label className="flex items-center gap-2 cursor-pointer"><input type="radio" name="ativo" checked={dadosEdicao.ativo == 0} onChange={() => setDadosEdicao({...dadosEdicao, ativo: 0})} /><span className="text-sm">Encerrada</span></label>
                               </div>
                           </div>
                           <div className="grid grid-cols-2 gap-4">
                               <div><label className="block text-sm text-gray-600 mb-1">Início</label><input type="date" className="w-full border p-2 rounded" value={dadosEdicao.data_inicio} onChange={e => setDadosEdicao({...dadosEdicao, data_inicio: e.target.value})} /></div>
                               <div><label className="block text-sm text-gray-600 mb-1">Fim</label><input type="date" className="w-full border p-2 rounded" value={dadosEdicao.data_fim} onChange={e => setDadosEdicao({...dadosEdicao, data_fim: e.target.value})} /></div>
                           </div>
                           <div>
                               <label className="block text-sm text-gray-600 mb-2">Dias</label>
                               <div className="flex flex-wrap gap-2">
                                   {['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'].map(dia => (
                                       <label key={dia} className={`cursor-pointer px-3 py-1 rounded text-sm border ${dadosEdicao.dias_aula?.includes(dia) ? 'bg-blue-100 border-blue-500 text-blue-700 font-bold' : 'bg-gray-50 border-gray-200'}`}>
                                           <input type="checkbox" className="hidden" checked={dadosEdicao.dias_aula?.includes(dia) || false} onChange={() => toggleDiaEdicao(dia)} />{dia}
                                       </label>
                                   ))}
                               </div>
                           </div>
                       </div>
                       <div className="flex justify-end gap-3 mt-6">
                           <button type="button" onClick={() => setModalEditarOpen(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded">Cancelar</button>
                           <button type="submit" className="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 font-bold">Salvar</button>
                       </div>
                   </form>
               </div>
           </div>
       )}
    </div>
  );
};

export default DetalhesTurma;