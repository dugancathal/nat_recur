module NatRecur

  # This class provides several utility methods for dealing with
  # time's natural language.
  class Parser

    
    # Public: A Recurrence vocabulary
    START_WORDS = %w(start begin commence)
    UNTIL_WORDS = %w(close conclude conclud end finish stop stopp quit quitt until)
    RECUR_WORDS = %w(recur recurr repeat)
    MATCHABLES = START_WORDS + UNTIL_WORDS + RECUR_WORDS + %w(each every $)

    # Public: Used to match and find the 'start' part of the string
    START_REGEX = /(?<whole_match>(?:#{START_WORDS.join('|')})(?:s|ed|ing|\-date)?\s*   # Match the word start with some ending
                      (\w+[\s\w]+?))                             # Match the time clause
                      (?:#{(MATCHABLES-START_WORDS).join('|')})   # The end of the start section, by end of string or otherwise
                  /ix
    UNTIL_REGEX = /(?<whole_match>(?:#{UNTIL_WORDS.join('|')})(?:s|ed|ing|\-date)?\s*   # Match the word start with some ending
                      (\w+[\s\w]+?))                             # Match the time clause
                    (?:#{(MATCHABLES-UNTIL_WORDS).join('|')})   # The end of the start section, by end of string or otherwise
                  /ix
    RECUR_REGEX = /(?<whole_match>(?:(?:#{RECUR_WORDS.join('|')})(?:s|ed|ing|\-date)?)?\s*   # Match the word start with some ending
                      (?:every|each)\s+(\w+((\s\w)+)?))           # Match the time clause
                      (?:#{(MATCHABLES-RECUR_WORDS).join('|')})   # The end of the start section, by end of string or otherwise
                  /ix

    CHRONIC_DATE_REGEX = //

    def initialize text
      @starting_point = @parseable = text

    end

    # Public: From a given natural language string, should pull out the given time
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
      define_method("find_#{matcher}_time") do |*args|
        text = args.first || @parseable
        return nil if text.blank?
        if matches = self.class.const_get("#{matcher.upcase}_REGEX").match(text)
          if matches[1]
            @parseable = text.gsub matches[:whole_match], ''
            return Chronic.parse(clean_time_text(matches[1]))
          end
        end
      end
    end

    # Public: For a given natural language string, should pull out the
    # recurrence information.
    # 
    # Currently, this only supports "every", "each", and some basic idioms.
    #
    # text - A natural language time recurrence string
    #
    # Examples
    #
    #   parse_recurrence "hourly" #=> 1.hour
    #   parse_recurrence "daily"  #=> 1.day
    #   parse_recurrence "every day" #=> 1.year
    #   parse_recurrence "every other day" #=> 2.days
    #
    # Returns an integer or nil if nothing was found
    def parse_recurrence text = @parseable
      return nil if text.blank?
      
      # These are the easy ones to check for
      matched = nil
      matched = search_recurrence_units_for(text)
      
      if !matched && (matches = RECUR_REGEX.match(text))
        if matches[1]
          matched = search_weekdays_for matches[1]
        end
      end
      matched
    end

    private
    # Internal: Remove all extraneous symbols, words, and nonsense
    # from a natural language time string
    def clean_time_text text
      text.gsub(/\bat\b/i, '').
        gsub(/[\,\@\"\'\/\-\.]/, '')
    end

    # Internal: Search through the RecurrenceUnits
    def search_recurrence_units_for text
      Idioms::RecurrenceUnits.find(lambda{return []}) do |unit, result|
        unit =~ text
      end.last
    end

    def search_weekdays_for text
      Idioms::Weekdays.find(lambda{return []}) do |day, result|
        day =~ text
      end.last
    end
  end
end