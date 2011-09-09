#! /usr/bin/ruby

files = []
files << 'Control Flow Functions'
files << 'String Functions'
files << "Numeric Functions"
files << 'Date and Time Functions' 
files << 'Cast Functions and Operators'
files << 'Encryption and Compression Functions' 
files << 'Information Functions'
files << 'Miscellaneous Functions'  
files << 'Group By Aggregate Functions' 


regex = Regexp.new('([^\(\)]*)(.*){0,1}')

plist = <<-PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>category</key>
	<string>CATEGORY</string>
	<key>command</key>
	<string>#! /usr/bin/ruby
tmp = "FUNCTION"
regex = Regexp.new('([^\(\)]*)(.*){0,1}')
md = regex.match(tmp)
v = gets
if v
	print md[1]+"("+v+")"
else
	print md[0]
end
</string>
	<key>input</key>
	<string>selectedtext</string>
	<key>input_fallback</key>
	<string>currentword</string>
	<key>name</key>
	<string>NAME</string>
	<key>output</key>
	<string>insertastext</string>
	<key>scope</key>
	<string>inputfield</string>
	<key>tooltip</key>
	<string><![CDATA[TOOLTIP]]></string>
	<key>trigger</key>
	<string>none</string>
	<key>uuid</key>
	<string>UUID</string>
</dict>
</plist>
PLIST


files.each do |title|
	value = File.open(title).read()
  value.split("∞").each do |fnc|
    l = fnc.lines
    k = l.first
    v = fnc
    k.strip!
    # v.strip!
    tooltip = v
    uuid = `uuidgen`
    md =  regex.match(k)
    name = md[1]
    dirname = name.gsub(/ +/,"_")
    dirname = dirname + ".spBundle"
    succ = `mkdir "#{dirname}"`
    
    plist_copy = String.new(str=plist) 
    plist_copy.gsub!(/FUNCTION/,md[0])
    plist_copy.gsub!(/NAME/,name)
    plist_copy.gsub!(/TOOLTIP/,tooltip)
    plist_copy.gsub!(/UUID/,uuid)
    plist_copy.gsub!(/CATEGORY/,title)
    File.open(dirname+"/command.plist", "w+") do |f|
     f.write plist_copy
    end
  end 
end