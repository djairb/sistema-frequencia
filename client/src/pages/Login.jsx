import React, { useState, useContext } from 'react';
import { AuthContext } from '../contexts/auth';
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const { login } = useContext(AuthContext);
    const navigate = useNavigate();

    const [cpf, setCpf] = useState('');
    const [senha, setSenha] = useState('');
    const [erro, setErro] = useState('');
    const [loading, setLoading] = useState(false);

    const handleLogin = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErro('');

        

        // Pegamos o 'user' que veio do retorno do context
        const result = await login(cpf, senha);

        if (result.success) {
            const perfil = result.user.perfil_id; // O ID que vem do Banco

            // 1 = Admin, 2 = Coordenador
            if (perfil === 1 || perfil === 2) {
                navigate('/app/gestao-turmas');
            } 
            // 6 = Professor
            else if (perfil === 6) {
                navigate('/app/minhas-turmas');
            } 
            // Outros (Estagiário, etc) - Mandamos pra home genérica por enquanto
            else {
                navigate('/app/home');
            }
        } else {
            setErro(result.message);
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-gray-100">
            <div className="bg-white p-8 rounded-xl shadow-lg w-full max-w-md">
                <div className="text-center mb-8">
                    <h1 className="text-2xl font-bold text-gray-800">SysConex Frequência</h1>
                    <p className="text-gray-500 text-sm">Faça login para gerenciar suas turmas</p>
                </div>

                <form onSubmit={handleLogin} className="space-y-6">
                    {erro && (
                        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded text-sm text-center">
                            {erro}
                        </div>
                    )}

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Usuário</label>
                        <input
                            type="text"
                            value={cpf}
                            onChange={(e) => setCpf(e.target.value)}
                            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                            placeholder="nome.sobrenome"
                            required
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Senha</label>
                        <input
                            type="password"
                            value={senha}
                            onChange={(e) => setSenha(e.target.value)}
                            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                            placeholder="********"
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={loading}
                        className={`w-full py-2.5 rounded-lg text-white font-semibold transition-all ${
                            loading ? 'bg-blue-400 cursor-not-allowed' : 'bg-blue-600 hover:bg-blue-700'
                        }`}
                    >
                        {loading ? 'Entrando...' : 'Acessar Sistema'}
                    </button>
                </form>
            </div>
        </div>
    );
};

export default Login;