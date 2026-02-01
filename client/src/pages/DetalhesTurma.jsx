import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Trash2, UserPlus, Users, GraduationCap } from 'lucide-react'; // Ícones bonitos

const DetalhesTurma = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  
  const [turma, setTurma] = useState(null);
  const [alunos, setAlunos] = useState([]);
  const [professores, setProfessores] = useState([]);
  const [loading, setLoading] = useState(true);

  // Controle de Abas e Modais
  const [abaAtiva, setAbaAtiva] = useState('alunos');
  const [modalOpen, setModalOpen] = useState(false);
  const [inputId, setInputId] = useState(''); // ID para adicionar

  useEffect(() => {
    carregarDados();
  }, [id]);

  const carregarDados = async () => {
    try {
      setLoading(true);
      const [resTurma, resAlunos, resProfs] = await Promise.all([
        api.get(`/turmas/${id}`),
        api.get(`/turmas/${id}/matriculas`),
        api.get(`/turmas/${id}/professores`)
      ]);
      setTurma(resTurma.data);
      setAlunos(resAlunos.data);
      setProfessores(resProfs.data);
    } catch (error) {
      alert("Erro ao carregar turma.");
      navigate('/app/gestao-turmas');
    } finally {
      setLoading(false);
    }
  };

  // Adicionar (Genérico para Aluno ou Professor dependendo da aba)
  const handleAdicionar = async (e) => {
    e.preventDefault();
    try {
        if (abaAtiva === 'alunos') {
            await api.post(`/turmas/${id}/matriculas`, { aluno_id: inputId });
            alert("Aluno matriculado!");
        } else {
            await api.post(`/turmas/${id}/professores`, { professor_id: inputId });
            alert("Professor vinculado!");
        }
        setModalOpen(false);
        setInputId('');
        carregarDados();
    } catch (error) {
        alert("Erro: " + (error.response?.data?.error || "Falha ao adicionar"));
    }
  };

  // Remover Item
  const handleRemover = async (itemId, tipo) => {
      if(!confirm("Tem certeza que deseja remover?")) return;
      try {
          if (tipo === 'aluno') {
              await api.delete(`/matriculas/${itemId}`);
          } else {
              await api.delete(`/turma-professores/${itemId}`);
          }
          carregarDados();
      } catch (error) {
          alert("Erro ao remover.");
      }
  };

  if (loading) return <div className="p-8 text-center text-gray-500">Carregando painel...</div>;
  if (!turma) return null;

  return (
    <div className="max-w-6xl mx-auto space-y-6 animate-fade-in">
      
      {/* HEADER DA TURMA */}
      <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
        <button onClick={() => navigate('/app/gestao-turmas')} className="text-sm text-gray-500 hover:text-blue-600 mb-2">← Voltar</button>
        <div className="flex justify-between items-start">
            <div>
                <h1 className="text-3xl font-bold text-gray-800">{turma.nome}</h1>
                <p className="text-gray-500 mt-1">{turma.turno} • {turma.periodo}</p>
            </div>
            <div className={`px-3 py-1 rounded-full text-xs font-bold ${turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                {turma.ativo ? 'ATIVO' : 'INATIVO'}
            </div>
        </div>
      </div>

      {/* ABAS */}
      <div className="flex gap-4 border-b border-gray-200">
        <button 
            onClick={() => setAbaAtiva('alunos')}
            className={`flex items-center gap-2 px-4 py-3 border-b-2 transition-colors ${abaAtiva === 'alunos' ? 'border-blue-600 text-blue-600 font-bold' : 'border-transparent text-gray-500'}`}
        >
            <GraduationCap size={20} /> Alunos ({alunos.length})
        </button>
        <button 
            onClick={() => setAbaAtiva('professores')}
            className={`flex items-center gap-2 px-4 py-3 border-b-2 transition-colors ${abaAtiva === 'professores' ? 'border-blue-600 text-blue-600 font-bold' : 'border-transparent text-gray-500'}`}
        >
            <Users size={20} /> Professores ({professores.length})
        </button>
      </div>

      {/* CONTEÚDO */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
        <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-bold text-gray-800">
                {abaAtiva === 'alunos' ? 'Lista de Chamada' : 'Corpo Docente'}
            </h2>
            <button 
                onClick={() => setModalOpen(true)}
                className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2 text-sm font-medium"
            >
                <UserPlus size={18} /> 
                {abaAtiva === 'alunos' ? 'Matricular Aluno' : 'Vincular Professor'}
            </button>
        </div>

        {/* LISTA */}
        <div className="divide-y divide-gray-100">
            {(abaAtiva === 'alunos' ? alunos : professores).map((item) => (
                <div key={item.id || item.matricula_id || item.vinculo_id} className="py-4 flex justify-between items-center hover:bg-gray-50 px-2 rounded transition-colors">
                    <div className="flex items-center gap-3">
                        <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-white ${abaAtiva === 'alunos' ? 'bg-green-500' : 'bg-purple-500'}`}>
                            {item.nome_completo?.charAt(0)}
                        </div>
                        <div>
                            <p className="font-medium text-gray-800">{item.nome_completo}</p>
                            <p className="text-xs text-gray-500">{item.cpf || item.email_institucional}</p>
                        </div>
                    </div>
                    <button 
                        onClick={() => handleRemover(item.matricula_id || item.vinculo_id, abaAtiva === 'alunos' ? 'aluno' : 'prof')}
                        className="text-gray-400 hover:text-red-500 p-2"
                        title="Remover"
                    >
                        <Trash2 size={18} />
                    </button>
                </div>
            ))}

            {(abaAtiva === 'alunos' ? alunos : professores).length === 0 && (
                <p className="text-center text-gray-400 py-10 italic">Nenhum registro encontrado.</p>
            )}
        </div>
      </div>

      {/* MODAL SIMPLIFICADO (POR ID) */}
      {modalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-sm p-6">
                <h3 className="text-lg font-bold mb-2">
                    {abaAtiva === 'alunos' ? 'Matricular Aluno' : 'Vincular Professor'}
                </h3>
                <p className="text-sm text-gray-500 mb-4">
                    Digite o ID do {abaAtiva === 'alunos' ? 'Beneficiário' : 'Colaborador'} para adicionar.
                </p>
                <form onSubmit={handleAdicionar}>
                    <input 
                        type="number" 
                        className="w-full border p-2 rounded mb-4 focus:ring-2 focus:ring-blue-500 outline-none" 
                        placeholder="Ex: 1" 
                        value={inputId}
                        onChange={e => setInputId(e.target.value)}
                        autoFocus
                        required
                    />
                    <div className="flex justify-end gap-2">
                        <button type="button" onClick={() => setModalOpen(false)} className="text-gray-600 px-4 py-2 hover:bg-gray-100 rounded">Cancelar</button>
                        <button type="submit" className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Adicionar</button>
                    </div>
                </form>
            </div>
        </div>
      )}

    </div>
  );
};

export default DetalhesTurma;