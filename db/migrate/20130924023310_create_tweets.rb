class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :id_str
      t.boolean :retweeted
      t.integer :retweet_count

      t.timestamps
    end
  end
end
