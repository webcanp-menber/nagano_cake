class AddGenreIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :genre_id, :integer, null: false, default: 1
  end
end
