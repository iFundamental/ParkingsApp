# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

  Person.delete_all
  Account.delete_all

  person = Person.create(first_name: 'Sally', last_name: 'Mclean')
  Account.create(email: 'smclean17@gmail.com', password: 'testpassword', person: person)
 

