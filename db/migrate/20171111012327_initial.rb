class Initial < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :wins
      t.integer :loses

      t.timestamps
    end

    create_table :tournaments do |t|
      t.string :name
      t.string :location
      t.integer :season

      t.timestamps

    end

    create_table :matches do |t|

      t.belongs_to :tournament, index: true, foreign_key: true
      t.integer :winner_one, foreign_key: true
      t.integer :winner_two, foreign_key: true
      t.integer :loser_one, foreign_key: true
      t.integer :loser_two, foreign_key: true

      t.timestamps
    end

    create_table :matches_players do |t|
      t.belongs_to :match, index: true
      t.belongs_to :player, index: true

      t.timestamps

    end
  end
end
