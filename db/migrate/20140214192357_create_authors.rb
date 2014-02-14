class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :last_name

      t.timestamps
    end

    add_index :authors, :last_name, unique: true
  end
end
