import React from 'react';

const MinhasTurmas = () => {
  return (
    <div className="p-6">
      <div className="bg-white p-8 rounded-xl shadow-md border-l-4 border-green-500">
        <h1 className="text-2xl font-bold text-gray-800">🍎 Área do Professor</h1>
        <p className="text-gray-600 mt-2">
          Bem-vindo! Aqui você verá a lista das suas turmas para fazer a chamada.
        </p>
        <div className="mt-6 p-4 bg-gray-50 rounded border border-gray-200">
          <p className="text-sm text-gray-500 italic">
            🚧 Construção das rotas de professor será a próxima etapa.
          </p>
        </div>
      </div>
    </div>
  );
};

export default MinhasTurmas;