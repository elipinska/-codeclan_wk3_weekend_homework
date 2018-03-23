require('pg')
require_relative('../db/sqlrunner')

class Screening

  attr_accessor :time, :film_id, :price, :max_seats
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @time = options['time']
    @film_id = options['film_id'].to_i
    @price = options['price'].to_i
    @max_seats = options['max_seats'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
           (time, film_id, price, max_seats)
           VALUES
           ($1, $2, $3, $4)
           RETURNING id;"
    values = [@time, @film_id, @price, @max_seats]
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    all_screenings = SqlRunner.run(sql)
    return Screening.map_items(all_screenings)
  end

  def self.map_items(screenings_array)
    return screenings_array.map {|screening| Screening.new(screening)}
  end

  def update()
    sql = "UPDATE screenings
           SET (time, film_id, price, max_seats) = ($1, $2, $3, $4)
           WHERE id = $5"
    values = [@time, @film_id, @price, @max_seats, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM screenings
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * from screenings
           WHERE id = $1"
    values = [id]
    found_screening = SqlRunner.run(sql, values)
    unless found_screening.values.empty?
      return Screening.new(found_screening[0])
    end
  end

  def seats_available?
    sql = "SELECT COUNT(tickets.id) FROM tickets
          WHERE tickets.screening_id = $1"
    values = [@id]
    tickets_sold = SqlRunner.run(sql, values)[0]['count'].to_i

    return tickets_sold < @max_seats
  end

end
