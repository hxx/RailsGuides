class AddDetailsToOverridings < ActiveRecord::Migration
  def change
    add_column :overridings, :part_number, :string
    add_column :overridings, :price, :decimal
  end
end
