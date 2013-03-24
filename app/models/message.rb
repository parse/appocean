class Message < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :island

  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'

 # belongs_to :user
end
