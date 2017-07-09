class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :password_digest

      t.timestamps

      t.index :token, unique: true
    end
  end
end
