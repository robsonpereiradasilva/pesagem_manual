SELECT 'A senha gerada é: '||p1||p2||p3||p4||p5||p6 senha   from(
SELECT
    chr(substr(fg_pwd,1,3)+8)p1,
    chr(substr(fg_pwd,4,3)+9)p2,
    chr(substr(fg_pwd,7,3)+8)p3,
    chr(substr(fg_pwd,10,3)+5)p4,
    chr(substr(fg_pwd,13,3))p5,
    chr(substr(fg_pwd,16,3)-7)p6,
    FG_INATIVO
FROM
    pimscs.pmusuarios
WHERE
    cd_usuario = 'DIGITPESAG'
and fg_inativo = 'N')








