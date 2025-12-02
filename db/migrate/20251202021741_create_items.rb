class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.date :expiration_date
      t.boolean :ai_detected
      t.datetime :detected_at

      t.timestamps
    end
  end
end
