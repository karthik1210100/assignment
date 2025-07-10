class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :parental_consent, :boolean
  end
end
