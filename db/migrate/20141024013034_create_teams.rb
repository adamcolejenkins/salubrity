class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :subdomain
      t.string :website
      t.text :logo

      t.timestamps
    end
  end
end
