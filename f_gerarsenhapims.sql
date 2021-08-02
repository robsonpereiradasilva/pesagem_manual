
create or replace FUNCTION       F_GERARSENHAPIMS RETURN VARCHAR2 IS
BEGIN
    DECLARE
        v_caracter  NUMBER;
        v_senha     NUMBER;
        v1          NUMBER;
        v2          NUMBER;
        v3          NUMBER;
        v4          NUMBER;
        v5          NUMBER;
        v6          NUMBER;
        v_token     VARCHAR2(40);
    BEGIN
    --Gerando senha randomica de 6 digitos
        SELECT
            lpad(round(dbms_random.value * 1000000),6,'000000')  senha
        INTO v_senha
        FROM
            dual;
--Loop para converter a senha em caracteres ASCII e convertendo no padrão PIMS
--v_senha := 703874;
        FOR i IN 1..7 LOOP
            SELECT
                ascii(substr(v_senha, i, 1)) - 8
            INTO v_caracter
            FROM
                dual;

            IF ( i = 1 ) THEN
                v1 := v_caracter;
            END IF;
            IF ( i = 2 ) THEN
                v2 := v_caracter - 1;
            END IF;
            IF ( i = 3 ) THEN
                v3 := v_caracter;
            END IF;
            IF ( i = 4 ) THEN
                v4 := v_caracter + 3;
            END IF;
            IF ( i = 5 ) THEN
                v5 := v_caracter + 8;
            END IF;
            IF ( i = 6 ) THEN
                v6 := v_caracter + 15;
            END IF;
        END LOOP;
        
        v_token := to_char(v1,'099');
        v_token := v_token || to_char(v2,'099');
        v_token := v_token || to_char(v3,'099');
        v_token := v_token || to_char(v4,'099');
        v_token := v_token || to_char(v5,'099');
        v_token := v_token || to_char(v6,'099');
       -- DBMS_OUTPUT.PUT_LINE(v_senha);
        DBMS_OUTPUT.PUT_LINE(v_token);
        v_token :=  to_char(v_senha,'999999')||v_token;
        RETURN REPLACE(v_token, ' ', '') ;
    END;
END;