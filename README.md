# Introducing the keyword-filter gem

    require 'keyword-filter'

    xml =<<XML
    <keywords>
      <summary>
        <recordx_type>dynarex</recordx_type>
        <format_mask>[!phrase]</format_mask>
        <schema>keywords/keyword(phrase)</schema>
      </summary>
      <records>
        <keyword><phrase>crap</phrase></keyword>
        <keyword><phrase>hate</phrase></keyword>
        <keyword><phrase>squash th\\w+ snail</phrase></keyword>
        <keyword><phrase>I('m| am) driving the car while reading a book</phrase></keyword>
        <keyword><phrase>playing games at work</phrase></keyword>
      </records>
    </keywords>
    XML


    @kef = KeywordFilter.new(xml)

    def filter(raw_s)

      r = @kef.filter(raw_s)

      if r.is_a? String then
       'publish to twitter: ' + raw_s
      else
       'log it as private: ' + r.to_s[6..-8]
      end

    end

    puts filter("it is a sunny afternoon")
    #=> publish to twitter: it is a sunny afternoon

    puts filter("it is a crap afternoon")
    #=> log it as private: it is a <f>crap</f> afternoon

The keyword-filter gem arose from the need for a self censorship service when micro-blogging.

Resources: 
* <a href="https://github.com/jrobertson/keyword-filter">jrobertson's keyword-filter at master</a> [github.com]

