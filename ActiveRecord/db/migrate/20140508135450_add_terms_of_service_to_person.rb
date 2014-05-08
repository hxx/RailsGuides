class AddTermsOfServiceToPerson < ActiveRecord::Migration
  def change
    add_column :people, :terms_of_service, :text
  end
end
