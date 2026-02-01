import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Trash2, UserPlus, Users, GraduationCap, ArrowLeft, Search, CheckSquare, Square, X } from 'lucide-react';

const DetalhesTurma = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  
  const [turma, setTurma] = useState(null);
  const [alunos, setAlunos] = useState([]);
  const [professores, setProfessores] = useState([]);
  const [loading, setLoading] = useState(true);

  // Controle de Abas e Modais
  const [abaAtiva, setAbaAtiva] = useState('alunos'); // 'alunos' ou 'professores'
  const [modalOpen, setModalOpen] = useState(false);
  const [inputId, setInputId] = useState(''); // ID para adicionar

  useEffect(() => {
    carregarDados();
  }, [id]);

  const carregarDados = async () => {
    try {
      setLoading(true);
      // Busca tudo em paralelo pra ser rápido
      const [resTurma, resAlunos, resProfs] = await Promise.all([
        api.get(`/turmas/${id}`),
        api.get(`/turmas/${id}/matriculas`),
        api.get(`/turmas/${id}/professores`)
      ]);
      setTurma(resTurma.data);
      setAlunos(resAlunos.data);
      setProfessores(resProfs.data);
    } catch (error) {
      console.error(error);
      alert("Erro ao carregar dados da turma.");
      navigate('/app/gestao-turmas');
    } finally {
      setLoading(false);
    }
  };

  // Função Genérica para Adicionar (Aluno ou Professor)
  const handleAdicionar = async (e) => {
    e.preventDefault();
    try {
        if (abaAtiva === 'alunos') {
            await api.post(`/turmas/${id}/matriculas`, { aluno_id: inputId });
            alert("✅ Aluno matriculado com sucesso!");
        } else {
            await api.post(`/turmas/${id}/professores`, { professor_id: inputId });
            alert("✅ Professor vinculado com sucesso!");
        }
        setModalOpen(false);
        setInputId('');
        carregarDados(); // Recarrega a lista
    } catch (error) {
        alert("❌ Erro: " + (error.response?.data?.error || "Falha ao adicionar. Verifique o ID."));
    }
  };

  // Função Genérica para Remover
  const handleRemover = async (itemId, tipo) => {
      if(!confirm("Tem certeza que deseja remover esta pessoa da turma?")) return;
      
      try {
          if (tipo === 'aluno') {
              // Atenção: Aqui usamos o ID DA MATRÍCULA, não do aluno
              await api.delete(`/matriculas/${itemId}`);
          } else {
              // Atenção: Aqui usamos o ID DO VÍNCULO, não do professor
              await api.delete(`/turma-professores/${itemId}`);
          }
          carregarDados(); // Atualiza a tela sem recarregar
      } catch (error) {
          alert("Erro ao remover: " + error.response?.data?.error);
      }
  };

  // NOVOS ESTADOS PARA O MODAL DE ALUNOS
  const [busca, setBusca] = useState('');
  const [resultadosBusca, setResultadosBusca] = useState([]);
  const [selecionados, setSelecionados] = useState([]); // Array de IDs selecionados

  // ... (Mantenha o useEffect e carregarDados igual) ...

  // Função de buscar enquanto digita
  const handleBuscaAluno = async (e) => {
      const termo = e.target.value;
      setBusca(termo);
      if (termo.length > 2) {
          try {
              const res = await api.get(`/beneficiarios/busca?q=${termo}`);
              setResultadosBusca(res.data);
          } catch (error) { console.error("Erro busca"); }
      } else {
          setResultadosBusca([]);
      }
  };

  // Função para marcar/desmarcar checkbox
  const toggleSelecao = (id) => {
      setSelecionados(prev => 
          prev.includes(id) ? prev.filter(item => item !== id) : [...prev, id]
      );
  };

  // Enviar Múltiplos
  const handleMatriculaMultipla = async (e) => {
      e.preventDefault();
      if (selecionados.length === 0) return alert("Selecione pelo menos um aluno.");
      
      try {
          // Envia o array de IDs
          await api.post(`/turmas/${id}/matriculas`, { aluno_id: selecionados });
          
          alert("✅ Alunos matriculados!");
          setModalOpen(false);
          setSelecionados([]);
          setBusca('');
          setResultadosBusca([]);
          carregarDados();
      } catch (error) {
          const msg = error.response?.data?.detalhes 
              ? error.response.data.detalhes.join('\n') 
              : error.response?.data?.error;
          alert("⚠️ Atenção:\n" + msg);
      }
  };

  if (loading) return (
      <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
  );
  
  if (!turma) return null;

  return (
    <div className="max-w-6xl mx-auto space-y-6 animate-fade-in p-6">
      
      {/* HEADER DA TURMA */}
      <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 relative overflow-hidden">
        <div className="absolute top-0 left-0 w-1 h-full bg-blue-500"></div>
        
        <button onClick={() => navigate('/app/gestao-turmas')} className="flex items-center text-sm text-gray-500 hover:text-blue-600 mb-4 transition-colors">
            <ArrowLeft size={16} className="mr-1"/> Voltar
        </button>
        
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
            <div>
                <h1 className="text-3xl font-bold text-gray-800">{turma.nome}</h1>
                <div className="flex gap-3 mt-2 text-sm text-gray-600">
                    <span className="bg-blue-50 text-blue-700 px-2 py-0.5 rounded font-medium">{turma.turno}</span>
                    <span className="bg-gray-100 px-2 py-0.5 rounded border border-gray-200">{turma.periodo}</span>
                </div>
            </div>
            <div className={`px-4 py-1.5 rounded-full text-xs font-bold uppercase tracking-wider ${turma.ativo ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                {turma.ativo ? 'Em Andamento' : 'Encerrada'}
            </div>
        </div>
      </div>

      {/* NAVEGAÇÃO DE ABAS */}
      <div className="flex gap-1 bg-gray-100/50 p-1 rounded-lg w-fit">
        <button 
            onClick={() => setAbaAtiva('alunos')}
            className={`flex items-center gap-2 px-6 py-2.5 rounded-md text-sm font-medium transition-all ${abaAtiva === 'alunos' ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
        >
            <GraduationCap size={18} /> 
            Alunos 
            <span className="bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded text-xs ml-2">{alunos.length}</span>
        </button>
        <button 
            onClick={() => setAbaAtiva('professores')}
            className={`flex items-center gap-2 px-6 py-2.5 rounded-md text-sm font-medium transition-all ${abaAtiva === 'professores' ? 'bg-white text-blue-600 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}
        >
            <Users size={18} /> 
            Professores
            <span className="bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded text-xs ml-2">{professores.length}</span>
        </button>
      </div>

      {/* CONTEÚDO PRINCIPAL */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 flex flex-col min-h-[400px]">
        
        {/* BARRA DE AÇÃO DA ABA */}
        <div className="p-6 border-b border-gray-100 flex justify-between items-center bg-gray-50/30">
            <h2 className="text-lg font-bold text-gray-800">
                {abaAtiva === 'alunos' ? 'Lista de Frequência' : 'Corpo Docente'}
            </h2>
            <button 
                onClick={() => setModalOpen(true)}
                className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2 text-sm font-medium shadow-sm shadow-blue-500/30 transition-all"
            >
                <UserPlus size={18} /> 
                {abaAtiva === 'alunos' ? 'Matricular Aluno' : 'Vincular Professor'}
            </button>
        </div>

        {/* LISTAGEM */}
        <div className="p-2">
            {(abaAtiva === 'alunos' ? alunos : professores).length === 0 ? (
                <div className="flex flex-col items-center justify-center h-64 text-gray-400">
                    <div className="bg-gray-50 p-4 rounded-full mb-3">
                        {abaAtiva === 'alunos' ? <GraduationCap size={32} /> : <Users size={32} />}
                    </div>
                    <p>Nenhum {abaAtiva === 'alunos' ? 'aluno' : 'professor'} registrado nesta turma.</p>
                </div>
            ) : (
                <div className="divide-y divide-gray-100">
                    {(abaAtiva === 'alunos' ? alunos : professores).map((item) => (
                        <div key={item.matricula_id || item.vinculo_id} className="p-4 flex justify-between items-center hover:bg-gray-50 rounded-lg transition-colors group mx-2">
                            <div className="flex items-center gap-4">
                                <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold text-white shadow-sm ${abaAtiva === 'alunos' ? 'bg-gradient-to-br from-green-400 to-green-600' : 'bg-gradient-to-br from-purple-400 to-purple-600'}`}>
                                    {item.nome_completo?.charAt(0)}
                                </div>
                                <div>
                                    <p className="font-bold text-gray-800">{item.nome_completo}</p>
                                    <p className="text-xs text-gray-500 font-mono mt-0.5">
                                        {abaAtiva === 'alunos' ? `CPF: ${item.cpf || '---'}` : item.email_institucional}
                                    </p>
                                </div>
                            </div>
                            
                            <button 
                                onClick={() => handleRemover(item.matricula_id || item.vinculo_id, abaAtiva === 'alunos' ? 'aluno' : 'prof')}
                                className="text-gray-300 hover:text-red-500 hover:bg-red-50 p-2 rounded-lg transition-all opacity-0 group-hover:opacity-100"
                                title="Remover da turma"
                            >
                                <Trash2 size={18} />
                            </button>
                        </div>
                    ))}
                </div>
            )}
        </div>
      </div>

      {/* MODAL DE MATRÍCULA (BUSCA E SELEÇÃO) */}
  {modalOpen && abaAtiva === 'alunos' && (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4 animate-fade-in">
        <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden flex flex-col max-h-[80vh]">
            
            {/* Header do Modal */}
            <div className="px-6 py-4 bg-gray-50 border-b border-gray-100 flex justify-between items-center">
                <h3 className="text-lg font-bold text-gray-800">Matricular Alunos</h3>
                <button onClick={() => setModalOpen(false)}><X className="text-gray-400 hover:text-red-500" /></button>
            </div>
            
            {/* Corpo: Busca e Lista */}
            <div className="p-6 flex-1 overflow-hidden flex flex-col">
                <div className="relative mb-4">
                    <Search className="absolute left-3 top-2.5 text-gray-400" size={20} />
                    <input 
                        type="text" 
                        className="w-full border border-gray-300 pl-10 p-2 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" 
                        placeholder="Buscar por Nome ou CPF..." 
                        value={busca}
                        onChange={handleBuscaAluno}
                        autoFocus
                    />
                </div>

                {/* Área de Resultados com Scroll */}
                <div className="flex-1 overflow-y-auto border rounded-lg border-gray-100 bg-gray-50 p-2 space-y-2">
                    {resultadosBusca.length === 0 && busca.length > 0 && (
                        <p className="text-center text-gray-400 text-sm mt-4">Nenhum aluno encontrado.</p>
                    )}
                    {resultadosBusca.length === 0 && busca.length === 0 && (
                        <p className="text-center text-gray-400 text-sm mt-4">Digite para buscar...</p>
                    )}

                    {resultadosBusca.map(aluno => (
                        <div 
                            key={aluno.id} 
                            onClick={() => toggleSelecao(aluno.id)}
                            className={`p-3 rounded-lg flex items-center justify-between cursor-pointer transition-colors border ${selecionados.includes(aluno.id) ? 'bg-blue-50 border-blue-200' : 'bg-white border-transparent hover:border-gray-200'}`}
                        >
                            <div>
                                <p className="font-bold text-gray-800 text-sm">{aluno.nome_completo}</p>
                                <p className="text-xs text-gray-500">CPF: {aluno.cpf}</p>
                            </div>
                            <div className={selecionados.includes(aluno.id) ? "text-blue-600" : "text-gray-300"}>
                                {selecionados.includes(aluno.id) ? <CheckSquare /> : <Square />}
                            </div>
                        </div>
                    ))}
                </div>
                
                <p className="text-right text-xs text-gray-500 mt-2">
                    {selecionados.length} aluno(s) selecionado(s)
                </p>
            </div>

            {/* Footer: Botão Confirmar */}
            <div className="p-4 border-t border-gray-100 bg-gray-50 flex justify-end gap-3">
                <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-gray-600 hover:bg-gray-200 rounded-lg">Cancelar</button>
                <button 
                    onClick={handleMatriculaMultipla} 
                    className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-bold shadow-lg disabled:opacity-50"
                    disabled={selecionados.length === 0}
                >
                    Matricular Selecionados
                </button>
            </div>
        </div>
    </div>
  )}

  {/* MANTENHA O MODAL DE PROFESSOR (SIMPLES) SEPARADO OU FAÇA IGUAL */}
  {modalOpen && abaAtiva === 'professores' && (
      // ... (Código do modal simples de ID do professor que já estava, ou podemos melhorar depois)
       <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          {/* ... Copie o modal antigo de input ID aqui ... */}
           <div className="bg-white rounded-xl shadow-2xl w-full max-w-sm p-6">
                <h3 className="text-lg font-bold mb-2">Vincular Professor</h3>
                <form onSubmit={handleAdicionar}>
                    <input type="number" className="w-full border p-2 rounded mb-4" placeholder="ID do Professor" value={inputId} onChange={e => setInputId(e.target.value)} required />
                    <button type="submit" className="bg-blue-600 text-white px-4 py-2 rounded w-full">Vincular</button>
                </form>
           </div>
       </div>
  )}
      

    </div>
  );
};

export default DetalhesTurma;