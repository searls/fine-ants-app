class DashboardsController < ApplicationController
  def show
    @snapshots = Account.all.map do |account|
      account.snapshots.order("created_at").last
    end
    @total = @snapshots.sum(&:amount)
  end
end
