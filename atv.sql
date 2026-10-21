//um milhao de usuarios

DELIMITER $$
DROP PROCEDURE IF EXISTS umM_user$$
CREATE PROCEDURE umM_user(IN p_qtd INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE offset_id INT DEFAULT 100000; 
    WHILE i <= p_qtd DO
        INSERT INTO usuario
            (cpf_cnpj, nome, idade, email, senha, telefone, endereco)
        VALUES (
            LPAD(offset_id + i, 11, '0'),      
            CONCAT('Usuario ', offset_id + i),        
            FLOOR(16 + (RAND() * 45)),   
            CONCAT('user', offset_id + i, '@teste.com'),         
            CONCAT('senha', offset_id + i),          
            CONCAT('449', LPAD(offset_id + i, 8, '0')),           
            CONCAT('Rua de Teste, N ', offset_id + i)
        );    
        IF MOD(i, 50000) = 0 THEN
            COMMIT;
        END IF;
        
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;
CALL umM_user(1000000)



--um milhao na tabela plano

DELIMITER $$
DROP PROCEDURE IF EXISTS umM_plano$$
CREATE PROCEDURE umM_plano(IN p_qtd INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE offset_id INT DEFAULT 100000; 
    DECLARE max_id INT;
    DECLARE v_tipo_plano VARCHAR(50);
    DECLARE v_data_criacao DATE;
    DECLARE v_data_validade DATE;
    SELECT COALESCE(MAX(id_plano), 100) INTO max_id FROM plano;
    WHILE i <= p_qtd DO
        SET v_tipo_plano = CASE (i % 3)
            WHEN 0 THEN 'VIP1'
            WHEN 1 THEN 'VIP2'
            ELSE 'VIP3'
        END;       
        SET v_data_criacao = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY);
        SET v_data_validade = DATE_ADD(v_data_criacao, INTERVAL 1 YEAR);       
        INSERT INTO plano
            (id_plano, cpf_cnpj, tipo_plano, data_validade, data_criacao)
        VALUES (
            max_id + i,
            LPAD(offset_id + i, 11, '0'),
            v_tipo_plano,
            v_data_validade,
            v_data_criacao
        );
        IF MOD(i, 50000) = 0 THEN
            COMMIT;
        END IF;
        
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL umM_plano (1000000)






SELECT * FROM `usuario`
WHERE nome = 'Anderson' 
--Mostrando registros 0 - 0 (1 no total, Consulta levou 0.1679 segundos.)

CREATE INDEX busca_nome
ON usuario(nome)

SELECT * FROM `usuario`
WHERE nome = 'Anderson' 
--Mostrando registros 0 - 0 (1 no total, Consulta levou 0.0002 segundos.)

  

SELECT * FROM `usuario` 
WHERE idade BETWEEN 20 AND 33 
--Mostrando registros 0 - 24 (314814 no total, Consulta levou 0.0002 segundos.)

CREATE INDEX buscar_idade
ON usuario(idade)

SELECT * FROM `usuario` 
WHERE idade BETWEEN 20 AND 33 
--Mostrando registros 0 - 24 (314814 no total, Consulta levou 0.0003 segundos.)




SELECT * FROM `usuario` 
WHERE idade = 30 AND  endereco LIKE 'Rua de Teste%'
--Mostrando registros 0 - 24 (22676 no total, Consulta levou 0.0004 segundos.)

CREATE INDEX buscar_idade_end
ON usuario(idade, endereco)

SELECT * FROM `usuario` 
WHERE idade = 30 AND  endereco LIKE 'Rua de Teste%'
--Mostrando registros 0 - 24 (22676 no total, Consulta levou 0.0003 segundos.)


SELECT * FROM `plano` 
WHERE YEAR(data_criacao) = 2006
 Mostrando registros 0 - 0 (1 no total, Consulta levou 0.1326 segundos.)

CREATE INDEX buscar_ano
ON plano(data_criacao)

SELECT * FROM `plano` 
WHERE YEAR(data_criacao) = 2006
--Mostrando registros 0 - 0 (1 no total, Consulta levou 0.0002 segundos.)
