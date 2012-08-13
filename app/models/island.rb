class Island < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :messages
end
