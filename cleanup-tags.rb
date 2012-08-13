# usage script inputfile outputfile
$input = ARGV[0]
$output = ARGV[1]
def remove_tags str
  str = str.gsub(/<[^>]+>/, '')
end
def to_markdown str
  str = str.gsub(/\r/, "\n")
  arr = str.split(/\n/).delete_if {|i| i == ''}
  r = []
  arr.each do |line|
     if line =~ /<\/*table>/i
       r << line
     elsif line =~ /<\/*tr>/i
       r << line
     elsif line =~ /<\/*th>/i
       r << line
     elsif line =~ /<\/*td>/i
       r << line
     elsif line =~ /<\/*p>/i
       line = remove_tags(line)
       line = "\n\n" + line + "\n\n"
       r << line
     elsif line =~ /<\/*cm.>/i # some chinese xml has this strange tag
       line = remove_tags(line)
       line = "\n\n" + line + "\n\n"
       r << line
     elsif match = line.match(/<h(.)>/i)
       times = match[1].to_i
       line = remove_tags(line)
       header = '#' * times + ' '
       line = line.sub(/^/, header)
       line = "\n\n" + line + "\n\n"
       r << line
     elsif line =~ /<\/*caption>/i
       line = remove_tags(line)
       line = "\n\n" + line + "\n\n"
       r << line
#     elsif line =~ /<\/*sect>/i
 #      line = "\n\n----\n\n"  # <hr>
  #     r << line
     elsif line =~ /<\/*figure>/i
       line = remove_tags(line)
       line = "\n\n" + line + "\n\n"
       r << line
     elsif line =~ /<\/*normal>/i
       line = "\n\n" + line + "\n\n"
       line = remove_tags(line)
       r << line
     elsif line =~ /<\/*li_title>/i
       header = '+ '
       line = line.sub(/^/, header)
       r << remove_tags(line)
     elsif line =~ /<\/*lbody>/i
       header = '+ '
       line = line.sub(/^/, header)
       r << remove_tags(line)
     elsif line =~ /^<imagedata/i
       m = line.match(/ImageData +src="([^"]+)"/)
       img_url = m[1]
       line = '![](' + img_url + ')'
       line = "\n\n" + line + "\n\n"
       r << line
     else
     end
  end
  r.join("\n")
end
def add_line_space str
  str.each_line do |line|
    line = "\n\n" + line + "\n\n" # add \n first
    if line =~ /\++ / # if list, remove the \n
      line = line.gsub!(/\n/, '')
    end
  end
  str = str.gsub(/\n\n+/, "\n\n")
end
def squeez_lines str
  str = str.gsub(/\A\n+/, '')
  str = str.gsub(/\n\n+/, "\n\n")
  str = str.gsub(/\Z\n+/, '')
end
#str = add_line_space(to_markdown(File.read($input)))
str = squeez_lines(to_markdown(File.read($input)))
File.open("#{$output}", 'w') do |f|
  f.puts str
end
       

  
