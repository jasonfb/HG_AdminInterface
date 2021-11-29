class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.integer :account_id
      t.string :name

      t.timestamps
    end
  end
end
