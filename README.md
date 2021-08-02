Objetivo
Através desse procedimento será possível a geração automática e aleatória de senha para o usuário pesagem.digitada para realizar pesagens manuais, também será possivel habilitar e desabilitar o acesso ao usuário. 
Outro ponto desse procedimento é que será possível a atribuição de pesagem manual no sistema ERP – Sapiens conforme descrição abaixo.

Descrição do processo
Quando houver a necessidade de realizar uma pesagem manual ou correção de uma pesagem incorreta, esse procedimento poderá ser adotado, para isto seguir os passos abaixo.
1.	Acessar o sistema PIMS
1.1.	Acessar os submenus Customização – Visões/Procedimentos/Relatorios/Inegração – Integração PIMSVIEW
 


2.	Após aberto o PIMSVIEW acesse o menus Processamento | Interfaces | .
Aqui esta disponível os menus para liberação de pesagem manual PIMS e Sapiens.

 
 
3.	Após escolher o menu Liberar pesagem Pims a tela abaixo sera aberta, nela deve-se escolher a opção Liberar(S/N)? sendo S para liberar e gerar senha e N para desativar o acesso do usuário pesagem.digitada.
A senha gerada é exibida em tela  e envida para os emails cadastrados no grupo de email que está descrito logo abaixo.
 

Após o processamento a senha é motrado em tela, caso seja gerado erro e a senha não seja exibida basta clicar em Processamento novamente.
 
Abaixo imagem exemplo dos e-mails enviados após a liberação ou bloqueio do acesso. 
 

 


4.	Voltando ao passo 2 onde esta localizado os menus, acesar o menu Libera pesagem Sapiens, nesta tela deve escolher a opção S o N na lista Liberar(S/N)?
sendo S para habilitar e N para desabilitar, na lista Código usuário deve-se escolher qual usuário terá habilitado em seu perfil o acesso a digitação de pesagem no ERP – Sapiens.
 

Abaixo imagem exemplo dos e-mails enviados após a liberação ou bloqueio do acesso. 
 
 
 

5.	Para o cadastro dos email que receberão o alerta de liberação e senha, está disponivel a tela Cadastrar grupo de avisos. Nesta tela deve-se ser informado o grupo de aviso de codigo 0005 que é referente a liberação de pesagem manual.
 

 

6.	Documentação técnica
Disponível os seguintes objetos de banco.
•	Função SHINT.F_GERARSENHAPIMS
•	Procedure SHINT.PRC_LIBERA_PESAGEM
•	Tabela SHINT.LOGPESADIG
•	GRANT SELECT ON SAPIENS.EW99USU TO SHINT;
•	GRANT SELECT ON SAPIENS.R999USU TO SHINT;
•	GRANT SELECT ON SAPIENS.R910USU TO SHINT;
•	GRANT UPDATE ON SAPIENS.E099USU TO SHINT;
•	GRANT INSERT, UPDATE, SELECT on SHINT.LOGPESADIG to PIMSCS
