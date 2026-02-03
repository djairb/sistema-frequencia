import { HashRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/auth';
import Login from './pages/Login';
import { DefaultLayout } from './layouts/DefaultLayout';
import GestaoTurmas from './pages/GestaoTurmas';
import DetalhesTurma from './pages/DetalhesTurma';
import MinhasTurmas from './pages/MinhasTurmas';
import DiarioClasse from './pages/DiarioClasse';
import ListaTurmas from './pages/ListaTurmas';
import ListaProfessores from './pages/ListaProfessores';

// Componente temporário (Placeholder)
const PaginaEmConstrucao = ({ titulo }) => (
  <div className="bg-white p-8 rounded-xl shadow-sm border border-gray-100">
    <h1 className="text-2xl font-bold text-gray-800 mb-2">{titulo}</h1>
    <p className="text-gray-500">Esta funcionalidade será implementada em breve.</p>
  </div>
);

export default function App() {
  return (
    <AuthProvider>
      <HashRouter>
        <Routes>

          {/* Rota Pública (Login) */}
          <Route path="/" element={<Login />} />
          <Route path="/login" element={<Login />} />

          {/* Rotas Privadas (Protegidas pelo Layout) */}
          <Route path="/app" element={<DefaultLayout />}>

            {/* Rotas de Coordenador */}
            <Route path="gestao-turmas" element={<GestaoTurmas />} />
            <Route path="turmas" element={<ListaTurmas />} />
            <Route path="professores" element={<ListaProfessores />} />

            {/* Rotas de Professor */}
            <Route path="meu-diario" element={<PaginaEmConstrucao titulo="Meu Diário de Classe" />} />
            <Route path="minhas-turmas" element={<MinhasTurmas />} />

            <Route path="turmas/:id/diario" element={<DiarioClasse />} />
            <Route path="diario/:id" element={<DiarioClasse />} />

            {/* Rota Padrão (Fallback) */}
            <Route path="home" element={<PaginaEmConstrucao titulo="Bem-vindo ao SysConex" />} />

            <Route path="turmas/:id" element={<DetalhesTurma />} />





          </Route>

        </Routes>
      </HashRouter>
    </AuthProvider>
  );
}