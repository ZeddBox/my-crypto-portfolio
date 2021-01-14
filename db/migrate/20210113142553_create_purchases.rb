class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :user, index: true
      t.belongs_to :portfolio, index: true
      t.string :crypto
      t.float :number
      t.float :price
      t.datetime :purchasedate

      t.timestamps
    end
  end
end
