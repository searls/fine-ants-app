require "fine_ants"

class FineAntsController < ApplicationController
  def create
    User.all.each do |user|
      FineAnts.download(user.bank.fine_ants_adapter, {
        :user => user.user,
        :password => user.password
      }).each do |account_snapshot|
        Account.find_or_create_by!(
          :bank => user.bank,
          :foreign_id => account_snapshot[:id]
        ).tap do |account|
          account.update!(:name => account_snapshot[:name])
          account.users << user unless account.users.include?(user)
          account.snapshots.create!(:amount => account_snapshot[:amount])
        end
      end
    end
    flash[:info] = "Accounts updated!"
    redirect_to dashboard_path
  end
end
