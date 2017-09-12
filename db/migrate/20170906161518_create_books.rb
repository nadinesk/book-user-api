class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :rating
      t.string :notes

      t.timestamps
    end
     
   
  end
end
