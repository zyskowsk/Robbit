class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_id, :user_id

  belongs_to :link
  belongs_to :author, 
  					 :class_name => "User",
  					 :foreign_key => :user_id
  belongs_to :parent, 
  					 :class_name => "Comment",
  					 :foreign_key => :parent_id

  has_many :children,
  				 :class_name => "Comment",
  				 :foreign_key => :parent_id

end
