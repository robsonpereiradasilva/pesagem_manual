SELECT
    u.r999usu_nomusu nomusu     ,
    t.codusu P_CODUSU
FROM
    SAPIENS.eW99usu u, sapiens.r999usu t, sapiens.r910usu c
    where t.codusu=u.r999usu_codusu
    and u.r999usu_codusu  = c.codent   
    and upper(c.desusu) <> 'EXT'
    and c.conhab = 1
order by  u.r999usu_nomusu 