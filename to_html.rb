
# require 'reverse_markdown'
require './lib/reverse_markdown'

=begin
Usage
-----
 1. Include ReverseMarkdown class to your application
 2. get an instance: r = ReverseMarkdown.new
 3. parse a HTML string and save the return value: markdown = r.parse_string(html_string)
=end


$input = ARGV[0]
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
     elsif line =~ /<\/*td>/i
       r << line
     elsif line =~ /<\/*p>/i
       r << (line)
     elsif line.match(/<h(.)>/i)
        r << line
     elsif line =~ /<\/*caption>/i
       r << (line)
     elsif line =~ /<\/*normal>/i
       line = '<p>' + line + '</p>'
       r << (line)
     elsif line =~ /<\/*li_title>/i
       line = line.sub(/<li_title>/i, '<li>')
       line = line.sub(/<\/li_title>/i, '</li>')
       r << (line)
     elsif line =~ /^<imagedata/i
       line = line.sub(/imagedata/i, 'img')
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

str = to_markdown(File.read($input))
r = ReverseMarkdown.new
markdown = r.parse_string(str)
r.print_errors   
# str = add_line_space(to_markdown(File.read($input)))
File.open('test.txt', 'w') do |f|
  f.puts markdown
end
       

  
