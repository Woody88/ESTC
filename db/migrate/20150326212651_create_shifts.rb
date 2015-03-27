class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :position
      t.datetime :date
      t.datetime :start
      t.datetime :finish
      t.text :description
      t.string :workflow_state
      t.string :shift_type

      t.timestamps
    end
  end
end
