class SystemSetting < ApplicationRecord
  include Encryptor

  attr_accessor :client_secret
  enum auth_method: {nothing: 0, api_key: 1, oauth2: 2}

  before_save :encrypt_client_secret
  after_initialize :decrypt_client_secret

  validates :auth_method, presence: true
  validates :api_key, presence: true, if: :api_key?
  validates :client_id, presence: true, if: :oauth2?
  validates :client_secret, presence: true, if: :oauth2?

  def self.auth_methods_without_nothing
    auth_methods.reject {|k, _v| k.to_sym == :nothing}
  end

  def self.auth_methods_i18n_without_nothing
    auth_methods_i18n.reject {|k, _v| k.to_sym == :nothing}
  end

  private

  def encrypt_client_secret
    self.encrypted_client_secret = encrypt(client_secret) if client_secret
  end

  def decrypt_client_secret
    self.client_secret = decrypt(encrypted_client_secret) if encrypted_client_secret
  end
end
