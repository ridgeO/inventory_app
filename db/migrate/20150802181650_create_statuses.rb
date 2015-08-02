class CreateStatuses < ActiveRecord::Migration

  def change
    create_table :statuses do |t|
      t.integer :item_num
      t.string :name
      t.string :holder
      t.date :due
      t.timestamps null: false
    end
  end

end
