class AddSurnameToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :surname, :string, after: :name
    add_column :providers, :credential, :string, after: :surname
  end
end
