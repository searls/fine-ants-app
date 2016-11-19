require "pry"
require_relative "config/environment"

puts "User ID:"
user_id = gets.chomp
transactions = DownloadsTransactions.new(User.find(user_id)).download

binding.pry
puts transactions
