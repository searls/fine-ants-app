class AccountSummaries
  attr_reader :name, :last_updated, :week_change, :month_change, :ytd_change,
              :amount,
              :accounts, :empty_accounts

  def initialize(accounts)
    @accounts = accounts.map { |a| AccountSummary.new(a) }
    @name = "Totals"
    @last_updated = @accounts.map(&:last_updated).max
    @week_change = @accounts.map(&:week_change).sum
    @month_change = @accounts.map(&:month_change).sum
    @ytd_change = @accounts.map(&:ytd_change).sum
    @amount = @accounts.map(&:amount).sum
    @empty_accounts = @accounts.select { |a| a.amount.zero? }
  end
end

class AccountSummary
  attr_reader :name, :last_updated, :week_change, :month_change, :ytd_change,
              :amount,
              :account

  def initialize(account)
    snapshot = account.most_recent_snapshot
    @name = account.full_name
    @last_updated = snapshot.created_at
    @week_change = snapshot.change_since(1.week.ago.to_date)
    @month_change = snapshot.change_since(1.month.ago.to_date)
    @ytd_change = snapshot.change_since(Date.today.beginning_of_year)
    @amount = snapshot.amount
    @account = account
  end
end

