module NatRecur

  # This class provides several utility methods for dealing with
  # time's natural language.
  class Parser

    
    
    START_WORDS = %w(start begin commence)
    UNTIL_WORDS = %w(close conclude conclud end finish stop stopp quit quitt until)
    RECUR_WORDS = %w(recur repeat every)
    MATCHABLES = START_WORDS + UNTIL_WORDS + RECUR_WORDS + ['$']

    # Used to match and find the 'start' part of the string
    START_REGEX = /(?:#{START_WORDS.join('|')})(?:s|ed|ing|\-date)?\s*   # Match the word start with some ending
                    (\w+[\s\w]+?)                             # Match the time clause
                    (?:#{(MATCHABLES-START_WORDS).join('|')})   # The end of the start section, by end of string or otherwise
                  /ix
    UNTIL_REGEX = /(?:#{UNTIL_WORDS.join('|')})(?:s|ed|ing|\-date)?\s*   # Match the word start with some ending
                    (\w+[\s\w]+?)                             # Match the time clause
                    (?:#{(MATCHABLES-UNTIL_WORDS).join('|')})   # The end of the start section, by end of string or otherwise
                  /ix
    RECUR_REGEX = /repeat(ing|ed|s)|every/

    class << self

      # From a given natural language string, should pull out the given time
      # If there isn't one, it should return nil
      # == Parameters
      # text::
      #   A natural language time recurrence string
      # 
      # == Examples
      # Parser.find_start_time 'tomorrow' #=> nil
      # Parser.find_start_time 'start tomorrow' == Chronic.parse('tomorrow') #=> true
      # Parser.find_start_time 'beginning tomorrow' == Chronic.parse('tomorrow') #=> true
      # Parser.find_until_time 'next year' #=> nil
      #
      # See specs for more examples
      %w(start until).each do |matcher|
        define_method("find_#{matcher}_time") do |text|
          if matches = const_get("#{matcher.upcase}_REGEX").match(text)
            if matches[1]
              return Chronic.parse(clean_time_text(matches[1]))
            end
          end
        end
      end

      private
      # Remove all extraneous symbols, words, and nonsense
      # from a natural language time string
      def clean_time_text text
        text.gsub(/\bat\b/i, '').
          gsub(/[\,\@\"\'\/\-\.]/, '')
      end
    end
  end
end