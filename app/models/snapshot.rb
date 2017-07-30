class Snapshot < ActiveRecord::Base
  belongs_to :account
  monetize :amount_cents

  def self.chart_data
    accounts = Account.all
    snapshots = all
    snapshots.map(&:created_at).map(&:to_date).uniq.sort.map { |date|
      {
        :date => date,
        :value => accounts.map { |a|
          value_at_or_between(date, snapshots.select { |s| s.account == a })
        }.sum.to_f
      }
    }
  end

  def self.value_at_or_between(date, snapshots)
    if that_day = snapshots.find { |s| s.created_at.to_date == date }
      that_day.amount
    elsif snapshots.any? {|s| s.created_at < date } && snapshots.any? {|s| s.created_at > date }
      previous = snapshots.select { |s| s.created_at < date }.max_by(&:created_at)
      subsequent = snapshots.select { |s| s.created_at > date }.min_by(&:created_at)
      total_days = subsequent.created_at.to_date - previous.created_at.to_date
      target_days = date - previous.created_at.to_date
      (((total_days - target_days) / total_days) * previous.amount) +
        ((target_days / total_days) * subsequent.amount)
    elsif snapshots.any? {|s| s.created_at < date }
      snapshots.select { |s| s.created_at < date }.max_by(&:created_at).amount
    else
      0
    end
  end

  def ytd_change
    first_snapshot_this_year = account.snapshots.
      where("strftime('%Y', created_at) = strftime('%Y', date('now'))").
      order('created_at asc').first
    amount - first_snapshot_this_year.amount
  end
end
