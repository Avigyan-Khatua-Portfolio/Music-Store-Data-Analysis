EASY
1. Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1

2. Which countries have the most Invoices?

SELECT COUNT(*) as C, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY C DESC
LIMIT 1

3. What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3

4. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals.

SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1

5. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money.

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1

MODERATE
1. Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.track_id IN (
	SELECT track.track_id 
	FROM track
	JOIN genre ON genre.genre_id = track.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email

2. Lets invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands.

SELECT COUNT(track.track_id) as total_tracks, artist.name
FROM artist
JOIN album on artist.artist_id = album.artist_id
JOIN track on album.album_id = track.album_id
JOIN genre on track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.name
ORDER BY total_tracks DESC
LIMIT 10

3. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first.

SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG (milliseconds) as avg_track_length
	FROM track
)
ORDER BY milliseconds DESC
