class AddOriginalOwnerToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :original_owner, :integer
  end
end
