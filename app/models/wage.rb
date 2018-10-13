class Wage < ActiveRecord::Base
  monetize :amount_cents
end
