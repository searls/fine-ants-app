class Account < ActiveRecord::Base
  belongs_to :bank
  has_and_belongs_to_many :users
  has_many :snapshots
end
