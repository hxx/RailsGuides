class AddUserRefToOverridings < ActiveRecord::Migration
  def change
    add_reference :overridings, :user, index: true
  end
end
