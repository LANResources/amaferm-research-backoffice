class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :password_digest
      t.integer :role, default: 0
      t.string :avatar

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
  end
end
