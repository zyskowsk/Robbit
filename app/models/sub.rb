class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name

  validates :name, :presence => true

  belongs_to :moderator, 
  					 :class_name => "User",
  					 :foreign_key => :moderator_id

  has_many :sub_links
  has_many :links, :through => :sub_links

	def save_sub_and_links(links)
	  ActiveRecord::Base.transaction do
			self.save!

			links.each do |link|
				link.user_id = self.moderator_id 
				link.save! 
				SubLink.create(:sub_id => self.id, :link_id => link.id)
			end
		end
	end
end
