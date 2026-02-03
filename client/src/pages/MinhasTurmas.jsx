import React, { useState, useEffect, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import { getMinhasTurmas } from '../services/sysconex';
import {
  BookOpen, Calendar, Clock, GraduationCap,
  ArrowRight, Loader2, School
} from 'lucide-react';

const MinhasTurmas = () => {
  const navigate = useNavigate();
  const { user } = useContext(AuthContext);

  const [turmas, setTurmas] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    carregarTurmas();
  }, []);

  const carregarTurmas = async () => {
    try {
      const dados = await getMinhasTurmas();
      setTurmas(dados);
    } catch (error) {
      console.error("Erro ao carregar turmas", error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="flex h-[calc(100vh-100px)] items-center justify-center">
        <Loader2 className="animate-spin text-blue-600" size={40} />
        <span className="ml-3 text-gray-500 font-medium">Carregando suas turmas...</span>
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto animate-fade-in space-y-8">

      {/* HEADER */}
      <div className="bg-gradient-to-r from-blue-600 to-indigo-700 p-8 rounded-2xl shadow-lg relative overflow-hidden text-white">
        <div className="absolute top-0 right-0 p-4 opacity-10">
          <School size={150} />
        </div>
        <div className="relative z-10">
          <h1 className="text-3xl font-bold mb-2">Olá, Professor(a) {user?.pessoa?.nome?.split(' ')[0] || user?.nome}!</h1>
          <p className="text-blue-100 max-w-xl">
            Bem-vindo à sua área de gestão. Aqui você pode acessar suas turmas ativas e realizar o registro de aulas e frequências de forma rápida.
          </p>
        </div>
      </div>

      {/* LISTAGEM DE TURMAS */}
      <div>
        <h2 className="text-xl font-bold text-gray-800 mb-6 flex items-center gap-2">
          <BookOpen className="text-blue-600" /> Suas Turmas Ativas
        </h2>

        {turmas.length === 0 ? (
          <div className="bg-white p-12 rounded-xl text-center shadow-sm border border-gray-100">
            <div className="bg-gray-50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 text-gray-400">
              <BookOpen size={40} />
            </div>
            <h3 className="text-lg font-bold text-gray-700">Nenhuma turma encontrada</h3>
            <p className="text-gray-500 mt-2">
              Você não está vinculado a nenhuma turma ativa no momento.
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {turmas.map(turma => (
              <div key={turma.id} className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-all group flex flex-col">

                {/* Card Header */}
                <div className="p-5 border-b border-gray-50 bg-gray-50/50">
                  <div className="flex justify-between items-start mb-2">
                    <span className="bg-blue-100 text-blue-700 text-[10px] font-bold px-2 py-1 rounded uppercase tracking-wider">
                      {turma.periodo}
                    </span>
                    <span className="bg-green-100 text-green-700 text-[10px] font-bold px-2 py-1 rounded uppercase tracking-wider">
                      {turma.turno}
                    </span>
                  </div>
                  <h3 className="text-lg font-extrabold text-gray-800 group-hover:text-blue-600 transition-colors line-clamp-1" title={turma.nome}>
                    {turma.nome}
                  </h3>
                  <p className="text-xs text-gray-500 font-medium mt-1 truncate">
                    {turma.nome_projeto}
                  </p>
                </div>

                {/* Card Body */}
                <div className="p-5 flex-1 space-y-3">
                  <div className="flex items-center gap-3 text-sm text-gray-600">
                    <Calendar size={16} className="text-blue-400" />
                    <span>
                      {turma.dias_aula && turma.dias_aula.length > 0
                        ? turma.dias_aula.join(', ')
                        : 'Dias não definidos'}
                    </span>
                  </div>
                </div>

                {/* Card Footer */}
                <div className="p-4 bg-gray-50 border-t border-gray-100">
                  <button
                    onClick={() => navigate(`/app/diario/${turma.id}`)}
                    className="w-full bg-white border border-blue-200 text-blue-600 py-2.5 rounded-lg font-bold text-sm hover:bg-blue-600 hover:text-white hover:border-blue-600 transition-all flex items-center justify-center gap-2 shadow-sm"
                  >
                    <GraduationCap size={18} />
                    Acessar Diário
                    <ArrowRight size={16} />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default MinhasTurmas;