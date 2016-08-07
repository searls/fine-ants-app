class User < ActiveRecord::Base
  belongs_to :bank
  has_and_belongs_to_many :accounts

  delegate :password, :password=, to: :user_password
  delegate :server, to: :bank

  private

  def user_password
    @user_password ||= UserPassword.new(server: server, account: user)
  end
end
