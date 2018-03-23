require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


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

film1 = Film.new({'title'=>'Thor Ragnarok', 'price'=>'6'})
film1.save()

film2 = Film.new({'title'=>'Hunt for the Wilderpeople', 'price'=>'10'})
film2.save()

film3 = Film.new({'title'=>'The Shape of Water', 'price'=>'12'})
film3.save()

ticket1 = customer1.buy_ticket(film1)

ticket2 = customer2.buy_ticket(film2)

ticket3 = customer3.buy_ticket(film2)

ticket4 = customer4.buy_ticket(film1)

ticket5 = customer5.buy_ticket(film1)

ticket6 = customer5.buy_ticket(film3)

ticket7 = customer4.buy_ticket(film3)

ticket8 = customer4.buy_ticket(film2)

ticket9 = customer4.buy_ticket(film1)
# ticket1 = Ticket.new('customer_id'=> customer1.id, 'film_id'=> film1.id)
# ticket1.save()
#
# ticket2 = Ticket.new('customer_id'=> customer2.id, 'film_id'=> film2.id)
# ticket2.save()
#
# ticket3 = Ticket.new('customer_id'=> customer3.id, 'film_id'=> film2.id)
# ticket3.save()
#
# ticket4 = Ticket.new('customer_id'=> customer4.id, 'film_id'=> film1.id)
# ticket4.save()
#
# ticket5 = Ticket.new('customer_id'=> customer5.id, 'film_id'=> film1.id)
# ticket5.save()
#
# ticket6 = Ticket.new('customer_id'=> customer5.id, 'film_id'=> film3.id)
# ticket6.save()
#
# ticket7 = Ticket.new('customer_id'=> customer4.id, 'film_id'=> film3.id)
# ticket7.save()
#
# ticket8 = Ticket.new('customer_id'=> customer4.id, 'film_id'=> film2.id)
# ticket8.save()

# #Ticket 9 should not be created as customer4 won't have enough money
# ticket9 = Ticket.new('customer_id'=> customer4.id, 'film_id'=> film1.id)
# ticket9.save()




#Test CRUD
#
# puts "All customers"
# p Customer.all()
# puts ""
#
# puts "All films"
# p Film.all()
# puts ""
#
# puts "All tickets"
# p Ticket.all()
# puts ""
#
# puts "Update customer, film and ticket"
# customer1.name = "Kasia Boczek"
# customer1.update()
#
# film1.price = "8"
# film1.update()
# p Customer.all()
# puts ""
# p Film.all()
# puts ""
#
# ticket2.film_id = film1.id
# ticket2.update()
# p Ticket.all()
# puts ""
#
# puts "Delete one film, one customer and one tickets"
# ticket2.delete()
# p Ticket.all()
# puts ""
# customer3.delete()
# p Customer.all()
# puts ""
# film2.delete()
# p Film.all()
# puts ""
#
#
# puts "Delete all customers, films and tickets"
# Customer.delete_all()
# Film.delete_all()
# Ticket.delete_all()
# p Customer.all()
# puts ""
# p Film.all()
# puts ""
# p Ticket.all()
# puts ""

# puts "Customer 2's booked films"
# p customer2.booked_films()
# puts ""
#
# puts "Film 2's audience"
# p film2.audience()
# puts ""

#Tests for extensions
# puts "Testing find_by_id methods for customers and films"
# p Customer.find_by_id(2)
# p Film.find_by_id(2)
# puts ""
#
# puts "Customer 4's funds decrease to 2 after buying 3 tickets"
# puts "funds"
# p Customer.find_by_id(4).funds
# puts ""
# puts "Ticket qty"
# p customer4.ticket_qty()
# puts ""
#
#
# puts "Audience number for film 3"
# puts film2.audience_nr
# puts ""
