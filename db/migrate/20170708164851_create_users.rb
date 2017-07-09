class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :token
      t.string :password_digest

      t.timestamps

      t.index :name, unique: true
      t.index :email, unique: true
      t.index :token, unique: true
    end
  end
end
