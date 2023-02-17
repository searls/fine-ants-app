class DashboardsController < ApplicationController
  def show
    @summaries = AccountSummaries.new(Account.active)
  end

  def snapshot_chart_data
    render json: merge_points([Snapshot.chart_data, Wage.chart_data])
  end

  def merge_points(points)
    points.flatten.group_by { |e| e[:date] }.map { |(_, entries)|
      if entries.size == 1
        entries.first
      else
        entries.each_with_object({}) { |entry, combined|
          combined.merge!(entry)
        }
      end
    }.flatten.sort_by { |e| e[:date] }
  end
end
