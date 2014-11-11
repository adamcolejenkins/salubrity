class AddDeletedAtToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :deleted_at, :datetime
  end
end
