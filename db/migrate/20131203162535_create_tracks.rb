class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :description
      t.string :permalink

      t.timestamps
    end
  end
end
