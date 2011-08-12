module LotusNotesCalendar
  class Event
  
    attr_accessor :id, :at, :text
  
  
    def self.from_xml(xml_node)
      # xml_node is 'viewentry' node
      
      e = Event.new
      e.id = xml_node['unid']
      date_str = xml_node.xpath('entrydata[@name="$6"]/text')[0].content
      e.at = ::Date.new(*::Date._parse(date_str, false).values_at(:year, :mon, :mday))
      e.text = xml_node.xpath('entrydata[@name="$7"]/text')[0].content
      
      return e
      
    end
  
  end
end