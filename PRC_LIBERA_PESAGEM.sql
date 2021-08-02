create or replace PROCEDURE       PRC_LIBERA_PESAGEM(FG_ATIVO IN VARCHAR2, P_DATFIM  IN DATE, P_SISTEMA IN VARCHAR2, P_CODUSU IN INTEGER )
is
V_OUSER VARCHAR2(50);
V_SENHA VARCHAR2(100);
V_PASWD VARCHAR2(100);
V_CODUSU INTEGER;
V_NOMUSU VARCHAR2(100); 

BEGIN


DECLARE

V_EMAIL VARCHAR2(500);

BEGIN

V_EMAIL := '';

FOR email IN (select u.email
                from pimscs.sh_aviso a,
                     pimscs.sh_grp_aviso g,
                     pimscs.sh_usu_aviso u
               where a.cd_aviso = g.cd_aviso
                     and g.login_rec = u.login
                     and g.cd_empresa = 001
                     and g.cd_aviso = '0005'
                     and u.bloqueado = 'N') LOOP

    V_EMAIL  := EMAIL.email ||';'|| V_EMAIL;

END LOOP;


SELECT   f_gerarsenhapims   INTO V_SENHA FROM DUAL;

SELECT  substr(V_SENHA,1,6) senha,substr(V_SENHA,7,24) senha_bd INTO V_SENHA,V_PASWD FROM DUAL;



SELECT  pimscs.pk_cs_equiptoparametrosessao.getusuario into V_OUSER FROM dual;


IF (P_SISTEMA ='PIMS')
THEN

insert into shint.logpesadig(usualt,datalt,fg_ativo,codusu,datfim,sistema) values(v_ouser,sysdate,FG_ATIVO,'DIGITPESAG',p_datfim,p_sistema);
commit;

IF (FG_ATIVO= 'S')
THEN
update pmusuarios set fg_pwd = V_PASWD, fg_inativo = 'N',dt_alteracao = sysdate, dt_validade_pwd = p_datfim where cd_usuario = 'DIGITPESAG';
commit;
update  pmusuarios_inst set  dt_alteracao = sysdate,dt_validade = p_datfim   where cd_usuario = 'DIGITPESAG' ;
commit;


 UTL_MAIL.SEND(SENDER     => 'nao_responder@bcoutinho.com.br',
                  RECIPIENTS => V_EMAIL,
                  SUBJECT    => 'Libera Pesagem manual',
                  MESSAGE   => 'Liberado o acesso a pesagem manual no sistema: ' || P_SISTEMA ||' por: ' || V_OUSER ||' para o usuario pesagem.digitada com a senha: ' || v_senha  || ' às ' ||  to_char(sysdate,'dd/mm/yyyy HH24:MI')
              ); 


ELSE

update pmusuarios set fg_pwd = V_PASWD, fg_inativo = 'S',dt_alteracao = sysdate, dt_validade_pwd = p_datfim where cd_usuario = 'DIGITPESAG';
commit;
update  pmusuarios_inst set  dt_alteracao = sysdate,dt_validade = p_datfim   where cd_usuario = 'DIGITPESAG' ;
commit;

UTL_MAIL.SEND(SENDER     => 'nao_responder@bcoutinho.com.br',
                  RECIPIENTS => V_EMAIL,
                  SUBJECT    => 'Bloqueado Pesagem manual',
                  MESSAGE    => 'Bloqueado o acesso a pesagem manual no sistema: ' || P_SISTEMA ||' por: ' || V_OUSER ||' para o usuario pesagem.digitada ' || ' às ' ||  to_char(sysdate,'dd/mm/yyyy HH24:MI'));
END IF;
END IF;



IF(P_SISTEMA='SAPIENS')

THEN

SELECT
    u.r999usu_nomusu nomusu,
    t.codusu         p_codusu

     INTO V_NOMUSU,
         V_CODUSU
FROM
    sapiens.ew99usu u,
    sapiens.r999usu t,
    sapiens.r910usu c
WHERE
        t.codusu = u.r999usu_codusu
    AND u.r999usu_codusu = c.codent
    AND upper(c.desusu) <> 'EXT'
    AND t.codusu = P_CODUSU
    AND c.conhab = 1
ORDER BY
    u.r999usu_nomusu ;

insert into shint.logpesadig(usualt,datalt,fg_ativo,codusu,datfim,sistema) values(v_ouser,sysdate,FG_ATIVO,V_NOMUSU,p_datfim,p_sistema);
commit;

IF (FG_ATIVO= 'S')
THEN
 update sapiens.e099usu set venapi = FG_ATIVO where codusu = P_CODUSU AND codemp = '1';
 commit;
    UTL_MAIL.SEND(SENDER     => 'nao_responder@bcoutinho.com.br',
                  RECIPIENTS => V_EMAIL,
                  SUBJECT    => 'Libera Pesagem manual',
                  MESSAGE    => 'Liberado o acesso a pesagem manual no sistema: ' || P_SISTEMA ||' por: ' || V_OUSER ||' para o usuario: ' || V_NOMUSU  || ' às ' ||  to_char(sysdate,'dd/mm/yyyy HH24:MI'));

ELSE
 update sapiens.e099usu set venapi = FG_ATIVO where codusu = P_CODUSU AND codemp = '1';
 commit;
 UTL_MAIL.SEND(SENDER     => 'nao_responder@bcoutinho.com.br',
                  RECIPIENTS => V_EMAIL,
                  SUBJECT    => 'Bloqueio Pesagem manual',
                  MESSAGE    => 'Bloqueado o acesso a pesagem manual por: ' || V_OUSER ||' para o usuario: ' || V_NOMUSU  || ' às ' ||  to_char(sysdate,'dd/mm/yyyy HH24:MI'));
END IF;
END IF;



END;



END PRC_LIBERA_PESAGEM;