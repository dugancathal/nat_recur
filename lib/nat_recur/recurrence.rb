module NatRecur

  # A class to hold and manage recurrences.
  # Accepts a string and builds a recurrence object off of that
  class Recurrence
    attr_reader :expression, :current_date
    # Public: Initialization method - primary entry point into the API
    #
    # expression - a natural language string corresponding to 
    #              * a start date
    #              * a recurrence time
    #              * an until date
    #          
    #              Any or all of these can be left out and have set defaults
    #              * Start Date #=> now
    #              * Recurrence time #=> 1.day
    #              * Until Time #=> never OR nil
    #              This basically corresponds to the language:
    #                'every 1 day starting now'
    #                'daily', 'daily starting now'
    #
    # Returns A Recurrence object
    def initialize expression = "now"
      raise ArgumentError unless expression.is_a? String
      @expression = parseable = expression
      parseable = translate_holidays(parseable)
      
      @parser = Parser.new parseable
      @parser.find_start_time
      @parser.find_until_time
      @parser.parse_recurrence
      @current_date = @parser.start_at
    end

    # Public: Gets the next iteration of the recurrence
    #
    # i - a Fixnum or Bignum that specifies the amount to increment by
    #
    # Returns a Date/Time object specifying the next occurrence
    def recur i = 1
      @current_date + (i * recurrence_amount)
    end

    # Public: changes the current_date parameter to be
    # start_at + (i*recurrence_amount) such that additional calls
    # to #recur or #recur! will use that date
    #
    # i - a Fixnum or Bignum that specifies the amount to increment by
    #
    # Returns a Date/Time object specifying the next occurrence
    def recur! i = 1
      @current_date = recur i
    end


    # Public: The day the recurrence starts
    delegate :start_at, to: :@parser
    
    # Public: The day it recurs until
    delegate :recur_until, to: :@parser

    # Public: The amount it increments by
    delegate :recurrence_amount, to: :@parser

    private

    # Internal: substitutes holiday names with their Chronic interpretation
    def translate_holidays text
      Idioms::Holidays.each do |holiday, chronic_name|
        text.gsub! holiday, chronic_name
      end
      text
    end
  end
end