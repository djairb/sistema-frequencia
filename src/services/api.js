import { mockBeneficiarios } from './mocks/beneficiarios';
import { mockUsuarios } from './mocks/usuarios';

// Lê a variável de ambiente (definida no .env)
const USE_MOCK = import.meta.env.VITE_USE_MOCK === 'true';
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:10000';

// Simula um delay de rede pra ficar realista (500ms)
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

export const api = {
  // Rota de Beneficiários (Alunos)
  getBeneficiarios: async () => {
    if (USE_MOCK) {
      console.log("⚠️ [MOCK] Carregando beneficiários...");
      await delay(500);
      return { data: mockBeneficiarios };
    }
    // Implementação real (quando o Rhian terminar)
    const response = await fetch(`${API_URL}/beneficiarios/completos`);
    return response.json();
  },

  // Rota de Usuários (Professores/Coordenadores)
  getUsuariosPorPerfil: async (perfilId) => {
    if (USE_MOCK) {
      console.log(`⚠️ [MOCK] Carregando usuários perfil ${perfilId}...`);
      await delay(500);
      return { data: mockUsuarios }; 
    }
    const response = await fetch(`${API_URL}/usuarios/perfil/${perfilId}`);
    return response.json();
  }
};