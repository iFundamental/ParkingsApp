# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

  Person.delete_all
  Account.delete_all
  FacebookAccount.delete_all

  person = Person.create(first_name: 'Sally', last_name: 'Mclean')
  Account.create(email: 'smclean17@gmail.com', password_digest:  BCrypt::Password.create('testpassword'), person: person)
 
