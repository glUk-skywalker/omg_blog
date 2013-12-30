class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :owner_id
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
