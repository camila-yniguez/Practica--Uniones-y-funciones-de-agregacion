-- 1. Utilizando la base de datos de películas queremos conocer, por un lado, los títulos y el
-- nombre del género de todas las series de la base de datos. Por otro, necesitamos listar los
-- títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada
-- uno de ellos 

select s.title , g.name  from genres g 
inner join series s 
on s.genre_id = g.id ;

select e.title , concat(a.first_name, " ", a.last_name) as "Nombre completo"
from episodes e 
inner join actor_episode ae 
on e.id = ae.episode_id 
inner join actors a 
on a.id = ae.actor_id
;

-- Para nuestro próximo desafío necesitamos obtener a todos los actores o actrices (mostrar
-- nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
-- galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada
-- actor/actriz.

select concat(a.first_name, " ", a.last_name) as "Nombre de actor" from actor_movie am  
inner join movies m 
on m.id = am.movie_id 
inner join actors a 
on a.id = am.actor_id  
where m.title like "La Guerra de las galaxias%"
group by concat(a.first_name, " ", a.last_name)
;

select g.name , s.title  from genres g 
inner join series s 
on g.id  = s.genre_id ;

-- Debemos listar los títulos de cada película con su género correspondiente. En el caso de
-- que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda
-- podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista.

select coalesce(g.name, "no tiene genero") , m.title  from genres g 
right join movies m 
on g.id  = m.genre_id ;

-- Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
-- la particularidad de que a la columna que mostrará dicha cantidad la renombraremos:
-- “Duración”.

select title , datediff(end_date, release_date) as duracion
from series s ;

-- Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres.
-- Debemos mostrar la cantidad total de los episodios guardados en la base de datos.
-- Para el siguiente desafío nos piden que obtengamos el título de todas las series y el total
-- de temporadas que tiene cada una de ellas.
-- Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
-- o igual a 3.

select first_name  from actors a 
where length (first_name) > 6;

select count(title) as "cantidad de episodios" from episodes e ;

select s2.title, max(s.number)  from seasons s 
inner join series s2
on s2.id = s.serie_id
group by s2.title 
;

select g.name, count(m.title)  from genres g 
inner join movies m 
on g.id = m.genre_id 
group by g.name
having count(m.title) >= 3
;