class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role
      t.boolean :active
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end

    create_table :orders do |t|
      t.integer :status

      t.timestamps
      t.references :user, foreign_key: true
    end

    create_table :items do |t|
      t.string :name
      t.boolean :active
      t.decimal :price
      t.text :description
      t.string :image
      t.integer :inventory

      t.timestamps
      t.references :user, foreign_key: true
    end

    create_table :order_items do |t|
      t.integer :quantity
      t.decimal :price
      t.boolean :fulfilled

      t.timestamps
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
