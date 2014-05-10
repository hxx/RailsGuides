class AddIsReadToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :is_read, :boolean
  end
end
