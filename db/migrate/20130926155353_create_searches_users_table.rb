class CreateSearchesUsersTable < ActiveRecord::Migration
  def change
  	create_table :searches_tables, :id => false do |t|
  		t.integer :search_id
  		t.ingteger :user_id
  	end
  end
end
