class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :email, uniqueness: true
      t.attachment :avatar
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :remember_digest
  end
end
