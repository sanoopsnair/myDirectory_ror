class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true
      t.string :contact_name
      t.integer :phone_number
      t.string :description

      t.timestamps
    end
  end
end
