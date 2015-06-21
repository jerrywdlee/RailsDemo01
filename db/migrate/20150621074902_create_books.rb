class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :isbn
      t.string :genre
      t.boolean :useable
      t.text :summary

      t.timestamps null: false
    end
  end
end
