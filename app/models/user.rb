class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :session_key, :username

  

  def gave_correct_password?(password)
  	self.password_digest == password
  end

  def password=(new_password)
  	@password = BCrypt::Password.create(password)
  	self.password_digest = @password
  end

  def password
  	@password ||= BCrypt::Password.new(self.password_digest)
  end

  def shuffle_session_key!
  	self.session_key = SecureRandom::urlsafe_base64(16)
  	self.save!
  end


end
