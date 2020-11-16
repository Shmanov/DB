
-- список контактных лиц принадлежащих компаниям
select
	c2.name as Company, 
  	i2.name as Contact,
  	p.phone as Phone
FROM
  individuals  AS i2 JOIN contact_persons AS cp join companies c2 join phones p 
ON
  i2.id = cp.individual_id and
  cp.company_id = c2.id and 
  p.contact_person_id = cp.id; 

 
 -- Выбрать все сделки со статусом "Выдана и занесена в пчёлку" комании "Анфилада ООО"   
SELECT
  c2.number_contract, 
  c2.сommission,
  c2.сommission_remuneration,
  c2.status 
FROM
  contracts c2 
  
WHERE
  company_id = (SELECT id FROM companies WHERE name = "Анфилада ООО" and c2.status = 'Выдана и занесена в пчёлку');
  
 -- сумма коммисионных вознаграждений по компаниям со статусом 'Выдана и занесена в пчёлку'
 
 select
   c3.inn,
   c3.name,
   sum( c2.сommission_remuneration) as 'sum'
 
 from contracts c2 join companies c3 
 ON 
  c2.company_id = c3.id
 
where
  c2.status = 'Выдана и занесена в пчёлку'
group by c3.id;