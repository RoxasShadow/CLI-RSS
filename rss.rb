#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'

class String
	def strip_tags
		self.gsub(%r{</?[^>]+?>}, '')
	end
end

abort "Usage:\n ./#{__FILE__} [url feed rss]\n\tExample: #{__FILE__} http://www.ruby-lang.org/en/feeds/news.rss" if ARGV.empty?

url = ARGV[0]
i   = 1

doc = Nokogiri::XML(open(url))
doc.css('title').each { |title|
	puts "#{i}: #{title.content}"
	i += 1
}

print 'Article to read: '
article = STDIN.gets.chomp.to_i
puts

abort 'The selected article is not valid.' if article > i

puts doc.css('description')[article - 1].content.strip_tags