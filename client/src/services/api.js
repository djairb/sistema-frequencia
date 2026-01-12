import { mockBeneficiarios } from './mocks/beneficiarios';
import { mockUsuarios } from './mocks/usuarios';
import { mockProjetos } from './mocks/projetos';

// Configurações
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:10000';
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

export const api = {
  // --- MOCKS (Pessoas e Projetos continuam aqui) ---
  
  getBeneficiarios: async () => {
    await delay(300);
    return { data: mockBeneficiarios };
  },

  getUsuariosPorPerfil: async (perfilId) => {
    await delay(300);
    return { data: mockUsuarios }; 
  },

  getProjetos: async () => {
    await delay(300);
    return { data: mockProjetos };
  },

  // --- DADOS REAIS (MySQL via Node.js) ---

  // 1. LISTAR TODAS AS TURMAS
  getTurmas: async () => {
    try {
      console.log("📡 API: Buscando lista de turmas...");
      const response = await fetch(`${API_URL}/turmas`);
      const dados = await response.json();
      return { data: dados }; // Embrulha pra padronizar
    } catch (error) {
      console.error("❌ Erro getTurmas:", error);
      return { data: [] };
    }
  },

  // 2. PEGAR UMA TURMA POR ID (AQUI ESTAVA O PROBLEMA)
  getTurmaById: async (id) => {
    try {
      console.log(`📡 API: Buscando detalhes da turma ${id}...`);
      const response = await fetch(`${API_URL}/turmas/${id}`);
      
      if (!response.ok) {
        throw new Error(`Erro HTTP: ${response.status}`);
      }
      
      const dados = await response.json();
      console.log("✅ API: Turma encontrada:", dados);
      
      // OBRIGATÓRIO: Retornar embrulhado em 'data' ou direto, 
      // mas vamos garantir que não seja null
      return { data: dados }; 
      
    } catch (error) {
      console.error("❌ Erro getTurmaById:", error);
      // Retorna objeto vazio pra não dar erro de 'null' na tela
      return { data: { nome: "Erro ao carregar", projeto_id: "?", dias_aula: [] } };
    }
  },

  // 3. LISTAR MATRÍCULAS DA TURMA (AQUI TAMBÉM)
  getMatriculasTurma: async (turmaId) => {
    try {
      const response = await fetch(`${API_URL}/turmas/${turmaId}/matriculas`);
      const dados = await response.json();
      return { data: dados };
    } catch (error) {
      console.error("❌ Erro getMatriculasTurma:", error);
      return { data: [] };
    }
  },

  // 4. CRIAR TURMA
  createTurma: async (novaTurma) => {
    const response = await fetch(`${API_URL}/turmas`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(novaTurma)
    });
    return await response.json();
  },

  // 5. MATRICULAR ALUNO
  matricularAluno: async (turmaId, alunoId) => {
    const response = await fetch(`${API_URL}/turmas/${turmaId}/matriculas`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ aluno_id: alunoId })
    });
    
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || 'Erro ao matricular');
    }
    return await response.json();
  },

  // ... dentro do objeto api ...

  // 6. LISTAR PROFESSORES VINCULADOS (Do Banco)
  getProfessoresTurma: async (turmaId) => {
    try {
      const response = await fetch(`${API_URL}/turmas/${turmaId}/professores`);
      const dados = await response.json();
      return { data: dados };
    } catch (error) {
      console.error("Erro getProfessoresTurma:", error);
      return { data: [] };
    }
  },

  // 7. VINCULAR PROFESSOR
  vincularProfessor: async (turmaId, professorId) => {
    const response = await fetch(`${API_URL}/turmas/${turmaId}/professores`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ professor_id: professorId })
    });
    
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || 'Erro ao vincular professor');
    }
    return await response.json();
  }





};