module LotusNotesCalendar
  class Event
    attr_accessor :id, :at, :text, :calendar

    def initialize(id = nil, at = nil, text = nil, url = nil)
      @id = id
      @at = at
      @text = text
      @calendar = Calendar.new(url)
    end

    def self.from_xml(calendar, xml_node)
      # xml_node is 'viewentry' node
      e = Event.new
      e.id = xml_node['unid']
      e.calendar = calendar
      date_str = xml_node.xpath('entrydata[@name="$6"]/text')[0].content
      e.at = Date.strptime date_str, '%m/%d/%Y'
      e.text = xml_node.xpath('entrydata[@name="$7"]/text')[0].content
      return e
    end

    def self.from_html(calendar, id, html)
      e = Event.new
      e.id = id
      e.calendar = calendar
      next_attr = nil

      html.xpath('//html/body/form/table/tr/td/font').each do |el|
        if next_attr.nil?
          case el.content
          when 'Date'
            next_attr = :at
          when 'Description'
            next_attr = :text
          end
        else
          case next_attr
          when :at
            e.at = Date.strptime el.content, '%m/%d/%Y'
          when :text
            e.text = el.content
          end
          next_attr = nil
        end

      end

      # e.id = xml_node['unid']
      # date_str = xml_node.xpath('entrydata[@name="$6"]/text')[0].content
      # e.at = Date.strptime date_str, '%m/%d/%Y'
      # e.text = xml_node.xpath('entrydata[@name="$7"]/text')[0].content

      return e
    end
  end
end
