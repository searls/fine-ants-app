class Account < ActiveRecord::Base
  belongs_to :bank
  belongs_to :user
end
