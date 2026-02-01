import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex'; // Use a instância do axios configurada

const GestaoTurmas = () => {
  const navigate = useNavigate();
  const [turmas, setTurmas] = useState([]);
  const [projetos, setProjetos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);

  // Form State
  const [novaTurma, setNovaTurma] = useState({
    projeto_id: '',
    nome: '',
    turno: 'Manhã',
    periodo: '2026.1',
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
      alert('Erro ao carregar dados. Verifique se você está logado.');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
        await api.post('/turmas', novaTurma);
        alert("Turma criada com sucesso!");
        setShowModal(false);
        carregarDados();
        setNovaTurma({ ...novaTurma, nome: '', dias_aula: [] });
    } catch (error) {
        alert("Erro ao criar turma.");
    }
  };

  // ... (Mantenha a função handleDiaChange igual) ...
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
        <h1 className="text-2xl font-bold text-gray-800">Gestão de Turmas</h1>
        <button onClick={() => setShowModal(true)} className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
          + Nova Turma
        </button>
      </div>

      {loading ? <p>Carregando...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmas.map(turma => (
            <div key={turma.id} className="bg-white p-5 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all">
               {/* Nome do Projeto (Vindo do Join no backend) */}
               <span className="text-xs font-bold text-blue-600 uppercase tracking-wide">
                  {turma.nome_projeto || 'Projeto Geral'}
               </span>
               
               <h3 className="font-bold text-lg text-gray-800 mt-1">{turma.nome}</h3>
               
               <div className="mt-4 space-y-1 text-sm text-gray-600">
                  <p>📅 {turma.periodo} • {turma.turno}</p>
                  <div className="flex flex-wrap gap-1 mt-2">
                    {turma.dias_aula?.map(dia => (
                        <span key={dia} className="bg-gray-100 px-2 py-0.5 rounded text-xs">{dia}</span>
                    ))}
                  </div>
               </div>

               <button 
                 onClick={() => navigate(`/app/turmas/${turma.id}`)}
                 className="w-full mt-4 bg-gray-50 text-blue-600 py-2 rounded-lg text-sm font-medium hover:bg-blue-50 border border-blue-100"
               >
                 Gerenciar Turma →
               </button>
            </div>
          ))}
        </div>
      )}

      {/* --- MANTENHA O MODAL IGUAL AO QUE JÁ TINHA --- */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg p-6">
                <h2 className="text-lg font-bold mb-4">Nova Turma</h2>
                <form onSubmit={handleSubmit} className="space-y-4">
                    {/* Select de Projetos */}
                    <select 
                        className="w-full border p-2 rounded" 
                        value={novaTurma.projeto_id} 
                        onChange={e => setNovaTurma({...novaTurma, projeto_id: e.target.value})}
                        required
                    >
                        <option value="">Selecione o Projeto...</option>
                        {projetos.map(p => <option key={p.id} value={p.id}>{p.titulo}</option>)}
                    </select>

                    <input placeholder="Nome da Turma" className="w-full border p-2 rounded" value={novaTurma.nome} onChange={e => setNovaTurma({...novaTurma, nome: e.target.value})} required />
                    
                    {/* ... Resto dos inputs (turno, datas, dias) iguais ao anterior ... */}
                    <div className="flex gap-2">
                         <input type="date" className="w-1/2 border p-2 rounded" value={novaTurma.data_inicio} onChange={e => setNovaTurma({...novaTurma, data_inicio: e.target.value})} required />
                         <input type="date" className="w-1/2 border p-2 rounded" value={novaTurma.data_fim} onChange={e => setNovaTurma({...novaTurma, data_fim: e.target.value})} required />
                    </div>

                    <div className="flex flex-wrap gap-2">
                        {diasOpcoes.map(dia => (
                            <label key={dia} className="flex items-center gap-1 bg-gray-50 px-2 py-1 rounded cursor-pointer border">
                                <input type="checkbox" checked={novaTurma.dias_aula.includes(dia)} onChange={() => handleDiaChange(dia)} />
                                <span className="text-sm">{dia}</span>
                            </label>
                        ))}
                    </div>

                    <div className="flex justify-end gap-2 pt-4">
                        <button type="button" onClick={() => setShowModal(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded">Cancelar</button>
                        <button type="submit" className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
      )}
    </div>
  );
};
export default GestaoTurmas;