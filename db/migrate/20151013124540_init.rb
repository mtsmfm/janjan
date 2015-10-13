class Init < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
    end

    create_table :rooms do |t|
      t.timestamps null: false
    end

    create_table :joins do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :room, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end

    create_table :games do |t|
      t.references :room, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end

    create_table :fields do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.references :user, foreign_key: true, index: true
      t.string :type, null: false

      t.timestamps null: false
    end

    create_table :tiles do |t|
      t.references :field, foreign_key: true, index: true, null: false
      t.string :kind, null: false

      t.timestamps null: false
    end

    create_table :actions do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.string :type, null: false
      t.references :tile, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
