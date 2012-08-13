class User < ActiveRecord::Base

  attr_accessible :username, :password

  has_many :user_metas
  has_many :friendships

	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
end
