class AddProductToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :product, :string, index: true

    reversible do |dir|
      dir.up do
        Paper.update_all product: 'AMAFERM'
      end
    end
  end
end
