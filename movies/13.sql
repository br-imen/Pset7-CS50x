SELECT name FROM people
JOIN stars ON stars.person_id = people.id
JOIN movies ON movies.id = stars.movie_id
WHERE NOT people.name = "Kevin Bacon" AND movies.id
IN ( SELECT movies.id FROM movies
JOIN stars ON stars.movie_id = movies.id
JOIN people ON  stars.person_id = people.id
WHERE people.name = "Kevin Bacon" AND people.birth = 1958);