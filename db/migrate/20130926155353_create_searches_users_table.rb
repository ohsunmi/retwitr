class CreateSearchesUsersTable < ActiveRecord::Migration
  def change
  	create_table :searches_users, :id => false do |t|
  		t.integer :search_id
  		t.integer :user_id
  	end
  end
end
