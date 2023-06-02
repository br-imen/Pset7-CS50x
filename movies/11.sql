SELECT title FROM movies
JOIN STARS ON stars.movie_id = movies.id
JOIN ratings ON ratings.movie_id = movies.id
JOIN people ON people.id = stars.person_id
WHERE people.name = "Chadwick Boseman" ORDER BY rating DESC LIMIT 5;