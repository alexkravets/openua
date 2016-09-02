namespace :cron do
  desc 'Sync OP data'
  task :sync => :environment do
    Rake::Task["open_procurement:sync"].invoke
    Rake::Task["tender_info:sync"].invoke
  end
end
