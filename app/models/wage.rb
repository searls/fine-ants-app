class Wage < ActiveRecord::Base
  monetize :amount_cents

  def self.chart_data
    scan(Wage.all.order("date asc")) { |total, wage|
      acc = total.present? ? total[:wage] : 0
      {
        date: wage.date,
        wage: acc + wage.amount.to_d
      }
    }
  end

  def self.scan(arr)
    arr.inject([]) { |acc, el| acc << yield(acc.last, el) }
  end
end
