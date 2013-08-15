class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :session_key, :username
end
