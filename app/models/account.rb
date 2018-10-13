class Account < ActiveRecord::Base
  belongs_to :bank
  has_and_belongs_to_many :users
  has_many :snapshots

  def self.active
    where.not(:disabled => true)
  end

  def self.upsert!(user, account_snapshot)
    find_or_create_by!(
      :bank => user.bank,
      :foreign_id => account_snapshot[:id]
    ).tap do |account|
      account.update!(:name => account_snapshot[:name])
      account.users << user unless account.users.include?(user)
      account.snapshots.create!(:amount => account_snapshot[:amount])
    end
  end

  def most_recent_snapshot
    snapshots.order("created_at").last
  end

  # Returns the value of the account for a date.
  # 1. If there was a snapshot that day, great
  # 2. Else if there are before & after snapshots, interpolate (eww linear math)
  # 3. Else just grab the most recent before-snapshot if there's one of those
  # 4. Else zero ¯\_(ツ)_/¯
  def value_on(date, snapshots = self.snapshots)
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

  def full_name
    "#{bank.name} - #{name}"
  end
end
