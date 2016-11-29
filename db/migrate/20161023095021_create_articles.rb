class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :issue_num, index: true
      t.string :edition
      t.references :content
      t.references :category

      t.timestamps
    end
  end
end
