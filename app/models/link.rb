class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :user_id

  belongs_to :sub
  belongs_to :author, 
  					 :class_name => "User",
  					 :foreign_key => :user_id
end
