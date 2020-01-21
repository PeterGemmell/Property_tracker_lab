require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()

  db = PG.connect({dbname:'property_tracker', host: 'localhost'})
  sql = "INSERT INTO properties_tracker
  (address, value, number_of_bedrooms, year_built)
  VALUES ($1, $2, $3, $4) RETURNING *"
  values = [@address, @value, @number_of_bedrooms, @year_built]
  db.prepare("save", sql)
  @id=db.exec_prepared("save", values)[0]["id"].to_i
  db.close()
  end

  def Property.all()
  db = PG.connect({dbname:'property_tracker', host: 'localhost'})
  sql = "SELECT * FROM properties_tracker;"
  db.prepare("all", sql)
  properties = db.exec_prepared("all")
  db.close()
  return properties.map{|property| Property.new(property)}
end

def update()
  db = PG.connect({dbname:'property_tracker', host: 'localhost'})
  sql = "UPDATE properties_tracker
  SET
  (address, value, number_of_bedrooms, year_built) =
  ($1, $2, $3, $4)
  WHERE id = $5"
  values = [@address, @value, @number_of_bedrooms, @year_built, @id]
  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close()
end

def delete()
db = PG.connect({dbname:'property_tracker', host: 'localhost'})
sql = "DELETE FROM properties_tracker WHERE id = $1"
values = [@id]
db.prepare("delete_one", sql)
db.exec_prepared("delete_one", values)
db.close()
end

def Property.find_by_id(id_to_find)
db = PG.connect({dbname:'property_tracker', host: 'localhost'})
sql = "SELECT * FROM properties_tracker WHERE id = $1"
values = [id_to_find.to_i]
db.prepare("find_by_id", sql)
found = db.exec_prepared("find_by_id", values)
db.close()
instance = Property.new(found.first)
return instance
end

def Property.find_by_address(address_to_find)
db = PG.connect({dbname:'property_tracker', host: 'localhost'})
sql = "SELECT * FROM properties_tracker WHERE address = $1"
values = [address_to_find]
db.prepare("find_by_address", sql)
address_found = db.exec_prepared("find_by_address", values)
db.close()
address_instance = Property.new(address_found.first)
return address_instance
end

end
