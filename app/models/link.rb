class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :user_id

  validates :user_id, :title, :url, :presence => true

  belongs_to :sub
  belongs_to :author, 
  					 :class_name => "User",
  					 :foreign_key => :user_id

  has_many :sub_links
  has_many :subs, :through => :sub_links
  has_many :comments
  has_many :votes, 
           :class_name => "UserVote",
           :foreign_key => :link_id

  def comments_by_parent_id
  	temp_hash = Hash.new { [] }
    comments_by_parent_id = Hash.new{ [] }
    
  	self.comments.each do |comment|
  		temp_hash[comment.parent_id] += [comment]
  	end

  	temp_hash.each do |key ,value| 
      comments_by_parent_id[key] = value.sort_by(&:score) 
    end

    comments_by_parent_id
  end
     
  def downvote_count
    self.votes.where("value = ?", -1).count
  end

  def save_link_and_subs(sub_ids)
    ActiveRecord::Base.transaction do
      self.save!
      sub_ids.each do |sub_id|
        SubLink.create!(:sub_id => sub_id, :link_id => self.id)
      end
    end
  end

  def score
    self.downvote_count - self.upvote_count 
  end

  def upvote_count
    self.votes.where("value = ?", 1).count
  end

  def update_link_and_subs(params)
    @new_sub_ids = params[:sub_ids] - self.sub_ids
    @old_sub_ids = self.sub_ids - params[:sub_ids]

    ActiveRecord::Base.transaction do
      self.update_attributes(params[:link])

      @new_sub_ids.each do |sub_id| 
        SubLink.create(:sub_id => sub_id, :link_id => self.id)
      end

      @old_sub_ids.each do |sub_id|
        SubLink.find_by_sub_id_and_link_id(sub_id, self.id).destroy
      end
    end
  end
end
