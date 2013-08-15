require 'bcrypt'

class User < ActiveRecord::Base
	attr_accessor :password_confirmation, :password
  attr_accessible :email, :name, :password_digest, :session_key, :username, 
  							  :password_confirmation, :password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password, :length => { :minimum => 6 }
  validate 	:confirm_password
  validates :email, :format => { 
  									:with => VALID_EMAIL_REGEX,
  									:message => "Please give a valid email"
  								}
  validates :email, :name, :password, :password_confirmation, :username,
  					:presence => true

  before_save :encrypt_password
  before_validation :shuffle_session_key


  def gave_correct_password?(password)
  	self.password_digest == password
  end

  def encrypt_password
  	self.password_digest = BCrypt::Password.create(password)
  end

  def shuffle_session_key
  	self.session_key = SecureRandom::urlsafe_base64(16)
  end

  private 
  	def confirm_password
  		@password == @password_confirmation
  		self.errors.full_messages << "Passwords don't match"
  	end
end
