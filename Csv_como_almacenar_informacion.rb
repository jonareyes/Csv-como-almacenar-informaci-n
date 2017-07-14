# En este ejercicio vamos a aprender a utilizar Csv para almacenar información tipo base de datos

require 'faker'
require 'csv'

class Person
	attr_accessor :first_name, :last_name, :email, :phone, :created_at
	def initialize(first_name, last_name, email, phone, created_at)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = created_at
	end
end

def people(number)
	array = []
	for num in 1..number
		array << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Faker::Date.backward)
	end
	array[0] = Person.new("Jonathan", "Reyes", "jonathan@corre.com", "555-555-55", "2017-02-12")
	array
end
persona = people(15)


class PersonWriter
	def initialize(file, var)
		@file = file
		@var = var
	end

	def create_csv
		CSV.open(@file, "wb") do |csv|
		@var.each do |persona|		 			
			csv << [persona.first_name, persona.last_name, persona.email, persona.phone, persona.created_at]
			end
		end
	end
end	

person_writer = PersonWriter.new("people.csv", persona)
person_writer.create_csv


class PersonParser
	def initialize(read_csv)
		@read_csv = read_csv
	end

	def people
		arreglo = []
		CSV.foreach(@read_csv) do |row|
			arreglo << Person.new(row[0], row[1], row[2],row[3], row[4])
		end
		arreglo[0..9]
	end
end

parser = PersonParser.new('people.csv')
p people = parser.people
