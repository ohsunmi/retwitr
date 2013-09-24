class Tweet < ActiveRecord::Base
  attr_accessible :id_str, :retweet_count, :retweeted, :text

  belongs_to :search
end
