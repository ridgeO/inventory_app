class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name
      t.integer :location
      t.string :image_url
      t.boolean :admin
      t.boolean :super_admin
      t.timestamps null: false
    end
    add_index :users, :provider
    add_index :users, :uid
    add_index :users, [:provider, :uid], unique: true
  end

end
