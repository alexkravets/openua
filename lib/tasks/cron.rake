namespace :cron do
  desc 'Sync OP data'
  task :sync => :environment do
    Rake::Task["open_procurement:sync"].invoke
    Rake::Task["openua:sync"].invoke
  end
end
