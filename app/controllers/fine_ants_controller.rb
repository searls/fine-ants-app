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
    if params.key?(:user_id)
      [User.find(params[:user_id])]
    else
      User.active.sort_by { |u|
        u.accounts.active.map { |a| a.most_recent_snapshot.created_at }.min
      }
    end
  end
end
