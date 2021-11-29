class CreateSittings < ActiveRecord::Migration[6.1]
  def change
    create_table :sittings do |t|
      t.integer :lineitem_id
      t.integer :service_id
      t.string :notes

      t.timestamps
    end
  end
end
