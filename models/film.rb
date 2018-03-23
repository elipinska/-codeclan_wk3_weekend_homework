require('pg')
require_relative('../db/sqlrunner')

class Film

  attr_accessor :title
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
  end

  def save()
    sql = "INSERT INTO films
           (title)
           VALUES
           ($1)
           RETURNING id;"
    values = [@title]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM films;"
    all_films = SqlRunner.run(sql)
    return Film.map_items(all_films)
  end

  def self.map_items(films_array)
    return films_array.map {|film| Film.new(film)}
  end

  def update()
    sql = "UPDATE films
           SET title = $1
           WHERE id = $2"
    values = [@title, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def audience
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets ON customers.id = tickets.customer_id
          INNER JOIN screenings ON tickets.screening_id = screenings.id
          WHERE screenings.film_id = $1;"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    return Customer.map_items(customers_array)
  end

  def audience_no_duplicates()
    sql = "SELECT DISTINCT customers.* FROM customers
          INNER JOIN tickets ON customers.id = tickets.customer_id
          INNER JOIN screenings ON tickets.screening_id = screenings.id
          WHERE screenings.film_id = $1;"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    return Customer.map_items(customers_array)
  end

  def self.find_by_id(id)
    sql = "SELECT * from films
           WHERE id = $1"
    values = [id]
    found_film = SqlRunner.run(sql, values)
    unless found_film.values.empty?
      return Film.new(found_film[0])
    end
  end


#Check how many customers are going to watch a certain film
  def audience_nr()
    # sql = "SELECT COUNT(customers.*) FROM customers
    #       INNER JOIN tickets ON customers.id = tickets.customer_id
    #       INNER JOIN screenings ON tickets.screening_id = screenings.id
    #       WHERE screenings.film_id = $1;"
    # values = [@id]
    # return SqlRunner.run(sql, values)[0]['count'].to_i
    audience.length()
  end

  def audience_nr_no_duplicates
    audience_no_duplicates.length()
  end

  def most_popular_time
    sql = "SELECT screenings.time::time FROM tickets
          INNER JOIN screenings ON tickets.screening_id = screenings.id
          INNER JOIN films ON screenings.film_id = films.id
          WHERE films.id = $1
          GROUP BY screenings.time::time
          ORDER BY COUNT(tickets.id) DESC
          LIMIT 1"
    values = [@id]
    return SqlRunner.run(sql, values)[0]['time']
  end



end
