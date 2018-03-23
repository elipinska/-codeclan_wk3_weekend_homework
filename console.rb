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

film1 = Film.new({'title'=>'Thor Ragnarok', 'price'=>'6'})
film1.save()

film2 = Film.new({'title'=>'Hunt for the Wilderpeople', 'price'=>'10'})
film2.save()

film3 = Film.new({'title'=>'The Shape of Water', 'price'=>'12'})
film3.save()

ticket1 = Ticket.new('customer_id'=> customer1.id, 'film_id'=> film1.id)
ticket1.save()

ticket2 = Ticket.new('customer_id'=> customer2.id, 'film_id'=> film2.id)
ticket2.save()

ticket3 = Ticket.new('customer_id'=> customer3.id, 'film_id'=> film2.id)
ticket3.save()

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

p customer2.booked_films()
puts ""
p film2.audience()

p Customer.find_by_id(2)
