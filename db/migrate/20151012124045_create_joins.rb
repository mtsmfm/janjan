class CreateJoins < ActiveRecord::Migration
  def change
    create_table :joins do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :room, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
