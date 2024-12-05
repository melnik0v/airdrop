class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :ip
      t.string :name
      t.string :fingerprint
      t.boolean :online
      t.timestamps
    end
  end
end
