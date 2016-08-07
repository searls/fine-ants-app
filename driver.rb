require "fine_ants"
require "dotenv"
require "pry"

Dotenv.load

accounts = FineAnts.download(:vanguard, {
  :user => "ENV['VANGUARD_USER']",
  :password => ENV['VANGUARD_PASSWORD']
})

puts accounts
