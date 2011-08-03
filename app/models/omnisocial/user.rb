module Omnisocial
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    field :remember_token
    field :last_login_date, :type => Time
    field :login_count, :type => Integer
    embeds_one :login_account, :class_name => 'Omnisocial::LoginAccount'
    delegate :login, :name, :picture_url, :account_url, :access_token, :access_token_secret, :to => :login_account
    
    def to_param
      if !self.login.include?('profile.php?')
        "#{self.id}-#{self.login.gsub('.', '-')}"
      else
        self.id.to_s
      end
    end

    def from_twitter?
      login_account.kind_of? TwitterAccount
    end

    def from_facebook?
      login_account.kind_of? FacebookAccount
    end

    def from_linked_in?
      login_account.kind_of? LinkedInAccount
    end

    def from_github?
      login_account.kind_of? GithubAccount
    end

    def remember
      update_attributes(:remember_token => ::BCrypt::Password.create("#{Time.now}-#{self.login_account.type}-#{self.login}")) unless new_record?
    end

    def forget
      update_attributes(:remember_token => nil) unless new_record?
    end
  end
end
