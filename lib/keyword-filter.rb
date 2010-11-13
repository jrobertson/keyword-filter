#!/usr/bin/ruby

# file: keywords-filter.rb

require 'rexml/document'
include REXML

class KeywordFilter
  include REXML

  def initialize(s)
    @keywords = XPath.match(Document.new(open(s)).root, 'records/keyword/phrase/text()')
  end

  def filter(raw_s)
    s = raw_s.gsub(/\b(#{@keywords.join('|')})\b/i,'<f>\0</f>')
    doc = Document.new("<root>#{s}</root>")
    filtered_words = XPath.match(doc.root, '*')

    filtered_words.empty? ? raw_s : doc.root
  end

  def open(s)
    if s[/^https?:\/\//] then  # open a file from a url 
      buffer = Kernel.open(s, 'UserAgent' => 'KeywordsFilter-Reader').read
    elsif s[/\</] # input xml string
      buffer = s
    else # local file
      buffer = File.open(s,'r').read
    end
  end
end
