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
          a.value_on(date, snapshots.select { |s| s.account == a })
        }.sum.to_f
      }
    }
  end

  def ytd_change
    amount - account.value_on(Date.today.beginning_of_year)
  end
end
