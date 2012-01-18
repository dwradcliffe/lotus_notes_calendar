require 'helper'

class TestEvent < Test::Unit::TestCase
  
  should "be able to parse event data from xml" do
    raw_xml = <<END
<viewentry position="4140" unid="852571A7002389488525791200665961" noteid="24BC0E" siblings="4533">
<entrydata columnnumber="0" name="$6">
<text>12/26/2011 12:00:00 AM</text>
</entrydata>
<entrydata columnnumber="1" name="$7">
<text>Christmas Break</text>
</entrydata>
</viewentry>
END
    xml_node = Nokogiri::XML(raw_xml).root
    event = LotusNotesCalendar::Event.from_xml(LotusNotesCalendar::Calendar.new(''), xml_node)
    assert_equal '852571A7002389488525791200665961', event.id
    assert_equal Date.new(2011,12,26), event.at
    assert_equal 'Christmas Break', event.text

  end
  
  should "be able to parse event data from html" do
    raw_html = <<END
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<TITLE>Calendar Event</TITLE><style type = "text/css">  td {font-family: Arial; font-size: 9} td.menu {font-family: Arial} td.menu {font-size: 11; font-family: Arial; font-weight: normal}  a {text-decoration: none; color: navy} a:hover {text-decoration: underline; color: blue} a.menu {text-decoration: none; color: navy} a.menu:hover {text-decoration: underline; color: blue; font-weight: bold} </style>
<script language="JavaScript" type="text/javascript">
<!-- 
document._domino_target = "_self";
function _doClick(v, o, t) {
  var returnValue = false;
  var url="/centraloffice.nsf/9eedb3f6499687e7852573f3006560bb/5c810f13e09ab8c785257912006662bc?OpenDocument&Date=2011-12-27&Click=" + v;
  if (o.href != null) {
    o.href = url;
    returnValue = true;
  } else {
    if (t == null)
      t = document._domino_target;
    window.open(url, t);
  }
  return returnValue;
}
// -->
</script>
</head>
<body text="#000000" bgcolor="#FFFFFF">

<form action=""><A HREF="#" onClick="window.close();" onmouseover="status='Close'; return true;" onmouseout="status='';">
<font size = 2 face = Arial><b>Close</font></b></A><br>
<hr align = left height = 3 width = 640 color = #000080><br>
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="480"><b><font size="4" color="#6260a1">Mooresville Consolidated School Corporation</font></b><br>
<b><font size="6" color="#000080">Calendar Event</font></b></td><td width="125"><img width="1" height="1" src="/icons/ecblank.gif" border="0" alt=""></td></tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td width="144"><font size="2">Date</font></td><td width="288"><font size="2">12/27/2011</font></td></tr>

<tr valign="top"><td width="144"><br></td><td width="288"><img width="1" height="1" src="/icons/ecblank.gif" border="0" alt=""></td></tr>

<tr valign="top"><td width="144"><font size="2">Description</font></td><td width="288"><font size="2">Christmas Break</font></td></tr>

<tr valign="top"><td width="144"><font size="2">Details</font><br>
</td><td width="288"><font size="2"></font></td></tr>
</table>
</form>
</body>
</html>
END

    html_doc = Nokogiri::HTML(raw_html)
    event = LotusNotesCalendar::Event.from_html(LotusNotesCalendar::Calendar.new(''), '5C810F13E09AB8C785257912006662BC', html_doc)
    assert_equal '5C810F13E09AB8C785257912006662BC', event.id
    assert_equal Date.new(2011,12,27), event.at
    assert_equal 'Christmas Break', event.text

  end
  
end
