class CreateAccessRequests < ActiveRecord::Migration
  def change
    create_table :access_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :company
      t.string :phone
      t.string :email
      t.string :occupation
      t.string :species, array: true, default: []

      t.timestamps
    end
  end
end
