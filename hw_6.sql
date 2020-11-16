
-- пользователь отправивший максимальное количество сообщений, пользователю с id =200  

select name, surname, max(`msg_count`)  from  

(select
	
	(select name from users where id = m.from_user_id) as `name` ,
	(select surname from users where id = m.from_user_id) as `surname` ,
	count(*) as `msg_count`

from messages m 
where to_user_id = 200
group by from_user_id order by `msg_count` desc) as `user_messages`

;

-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей


select sum(`likes`) as `total_likes` from
(select 
	id,
	name,
	surname,
	birthday,
	(select sum(cout)  from likes where user_id = u.id group by user_id) as `likes` -- пришлось суммировать не правильно заполнилась таблица данными

from users u
order by birthday desc
limit 10 ) as `tab10`;

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

select gender, sum(`likes`) as `total_likes` from
(select 
	gender,
	(select sum(cout)  from likes where user_id = u.id group by user_id) as `likes` -- пришлось суммировать не правильно заполнилась таблица данными
from users u) as tab
group by gender;

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

