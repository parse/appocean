class Message < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :island
  belongs_to :user
end
