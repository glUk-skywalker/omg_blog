class ChangeOwneridToUseridInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :owner_id, :user_id
  end
end
