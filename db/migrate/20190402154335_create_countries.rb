class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, id: false do |t|
      t.string :country_code, null: false
      t.string :name
      t.text :calling_codes, array: true, default: []
      t.string :region

      t.timestamps null: false
    end

    add_index :countries, :country_code, unique: true

    change_table :sales_aids do |t|
      t.string :country_codes, array: true, default: []
    end
  end
end
