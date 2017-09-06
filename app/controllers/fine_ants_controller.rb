require "fine_ants"

class FineAntsController < ApplicationController
  def create
    users.each do |user|
      DownloadsTransactions.new(user).download.each do |account_snapshot|
        Account.upsert!(user, account_snapshot)
      end
    end
    flash[:info] = "Snapshots taken!"
    redirect_to dashboard_path
  end

  private

  def users
    if params.has_key?(:user_id)
      [User.find(params[:user_id])]
    else
      User.all.sort_by { |u| u.accounts.map(&:most_recent_snapshot).min.created_at  }
    end
  end
end
