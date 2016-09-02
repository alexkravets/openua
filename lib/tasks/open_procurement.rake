namespace :open_procurement do
  desc 'Sync bundles with OP database'
  task :sync => :environment do
    sync = OpenProcurement::Sync.new
    sync.start

    total_tenders = OpenProcurement::TenderBundle.all.size
    ap "Total tenders: #{total_tenders}"
  end
end
