class RemovePartNumberFromOverridings < ActiveRecord::Migration
  def change
    remove_column :overridings, :part_number, :string
  end
end
