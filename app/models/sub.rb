class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name

  belongs_to :moderator, 
  					 :class_name => "User",
  					 :foreign_key => :moderator_id

  has_many :links

end
