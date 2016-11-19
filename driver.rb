require "pry"
require_relative "config/environment"

transactions = DownloadsTransactions.new(User.find(3)).download

binding.pry
puts transactions
