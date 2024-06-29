class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references users
      t.references posts

      t.timestamps
    end
  end
end
