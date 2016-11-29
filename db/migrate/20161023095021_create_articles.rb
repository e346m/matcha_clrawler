class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :issue_num
      t.string :edition

      t.timestamps
    end
  end
end
