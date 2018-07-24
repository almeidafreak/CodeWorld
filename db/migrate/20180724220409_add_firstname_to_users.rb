class AddFirstnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :surname, :string
    add_column :users, :address, :string
    add_column :users, :phone, :integer
  end
end
