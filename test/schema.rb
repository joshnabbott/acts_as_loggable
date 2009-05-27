ActiveRecord::Schema.define(:version => 1) do
  create_table :action_logs, :force => true do |t|
    t.column :user_id,        :integer
    t.column :loggable_id,    :integer
    t.column :loggable_type,  :string
    t.column :action,         :text
    t.column :created_at,     :datetime
  end
  
  create_table :blog_posts, :force => true do |t|
    t.column :title,  :string
  end

  create_table :products, :force => true do |t|
    t.column :title,        :string
  end
  
  create_table :images, :force => true do |t|
    t.column :title, :string
  end
  
  create_table :users, :force => true do |t|
    t.column :login, :string
  end
end
