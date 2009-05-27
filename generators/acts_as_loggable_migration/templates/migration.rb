class CreateActionLogs < ActiveRecord::Migration
  def self.up
    create_table :action_logs do |t|
      t.integer :user_id, :loggable_id, :null => false
      t.string :loggable_type, :action, :null => false
      t.text :description, :loggable_before_change, :loggable_after_change

      t.timestamps
    end
  end
  
  def self.down
    drop_table :action_logs
  end
end
