class UserVote < ActiveRecord::Base
  attr_accessible :link_id, :user_id, :value

  validates :link_id, :uniqueness => { :scope => :user_id }
  validates :value, :inclusion => { :in => [1, -1] }

  belongs_to :user
  belongs_to :link
end
