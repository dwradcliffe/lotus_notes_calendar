require 'nokogiri'
require 'open-uri'

module LotusNotesCalendar
  class Calendar
  
    def initialize(url)
      @url = url
    end
    
    def all
      where
    end
  
    def where(options = {})
      doc = Nokogiri::XML(open(build_url(options)))
      events = []
      doc.xpath('//viewentries/viewentry').each do |event_xml|
        events << Event.from_xml(event_xml)
      end
      return events
    end
    
    private      
      def build_url(options = {})
        url = "#{@url}?ReadViewEntries&PreFormat"
        if options[:start] and options[:end]
          url += "&KeyType=time"
          url += "&StartKey=#{options[:start]}"
          url += "&UntilKey=#{options[:end]}"
        end
        url
      end
  
  end
end