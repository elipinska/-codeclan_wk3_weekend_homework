require('pg')
require_relative('../db/sqlrunner')

class Ticket

  attr_accessor :customer_id, :screening_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
      sql = "INSERT INTO tickets
             (customer_id, screening_id)
             VALUES
             ($1, $2)
             RETURNING id;"
      values = @customer_id, @screening_id
      @id = SqlRunner.run(sql, values)[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    all_tickets = SqlRunner.run(sql)
    return Ticket.map_items(all_tickets)
  end

  def self.map_items(tickets_array)
    return tickets_array.map {|ticket| Ticket.new(ticket)}
  end

  def update()
    sql = "UPDATE tickets
           SET (customer_id, screening_id) = ($1, $2)
           WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * from tickets
           WHERE id = $1"
    values = [id]
    found_ticket = SqlRunner.run(sql, values)
    unless found_ticket.values.empty?
      return Ticket.new(found_ticket[0])
    end
  end



end
