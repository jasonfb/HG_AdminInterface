class CreateLineitems < ActiveRecord::Migration[6.1]
  def change
    create_table :lineitems do |t|
      t.integer :invoice_id
      t.integer :person_id
      t.date :services_rendered_date
      t.float :price

      t.timestamps
    end
  end
end
