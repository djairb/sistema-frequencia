import axios from 'axios';

// Ajuste a URL se seu backend estiver em outra porta ou em produção
const API_URL = 'http://localhost:10000/api/sysconex-freq'; 

// Configuração básica do Axios
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
    // dadosTurma = { projeto_id, nome, turno, periodo, dias_aula, etc }
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
    // dadosAula = { professor_id, data_aula, conteudo, lista_presenca }
    const response = await api.post(`/turmas/${turmaId}/aulas`, dadosAula);
    return response.data;
};

// --- INTEGRAÇÃO (Busca alunos disponíveis no banco para matricular) ---
// Como a gente ainda não criou essa rota específica de busca no backend, 
// vamos deixar preparado. A ideia é buscar na tabela 'Beneficiario'/'Pessoa'.
// Por enquanto, vou deixar comentado ou fazer um mock depois.

export default api;