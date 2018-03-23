require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')


customer1 = Customer.new({'name'=>'Kasia', 'funds'=>'30'})
customer1.save()

customer2 = Customer.new({'name'=>'James Yates', 'funds'=>'20'})
customer2.save()

customer3 = Customer.new({'name'=>'Ewa Lipinska', 'funds'=>'50'})
customer3.save()

customer4 = Customer.new({'name'=>'Aaron Gillgren', 'funds'=>'30'})
customer4.save()

customer5 = Customer.new({'name'=>'Kasia Agrafka', 'funds'=>'40'})
customer5.save()

film1 = Film.new({'title'=>'Thor Ragnarok'})
film1.save()

film2 = Film.new({'title'=>'Hunt for the Wilderpeople'})
film2.save()

film3 = Film.new({'title'=>'The Shape of Water'})
film3.save()

screening1 = Screening.new({'time'=>'2018-03-05 10:30:00', 'film_id'=>film1.id, 'price'=>6, 'max_seats'=>30})
screening1.save()

screening2 = Screening.new({'time'=>'2018-03-06 15:00:00', 'film_id'=>film3.id, 'price'=>6, 'max_seats'=>15})
screening2.save()

screening3 = Screening.new({'time'=>'2018-03-04 18:00:00', 'film_id'=>film2.id, 'price'=>8, 'max_seats'=>30})
screening3.save()

screening4 = Screening.new({'time'=>'2018-03-08 18:00:00', 'film_id'=>film2.id, 'price'=>10, 'max_seats'=>30})
screening4.save()

screening5 = Screening.new({'time'=>'2018-03-08 13:20:00', 'film_id'=>film2.id, 'price'=>6, 'max_seats'=>30})
screening5.save()

ticket1 = customer1.buy_ticket(screening1)

ticket2 = customer1.buy_ticket(screening4)

ticket3 = customer2.buy_ticket(screening5)

ticket4 = customer3.buy_ticket(screening3)

ticket5 = customer2.buy_ticket(screening4)

ticket6 = customer5.buy_ticket(screening3)

ticket7 = customer5.buy_ticket(screening5)

ticket8 = customer4.buy_ticket(screening2)

ticket9 = customer4.buy_ticket(screening1)

ticket10 = customer4.buy_ticket(screening4)

#This tickets should not be created as the customer2 has insufficient funds
ticket10 = customer2.buy_ticket(screening1)


#Test CRUD

# puts "All customers"
# p Customer.all()
# p Customer.all().length
# puts ""
#
# puts "All films"
# p Film.all()
# p Film.all().length
# puts ""
#
# puts "All tickets"
# p Ticket.all()
# p Ticket.all().length
# puts ""
#
# puts "Update customer, screening, film and ticket"
# customer1.name = "Kasia Boczek"
# customer1.update()
# p Customer.find_by_id(customer1.id)
# puts ""
#
# screening1.time = "2018-03-05 11:30:00"
# screening1.update()
# p Screening.find_by_id(screening1.id)
# puts ""
#
# film2.title = "Hunt For The Wilderpeople"
# film2.update()
# p Film.find_by_id(film2.id)
# puts ""
#
# ticket2.screening_id = screening1.id
# ticket2.update()
# p Ticket.find_by_id(ticket2.id)
# puts ""
#
# puts "Delete one ticket, one screening, one customer and one film"
# ticket2.delete()
# p Ticket.all().length
# puts ""
# screening2.delete()
# p Screening.all().length
# puts ""
# customer3.delete()
# p Customer.all().length
# puts ""
# film2.delete()
# p Film.all().length
# puts ""
#
#
# puts "Delete all customers, screenings, films and tickets"
# Customer.delete_all()
# Film.delete_all()
# Ticket.delete_all()
# Screening.delete_all()
# p Customer.all()
# puts ""
# p Film.all()
# puts ""
# p Ticket.all()
# puts ""
# p Screening.all()
# puts ""

#Test other MVC methods

# puts "Customer 4's booked films"
# p customer4.booked_films()
# puts ""
#
puts "Film 2's audience (including duplicates for customers who went to see a film more than once)"
p film2.audience()
puts ""
puts "Film 2's audience (without duplicates)"
p film2.audience_no_duplicates()
puts ""

#Tests for extensions

# Buying tickets should decrease the funds of the customer by the price
puts "Customer 4's funds decrease to 4 after buying 2 tickets"
puts "funds"
p Customer.find_by_id(2).funds
puts ""
# Check how many tickets were bought by a customer
puts "Ticket qty"
p Customer.find_by_id(2).ticket_qty()
puts ""

#Check how many customers are going to watch a certain film
puts "Number of customers going to see The Hunt For the Wilderpeople (including duplicates for customers who went to see a film more than once)"
puts film2.audience_nr
puts ""
puts "Number of customers going to see The Hunt For the Wilderpeople (excluding duplicates)"
puts film2.audience_nr_no_duplicates
puts ""

#Write a method that finds out what is the most popular time (most tickets sold) for a given film
puts "Most popular screening time for film2"
p film2.most_popular_time()
