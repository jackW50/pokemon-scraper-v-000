require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  
  @@all = []
  
  def initialize(id:, name:, type:, db:, hp: 60)
    @id = id
    @name = name 
    @type = type
    @db = db
    self.class.all << self 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.save(name, type, database_connection)
    database_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",[name, type])
  end 
  
  def self.find(id, database_connection)
    #binding.pry
    array = database_connection.execute("SELECT * FROM pokemon WHERE pokemon.id = (?)", id).flatten
    self.new(id: array[0], name: array[1], type: array[2], db: database_connection)
  end 
  
  def alter_hp(new_hp, db)
    #binding.pry
    db.execute("UPDATE pokemon SET hp = (?) WHERE pokemon.id = (?)", [new_hp, self.id])
    self.hp = db.execute("SELECT pokemon.hp FROM pokemon WHERE (?) = pokemon.id", self.id).flatten.first
  end 
    
end
