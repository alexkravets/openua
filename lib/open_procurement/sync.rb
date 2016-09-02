module OpenProcurement
  class Sync
    def start
      offset = (Time.now - 5.minutes).to_s

      lastest_bundle = OpenProcurement::TenderBundle.first
      if lastest_bundle
        offset = lastest_bundle.date_modified
      end

      params = { offset: offset }
      loop do
        res = client.tenders(params: params)

        params[:offset] = res["next_page"]["offset"]
        data = res["data"]
        break if data.empty?
        update_bundles(data)
      end

      sync_bundles_data
    end

    private

    def client
      @client ||= OpenProcurement::Client.new
    end

    def update_bundles(data)
      data.each do |entry|
        id = entry["id"]
        date_modified = entry["dateModified"]
        tb = TenderBundle.find_or_create_by(open_procurement_id: id)
        unless tb.date_modified == date_modified
          tb.update_attributes! date_modified: date_modified,
                                data_in_sync: false,
                                model_in_sync: false
          ap "    #{id} — #{date_modified}"
        end
      end
    end

    def sync_bundles_data
      bundles = TenderBundle.data_not_in_sync.to_a
      bundles.each do |b|
        res = client.tender(b.open_procurement_id)
        data = res["data"]
        b.update_attributes! data: data,
                             data_in_sync: true,
                             model_in_sync: false
      end
    end
  end
end
