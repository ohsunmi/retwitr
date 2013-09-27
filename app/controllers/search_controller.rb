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

		timeline = client.user_timeline(params[:q])
		name = timeline.first.user.name
		twitter_handle = timeline.first.user.screen_name
		image = timeline.first.user.profile_image_url

		search = Search.create(:name => name, :twitter_handle => twitter_handle, :image => image)
		current_user.searches << search
		# current_user.searches << Search.create(:name => name, :twitter_handle => twitter_handle, :image => image)
		id = current_user.id

		redirect_to "/user/#{id}"
	end

	def view

		@timeline = get_tweets(params[:id])

		puts "================================"
		p @timeline.first.user.profile_banner_url
		# @search = Search.find(params[:id])
		# q = @search.twitter_handle 

		# token = current_user.oauth_token 
	  #	secret = current_user.oauth_secret 

		# client = Twitter::Client.new(
		# 	consumer_key: ENV['CONSUMER_KEY'],
	 	#   consumer_secret: ENV['CONSUMER_SECRET'],
	 	#   oauth_token: token,
	 	#   oauth_token_secret: secret
		# )

		# timeline = client.user_timeline(q)
		# timeline = timeline.reject { |status| status.text[0..1].include? "RT" }
		# @timeline = timeline.sort_by { |k| k['retweet_count'] }.reverse.first(3)
		# render :json => @timeline
	end

	def remove
		current_user.searches.delete(current_user.searches.find(params[:id]))

		id = current_user.id

		redirect_to "/user/#{id}"
	end

	private

	def get_tweets(id)
		@search = Search.find(id)
		q = @search.twitter_handle 

		token = current_user.oauth_token 
  	secret = current_user.oauth_secret 

		client = Twitter::Client.new(
			consumer_key: ENV['CONSUMER_KEY'],
	 	  consumer_secret: ENV['CONSUMER_SECRET'],
	 	  oauth_token: token,
	 	  oauth_token_secret: secret
		)

		timeline = client.user_timeline(q)
		timeline = timeline.reject { |status| status.text[0..1].include? "RT" }
		timeline = timeline.sort_by { |k| k['retweet_count'] }.reverse.first(3)
		timeline
	end

	# def get_tweet(user_id, tweet_id)

	# 	token = current_user.oauth_token 
 #  	secret = current_user.oauth_secret 

	# 	client = Twitter::Client.new(
	# 		consumer_key: ENV['CONSUMER_KEY'],
	#  	  consumer_secret: ENV['CONSUMER_SECRET'],
	#  	  oauth_token: token,
	#  	  oauth_token_secret: secret
	# 	)

	# 	puts "+++++++++++++++++++++++++"
	# 	puts Twitter::OEmbed.new.provider_name?


	# 	client.status(tweet_id)

	# end

end
