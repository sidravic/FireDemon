class CreateJabberCredentials < ActiveRecord::Migration
  def self.up
    create_table :jabber_credentials do |t|
      t.string :jabber_id
      t.string :jabber_password
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jabber_credentials
  end
end
