class SearchController < ApplicationController

	def form
	end

	def results
		token = current_user.oauth_token 
  	secret = current_user.oauth_secret 

		client = Twitter::Client.new(
			consumer_key: ENV['CONSUMER_KEY'],
	 	  consumer_secret: ENV['CONSUMER_SECRET'],
	 	  oauth_token: token,
	 	  oauth_token_secret: secret
		)

		# find user: client.user('screen_name')
		timeline = client.user_timeline(params[:q])
		timeline = timeline.reject { |status| status.text[0..1].include? "RT" }
		@timeline = timeline.sort_by { |k| k['retweet_count'] }.reverse.first(3)
	end

	def add_search

		token = current_user.oauth_token 
  	secret = current_user.oauth_secret 

		client = Twitter::Client.new(
			consumer_key: ENV['CONSUMER_KEY'],
	 	  consumer_secret: ENV['CONSUMER_SECRET'],
	 	  oauth_token: token,
	 	  oauth_token_secret: secret
		)

		timeline = client.user_timeline(params[:twitter_handle])
		name = timeline.first.user.name
		twitter_handle = timeline.first.user.screen_name
		image = timeline.first.user.profile_image_url

		search = Search.create(:name => name, :twitter_handle => twitter_handle, :image => image)
		binding.pry
		current_user.searches << search

	end

end
