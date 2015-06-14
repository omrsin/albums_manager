class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.text :name
      t.text :artist

      t.timestamps null: false
    end

    create_table :albums_users, id: false do |t|
		t.belongs_to :user, index: true
		t.belongs_to :album, index: true
    end
  end
end
