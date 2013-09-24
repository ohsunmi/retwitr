class Search < ActiveRecord::Base
  attr_accessible :image, :name, :twitter_handle

  has_and_belongs_to_many :users
  has_many :tweets
end
