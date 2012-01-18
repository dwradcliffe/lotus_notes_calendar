require 'helper'

class TestCalendar < Test::Unit::TestCase
  
  should "be able to get current events" do
    calendar = LotusNotesCalendar::Calendar.new("https://harmony.mooresvilleschools.org/madison.nsf/school+calendar")
    results = calendar.all
    assert results.count > 0
    # assert_equal "7th Gr. First Football Practice - 9-11am", results[0].text
    # assert_equal "Monday, Aug  1", results[0].at.strftime('%A, %b %e')
  end
  
  should "be able to get a single event" do
    calendar = LotusNotesCalendar::Calendar.new("https://harmony.mooresvilleschools.org/madison.nsf/school+calendar")
    result = calendar.find('5F217BE1172632A8852578D90050CFB8')
    assert_equal '5F217BE1172632A8852578D90050CFB8', result.id
    assert_equal "Backe to School Night Grades 3 & 4 (6:00-7:30)", result.text
    assert_equal Date.new(2011, 8, 11), result.at
    assert_equal "Thursday, Aug 11", result.at.strftime('%A, %b %e')
  end
  
end
