# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :location
  String :time
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :guest
  String :name
  String :email
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :city
  String :email
  String :password
  String :message, text: true
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Cash Cows Chicago Architecture Cruise Boat Day", 
                    description: "Let's celebrate with the famous Chicago skyline as our backdrop!",
                    date: "June 17",
                    time: "2-5pm",
                    location: "112 E Wacker Dr, Chicago, IL 60601")

events_table.insert(title: "Cash Cows Friends and Family Reception", 
                    description: "Bring you family and loved ones and we will celebrate together!",
                    date: "June 18",
                    time: "5-9pm",
                    location: "1701 Maple Ave, Evanston, IL 60201")

events_table.insert(title: "If we are still self-isolating .... Virtual Section Connection!", 
                    description: "Worst case scenario ... we still want a proper goodbye!",
                    date: "June 18",
                    time: "5-9pm",
                    location: "Chicago")
