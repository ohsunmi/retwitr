class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.string :twitter_handle
      t.string :image

      t.timestamps
    end
  end
end
