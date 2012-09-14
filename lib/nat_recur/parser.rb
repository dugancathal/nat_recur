module NatRecur

  # This class provides several utility methods for dealing with
  # time's natural language.
  class Parser
    attr_reader :found_new_start_at, :new_start_at
    
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
      @found_new_start_at = false
      @new_start_at = nil
    end

    def start_at;    @_start_at    || Time.now; end
    def recur_until; @_recur_until || nil;      end
    def recurrence_amount;    @_recurrence_amount || 1.day; end

    # Public: From a given natural language string, should pull out the start time
    # If there isn't one, it should return nil
    # == Parameters
    # text::
    #   A natural language time recurrence string
    # 
    # == Examples
    # Parser.find_start_time 'tomorrow' #=> nil
    # Parser.find_start_time 'start tomorrow' == Chronic.parse('tomorrow') #=> true
    # Parser.find_start_time 'beginning tomorrow' == Chronic.parse('tomorrow') #=> true
    #
    # See specs for more examples
    #
    # Returns the start_time found or nil
    def find_start_time text = @parseable
      return nil if text.blank?
      if matches = START_REGEX.match(text)
        if matches[1]
          @parseable = text.gsub matches[:whole_match], ''
          return @_start_at = Chronic.parse(clean_time_text(matches[1]))
        end
      end
    end

    # Public: From a given natural language string, should pull out the until time
    # If there isn't one, it should return nil
    # 
    # 
    def find_until_time text = @parseable
      return nil if text.blank?
      if matches = UNTIL_REGEX.match(text)
        if matches[1]
          @parseable = text.gsub matches[:whole_match], ''
          return @_recur_until = Chronic.parse(clean_time_text(matches[1]))
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
      @_recurrence_amount = search_recurrence_units_for(text)
      
      if !@_recurrence_amount && (matches = RECUR_REGEX.match(text))
        if matches[1]
          @_recurrence_amount = search_weekdays_for matches[1]
        end
      end
      @_recurrence_amount
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

    # Internal: Search through and return a matched weekday
    # If one is found, the date should be reset for the recurrence
    def search_weekdays_for text
      found = Idioms::Weekdays.find(lambda{return []}) do |day, result|
        day =~ text
      end
      
      if @found_new_start_at = found.last
        @new_start_at = Chronic.parse($1)
      end
      found.last
    end
  end
end