class CreateTinks < ActiveRecord::Migration
  def change
    create_table :tinks do |t|
      t.string :url
      t.string :title
      t.date :date_of_send
      t.references :user

      t.timestamps
    end
    add_index :tinks, :user_id
  end
end
