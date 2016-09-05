namespace :tender_info do
  desc 'Sync models with OP data'
  task :sync => :environment do
    loop do
      bundles = OpenProcurement::TenderBundle.model_not_in_sync.limit(100).to_a
      break if bundles.empty?

      bundles.each do |tender_bundle|
        TenderDataService.new(tender_bundle).update!
        tender_bundle.update_attribute(:model_in_sync, true)
      end
    end
  end

  desc 'Force sync models with OP data'
  task :force_sync => :environment do
    OpenProcurement::TenderBundle.update_all(model_in_sync: false)
    Rake::Task["tender_info:sync"].invoke
  end
end
