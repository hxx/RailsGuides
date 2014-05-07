class AddPartNumberToOverridings < ActiveRecord::Migration
  def change
    add_column :overridings, :part_number, :string
  end
end
