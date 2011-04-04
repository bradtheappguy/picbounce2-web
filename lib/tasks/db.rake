namespace :db do
  desc "Restore"
  task :restore => :environment do
    db_config = ActiveRecord::Base.configurations[::Rails.env]
    if (db_config['adapter'] = 'postgres')
      cmd = "pg_restore -U #{db_config['username']} --clean -d #{db_config['database']} < #{ENV['FILE']}"
      puts "running: #{cmd}"
      `#{cmd}`
    else
      puts "Error: I don't know how to restore using #{db_config['adapter']} adapter"
    end
  end 
end
