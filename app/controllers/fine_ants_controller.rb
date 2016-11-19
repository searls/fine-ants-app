require "fine_ants"

class FineAntsController < ApplicationController
  def create
    User.all.each do |user|
      DownloadsTransactions.new(user).download.each do |account_snapshot|
        Account.upsert!(user, account_snapshot)
      end
    end
    flash[:info] = "Accounts updated!"
    redirect_to dashboard_path
  end
end
