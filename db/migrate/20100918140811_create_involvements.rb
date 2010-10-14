class CreateInvolvements < ActiveRecord::Migration
  def self.up
    create_table :involvements, :id => false do |t|
      t.integer :project_id
      t.integer :user_id
    end

    add_index :involvements, [:project_id, :user_id]
  end

  def self.down
    drop_table :involvements
  end
end
