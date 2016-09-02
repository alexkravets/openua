require 'net/http'

module OpenProcurement
  class Client
    def initialize(options={})
      @schema  = options[:schema]  || 'http'
      @host    = options[:host]    || 'api.openprocurement.org'
      @version = options[:version] || '2.3'
    end

    def tenders(options)
      uri    = URI("#{path}/tenders")
      params = options[:params] || {}
      format = options[:format]

      json = request(uri, params)
      if format == 'json'
        json
      else
        parse(json)
      end
    end

    def tender(id, format='')
      uri = URI("#{path}/tenders/#{id}")

      json = request(uri)
      if format == 'json'
        json
      else
        parse(json)
      end
    end

    private

    def path
      "#{@schema}://#{@host}/api/#{@version}"
    end

    def request(uri, params={})
      uri.query = URI.encode_www_form(params)
      ap "> #{uri}"
      res = Net::HTTP.get_response(uri)

      if res.is_a?(Net::HTTPSuccess)
        res.body
      else
        ap 'Woops, request has failed.'
        ''
      end
    end

    def parse(json)
      parser = Yajl::Parser.new
      json = parser.parse(json)
    end
  end
end
