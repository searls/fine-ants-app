class Snapshot < ActiveRecord::Base
  belongs_to :account
  monetize :amount_cents

  def ytd_change
    first_snapshot_this_year = account.snapshots.
      where("strftime('%Y', created_at) = strftime('%Y', date('now'))").
      order('created_at asc').first
    amount - first_snapshot_this_year.amount
  end
end
