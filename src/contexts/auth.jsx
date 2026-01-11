import { createContext, useState, useEffect } from 'react';
import { api } from '../services/api';
import { mockUsuarios } from '../services/mocks/usuarios'; // Importamos pra simular o login

export const AuthContext = createContext({});

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Ao recarregar a página, verifica se já tem usuário salvo
    const recoveredUser = localStorage.getItem('sysconex_user');
    if (recoveredUser) {
      setUser(JSON.parse(recoveredUser));
    }
    setLoading(false);
  }, []);

  async function signIn(login, senha) {
    // --- LÓGICA DE MOCK ---
    // Na vida real, aqui seria api.post('/login', { login, senha })
    // Como estamos no modo demo, vamos procurar no array de mocks:
    
    // Simula delay de rede
    await new Promise(resolve => setTimeout(resolve, 500));

    // Procura o usuário pelo login (ignorando senha por enquanto)
    const usuarioEncontrado = mockUsuarios.find(u => u.login === login);

    if (usuarioEncontrado) {
      // Salva no estado e no LocalStorage pra não deslogar no F5
      setUser(usuarioEncontrado);
      localStorage.setItem('sysconex_user', JSON.stringify(usuarioEncontrado));
      return { success: true, perfil: usuarioEncontrado.perfil.id };
    } else {
      return { success: false, message: 'Usuário não encontrado!' };
    }
  }

  function signOut() {
    localStorage.removeItem('sysconex_user');
    setUser(null);
  }

  return (
    <AuthContext.Provider value={{ signed: !!user, user, signIn, signOut, loading }}>
      {children}
    </AuthContext.Provider>
  );
}