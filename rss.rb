require 'open-uri'
require 'cgi'
require 'nokogiri'

abort "Usage:\n #{__FILE__} rss feed\n Example: #{__FILE__} http://www.ruby-lang.org/en/feeds/news.rss" if ARGV.empty?

url = ARGV[0]

doc = Nokogiri::XML(open(url))

titles = doc.css("title")
i = 0

titles.each do |title|
	fixed = Nokogiri::HTML(title.to_s).content
	puts "#{i}: #{fixed}"
	i += 1
end

i = Integer(STDIN.gets.chomp)

puts Nokogiri::HTML(CGI.unescapeHTML(doc.css("description")[i].to_s).to_s).content