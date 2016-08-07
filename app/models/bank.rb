class Bank < ActiveRecord::Base
  # TODO: This is a temporary hack. Get the server from the adapter.
  def server
    'personal.vanguard.com'
  end
end
