class Account < ActiveRecord::Base
  belongs_to :bank
  has_and_belongs_to_many :users
  has_many :snapshots

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

end
