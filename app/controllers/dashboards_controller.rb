class DashboardsController < ApplicationController
  def show
    @summaries = AccountSummaries.new(Account.all)
  end

  def snapshot_chart_data
    render :json => Snapshot.chart_data
  end
end

