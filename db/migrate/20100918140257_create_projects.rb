class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :token

      t.timestamps
    end

    add_index :projects, :token, :unique => true
  end

  def self.down
    drop_table :projects
  end
end
