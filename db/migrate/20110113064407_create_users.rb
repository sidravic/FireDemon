class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email, :unique => true, :index => true
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.integer :login_count
      t.datetime :last_login_at

      t.timestamps
    end

    
  end

  def self.down    
    drop_table :users
  end
end
