import { useState, useEffect } from 'react';
import { getTurmas, criarTurma } from '../services/sysconex';
// Se você usar ícones (lucide-react, heroicons), pode importar aqui. 
// Vou usar texto/emoji pra garantir que rode sem instalar nada extra.

const GestaoTurmas = () => {
  const [turmas, setTurmas] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);

  // Estado do Formulário
  const [novaTurma, setNovaTurma] = useState({
    projeto_id: 1, // Valor padrão (pode mudar se tiver gestão de projetos)
    nome: '',
    turno: 'Manhã',
    periodo: '2026.1',
    data_inicio: '',
    data_fim: '',
    dias_aula: []
  });

  const diasOpcoes = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

  // 1. Carregar Turmas
  useEffect(() => {
    carregarDados();
  }, []);

  const carregarDados = async () => {
    setLoading(true);
    try {
      const dados = await getTurmas();
      setTurmas(dados);
    } catch (error) {
      console.error(error);
      alert('Erro ao conectar com o servidor (Porta 10000).');
    } finally {
      setLoading(false);
    }
  };

  // 2. Manipular Checkbox de Dias
  const handleDiaChange = (dia) => {
    setNovaTurma(prev => {
      const diasAtuais = prev.dias_aula;
      if (diasAtuais.includes(dia)) {
        return { ...prev, dias_aula: diasAtuais.filter(d => d !== dia) };
      } else {
        return { ...prev, dias_aula: [...diasAtuais, dia] };
      }
    });
  };

  // 3. Enviar Formulário
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!novaTurma.nome || !novaTurma.data_inicio) return alert("Preencha os campos obrigatórios");

    try {
      await criarTurma(novaTurma);
      alert("Turma criada com sucesso! 🚀");
      setShowModal(false);
      carregarDados();
      // Resetar form
      setNovaTurma({ ...novaTurma, nome: '', dias_aula: [] });
    } catch (error) {
      alert("Erro ao criar turma.");
    }
  };

  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* HEADER */}
      <div className="flex flex-col md:flex-row justify-between items-center mb-8 gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Gestão de Turmas</h1>
          <p className="text-gray-500">Administre as turmas e cronogramas do projeto</p>
        </div>
        <button 
          onClick={() => setShowModal(true)}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-medium shadow-sm transition-all flex items-center gap-2"
        >
          <span>+</span> Nova Turma
        </button>
      </div>

      {/* GRID DE TURMAS */}
      {loading ? (
        <div className="text-center py-10 text-gray-500">Carregando turmas...</div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmas.map(turma => (
            <div key={turma.id} className="bg-white rounded-xl shadow-sm border border-gray-100 p-5 hover:shadow-md transition-shadow">
              <div className="flex justify-between items-start mb-3">
                <h3 className="font-bold text-lg text-gray-800">{turma.nome}</h3>
                <span className={`px-2 py-1 rounded text-xs font-semibold ${turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                  {turma.ativo ? 'Ativo' : 'Inativo'}
                </span>
              </div>
              
              <div className="space-y-2 text-sm text-gray-600 mb-4">
                <div className="flex items-center gap-2">
                  <span className="font-medium text-gray-700">Período:</span> {turma.periodo}
                </div>
                <div className="flex items-center gap-2">
                  <span className="font-medium text-gray-700">Turno:</span> {turma.turno}
                </div>
                <div className="flex flex-wrap gap-1 mt-2">
                  {turma.dias_aula && turma.dias_aula.length > 0 ? (
                    turma.dias_aula.map(dia => (
                      <span key={dia} className="bg-gray-100 text-gray-600 px-2 py-0.5 rounded text-xs border border-gray-200">
                        {dia}
                      </span>
                    ))
                  ) : (
                    <span className="text-xs text-gray-400 italic">Dias não definidos</span>
                  )}
                </div>
              </div>

              <button 
                className="w-full mt-2 bg-gray-50 text-gray-700 hover:bg-gray-100 border border-gray-200 py-2 rounded-lg text-sm font-medium transition-colors"
                onClick={() => alert(`Em breve: Tela de detalhes da turma ${turma.id}`)}
              >
                Gerenciar Alunos & Chamada →
              </button>
            </div>
          ))}

          {turmas.length === 0 && (
            <div className="col-span-full text-center py-10 bg-gray-50 rounded-xl border border-dashed border-gray-300">
              <p className="text-gray-500">Nenhuma turma cadastrada ainda.</p>
              <button onClick={() => setShowModal(true)} className="text-blue-600 font-medium hover:underline mt-2">
                Criar a primeira turma agora
              </button>
            </div>
          )}
        </div>
      )}

      {/* MODAL (Tailwind puro) */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden animate-fade-in">
            <div className="bg-gray-50 px-6 py-4 border-b border-gray-100 flex justify-between items-center">
              <h2 className="text-lg font-bold text-gray-800">Nova Turma</h2>
              <button onClick={() => setShowModal(false)} className="text-gray-400 hover:text-gray-600 font-bold text-xl">&times;</button>
            </div>
            
            <form onSubmit={handleSubmit} className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Nome da Turma</label>
                <input 
                  type="text" 
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all"
                  placeholder="Ex: Informática Básica - Turma A"
                  value={novaTurma.nome}
                  onChange={e => setNovaTurma({...novaTurma, nome: e.target.value})}
                  required
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Turno</label>
                  <select 
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none bg-white"
                    value={novaTurma.turno}
                    onChange={e => setNovaTurma({...novaTurma, turno: e.target.value})}
                  >
                    <option>Manhã</option>
                    <option>Tarde</option>
                    <option>Noite</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Período</label>
                  <input 
                    type="text" 
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                    value={novaTurma.periodo}
                    onChange={e => setNovaTurma({...novaTurma, periodo: e.target.value})}
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Data Início</label>
                  <input 
                    type="date" 
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                    value={novaTurma.data_inicio}
                    onChange={e => setNovaTurma({...novaTurma, data_inicio: e.target.value})}
                    required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Data Fim</label>
                  <input 
                    type="date" 
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                    value={novaTurma.data_fim}
                    onChange={e => setNovaTurma({...novaTurma, data_fim: e.target.value})}
                    required
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Dias de Aula</label>
                <div className="flex flex-wrap gap-3">
                  {diasOpcoes.map(dia => (
                    <label key={dia} className="inline-flex items-center gap-2 cursor-pointer bg-gray-50 px-3 py-1 rounded border border-gray-200 hover:bg-gray-100">
                      <input 
                        type="checkbox" 
                        className="rounded text-blue-600 focus:ring-blue-500"
                        checked={novaTurma.dias_aula.includes(dia)}
                        onChange={() => handleDiaChange(dia)}
                      />
                      <span className="text-sm text-gray-700">{dia}</span>
                    </label>
                  ))}
                </div>
              </div>

              <div className="flex justify-end gap-3 mt-6 pt-4 border-t border-gray-100">
                <button 
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-4 py-2 text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 font-medium"
                >
                  Cancelar
                </button>
                <button 
                  type="submit"
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium shadow-sm"
                >
                  Salvar Turma
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default GestaoTurmas;