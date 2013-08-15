require 'bcrypt'

class User < ActiveRecord::Base
	attr_accessor :password_confirmation, :password
  attr_accessible :email, :name, :password_digest, :username, 
  							  :password_confirmation, :password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :password, :length => { :minimum => 6}, :on => :create
  validate 	:confirm_password, :on => :create
  validates :email, :format => { 
  									:with => VALID_EMAIL_REGEX,
  									:message => "Please give a valid email"
  								}
  validates :email, :name, :username, :presence => true
  validates :password_confirmation, :password, :presence => true, :on => :create 

  before_create :encrypt_password


  def gave_correct_password?(password)
  	BCrypt::Password.new(self.password_digest) == password
  end

  def encrypt_password
    p self.password
  	self.password_digest = BCrypt::Password.create(password)
  end

  def shuffle_session_key!
  	self.session_key = SecureRandom::urlsafe_base64(16)
    self.save!
  end

  private 
  	def confirm_password
  		@password == @password_confirmation
  		self.errors.full_messages << "Passwords don't match"
  	end
end
