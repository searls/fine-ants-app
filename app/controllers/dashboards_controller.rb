class DashboardsController < ApplicationController
  def show
    @snapshots = Account.all.flat_map do |account|
      account.snapshots.order("created_at").last(1)
    end
    @total = @snapshots.sum(&:amount)
  end
end
