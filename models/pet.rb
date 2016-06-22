require('pg')
require_relative('pet_shop')
require('pry-byebug')

class Pet

  attr_reader :name, :id, :type
  def initialize(options, runner)
    @name = options["name"]
    @type = options["type"]
    @id = options["id"].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO pets (name, type) VALUES ('#{name}', '#{type}') RETURNING *"
    pet_data = @runner.run(sql)
    @id = pet_data.first['id'].to_i
  end

  def belong_to()
    sql = "SELECT pet_shops.name FROM pet_shops
      WHERE pet_id = #{@id}"
    pet_belong_to = @runner.run(sql)
    store_name = pet_belong_to.map { |store| store }
    return store_name
  end

  def self.all(runner)
    sql = "SELECT * FROM pets"
    pet_data = runner.run(sql)
    pets = pet_data.map { |pet| pet }
    return pets
  end

  def self.delete(id, runner)
    sql_shop = "DELETE FROM pet_shops WHERE pet_id = #{id}"
    sql = "DELETE FROM pets WHERE id = #{id}"
    pet_delete_from_shop = runner.run(sql_shop)
    pet_delete = runner.run(sql)
  end

  def self.find_by_id(id, runner)
    sql = "SELECT name
    FROM pets
    WHERE id = #{id}"
    find_pet = runner.run(sql)
    pet_name = find_pet.map { |pet| pet }
    return pet_name
  end

  def edit(attribute, new_value)
    sql = "UPDATE pets
    SET #{attribute} = '#{new_value}'
    WHERE id = #{@id}"
    update_pet = @runner.run(sql)
  end
end