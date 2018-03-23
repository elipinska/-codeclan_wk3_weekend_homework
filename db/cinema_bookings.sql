DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  time TIMESTAMP,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  price INT,
  max_seats INT
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE
);
