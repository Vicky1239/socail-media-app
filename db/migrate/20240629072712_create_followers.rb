class CreateFollowers < ActiveRecord::Migration[7.1]
  def change
    create_table :followers do |t|
      t.references: User, as follower
      t.references: User, as following

      t.timestamps
    end
  end
end
