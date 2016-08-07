class Snapshot < ActiveRecord::Base
  belongs_to :account
  monetize :amount_cents

end
