class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :lecturer
      t.decimal :price
      t.string :image_url
      t.string :category
      t.string :skill_level

      t.timestamps
    end
  end
end
