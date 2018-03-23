require('pg')
require_relative('../db/sqlrunner')
require_relative('film')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
           (name, funds)
           VALUES
           ($1, $2)
           RETURNING id;"
    values = @name, @funds
    @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    all_customers = SqlRunner.run(sql)
    return Customer.map_items(all_customers)
  end

  def self.map_items(customers_array)
    return customers_array.map {|customer| Customer.new(customer)}
  end

  def update()
    sql = "UPDATE customers
           SET (name, funds) = ($1, $2)
           WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def booked_films
    sql = "SELECT films.* FROM films
          INNER JOIN screenings ON films.id = screenings.film_id
          INNER JOIN tickets ON screenings.id = tickets.screening_id
          WHERE tickets.customer_id = $1;"
    values = [@id]
    films_array = SqlRunner.run(sql, values)
    return Film.map_items(films_array)
  end

  def self.find_by_id(id)
    sql = "SELECT * from customers
           WHERE id = $1"
    values = [id]
    found_customer = SqlRunner.run(sql, values)
    unless found_customer.values.empty?
      return Customer.new(found_customer[0])
    end
  end

  def buy_ticket(screening)
    unless @funds < screening.price
      @funds -= screening.price
      update()
      ticket = Ticket.new('customer_id'=>@id, 'screening_id'=> screening.id)
      ticket.save()
      return ticket
    end
  end

  def ticket_qty()
    # sql = "SELECT COUNT(tickets.*) FROM tickets
    #       WHERE tickets.customer_id = $1"
    # values = [@id]
    # return SqlRunner.run(sql, values)[0]['count'].to_i
    booked_films.length()
  end

end
