class ActsAsLoggableMigrationGenerator < Rails::Generator::Base 
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end

  def file_name
    "create_action_logs"
  end
end