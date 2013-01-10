class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.timestamp :event_time
      t.integer :user_id

      t.timestamps
    end
  end
end
