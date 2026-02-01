import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';

const GestaoTurmas = () => {
  const navigate = useNavigate();
  const [turmas, setTurmas] = useState([]);
  const [projetos, setProjetos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);

  // Estado do Formulário
  const [novaTurma, setNovaTurma] = useState({
    projeto_id: '',
    nome: '',
    turno: 'Manhã',
    periodo: '', // Começa vazio pra exibir o placeholder
    data_inicio: '',
    data_fim: '',
    dias_aula: []
  });

  const diasOpcoes = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

  useEffect(() => {
    carregarDados();
  }, []);

  const carregarDados = async () => {
    setLoading(true);
    try {
      const [resTurmas, resProjetos] = await Promise.all([
        api.get('/turmas'),
        api.get('/projetos')
      ]);
      setTurmas(resTurmas.data);
      setProjetos(resProjetos.data);
    } catch (error) {
      console.error(error);
      alert('Erro ao carregar dados. Verifique sua conexão.');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    // Validação Manual apenas dos campos CRÍTICOS
    if (!novaTurma.projeto_id || !novaTurma.nome || !novaTurma.periodo) {
        return alert("Por favor, preencha: Projeto, Nome e Período.");
    }

    try {
        // Envia os dados (campos vazios irão como string vazia ou null, trataremos no back)
        await api.post('/turmas', novaTurma);
        alert("Turma criada com sucesso!");
        setShowModal(false);
        carregarDados();
        // Reset do form
        setNovaTurma({
            projeto_id: '', nome: '', turno: 'Manhã', periodo: '', 
            data_inicio: '', data_fim: '', dias_aula: []
        });
    } catch (error) {
        alert("Erro ao criar turma: " + (error.response?.data?.error || error.message));
    }
  };

  const handleDiaChange = (dia) => {
    setNovaTurma(prev => {
      const dias = prev.dias_aula;
      return dias.includes(dia) 
        ? { ...prev, dias_aula: dias.filter(d => d !== dia) }
        : { ...prev, dias_aula: [...dias, dia] };
    });
  };

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="flex justify-between items-center mb-8">
        <div>
            <h1 className="text-2xl font-bold text-gray-800">Gestão de Turmas</h1>
            <p className="text-gray-500 text-sm">Crie e administre as turmas dos projetos</p>
        </div>
        <button onClick={() => setShowModal(true)} className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 shadow-sm transition-all">
          + Nova Turma
        </button>
      </div>

      {loading ? <p className="text-center py-10 text-gray-500">Carregando turmas...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmas.map(turma => (
            <div key={turma.id} className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all relative overflow-hidden group">
               {/* Faixa lateral decorativa */}
               <div className="absolute left-0 top-0 bottom-0 w-1 bg-blue-500 group-hover:bg-blue-600 transition-colors"></div>
               
               <div className="pl-3">
                   <span className="text-[10px] font-bold text-blue-600 uppercase tracking-wider border border-blue-100 px-2 py-0.5 rounded-full bg-blue-50">
                      {turma.nome_projeto || 'Projeto Geral'}
                   </span>
                   
                   <h3 className="font-bold text-lg text-gray-800 mt-2">{turma.nome}</h3>
                   
                   <div className="mt-3 space-y-1 text-sm text-gray-600">
                      <div className="flex justify-between">
                        <span>{turma.periodo}</span>
                        <span>{turma.turno}</span>
                      </div>
                      
                      {/* Mostra dias apenas se tiver */}
                      {turma.dias_aula?.length > 0 && (
                          <div className="flex flex-wrap gap-1 mt-2 pt-2 border-t border-gray-50">
                            {turma.dias_aula.map(dia => (
                                <span key={dia} className="bg-gray-100 text-gray-500 px-1.5 py-0.5 rounded text-[10px] uppercase font-bold">{dia.substring(0,3)}</span>
                            ))}
                          </div>
                      )}
                   </div>

                   <button 
                     onClick={() => navigate(`/app/turmas/${turma.id}`)}
                     className="w-full mt-4 bg-gray-50 text-blue-600 py-2 rounded-lg text-sm font-medium hover:bg-blue-600 hover:text-white transition-colors border border-blue-100 hover:border-blue-600"
                   >
                     Gerenciar Turma →
                   </button>
               </div>
            </div>
          ))}
          
          {turmas.length === 0 && (
            <div className="col-span-full text-center py-12 bg-gray-50 rounded-xl border-2 border-dashed border-gray-200">
                <p className="text-gray-400 font-medium">Nenhuma turma cadastrada.</p>
                <button onClick={() => setShowModal(true)} className="text-blue-500 hover:underline text-sm mt-1">Criar a primeira agora</button>
            </div>
          )}
        </div>
      )}

      {/* MODAL DE CRIAÇÃO */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden">
                <div className="bg-gray-50 px-6 py-4 border-b border-gray-100 flex justify-between items-center">
                    <h2 className="text-lg font-bold text-gray-800">Nova Turma</h2>
                    <button onClick={() => setShowModal(false)} className="text-gray-400 hover:text-gray-600 text-2xl leading-none">&times;</button>
                </div>
                
                <form onSubmit={handleSubmit} className="p-6 space-y-4">
                    
                    {/* 1. VINCULAR PROJETO (OBRIGATÓRIO) */}
                    <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1">Projeto <span className="text-red-500">*</span></label>
                        <select 
                            className="w-full border border-gray-300 p-2.5 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none bg-white" 
                            value={novaTurma.projeto_id} 
                            onChange={e => setNovaTurma({...novaTurma, projeto_id: e.target.value})}
                            required
                        >
                            <option value="">Selecione o Projeto...</option>
                            {projetos.map(p => <option key={p.id} value={p.id}>{p.titulo}</option>)}
                        </select>
                    </div>

                    {/* 2. NOME DA TURMA (OBRIGATÓRIO) */}
                    <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1">Nome da Turma <span className="text-red-500">*</span></label>
                        <input 
                            type="text"
                            placeholder="Ex: Informática Básica - Turma A" 
                            className="w-full border border-gray-300 p-2.5 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" 
                            value={novaTurma.nome} 
                            onChange={e => setNovaTurma({...novaTurma, nome: e.target.value})} 
                            required 
                        />
                    </div>

                    {/* 3. TURNO E PERÍODO (OBRIGATÓRIOS) */}
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1">Turno <span className="text-red-500">*</span></label>
                            <select 
                                className="w-full border border-gray-300 p-2.5 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none bg-white"
                                value={novaTurma.turno} 
                                onChange={e => setNovaTurma({...novaTurma, turno: e.target.value})}
                            >
                                <option>Manhã</option>
                                <option>Tarde</option>
                                <option>Noite</option>
                            </select>
                        </div>
                        <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1">Período <span className="text-red-500">*</span></label>
                            <input 
                                type="text" 
                                placeholder="Ex: 2026.1" 
                                className="w-full border border-gray-300 p-2.5 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" 
                                value={novaTurma.periodo} 
                                onChange={e => setNovaTurma({...novaTurma, periodo: e.target.value})} 
                                required 
                            />
                        </div>
                    </div>

                    <div className="border-t border-gray-100 my-4"></div>
                    <p className="text-xs font-bold text-gray-400 uppercase tracking-wide mb-2">Informações Opcionais</p>

                    {/* 4. DATAS (OPCIONAIS) */}
                    <div className="grid grid-cols-2 gap-4">
                         <div>
                             <label className="block text-sm text-gray-600 mb-1">Data Início</label>
                             <input 
                                type="date" 
                                className="w-full border border-gray-300 p-2 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" 
                                value={novaTurma.data_inicio} 
                                onChange={e => setNovaTurma({...novaTurma, data_inicio: e.target.value})} 
                             />
                         </div>
                         <div>
                             <label className="block text-sm text-gray-600 mb-1">Data Fim</label>
                             <input 
                                type="date" 
                                className="w-full border border-gray-300 p-2 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none" 
                                value={novaTurma.data_fim} 
                                onChange={e => setNovaTurma({...novaTurma, data_fim: e.target.value})} 
                             />
                         </div>
                    </div>

                    {/* 5. DIAS (OPCIONAIS) */}
                    <div>
                        <label className="block text-sm text-gray-600 mb-2">Dias de Aula</label>
                        <div className="flex flex-wrap gap-2">
                            {diasOpcoes.map(dia => (
                                <label key={dia} className={`cursor-pointer px-3 py-1.5 rounded text-sm border transition-all ${novaTurma.dias_aula.includes(dia) ? 'bg-blue-50 border-blue-500 text-blue-700 font-bold' : 'bg-white border-gray-200 text-gray-600 hover:bg-gray-50'}`}>
                                    <input 
                                        type="checkbox" 
                                        className="hidden" 
                                        checked={novaTurma.dias_aula.includes(dia)} 
                                        onChange={() => handleDiaChange(dia)} 
                                    />
                                    {dia}
                                </label>
                            ))}
                        </div>
                    </div>

                    <div className="flex justify-end gap-3 pt-4 border-t border-gray-100 mt-4">
                        <button type="button" onClick={() => setShowModal(false)} className="px-5 py-2 text-gray-600 hover:bg-gray-100 rounded-lg font-medium transition-colors">Cancelar</button>
                        <button type="submit" className="px-5 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium shadow-lg shadow-blue-500/30 transition-all">Salvar Turma</button>
                    </div>
                </form>
            </div>
        </div>
      )}
    </div>
  );
};
export default GestaoTurmas;