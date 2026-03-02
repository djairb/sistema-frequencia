router.post("/integracao/receber-dados", verificarTokenIntegracao, async (req, res) => {
    const listaUsuarios = req.body;

    if (!Array.isArray(listaUsuarios)) {
        return res.status(400).json({ error: "O corpo deve ser uma lista JSON." });
    }

    dbSysConex.getConnection(async (err, connection) => {
        if (err) return res.status(500).json({ error: "Erro de conexão com banco." });

        const queryTx = (sql, params) => {
            return new Promise((resolve, reject) => {
                connection.query(sql, params, (e, r) => e ? reject(e) : resolve(r));
            });
        };

        try {
            await new Promise((resolve, reject) => connection.beginTransaction(e => e ? reject(e) : resolve()));

            let criados = 0;
            let atualizados = 0;

            for (const u of listaUsuarios) {
                if (!u.cpf) continue;
                const cpfLimpo = u.cpf.replace(/\D/g, '');

                const rows = await queryTx("SELECT id FROM pessoa WHERE cpf = ?", [cpfLimpo]);
                let pessoaId;

                const defaults = {
                    mae: u.nome_mae || "NÃO INFORMADO",
                    gen: u.genero_id || 1,
                    etn: u.etnia_id || 1
                };

                if (rows.length > 0) {
                    pessoaId = rows[0].id;
                    await queryTx("UPDATE pessoa SET nome_completo = ?, status = 1 WHERE id = ?", [u.nome_completo, pessoaId]);

                    if (u.email) {
                        const checkContato = await queryTx("SELECT id FROM contato WHERE pessoa_id = ?", [pessoaId]);
                        if (checkContato.length > 0) {
                            await queryTx("UPDATE contato SET email = ? WHERE id = ?", [u.email, checkContato[0].id]);
                        } else {
                            await queryTx("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                        }
                    }
                } else {
                    const sqlInsert = `
                        INSERT INTO pessoa (nome_completo, cpf, data_nasc, nome_mae, naturalidade, nacionalidade, genero_id, etnia_id, escolaridade_id, orgao_emissor_id, status) 
                        VALUES (?, ?, ?, ?, 'BRASIL', 'BRASIL', ?, ?, 1, 1, 1)
                    `;
                    const resPessoa = await queryTx(sqlInsert, [
                        u.nome_completo, cpfLimpo, u.data_nasc || '2000-01-01', defaults.mae, defaults.gen, defaults.etn
                    ]);
                    pessoaId = resPessoa.insertId;

                    if (u.email) {
                        await queryTx("INSERT INTO contato (pessoa_id, email) VALUES (?, ?)", [pessoaId, u.email]);
                    }
                }

                if (u.tipo === "ALUNO") {
                    const checkBenef = await queryTx("SELECT id FROM Beneficiario WHERE pessoa_id = ?", [pessoaId]);
                    if (checkBenef.length === 0) {
                        await queryTx(
                            "INSERT INTO Beneficiario (pessoa_id, id_projeto, id_processo_inscricao) VALUES (?, ?, 1)", 
                            [pessoaId, u.projeto_id || 1]
                        );
                        criados++;
                    } else {
                        atualizados++;
                    }

                } else {
                    let colabId;
                    const checkColab = await queryTx("SELECT id FROM colaborador WHERE pessoa_id = ?", [pessoaId]);
                    
                    const cargoId = u.cargo_id || 6;
                    const emailInst = u.email || 'sem_email@inst.com';

                    if (checkColab.length > 0) {
                        colabId = checkColab[0].id;
                        await queryTx(
                            "UPDATE colaborador SET cargo_id = ?, email_institucional = ?, status = 1 WHERE id = ?", 
                            [cargoId, emailInst, colabId]
                        );
                    } else {
                        const resColab = await queryTx(
                            "INSERT INTO colaborador (pessoa_id, cargo_id, email_institucional, status) VALUES (?, ?, ?, 1)", 
                            [pessoaId, cargoId, emailInst]
                        );
                        colabId = resColab.insertId;
                    }

                    if (u.login && u.senha && u.id_perfil_usuario) {
                        const checkUser = await queryTx("SELECT id FROM usuario WHERE id_colaborador = ?", [colabId]);

                        if (checkUser.length > 0) {
                            await queryTx(
                                "UPDATE usuario SET login = ?, senha = ?, id_perfil_usuario = ?, status = 1 WHERE id = ?",
                                [u.login, u.senha, u.id_perfil_usuario, checkUser[0].id]
                            );
                            atualizados++;
                        } else {
                            await queryTx(
                                "INSERT INTO usuario (id_colaborador, id_perfil_usuario, login, senha, status) VALUES (?, ?, ?, ?, 1)",
                                [colabId, u.id_perfil_usuario, u.login, u.senha]
                            );
                            criados++;
                        }
                    }
                }
            }

            await new Promise((resolve, reject) => connection.commit(e => e ? reject(e) : resolve()));

            res.status(200).json({
                message: "Sincronização realizada com sucesso!",
                resumo: { criados, atualizados }
            });

        } catch (error) {
            connection.rollback(() => { });
            res.status(500).json({ error: "Erro no processamento: " + error.message });
        } finally {
            connection.release();
        }
    });
})