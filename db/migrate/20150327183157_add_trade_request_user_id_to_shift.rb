class AddTradeRequestUserIdToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :tr_user_id, :integer
  end
end
