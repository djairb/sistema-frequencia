import axios from 'axios';

// URL apontando direto para a rota base do seu backend local
const API_URL = 'http://localhost:10000/sysconex-freq';

const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json'
    }
});

// --- SERVIÇOS DE TURMA ---
export const getTurmas = async () => {
    const response = await api.get('/turmas');
    return response.data;
};

export const criarTurma = async (dadosTurma) => {
    // O backend espera { projeto_id, nome, turno, periodo, dias_aula, data_inicio, data_fim }
    const response = await api.post('/turmas', dadosTurma);
    return response.data;
};

export const getTurmaById = async (id) => {
    const response = await api.get(`/turmas/${id}`);
    return response.data;
};

// --- SERVIÇOS DE MATRÍCULA ---
export const getAlunosMatriculados = async (turmaId) => {
    const response = await api.get(`/turmas/${turmaId}/matriculas`);
    return response.data;
};

export const matricularAluno = async (turmaId, alunoId) => {
    const response = await api.post(`/turmas/${turmaId}/matriculas`, { aluno_id: alunoId });
    return response.data;
};

// --- SERVIÇOS DE AULA/CHAMADA ---
export const registrarAula = async (turmaId, dadosAula) => {
    const response = await api.post(`/turmas/${turmaId}/aulas`, dadosAula);
    return response.data;
};

// --- LISTAGEM DE PROFESSORES ---
export const getProfessoresTurma = async (turmaId) => {
    const response = await api.get(`/turmas/${turmaId}/professores`);
    return response.data;
}

export const vincularProfessor = async (turmaId, professorId) => {
    const response = await api.post(`/turmas/${turmaId}/professores`, { professor_id: professorId });
    return response.data;
}

export default api;