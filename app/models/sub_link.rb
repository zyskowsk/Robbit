class SubLink < ActiveRecord::Base
  attr_accessible :link_id, :sub_id

  belongs_to :link
  belongs_to :sub
end
