create view vw_emp_idade_dep
as
select
	emp.nome as empregado,
    format(datediff(now(),emp.dt_admissao)/365,0) as tempo_empresa,
    format(datediff(now(),emp.dt_nascimento)/365,0) as idade_empregado,
    emp.sexo as sexo_empregado,
    dep.nome as dependente,
    emp.salario as renda,
    format(datediff(now(),dep.dt_nascimento)/365,0) as idade_dependente,
    dep.sexo as sexo_dependente
from
	empregado emp,
    dependente dep
where
	emp.cod_emp = dep.cod_emp;