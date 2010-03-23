class PrepareDatabase < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_name
      t.string :full_name
      t.string :email,            :null => false
      t.string :password_salt,    :null => false
      t.string :persistence_token
      t.string :crypted_password
      t.boolean :admin, :default => false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :posts do |t|
      t.text :description
      t.string :notes
      t.string :status, :default => "new"
      t.string :author_name
      t.integer :author_id
      t.references :user
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :comments, :force => true do |t|
      t.string :title, :limit => 50, :default => ""
      t.string :comment, :default => ""
      t.timestamps :created_at, :null => false
      t.integer :commentable_id, :default => 0, :null => false
      t.string :commentable_type, :limit => 15,
      :default => "", :null => false
      t.references :user, :default => 0, :null => false
      t.references :idea
      t.string :author_name
    end

    create_table :events, :force => true do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
 
  end

  def self.down
    drop_table :users
    drop_table :posts
    drop_table :comments
    drop_table :events
  end
end
