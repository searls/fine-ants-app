class User < ActiveRecord::Base
  belongs_to :bank
  has_and_belongs_to_many :accounts

  def self.active
    where.not(:disabled => true)
  end
end
