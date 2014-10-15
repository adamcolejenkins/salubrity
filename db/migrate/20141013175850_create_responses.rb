class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :survey, index: true
      t.references :clinic, index: true
      t.references :provider, index: true
      t.time :started_at
      t.time :ended_at
      t.text :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
