require('pg')
require_relative('../db/sqlrunner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
           (title, price)
           VALUES
           ($1, $2)
           RETURNING id;"
    values = @title, @price
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
           SET (title, price) = ($1, $2)
           WHERE id = $3"
    values = [@title, @price, @id]
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
          INNER JOIN tickets ON tickets.customer_id = customers.id
          WHERE tickets.film_id = $1;"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    return Customer.map_items(customers_array)
  end



end
