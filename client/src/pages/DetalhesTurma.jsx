import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { 
    Trash2, UserPlus, Users, GraduationCap, ArrowLeft, 
    Search, CheckSquare, Square, X, ChevronLeft, ChevronRight, Loader2
} from 'lucide-react';

const DetalhesTurma = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  
  // Dados Principais
  const [turma, setTurma] = useState(null);
  const [loading, setLoading] = useState(true);
  const [abaAtiva, setAbaAtiva] = useState('alunos'); // 'alunos' ou 'professores'

  // Listas da Tela Principal (Paginadas)
  const [alunosData, setAlunosData] = useState({ list: [], total: 0, page: 1, totalPages: 1 });
  const [profsData, setProfsData] = useState({ list: [], total: 0, page: 1, totalPages: 1 });

  // ESTADOS DO MODAL DE BUSCA (Compartilhado para Aluno e Professor)
  const [modalOpen, setModalOpen] = useState(false);
  const [termoBusca, setTermoBusca] = useState('');
  const [modalBuscaData, setModalBuscaData] = useState({ list: [], total: 0, page: 1, totalPages: 0 });
  const [selecionados, setSelecionados] = useState([]); // Array de IDs
  const [loadingBusca, setLoadingBusca] = useState(false);

  // --- INICIALIZAÇÃO ---
  useEffect(() => {
    carregarTurma();
    carregarAlunos(1);
    carregarProfessores(1);
  }, [id]);

  // --- CARREGAMENTO DA TELA PRINCIPAL ---
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
          setAlunosData({
              list: res.data.data, 
              total: res.data.pagination.total,
              page: res.data.pagination.page,
              totalPages: res.data.pagination.totalPages
          });
      } catch (error) { console.error("Erro loading alunos"); }
  };

  const carregarProfessores = async (page = 1) => {
      try {
          const res = await api.get(`/turmas/${id}/professores?page=${page}&limit=10`);
          setProfsData({
              list: res.data.data,
              total: res.data.pagination.total,
              page: res.data.pagination.page,
              totalPages: res.data.pagination.totalPages
          });
      } catch (error) { console.error("Erro loading profs"); }
  };

  // --- LÓGICA DE BUSCA NO MODAL ---
  
  // Função que decide qual rota chamar baseada na aba ativa
  const realizarBusca = async (termo, page = 1) => {
      setLoadingBusca(true);
      try {
          let url = '';
          if (abaAtiva === 'alunos') {
              url = `/beneficiarios/busca?q=${termo}&page=${page}&limit=10`;
          } else {
              url = `/colaboradores/busca?q=${termo}&page=${page}&limit=10`;
          }

          const res = await api.get(url);
          
          setModalBuscaData({
              list: res.data.data,
              total: res.data.pagination?.total || 0,
              page: res.data.pagination?.page || 1,
              totalPages: res.data.pagination?.totalPages || 0
          });
      } catch (error) {
          console.error("Erro na busca modal");
      } finally {
          setLoadingBusca(false);
      }
  };

  const handleInputBusca = (e) => {
      const termo = e.target.value;
      setTermoBusca(termo);
      // Só busca se tiver 3+ caracteres
      if (termo.length >= 3) {
          realizarBusca(termo, 1); // Sempre volta pra pág 1 ao digitar
      } else {
          setModalBuscaData({ list: [], total: 0, page: 1, totalPages: 0 });
      }
  };

  const handlePaginaModal = (novaPagina) => {
      realizarBusca(termoBusca, novaPagina);
  };

  // --- SELEÇÃO E ENVIO ---
  const toggleSelecao = (itemId) => {
      setSelecionados(prev => 
          prev.includes(itemId) ? prev.filter(id => id !== itemId) : [...prev, itemId]
      );
  };

  const handleSalvarSelecionados = async () => {
      if (selecionados.length === 0) return alert("Selecione pelo menos um item.");
      
      try {
          if (abaAtiva === 'alunos') {
              await api.post(`/turmas/${id}/matriculas`, { aluno_id: selecionados });
              alert("✅ Alunos matriculados!");
              
              // MUDANÇA: Recarrega sempre a página 1 para garantir que a lista atualize do zero
              await carregarAlunos(1); 
              
          } else {
              for (const profId of selecionados) {
                  try {
                    await api.post(`/turmas/${id}/professores`, { professor_id: profId });
                  } catch (e) { }
              }
              alert("✅ Professores vinculados!");
              
              // MUDANÇA: Recarrega página 1
              await carregarProfessores(1);
          }
          
          setModalOpen(false);
          setSelecionados([]);
          setTermoBusca('');
          setModalBuscaData({ list: [], total: 0, page: 1, totalPages: 0 });

      } catch (error) {
           const msg = error.response?.data?.detalhes 
              ? error.response.data.detalhes.join('\n') 
              : (error.response?.data?.error || "Erro ao salvar.");
          alert("⚠️ Atenção:\n" + msg);
      }
  };

  // --- REMOVER ---
  const handleRemover = async (itemId, tipo) => {
      if(!confirm("Remover este registro da turma?")) return;
      try {
          if (tipo === 'aluno') {
              await api.delete(`/matriculas/${itemId}`);
              carregarAlunos(alunosData.page);
          } else {
              await api.delete(`/turma-professores/${itemId}`);
              carregarProfessores(profsData.page);
          }
      } catch (error) { alert("Erro ao remover."); }
  };

  // --- RENDERIZAÇÃO ---
  if (loading || !turma) return <div className="flex h-screen items-center justify-center"><Loader2 className="animate-spin text-blue-600" size={40}/></div>;

  // Componente de Paginação (Reutilizável)
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
       
       {/* Header */}
       <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 relative overflow-hidden">
            <div className="absolute top-0 left-0 w-1 h-full bg-blue-500"></div>
            <button onClick={() => navigate('/app/gestao-turmas')} className="flex items-center text-sm text-gray-500 hover:text-blue-600 mb-4">
                <ArrowLeft size={16} className="mr-1"/> Voltar
            </button>
            <div className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-bold text-gray-800">{turma.nome}</h1>
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
       <div className="flex gap-2 bg-gray-100 p-1 rounded-lg w-fit">
            {['alunos', 'professores'].map(tab => (
                <button 
                    key={tab}
                    onClick={() => setAbaAtiva(tab)}
                    className={`flex items-center gap-2 px-6 py-2 rounded-md text-sm font-medium transition-all capitalize ${abaAtiva === tab ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
                >
                    {tab === 'alunos' ? <GraduationCap size={18} /> : <Users size={18} />} 
                    {tab} 
                    <span className="bg-blue-100 text-blue-700 px-1.5 rounded text-xs ml-2">
                        {tab === 'alunos' ? alunosData.total : profsData.total}
                    </span>
                </button>
            ))}
       </div>

       {/* Lista Principal */}
       <div className="bg-white rounded-xl shadow-sm border border-gray-100 min-h-[400px] flex flex-col">
            <div className="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/30">
                <h2 className="text-lg font-bold text-gray-800 capitalize">{abaAtiva}</h2>
                <button onClick={() => { setModalOpen(true); setTermoBusca(''); setSelecionados([]); setModalBuscaData({list:[], total:0, page:1, totalPages:0}); }} className="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 flex gap-2">
                    <UserPlus size={18} /> Adicionar {abaAtiva === 'alunos' ? 'Aluno' : 'Professor'}
                </button>
            </div>

            <div className="flex-1 p-2">
                {(abaAtiva === 'alunos' ? alunosData.list : profsData.list).length === 0 ? (
                    <div className="flex flex-col items-center justify-center h-48 text-gray-400">
                        <p>Nenhum registro.</p>
                    </div>
                ) : (
                    <div className="divide-y divide-gray-100">
                        {(abaAtiva === 'alunos' ? alunosData.list : profsData.list).map((item) => (
                            <div key={item.matricula_id || item.vinculo_id} className="p-4 flex justify-between items-center hover:bg-gray-50 rounded-lg group">
                                <div className="flex items-center gap-4">
                                    <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-white shadow-sm ${abaAtiva === 'alunos' ? 'bg-green-500' : 'bg-indigo-500'}`}>
                                        {item.nome_completo?.charAt(0)}
                                    </div>
                                    <div>
                                        <p className="font-bold text-gray-800">{item.nome_completo}</p>
                                        <p className="text-xs text-gray-500 font-mono">{item.cpf || item.email_institucional}</p>
                                    </div>
                                </div>
                                <button onClick={() => handleRemover(item.matricula_id || item.vinculo_id, abaAtiva === 'alunos' ? 'aluno' : 'prof')} className="text-gray-300 hover:text-red-500 p-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <Trash2 size={18} />
                                </button>
                            </div>
                        ))}
                    </div>
                )}
            </div>
            
            <Pagination data={abaAtiva === 'alunos' ? alunosData : profsData} onChangePage={abaAtiva === 'alunos' ? carregarAlunos : carregarProfessores} />
       </div>

       {/* --- MODAL DE BUSCA UNIFICADO (ALUNO E PROFESSOR) --- */}
       {modalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[85vh]">
                
                {/* Header Modal */}
                <div className="px-6 py-4 bg-gray-50 border-b border-gray-100 flex justify-between items-center">
                    <h3 className="text-lg font-bold text-gray-800">
                        {abaAtiva === 'alunos' ? 'Matricular Alunos' : 'Vincular Professores'}
                    </h3>
                    <button onClick={() => setModalOpen(false)}><X className="text-gray-400 hover:text-red-500" /></button>
                </div>
                
                {/* Busca */}
                <div className="p-4 border-b border-gray-100">
                    <div className="relative">
                        <Search className="absolute left-3 top-2.5 text-gray-400" size={20} />
                        <input 
                            type="text" 
                            className="w-full border border-gray-300 pl-10 p-2 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" 
                            placeholder={abaAtiva === 'alunos' ? "Buscar Aluno (Nome ou CPF)..." : "Buscar Professor (Nome ou CPF)..."} 
                            value={termoBusca}
                            onChange={handleInputBusca}
                            autoFocus
                        />
                    </div>
                </div>

                {/* Lista de Resultados com Scroll */}
                <div className="flex-1 overflow-y-auto bg-gray-50 p-2 space-y-2">
                    {loadingBusca && <div className="text-center py-4 text-blue-500 flex justify-center"><Loader2 className="animate-spin"/></div>}
                    
                    {!loadingBusca && modalBuscaData.list.length === 0 && (
                        <p className="text-center text-gray-400 text-sm mt-4">
                            {termoBusca.length < 3 ? "Digite pelo menos 3 caracteres..." : "Nenhum resultado encontrado."}
                        </p>
                    )}

                    {modalBuscaData.list.map(item => (
                        <div 
                            key={item.id} 
                            onClick={() => toggleSelecao(item.id)}
                            className={`p-3 rounded-lg flex items-center justify-between cursor-pointer transition-colors border ${selecionados.includes(item.id) ? 'bg-blue-50 border-blue-200' : 'bg-white border-transparent hover:border-gray-200'}`}
                        >
                            <div className="flex items-center gap-3">
                                <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white text-xs font-bold ${abaAtiva==='alunos'?'bg-green-400':'bg-indigo-400'}`}>
                                    {item.nome_completo?.charAt(0)}
                                </div>
                                <div>
                                    <p className="font-bold text-gray-800 text-sm">{item.nome_completo}</p>
                                    <p className="text-xs text-gray-500">{item.cpf || item.email_institucional}</p>
                                </div>
                            </div>
                            <div className={selecionados.includes(item.id) ? "text-blue-600" : "text-gray-300"}>
                                {selecionados.includes(item.id) ? <CheckSquare size={20}/> : <Square size={20}/>}
                            </div>
                        </div>
                    ))}
                </div>
                
                {/* Paginação do Modal */}
                {modalBuscaData.total > 0 && (
                    <div className="bg-white border-t border-gray-100">
                        <Pagination data={modalBuscaData} onChangePage={handlePaginaModal} simple={true} />
                    </div>
                )}

                {/* Footer */}
                <div className="p-4 border-t border-gray-100 bg-white flex justify-between items-center">
                    <span className="text-xs text-gray-500">{selecionados.length} selecionado(s)</span>
                    <div className="flex gap-2">
                        <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg text-sm">Cancelar</button>
                        <button 
                            onClick={handleSalvarSelecionados} 
                            className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-bold shadow-lg disabled:opacity-50 text-sm"
                            disabled={selecionados.length === 0}
                        >
                            Salvar
                        </button>
                    </div>
                </div>
            </div>
        </div>
      )}
    </div>
  );
};

export default DetalhesTurma;