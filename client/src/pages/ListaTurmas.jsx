import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/sysconex';
import { Search, BookOpen, Filter, ArrowLeft, Users, GraduationCap, Image as ImageIcon } from 'lucide-react';

// Importando os logos diretamente
import logo01 from '../img/logos-projetos/01.png';
import logo05 from '../img/logos-projetos/05.png';
import logo06 from '../img/logos-projetos/06.png';
import logo07 from '../img/logos-projetos/07.png';
import logo10 from '../img/logos-projetos/10.png';

const projectLogos = {
  "Projeto Conecta Vidas - Letramento Digital e educação financeira para pessoas idosas": logo01,
  "Projeto Comunidade Rural": logo05,
  "Projeto VamoSimbora?": logo06,
  "Projeto Skate Livre": logo07,
  "Projeto Oportunizar Comunidades": logo10
};

const ListaTurmas = () => {
  const navigate = useNavigate();
  const [turmas, setTurmas] = useState([]);
  const [filtro, setFiltro] = useState('');
  const [statusFiltro, setStatusFiltro] = useState('todos'); // todos, ativos, encerrados
  const [loading, setLoading] = useState(true);

  const [projetos, setProjetos] = useState([]);
  const [filtroProjeto, setFiltroProjeto] = useState('');

  useEffect(() => {
    setLoading(true);
    Promise.all([
      api.get('/turmas'),
      api.get('/projetos')
    ])
      .then(([resTurmas, resProjetos]) => {
        setTurmas(resTurmas.data);
        setProjetos(resProjetos.data);
      })
      .finally(() => setLoading(false));
  }, []);

  // Lógica de Filtragem Local + Ordenação Alfabética
  const turmasFiltradas = turmas.filter(t => {
    const matchTexto = t.nome.toLowerCase().includes(filtro.toLowerCase()) ||
      t.nome_projeto?.toLowerCase().includes(filtro.toLowerCase());

    const matchStatus = statusFiltro === 'todos'
      ? true
      : statusFiltro === 'ativos' ? t.ativo : !t.ativo;

    const matchProjeto = filtroProjeto ? t.projeto_id === Number(filtroProjeto) : true;

    return matchTexto && matchStatus && matchProjeto;
  }).sort((a, b) => a.nome.localeCompare(b.nome));

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6 animate-fade-in">

      {/* Header */}
      <div className="flex flex-col md:flex-row justify-between items-center gap-4">
        <div className="flex items-center gap-2">
          <button onClick={() => navigate('/app/gestao-turmas')} className="p-2 hover:bg-gray-100 rounded-full text-gray-500">
            <ArrowLeft size={20} />
          </button>
          <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
            <GraduationCap className="text-blue-600" /> Todas as Turmas
          </h1>
        </div>

        {/* Barra de Filtros */}
        <div className="flex gap-2 w-full md:w-auto flex-wrap md:flex-nowrap">
          <div className="relative flex-1 md:w-64">
            <Search className="absolute left-3 top-2.5 text-gray-400" size={20} />
            <input
              type="text"
              className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
              placeholder="Buscar turma..."
              value={filtro}
              onChange={e => setFiltro(e.target.value)}
            />
          </div>

          {/* Filtro de Projeto (NOVO) */}
          <select
            className="border rounded-lg px-4 py-2 bg-white outline-none focus:ring-2 focus:ring-blue-500 max-w-[200px]"
            value={filtroProjeto}
            onChange={e => setFiltroProjeto(e.target.value)}
          >
            <option value="">Todos os Projetos</option>
            {projetos.map(p => (
              <option key={p.id} value={p.id}>{p.titulo}</option>
            ))}
          </select>

          <select
            className="border rounded-lg px-4 py-2 bg-white outline-none focus:ring-2 focus:ring-blue-500"
            value={statusFiltro}
            onChange={e => setStatusFiltro(e.target.value)}
          >
            <option value="todos">Status: Todos</option>
            <option value="ativos">Status: Ativos</option>
            <option value="encerrados">Status: Encerrados</option>
          </select>
        </div>
      </div>

      {/* Grid */}
      {loading ? <p className="text-center py-10 text-gray-400">Carregando...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {turmasFiltradas.map(turma => {
            const logoPath = projectLogos[turma.nome_projeto];
            
            return (
              <div key={turma.id} onClick={() => navigate(`/app/turmas/${turma.id}`)} className="relative overflow-hidden bg-white p-5 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all cursor-pointer group flex flex-col justify-between h-full">
                
                {/* Listra Lateral Neutra */}
                <div className={`absolute left-0 top-0 bottom-0 w-1.5 transition-colors ${turma.ativo ? 'bg-slate-800 group-hover:bg-slate-900' : 'bg-gray-300'}`}></div>

                <div className="flex flex-col gap-2 pl-1">
                  {/* Informações da Esquerda (Topo) */}
                  <div className="flex items-center gap-2 mb-1">
                    <span className="text-[10px] font-bold uppercase text-gray-500">{turma.nome_projeto || 'Geral'}</span>
                    {!turma.ativo && <span className="text-[10px] bg-gray-100 px-2 rounded text-gray-500">Encerrada</span>}
                  </div>
                  <h3 className="font-bold text-lg text-gray-800 group-hover:text-blue-600 transition-colors leading-tight">
                      {turma.nome}
                  </h3>
                  <div className="flex gap-3 text-sm text-gray-500 mt-1 font-medium">
                    <span>{turma.periodo}</span>
                    <span>•</span>
                    <span>{turma.turno}</span>
                  </div>
                </div>

                {/* Rodapé do Card com Logo */}
                <div className="flex justify-between items-center mt-6 pt-4 border-t border-gray-50">
                  <div className="flex gap-4">
                    <div className="flex items-center gap-1.5 text-xs font-bold text-gray-500" title="Alunos Ativos">
                      <GraduationCap size={14} className="text-green-500" /> {turma.total_alunos}
                    </div>
                    <div className="flex items-center gap-1.5 text-xs font-bold text-gray-500" title="Professores">
                      <Users size={14} className="text-purple-500" /> {turma.total_professores}
                    </div>
                  </div>

                  {/* Logo à Direita na Parte de Baixo */}
                  <div className="flex-shrink-0">
                     {logoPath ? (
                        <img src={logoPath} alt={`Logo ${turma.nome_projeto}`} className="h-24 w-24 object-contain" />
                      ) : (
                        <div className="h-16 w-16 flex flex-col items-center justify-center bg-gray-50 border border-dashed border-gray-200 rounded-full text-gray-400 group-hover:text-blue-400 transition-colors" title="Adicionar Imagem">
                          <ImageIcon size={20} />
                          <span className="text-[7px] mt-0.5 font-bold text-center">ADD LOGO</span>
                        </div>
                      )}
                  </div>
                </div>
              </div>
            );
          })}
          {turmasFiltradas.length === 0 && (
            <p className="col-span-full text-center py-10 text-gray-400">
                Nenhuma turma encontrada.
            </p>
          )}
        </div>
      )}
    </div>
  );
};

export default ListaTurmas;