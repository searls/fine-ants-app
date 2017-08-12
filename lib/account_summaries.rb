class AccountSummaries
  attr_reader :name, :last_updated, :ytd_change, :amount, :accounts, :empty_accounts

  def initialize(accounts)
    @accounts = accounts.map { |a| AccountSummary.new(a) }
    @name = "Totals"
    @last_updated = @accounts.map(&:last_updated).max
    @ytd_change = @accounts.map(&:ytd_change).sum
    @amount = @accounts.map(&:amount).sum
    @empty_accounts = @accounts.select { |a| a.amount.zero? }
  end
end

class AccountSummary
  attr_reader :name, :last_updated, :ytd_change, :amount, :account

  def initialize(account)
    snapshot = account.most_recent_snapshot
    @name = account.full_name
    @last_updated = snapshot.created_at
    @ytd_change = snapshot.change_since(Date.today.beginning_of_year)
    @amount = snapshot.amount
    @account = account
  end
end

