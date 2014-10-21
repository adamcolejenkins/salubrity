class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :response, index: true
      t.references :field, index: true
      t.text :value
      t.time :started_at
      t.time :ended_at

      t.timestamps
    end
  end
end
