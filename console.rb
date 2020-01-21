require('pry-byebug')
require_relative('models/property.rb')

property1 = Property.new(
  {'address' => '1 Dog Street',
   'value' => '150',
   'number_of_bedrooms' => '5',
   'year_built' => '2020'}
)

property2 = Property.new(
  {'address' => '2 Dog Street',
  'value' => '200',
  'number_of_bedrooms' => '5',
  'year_built' => '2020'}
)


property1.save()
property2.save()


# property1.find_by_id()


# property1.delete()

address_found = Property.find_by_address(property1.address)

property2.value = 100
property2.update()

found = Property.find_by_id(property1.id)
binding.pry
nil
