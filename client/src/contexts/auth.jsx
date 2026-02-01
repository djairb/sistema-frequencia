import React, { createContext, useState, useEffect } from 'react';
import { loginSession, setAuthToken } from '../services/sysconex';

export const AuthContext = createContext({});

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // 1. Ao abrir o site, verifica se já tem token salvo
        const recoveredUser = localStorage.getItem('sys_user');
        const recoveredToken = localStorage.getItem('sys_token');

        if (recoveredUser && recoveredToken) {
            setUser(JSON.parse(recoveredUser));
            setAuthToken(recoveredToken); // Configura o axios
        }

        setLoading(false);
    }, []);

    const login = async (cpf, senha) => {
        try {
            const response = await loginSession(cpf, senha);
            
            const { token, user: loggedUser } = response;

            localStorage.setItem('sys_user', JSON.stringify(loggedUser));
            localStorage.setItem('sys_token', token);

            setAuthToken(token);
            setUser(loggedUser);
            
            // 👇 MUDANÇA AQUI: Retornamos o usuário logado também
            return { success: true, user: loggedUser }; 
        } catch (error) {
            return { success: false, message: error.response?.data?.error || "Erro ao logar" };
        }
    };

    const logout = () => {
        localStorage.removeItem('sys_user');
        localStorage.removeItem('sys_token');
        setAuthToken(null);
        setUser(null);
    };

    return (
        <AuthContext.Provider value={{ signed: !!user, user, loading, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};