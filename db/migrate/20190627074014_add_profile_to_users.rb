class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :title, :string
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cell_phone, :string
    add_column :users, :secondary_phone, :string
    add_column :users, :fax, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :postal, :string
    add_column :users, :country, :string
  end
end
