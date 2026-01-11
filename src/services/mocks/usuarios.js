export const mockUsuarios = [
    // --- 1. USUÁRIOS DO EXEMPLO DA DOC (Admins) ---
    // Mantidos idênticos à documentação para referência
    {
      "id": 1,
      "login": "admin.sistema",
      "status": true,
      "perfil": { "id": 1, "descricao": "Administrador" },
      "colaborador": {
        "id": 1,
        "email_institucional": "admin@empresa.gov.br",
        "status": true,
        "cargo": {
          "id": 1,
          "descricao": "Gerente de TI",
          "setor": { "id": 1, "nome": "Tecnologia da Informação", "descricao": "Setor responsável pela infraestrutura tecnológica" }
        }
      },
      "pessoa": {
        "id": 1,
        "nome_completo": "João Carlos da Silva",
        "nome_social": null,
        "apelido": "João",
        "cpf": "12345678901",
        "rg": "1234567",
        "data_nasc": "1985-03-15T00:00:00.000Z",
        "nome_mae": "Maria da Silva",
        "nome_pai": "José Carlos da Silva",
        "naturalidade": "São Paulo",
        "nacionalidade": "Brasileira",
        "tipo_sanguineo": "O_POS",
        "status": true,
        "genero": { "id": 1, "descricao": "Masculino" },
        "etnia": { "id": 1, "descricao": "Branca" },
        "escolaridade": { "id": 7, "descricao": "Ensino Superior Completo" },
        "orgao_emissor": { "id": 1, "descricao": "SSP", "uf_emissor": "SP" },
        "contatos": [
          { "id": 1, "telefone_fixo": "1133334444", "celular": "11999998888", "whatsapp": "11999998888", "email": "joao.silva@email.com" }
        ],
        "enderecos": [
          { "id": 1, "cep": "01310100", "localidade": "Paulista", "rua": "Avenida Paulista", "numero": "1000", "bairro": "Bela Vista", "cidade": "São Paulo", "estado": "SP", "zona_localidade": "Zona_Urbana", "ponto_referencia": "Próximo ao MASP" }
        ]
      }
    },

    // --- 2. COORDENADOR (Para testar o Dash de Gestão) ---
    // Dados completos preenchidos
    {
        "id": 10,
        "login": "coord.ana",
        "status": true,
        "perfil": { "id": 2, "descricao": "Coordenador" },
        "colaborador": {
            "id": 50,
            "email_institucional": "ana.coord@escola.org.br",
            "status": true,
            "cargo": {
                "id": 2,
                "descricao": "Coordenador de Projetos",
                "setor": { "id": 2, "nome": "Coordenação de Projetos", "descricao": "Gerenciamento de projetos institucionais" }
            }
        },
        "pessoa": {
            "id": 100,
            "nome_completo": "Ana Maria Coordenadora",
            "nome_social": null,
            "apelido": "Aninha",
            "cpf": "99988877766",
            "rg": "3344556",
            "data_nasc": "1990-05-20T00:00:00.000Z",
            "nome_mae": "Josefa Maria",
            "nome_pai": "Sebastião Coordenador",
            "naturalidade": "Recife",
            "nacionalidade": "Brasileira",
            "tipo_sanguineo": "A_POS",
            "status": true,
            "genero": { "id": 2, "descricao": "Feminino" },
            "etnia": { "id": 4, "descricao": "Parda" },
            "escolaridade": { "id": 8, "descricao": "Pós-Graduação" },
            "orgao_emissor": { "id": 4, "descricao": "SDS", "uf_emissor": "PE" },
            "contatos": [
                { "id": 50, "telefone_fixo": null, "celular": "81988887777", "whatsapp": "81988887777", "email": "ana.coord@email.com" }
            ],
            "enderecos": [
                { "id": 50, "cep": "50000000", "localidade": "Centro", "rua": "Rua das Flores", "numero": "123", "bairro": "Santo Antônio", "cidade": "Recife", "estado": "PE", "zona_localidade": "Zona_Urbana", "ponto_referencia": null }
            ]
        }
    },

    // --- 3. PROFESSOR (Para testar o Dash de Chamada) ---
    // Dados completos preenchidos
    {
        "id": 20,
        "login": "prof.pedro",
        "status": true,
        "perfil": { "id": 6, "descricao": "Professor" },
        "colaborador": {
            "id": 60,
            "email_institucional": "pedro.prof@escola.org.br",
            "status": true,
            "cargo": {
                "id": 13,
                "descricao": "Educador(a)",
                "setor": { "id": 6, "nome": "Coordenação Pedagógica", "descricao": "Gestão pedagógica e educacional" }
            }
        },
        "pessoa": {
            "id": 200,
            "nome_completo": "Pedro Alcantara Professor",
            "nome_social": null,
            "apelido": "Pedrão",
            "cpf": "55544433322",
            "rg": "7788990",
            "data_nasc": "1988-12-10T00:00:00.000Z",
            "nome_mae": "Maria Alcantara",
            "nome_pai": "João Professor",
            "naturalidade": "Olinda",
            "nacionalidade": "Brasileira",
            "tipo_sanguineo": "O_NEG",
            "status": true,
            "genero": { "id": 1, "descricao": "Masculino" },
            "etnia": { "id": 2, "descricao": "Preta" },
            "escolaridade": { "id": 7, "descricao": "Ensino Superior Completo" },
            "orgao_emissor": { "id": 4, "descricao": "SDS", "uf_emissor": "PE" },
            "contatos": [
                { "id": 60, "telefone_fixo": "8134343434", "celular": "81977776666", "whatsapp": "81977776666", "email": "pedro.prof@email.com" }
            ],
            "enderecos": [
                { "id": 60, "cep": "53000000", "localidade": "Carmo", "rua": "Ladeira da Misericórdia", "numero": "45", "bairro": "Carmo", "cidade": "Olinda", "estado": "PE", "zona_localidade": "Zona_Urbana", "ponto_referencia": "Perto da Igreja" }
            ]
        }
    }
];