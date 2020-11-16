-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select u.id, u.name, count(o.id) as `count`
from 
	users as u join orders as o
on
	u.id = o.user_id
group by u.id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
  p.name as `products`,
  p.price,
  c.name as `catalogs`
FROM
  catalogs AS c
LEFT JOIN
  products AS p
ON
  c.id = p.catalog_id;


-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
