import { useEffect, useState } from 'react';
import { api } from '../services/api'; // Sua api.js híbrida
import {
  Users, GraduationCap, Calendar, Plus, Search, MoreVertical, X, Loader2
} from 'lucide-react';

// src/pages/GestaoTurmas.jsx
import { useNavigate } from 'react-router-dom'; // <--- Adicione isso

export default function GestaoTurmas() {

  const navigate = useNavigate();
  const [turmas, setTurmas] = useState([]);
  const [projetos, setProjetos] = useState([]); // <--- NOVIDADE: Lista de Projetos
  const [loading, setLoading] = useState(true);

  // Estados do Modal
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSaving, setIsSaving] = useState(false);

  // Formulário (Agora com projeto_id e datas)
  const [formData, setFormData] = useState({
    projeto_id: '',
    nome: '',
    turno: 'Matutino',
    periodo: '2026.1',
    data_inicio: '',
    data_fim: '',
    dias_aula: []
  });

  // Carregar Dados Iniciais
  async function loadData() {
    try {
      setLoading(true);
      // Busca turmas (do MySQL) e Projetos (do Mock) em paralelo
      const [resTurmas, resProjetos] = await Promise.all([
        api.getTurmas(),
        api.getProjetos()
      ]);

      setTurmas(resTurmas.data || []); // O backend retorna direto o array ou {data: []} dependendo da implementação, ajusta aqui se precisar
      setProjetos(resProjetos.data || []);
    } catch (error) {
      console.error("Erro ao carregar dados:", error);
      alert("Erro ao conectar com o servidor. Verifique se o backend está rodando!");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadData();
  }, []);

  // Manipular inputs
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  // Manipular dias da semana
  const toggleDia = (dia) => {
    setFormData(prev => {
      const dias = prev.dias_aula.includes(dia)
        ? prev.dias_aula.filter(d => d !== dia)
        : [...prev.dias_aula, dia];
      return { ...prev, dias_aula: dias };
    });
  };

  // Salvar Turma (Envia pro Backend Node.js)
  async function handleSubmit(e) {
    e.preventDefault();

    // Validação básica
    if (!formData.projeto_id) {
      alert("Por favor, selecione um projeto!");
      return;
    }

    setIsSaving(true);

    try {
      // Chama a API real
      await api.createTurma(formData);

      // Recarrega a lista
      const response = await api.getTurmas();
      setTurmas(response.data || response); // Ajuste conforme o retorno da sua API

      // Fecha modal
      setIsModalOpen(false);
      setFormData({
        projeto_id: '', nome: '', turno: 'Matutino',
        periodo: '2026.1', data_inicio: '', data_fim: '', dias_aula: []
      });
      alert("Turma criada com sucesso!");
    } catch (error) {
      console.error(error);
      alert("Erro ao criar turma. Veja o console.");
    } finally {
      setIsSaving(false);
    }
  }

  // Função auxiliar para achar nome do projeto pelo ID (Visualização)
  const getNomeProjeto = (id) => {
    const proj = projetos.find(p => p.id === Number(id));
    return proj ? proj.titulo : 'Projeto Desconhecido';
  };

  if (loading) {
    return (
      <div className="flex flex-col justify-center items-center h-64 text-blue-600 gap-2">
        <Loader2 className="animate-spin" size={40} />
        <p>Carregando sistema...</p>
      </div>
    );
  }

  return (
    <div className="relative animate-fade-in">
      {/* Cabeçalho */}
      <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Gestão de Turmas</h1>
          <p className="text-gray-500">Administre as turmas dos projetos ativos.</p>
        </div>
        <button
          onClick={() => setIsModalOpen(true)}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2.5 rounded-lg flex items-center gap-2 font-medium transition-colors shadow-sm"
        >
          <Plus size={20} />
          Nova Turma
        </button>
      </div>

      {/* Cards de Resumo */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 flex items-center gap-4">
          <div className="p-3 bg-blue-50 text-blue-600 rounded-lg"><GraduationCap size={24} /></div>
          <div>
            <p className="text-sm text-gray-500 font-medium">Turmas Ativas</p>
            <h3 className="text-2xl font-bold text-gray-800">{turmas.filter(t => t.ativo).length}</h3>
          </div>
        </div>
        {/* Adicione mais cards aqui se quiser */}
      </div>

      {/* Lista de Turmas */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                <th className="p-4 font-semibold">Projeto / Turma</th>
                <th className="p-4 font-semibold">Período / Turno</th>
                <th className="p-4 font-semibold">Dias</th>
                <th className="p-4 font-semibold">Status</th>
                <th className="p-4 font-semibold text-right">Ações</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {turmas.length === 0 ? (
                <tr>
                  <td colSpan="5" className="p-8 text-center text-gray-500">
                    Nenhuma turma encontrada. Crie a primeira!
                  </td>
                </tr>
              ) : (
                turmas.map((turma) => (
                  <tr key={turma.id} className="hover:bg-gray-50 transition-colors">
                    <td className="p-4">
                      <span className="text-xs font-bold text-blue-600 uppercase tracking-wide">
                        {getNomeProjeto(turma.projeto_id)}
                      </span>
                      <p className="font-semibold text-gray-800">{turma.nome}</p>
                    </td>
                    <td className="p-4 text-gray-600">
                      <p>{turma.periodo}</p>
                      <span className="text-xs bg-slate-100 px-2 py-1 rounded text-slate-600">
                        {turma.turno}
                      </span>
                    </td>
                    <td className="p-4 text-sm text-gray-500">
                      {Array.isArray(turma.dias_aula) ? turma.dias_aula.join(', ') : turma.dias_aula}
                    </td>
                    <td className="p-4">
                      <span className={`px-2 py-1 rounded-full text-xs font-bold ${turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                        }`}>
                        {turma.ativo ? 'ATIVO' : 'INATIVO'}
                      </span>
                    </td>
                    <td className="p-4 text-right">
                      <button
                        onClick={() => navigate(`/app/turmas/${turma.id}`)} // <--- A MÁGICA É AQUI
                        className="text-gray-400 hover:text-blue-600 p-2 rounded-full hover:bg-blue-50 transition-colors"
                        title="Ver Detalhes" // Dica visual pro usuário
                      >
                        <MoreVertical size={18} />
                      </button>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* --- MODAL --- */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden animate-fade-in">
            <div className="bg-gray-50 px-6 py-4 border-b border-gray-100 flex justify-between items-center">
              <h2 className="text-lg font-bold text-gray-800">Nova Turma</h2>
              <button onClick={() => setIsModalOpen(false)} className="text-gray-400 hover:text-gray-600">
                <X size={24} />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="p-6 space-y-4">

              {/* SELECT DE PROJETOS (Fundamental pro modelo híbrido) */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Projeto Vinculado</label>
                <select
                  required
                  name="projeto_id"
                  value={formData.projeto_id}
                  onChange={handleInputChange}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none bg-white"
                >
                  <option value="">Selecione um projeto...</option>
                  {projetos.map(proj => (
                    <option key={proj.id} value={proj.id}>
                      {proj.titulo}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Nome da Turma</label>
                <input
                  required
                  name="nome"
                  value={formData.nome}
                  onChange={handleInputChange}
                  placeholder="Ex: Téc. Enfermagem - Módulo 1"
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Período Letivo</label>
                  <input
                    required
                    name="periodo"
                    value={formData.periodo}
                    onChange={handleInputChange}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Turno</label>
                  <select
                    name="turno"
                    value={formData.turno}
                    onChange={handleInputChange}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none bg-white"
                  >
                    <option value="Matutino">Matutino</option>
                    <option value="Vespertino">Vespertino</option>
                    <option value="Noturno">Noturno</option>
                  </select>
                </div>
              </div>

              {/* DATAS DE INÍCIO E FIM */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Data Início</label>
                  <input
                    type="date"
                    required
                    name="data_inicio"
                    value={formData.data_inicio}
                    onChange={handleInputChange}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Data Fim</label>
                  <input
                    type="date"
                    required
                    name="data_fim"
                    value={formData.data_fim}
                    onChange={handleInputChange}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Dias de Aula</label>
                <div className="flex gap-2 flex-wrap">
                  {['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'].map(dia => (
                    <button
                      key={dia}
                      type="button"
                      onClick={() => toggleDia(dia)}
                      className={`px-3 py-1 rounded-full text-sm font-medium border transition-colors ${formData.dias_aula.includes(dia)
                          ? 'bg-blue-100 border-blue-200 text-blue-700'
                          : 'bg-white border-gray-200 text-gray-500 hover:bg-gray-50'
                        }`}
                    >
                      {dia}
                    </button>
                  ))}
                </div>
              </div>

              <div className="pt-4 flex justify-end gap-3 border-t border-gray-100 mt-4">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 text-gray-700 hover:bg-gray-100 rounded-lg font-medium"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  disabled={isSaving}
                  className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg font-bold shadow-md transition-all flex items-center"
                >
                  {isSaving ? <Loader2 className="animate-spin mr-2" size={20} /> : null}
                  {isSaving ? 'Salvando...' : 'Criar Turma'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}