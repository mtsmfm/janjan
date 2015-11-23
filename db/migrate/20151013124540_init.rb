class Init < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.timestamps null: false
    end

    create_table :rooms do |t|
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

    execute %(CREATE TYPE seat_position AS ENUM (%s);) % (0..3).map {|s| %('#{s}') }.join(?,)

    create_table :seats do |t|
      t.references :user, foreign_key: true, index: true, null: false, type: :uuid
      t.references :game, foreign_key: true, index: true, null: false
      t.column :position, :seat_position, null: false
      t.integer :point, null: false

      t.timestamps null: false
    end

    create_table :fields do |t|
      t.references :game, foreign_key: true, index: true, null: false
      t.references :seat, foreign_key: true, index: true
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
      t.references :seat, foreign_key: true
      t.integer :base_point

      t.timestamps null: false
    end
  end
end
