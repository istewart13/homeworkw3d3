require('pg')
require_relative('pet')
require('pry-byebug')

class PetShop

  attr_reader :name, :stock_type, :address, :pet_id
  def initialize(options, runner)
    @name = options["name"]
    @address = options["address"]
    @stock_type = options["stock_type"]
    @runner = runner
    @pet_id = options["pet_id"]
  end

  def save()
    sql = "INSERT INTO pet_shops (name, address, stock_type, pet_id) VALUES ('#{name}', '#{address}', '#{stock_type}', '#{pet_id}') RETURNING *"
    pet_shop_data = @runner.run(sql)
    @id = pet_shop_data.first['id'].to_i
  end

  def self.list_pets(runner)
    sql = "SELECT pet_id FROM pet_shops"
    pet_shop_data = runner.run(sql)
    pets = pet_shop_data.map { |pet| pet }
    return pets
  end

  def self.find_by_id(id, runner)
    sql = "SELECT name
    FROM pet_shops
    WHERE id = #{id}"
    find_store = runner.run(sql)
    store_name = find_store.map { |store| store }
    return store_name
  end

  def self.all(runner)
    sql = "SELECT * FROM pet_shops"
    pet_shop_data = runner.run(sql)
    pet_shops = pet_shop_data.map { |shop| shop }
    return pet_shops
  end

  def self.delete(id, runner)
    sql = "DELETE FROM pet_shops WHERE id = #{id}"
    pet_delete = runner.run(sql)
  end

  def edit(attribute, new_value)
    sql = "UPDATE pet_shops
    SET #{attribute} = '#{new_value}'
    WHERE id = #{@id}"
    update_pet_shop = @runner.run(sql)
  end
end