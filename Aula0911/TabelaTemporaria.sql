delimiter //
create temporary table temp_holerite
select
	dto.nome as departamento,
    emp.cod_emp as cod_emp,
	emp.nome as empregado,
	emp.salario as renda,
    case
		when (emp.salario <= 2112) then 0
        when (emp.salario > 2112 and emp.salario <= 2826.65) then (emp.salario * 0.075) - 158.4
        when (emp.salario > 2826.65 and emp.salario <= 3751.05) then (emp.salario * 0.15) - 370.4
        when (emp.salario > 3751.05 and emp.salario <= 4664.68) then (emp.salario * 0.225) - 651.73
        else (emp.salario * 0.275) - 884.96
    end as IRPF,
    case
		when (emp.salario <= 1320) then (emp.salario * 0.075)
        when (emp.salario > 1320 and emp.salario <= 2571.29) then (emp.salario * 0.09)
        when (emp.salario > 2571.29 and emp.salario <= 3856.94) then (emp.salario * 0.12)
        when (emp.salario > 3856.94 and emp.salario <= 7507.49) then (emp.salario * 0.14)
        else 1051.05
	end as INSS,
    (emp.salario * 0.08) as FGTS
from departamento dto
inner join empregado emp
on dto.cod_depto = emp.cod_depto;

select
	*
, replace(replace(format(renda - (IRPF + INSS + FGTS),2),".",","),",",".") as liquido
from temp_holerite;

create  temporary table temp_count_dep
select
	emp.cod_emp as codigo,
    emp.nome as empregado,
    count(dep.cod_dep) as dependentes
from empregado emp
left join dependente dep
on emp.cod_emp = dep.cod_emp
group by emp.cod_emp, emp.nome;

select
	*
from temp_count_dep;

select
	*
from temp_holerite th
inner join temp_count_dep td
on th.cod_emp = td.codigo;

drop table temp_holerite;
drop table temp_count_dep;
//
