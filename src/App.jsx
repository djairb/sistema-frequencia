import { HashRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/auth';
import Login from './pages/Login';

// Componente temporário só pra testar o redirecionamento
const PaginaEmConstrucao = ({ titulo }) => (
  <div className="p-10 text-center">
    <h1 className="text-2xl font-bold mb-4">{titulo}</h1>
    <p>Área restrita. Em breve aqui terá o dashboard.</p>
    <a href="/" className="text-blue-500 hover:underline mt-4 block">Voltar para Login (Logout manual)</a>
  </div>
);

export default function App() {
  return (
    <AuthProvider>
      <HashRouter>
        <Routes>
          {/* Rota Pública */}
          <Route path="/" element={<Login />} />
          <Route path="/login" element={<Login />} />

          {/* Rotas Privadas (Futuramente vamos proteger isso com <PrivateRoute>) */}
          <Route path="/app/gestao-turmas" element={<PaginaEmConstrucao titulo="Painel do Coordenador" />} />
          <Route path="/app/meu-diario" element={<PaginaEmConstrucao titulo="Diário do Professor" />} />
          <Route path="/app/home" element={<PaginaEmConstrucao titulo="Home Geral" />} />
        </Routes>
      </HashRouter>
    </AuthProvider>
  );
}