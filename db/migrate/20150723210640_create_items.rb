class CreateItems < ActiveRecord::Migration

  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :status
      t.string :holder
      t.date :due
      t.timestamps null: false
    end
  end

end
