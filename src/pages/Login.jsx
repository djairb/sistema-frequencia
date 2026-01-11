import { useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../contexts/auth';
import { Lock, User, Loader2 } from 'lucide-react';

export default function Login() {
  const [login, setLogin] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');
  const [isLoggingIn, setIsLoggingIn] = useState(false);

  const { signIn } = useContext(AuthContext);
  const navigate = useNavigate();

  async function handleLogin(e) {
    e.preventDefault();
    setError('');
    setIsLoggingIn(true);

    if (!login || !senha) {
      setError('Preencha todos os campos.');
      setIsLoggingIn(false);
      return;
    }

    const result = await signIn(login, senha);

    if (result.success) {
      // REDIRECIONAMENTO INTELIGENTE
      // ID 2 = Coordenador -> Vai pro painel de gestão
      // ID 6 = Professor -> Vai pro diário de classe
      if (result.perfil === 2) {
        navigate('/app/gestao-turmas');
      } else if (result.perfil === 6) {
        navigate('/app/meu-diario');
      } else {
        // Se for admin ou outro, manda pra home genérica por enquanto
        navigate('/app/home');
      }
    } else {
      setError(result.message);
      setIsLoggingIn(false);
    }
  }

  return (
    <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4">
      <div className="bg-white w-full max-w-md rounded-2xl shadow-2xl overflow-hidden">
        
        {/* Cabeçalho do Card */}
        <div className="bg-gradient-to-r from-blue-600 to-indigo-700 p-8 text-center">
          <h1 className="text-3xl font-bold text-white mb-2">SysConex</h1>
          <p className="text-blue-100">Sistema de Frequência Escolar</p>
        </div>

        {/* Formulário */}
        <div className="p-8">
          <form onSubmit={handleLogin} className="space-y-6">
            
            {/* Input Login */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Usuário</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <User className="h-5 w-5 text-gray-400" />
                </div>
                <input
                  type="text"
                  placeholder="Ex: prof.pedro"
                  value={login}
                  onChange={(e) => setLogin(e.target.value)}
                  className="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 transition-colors"
                />
              </div>
            </div>

            {/* Input Senha */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Senha</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <Lock className="h-5 w-5 text-gray-400" />
                </div>
                <input
                  type="password"
                  placeholder="********"
                  value={senha}
                  onChange={(e) => setSenha(e.target.value)}
                  className="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:ring-blue-500 focus:border-blue-500 transition-colors"
                />
              </div>
            </div>

            {/* Mensagem de Erro */}
            {error && (
              <div className="p-3 bg-red-50 text-red-700 text-sm rounded-lg border border-red-200">
                {error}
              </div>
            )}

            {/* Botão de Entrar */}
            <button
              type="submit"
              disabled={isLoggingIn}
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-bold text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              {isLoggingIn ? (
                <div className="flex items-center">
                  <Loader2 className="animate-spin h-5 w-5 mr-2" />
                  Entrando...
                </div>
              ) : (
                'Acessar Sistema'
              )}
            </button>
          </form>

          {/* Dica de rodapé (só pra demo) */}
          <div className="mt-6 text-center text-xs text-gray-400">
            <p>Dica: Use <strong>coord.ana</strong> ou <strong>prof.pedro</strong></p>
          </div>
        </div>
      </div>
    </div>
  );
}