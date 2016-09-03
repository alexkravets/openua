namespace :tender_info do
  desc 'Sync TI models with OP data'
  task :sync => :environment do
    bundles = OpenProcurement::TenderBundle.model_not_in_sync.to_a
    bundles.each do |tender_bundle|
      TenderDataService.new(tender_bundle).update!
      tender_bundle.update_attribute(:model_in_sync, true)
    end
  end

  desc 'Force sync TI models with OP data'
  task :force_sync => :environment do
    bundles = OpenProcurement::TenderBundle.all.to_a
    bundles.each do |tender_bundle|
      TenderDataService.new(tender_bundle).update!
      tender_bundle.update_attribute(:model_in_sync, true)
    end
  end
end
