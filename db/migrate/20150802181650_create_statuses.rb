class CreateStatuses < ActiveRecord::Migration

  def change
    create_table :statuses do |t|
      t.integer :item_id
      t.string :name
      t.string :holder
      t.date :start_time
      t.date :due
      t.timestamps null: false
    end
  end

end
