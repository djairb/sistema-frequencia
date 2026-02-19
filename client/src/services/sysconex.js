import axios from 'axios';


// const API_URL = 'https://sra2.somosconexaosocial.org/api/sysconex-freq';

const API_URL = 'http://localhost:10000/sysconex-freq';



export const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json'
    }
});


export const loginSession = async (cpf, senha) => {
    // O backend espera { login, senha }
    const response = await api.post('/auth/login', { login: cpf, senha });
    return response.data;
};

// Função para injetar o Token nas requisições futuras
export const setAuthToken = (token) => {
    if (token) {
        api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    } else {
        delete api.defaults.headers.common['Authorization'];
    }
};





// --- SERVIÇOS DE TURMA ---
export const getMinhasTurmas = async () => {
    const response = await api.get('/professores/me/turmas');
    return response.data;
};

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

// --- SERVIÇOS DE AULAS ---
export const updateAula = async (aulaId, payload) => {
    const response = await api.put(`/aulas/${aulaId}`, payload);
    return response.data;
};

export const deleteAula = async (aulaId) => {
    const response = await api.delete(`/aulas/${aulaId}`);
    return response.data;
};

export const getFrequenciaAula = async (aulaId) => {
    const response = await api.get(`/aulas/${aulaId}/frequencia`);
    return response.data;
};

export const getHistoricoAulas = async (turmaId) => {
    const response = await api.get(`/turmas/${turmaId}/aulas`);
    return response.data;
};

export const getTurmaEstatisticas = async (turmaId) => {
    const response = await api.get(`/turmas/${turmaId}/estatisticas`);
    return response.data;
};

export const getHistoricoFrequenciaAluno = async (matriculaId) => {
    const response = await api.get(`/matriculas/${matriculaId}/frequencia`);
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

// --- RELATÓRIOS E BUSCA ---
export const searchBeneficiarios = async (q) => {
    const response = await api.get(`/beneficiarios/search?q=${q}`);
    return response.data;
};

export const getHistoricoGeral = async (beneficiarioId) => {
    const response = await api.get(`/beneficiarios/${beneficiarioId}/historico`);
    return response.data;
};

export default api;