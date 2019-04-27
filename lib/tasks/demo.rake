require "faker"

ACCOUNT_TYPES = ["Checking", "Savings", "Credit Card", "Investment"]
BANK_ACCOUNTS_COUNT = 5
SNAPSHOTS_COUNT = 100

task demo: :environment do
  raise "Error: Database must be empty to fill with demo data" if [Bank, User, Account, Snapshot].map(&:any?).any?
  puts "Generating sample banks..."

  banks = Array.new(BANK_ACCOUNTS_COUNT) {
    Bank.create!(name: Faker::Bank.name, fine_ants_adapter: :demo)
  }

  puts "Generating sample users, accounts, and historical snapshots..."
  banks.each do |bank|
    account_type = ACCOUNT_TYPES.sample
    account_number = Faker::Number.number(5)

    User.create!(bank: bank,
                 user: Faker::Internet.user_name,
                 password: "demo password")

    account = Account.create!(bank: bank, name: "#{account_type} - #{account_number}")

    Array.new(SNAPSHOTS_COUNT) do
      Snapshot.create!(account: account,
                       amount_cents: Faker::Number.decimal(4, 2),
                       created_at: Faker::Date.between(1.years.ago, Date.today))
    end
  end
end
