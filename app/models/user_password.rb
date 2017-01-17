class UserPassword
  PASSWORD_STORE = Keychain.internet_passwords

  def initialize(server:, account:, protocol: Keychain::Protocols::HTTPS)
    @server = server
    @account = account
    @protocol = protocol
  end

  def password
    keychain_item.password if keychain_item.present?
  end

  def password=(password)
    # There's a race condition here. Not a big deal, probably. But still...
    # Is there an atomic upsert option for keychain to avoid it? Or a way to
    # lock the keychain?
    if keychain_item.present?
      update_password(password)
    else
      insert_password(password)
    end
  end

  private

  attr_reader :server, :account, :protocol

  def update_password(password)
    keychain_item.password = password
    keychain_item.save!
  end

  def insert_password(password)
    PASSWORD_STORE.create(keychain_item_attributes.merge(password: password))
  end

  def keychain_item
    @keychain_item ||= PASSWORD_STORE.where(keychain_item_attributes).first
  end

  def keychain_item_attributes
    {
      server: server,
      protocol: protocol,
      account: account,
    }
  end
end
