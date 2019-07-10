class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
