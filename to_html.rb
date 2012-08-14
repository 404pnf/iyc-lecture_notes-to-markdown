
require 'reverse_markdown'
#require './lib/reverse_markdown'

=begin
Usage
-----
 1. Include ReverseMarkdown class to your application
 2. get an instance: r = ReverseMarkdown.new
 3. parse a HTML string and save the return value: markdown = r.parse_string(html_string)
=end

# Example HTML Code for parsing
example = <<-EOF
<h2>heading 1.1</h2>

<p>text *italic* and **bold**.</p>

<pre><code>text *italic* and **bold**.
sdfsdff
sdfsd
sdf sdfsdf
</code></pre>

<blockquote>
  <p>text <em>italic</em> and <strong>bold</strong>. sdfsdff
  sdfsd sdf sdfsdf</p>
</blockquote>

<p>asdasd <code>sdfsdfsdf</code> asdad <a href="http://www.bla.de">link text</a></p>

<p><a href="http://www.bla.de">link <strong>text</strong></a></p>

<ol>
<li>List item</li>
<li>List <em>item</em>
<ol><li>List item</li>
<li>dsfdsf
<ul><li>dfwe</li>
<li>dsfsdfsdf</li></ul></li>
<li>lidsf <img src="http://www.dfgdfg.de/dsf.jpe" alt="item" title="" /></li></ol></li>
<li>sdfsdfsdf
<ul><li>sdfsdfsdf</li>
<li>sdfsdfsdf <strong>sdfsdf</strong></li></ul></li>
</ol>

<blockquote>
  <p>Lorem ipsum dolor sit amet, consetetur
  voluptua. At vero eos et accusam et
  justo duo dolores et ea rebum. Stet
  clita kasd gubergren, no sea takimata
  sanctus est Lorem ipsum dolor sit
  amet. <em>italic</em></p>
</blockquote>

<hr />

<blockquote>
  <p>Lorem ipsum dolor sit amet, consetetur
  sadipscing elitr, sed diam nonumy
  eirmod tempor invidunt ut labore et
  dolore magna aliquyam erat, sed</p>
</blockquote>

<p>nur ein text! nur eine maschine!</p>
EOF

# $input = ARGV[0]
#str = File.read($input)
r = ReverseMarkdown
# p markdown = r.parse_string(str)
p markdown = r.parse_string(example)
#r.print_errors   
# str = add_line_space(to_markdown(File.read($input)))
File.open('test.txt', 'w') do |f|
  f.puts markdown
end
       

  
