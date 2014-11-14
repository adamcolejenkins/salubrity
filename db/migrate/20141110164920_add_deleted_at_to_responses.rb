class AddDeletedAtToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :deleted_at, :datetime
  end
end
