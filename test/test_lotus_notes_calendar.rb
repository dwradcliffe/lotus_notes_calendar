require 'helper'

class TestLotusNotesCalendar < Test::Unit::TestCase
  
  should "get current events" do
    calendar = LotusNotesCalendar::Calendar.new("https://harmony.mcsc.k12.in.us/msstudent.nsf/school+calendar")
    results = calendar.where
    assert_equal 26, results.count
    assert_equal "7th Gr. First Football Practice - 9-11am", results[0].text
    assert_equal "Monday, Aug  1", results[0].at.strftime('%A, %b %e')
  end
  
end
