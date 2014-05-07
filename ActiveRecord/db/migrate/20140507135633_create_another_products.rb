class CreateAnotherProducts < ActiveRecord::Migration
  def change
    create_table :another_products do |t|
      t.string :name
      t.string :part_number
    end
  end
end
