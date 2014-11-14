class AddColorToFieldChoices < ActiveRecord::Migration
  def change
    add_column :field_choices, :color, :string
  end
end
