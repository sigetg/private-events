class CreateEventAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendees do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :event_attendees, [:event_id, :user_id], unique: true
  end
end
