# -*- coding: utf-8 -*-
require 'find'
# usage script inputfile-contains-xml
# output .md file will be reside in the same folder
$input = ARGV[0]
# $output = ARGV[1]
def remove_tags str
  str = str.gsub(/<[^>]+>/, '')
end
def to_markdown str
  str = str.gsub(/\r/, "\n")
  arr = str.split(/\n/).delete_if {|i| i == ''}
  r = []
  strange_lines = []
  arr.each do |line|
    if line =~ /<\/*table>/i
      r << line
    elsif line =~ /<\/*tr>/i
      r << line
    elsif line =~ /<\/*th>/i
      r << line
    elsif line =~ /<\/*td>/i
      r << line
    elsif line =~ /<\/*p\s*([^>]+)*>/i # cover cases like: <P id=\"LinkTarget_110\">. 该产品的 
      line = remove_tags(line)
      line = "\n\n" + line + "\n\n"
      r << line
    elsif line =~ /<\/*cm.>/i # some chinese xml has this strange tag
      line = remove_tags(line)
      line = "\n\n" + line + "\n\n"
      r << line
    elsif match = line.match(/<\/*h([0-9])\s*([^>]+)*>/i)
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
    elsif line =~ /<\/*figure\s*[^>]*>/i # "<Figure ActualText=\"Control \"
      line = remove_tags(line)
      line = "\n\n" + line + "\n\n"
      r << line
    elsif line =~ /<\/*normal>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*list-paragraph>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line

    elsif line =~ /<\/*header>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*endnote-text>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*body-text-3>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*normal-indent>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*no-spacing>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*title>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*body-text>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*art>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line

    elsif line =~ /<\/*body-text-indent>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*note>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*header-[0-9]>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*Normal--Web->/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line



    elsif line =~ /<\/*default>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*heading-[0-9]>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*inlineshape>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*shape>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*footnote-text>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*正文>/i
      line = "\n\n" + line + "\n\n"
      line = remove_tags(line)
      r << line
    elsif line =~ /<\/*li_title>/i
      header = '- '
      line = line.sub(/^/, header)
      r << remove_tags(line)
    elsif line =~ /<\/*list-bullet>/i
      header = '- '
      line = line.sub(/^/, header)
      r << remove_tags(line)
    elsif line =~ /<\/*li>/i
      header = '- '
      line = line.sub(/^/, header)
      r << remove_tags(line)
    elsif line =~ /<\/*li_label>/i
      line = remove_tags(line)
      header = '- '
      if line.size > 3 # 如果lable是真是的lable，是一个符号并不含有文字，我们就忽略它 比如只是 * 
        line = line.sub(/^/, header)
        r << line
      end
    elsif line =~ /<\/*lbody>/i
      header = '- '
      line = line.sub(/^/, header)
      r << remove_tags(line)
    elsif not line =~ /<\/*.+>/i
      # to cover case like:
      # <p> some words
      # more chinese word
      # </p>
      r << remove_tags(line) 
    elsif  line =~ /<\/*link>/i
      r << remove_tags(line) 
    elsif line =~ /^<imagedata/i
      m = line.match(/ImageData +src="([^"]+)"/)
      if m == nil
        # some src="" is empty so there is no m[1] and calling m[1] throws exception
      else
        img_url = m[1]
        line = '![](' + img_url + ')'
        line = "\n\n" + line + "\n\n"
        r << line
      end
    elsif line =~ /<\/[a-z]+:[a-z]+>/i
      p "rdf tags?"
    else
      strange_lines << line unless line =~ /^<\/*[^>]+>\/*$/
    end
  end
#  strange_lines       
#  error_msg = []
  p  strange_lines
  File.open('error.txt', 'w') do |f|
    f.puts strange_lines
  end
  return r.join("\n")
end
def add_line_space str
  str.each_line do |line|
    line = "\n\n" + line + "\n\n" # add \n first
    if line =~ /\++ / # if list, remove the \n
      line = line.gsub(/\n/, '')
    end
  end
  str = str.gsub(/\n\n+/, "\n\n")
end

def remove_unwanted_lines str
  newstr = ''
  str.each_line do |line|
    newstr << line unless line =~ /^- $/  # remove empty list
  end
  newstr
end
def squeez_lines str
  str = str.gsub(/\A\n+/, '')
  str = str.gsub(/\Z\n+/, '')
  str = str.gsub(/^\s+$/, '')
  str = str.gsub(/\n\n+/, "\n\n")
end
path = $input
Find.find(path) do |file|
  next if File.directory? file
  next unless file =~ /.xml$/i
  filename = File.basename(file, '.xml')
  filepath = File.dirname file
  outputfilename = filename + '.md'
  str = remove_unwanted_lines(to_markdown(File.read(file)))
  str = squeez_lines str
  File.open("#{filepath}/#{outputfilename}", 'w') do |f|
    f.puts str
  end
end
#str = add_line_space(to_markdown(File.read($input)))
#str = squeez_lines(to_markdown(File.read($input)))
#File.open("#{$output}", 'w') do |f|
#  f.puts str
#end


  
