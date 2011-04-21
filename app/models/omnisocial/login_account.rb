module Omnisocial
  class LoginAccount
    include Mongoid::Document
    
    field :type
    field :user_id
    field :remote_account_id
    field :name
    field :login
    field :picture_url
    field :access_token
    field :access_token_secret
    
    embedded_in :user, :class_name => 'Omnisocial::User', :inverse_of => :login_account

    def self.find_or_create_from_auth_hash(auth_hash)
      if (user = ::User.first(:conditions => {"login_account.remote_account_id" => auth_hash['uid']}))
        acount = user.login_account
        account.assign_account_info(auth_hash)
        account.save
        account
      else
        create_from_auth_hash(auth_hash)
      end
    end

    def self.create_from_auth_hash(auth_hash)
      user = ::User.new
      user.login_account.assign_account_info(auth_hash)
      user.login_account
    end
  end
end