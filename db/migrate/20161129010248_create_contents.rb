class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.text :sequence
      t.references :article, index: true

      t.timestamps
    end
  end
end
