require 'nokogiri'
require 'net/http'
require 'uri'

module LotusNotesCalendar
  class Calendar
    
    attr_reader :name, :url
  
    def initialize(url, name = "")
      @name = name
      @url = url
      @results = {}
    end
    
    def find(id)
      url = "#{@url}/#{id}?OpenDocument"
      return @results[url] if @results.has_key?(url)
      doc = Nokogiri::HTML(open_url(url))
      event = Event.from_html(self, id, doc)
      @results[url] = event
      return event
    end
    
    def all
      where
    end
  
    def where(options = {})
      url = build_url(options)
      return @results[url] if @results.has_key?(url)
      doc = Nokogiri::XML(open_url(url))
      events = []
      doc.xpath('//viewentries/viewentry').each do |event_xml|
        next if event_xml.has_attribute?('conflict') and event_xml['conflict'] == "true"
        events << Event.from_xml(self, event_xml)
      end
      @results[url] = events
      return events
    end
    
    private      
      def build_url(options = {})
        url = "#{@url}?ReadViewEntries&PreFormat"
        if options[:start] and options[:end]
          url += "&KeyType=time"
          url += "&StartKey=#{options[:start]}"
          url += "&UntilKey=#{options[:end]}"
        elsif options[:date]
          url += "&Date=#{options[:date]}"
        end
        url
      end
      def open_url(url)
        begin
          # Rails.logger.info url
          uri = URI.parse(url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.is_a? URI::HTTPS
          # http.ca_file = "/etc/ssl/certs/ca-certificate.crt"
          request = Net::HTTP::Get.new(uri.request_uri)
          http.request(request).body
        rescue Errno::ETIMEDOUT
          ""
        end
      end
  
  end
end