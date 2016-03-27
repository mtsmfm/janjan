class Init < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :rooms do |t|
      t.integer :joins_count, null: false, default: 0
      t.timestamps null: false
    end

    create_table :joins do |t|
      t.references :user, foreign_key: true, index: true, null: false, type: :uuid
      t.references :room, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end

    create_table :games do |t|
      t.references :room, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end

    execute %(CREATE TYPE winds AS ENUM (%s);) % %i(east south west north).map {|s| %('#{s}') }.join(?,)

    create_table :scenes do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.binary :data

      t.timestamps null: false
    end
  end
end
