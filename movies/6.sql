SELECT AVG(rating) FROM ratings
JOIN movies ON movies.id = ratings.movie_id and movies.year = 2012;