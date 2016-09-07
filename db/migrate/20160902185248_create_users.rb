class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :email, uniqueness: true
      t.string :picture_url, limit: 40
      t.string :password_digest
      t.string :remember_digest
    end

    add_index :users, :email
    add_index :users, :remember_digest
  end
end
