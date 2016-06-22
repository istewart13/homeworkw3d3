require_relative('./models/pet')
require_relative('./models/pet_shop')
require_relative('./db/sql_runner')
require('pry-byebug')

runner = SqlRunner.new( {dbname: 'pet_shop', host: 'localhost'} )

pet1 = Pet.new( { 'name' => "Alfred", 'type' => "Cat" } , runner)
pet1.save()

pet2 = Pet.new( { 'name' => "Bob", 'type' => "Snail" } , runner)
pet2.save()

pet_shop1 = PetShop.new( { 'name' => "Glasgow Store", 'address' => "1 Glasgow Road, Glasgow", 'stock_type' => "Exotic", 'pet_id' => pet1.id} , runner)
pet_shop1.save()

pet_shop2 = PetShop.new( { 'name' => "Edinburgh Store", 'address' => "1 Edinburgh Road, Edinburgh", 'stock_type' => "Non-exotic", 'pet_id' => pet2.id} , runner)
pet_shop2.save()

puts PetShop.list_pets(runner)

puts pet1.belong_to()

puts PetShop.find_by_id(2, runner)

puts Pet.find_by_id(1, runner)

puts PetShop.delete(1, runner)

puts pet1.belong_to()

puts pet2.edit("name", "James")
puts pet_shop2.edit("name", "Dundee Store")

puts Pet.all(runner)
puts PetShop.all(runner)

binding.pry
nil