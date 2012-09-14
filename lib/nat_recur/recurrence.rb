module NatRecur

  # A class to hold and manage recurrences.
  # Accepts a string and builds a recurrence object off of that
  class Recurrence
    attr_reader :expression
    # Initialization method
    #
    # == Parameters 
    # expression::
    #    should be a natural language string corresponding to 
    #    * a start date
    #    * a recurrence time
    #    * an until date
    #
    #    Any or all of these can be left out and have set defaults
    #    * Start Date #=> now
    #    * Recurrence time #=> 1.day
    #    * Until Time #=> never OR nil
    #    This basically corresponds to the language:
    #      'every 1 day starting now'
    #      'daily', 'daily starting now'
    #
    # == Returns
    # A Recurrence object
    #  
    # == Examples
    def initialize expression = "now"
      raise ArgumentError unless expression.is_a? String
      @expression = parseable = expression
      parseable = translate_holidays(parseable)
      
      @parser = Parser.new parseable
      @start_at = @parser.find_start_time
      @recur_until = @parser.find_until_time
      @recurrence_amount = @parser.parse_recurrence
      if @parser.found_new_start_at
        #@start_at = @parser.new_start_at
      end

      
    end

    def next
      start_at + recurrence_amount
    end

    delegate :start_at, to: :@parser
    delegate :recur_until, to: :@parser
    delegate :recurrence_amount, to: :@parser

    def translate_holidays text
      Idioms::Holidays.each do |holiday, chronic_name|
        text.gsub! holiday, chronic_name
      end
      text
    end
  end
end