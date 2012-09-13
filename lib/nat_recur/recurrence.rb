module NatRecur

  # A class to hold and manage recurrences.
  # Accepts a string and builds a recurrence object off of that
  class Recurrence
    attr_reader :expression, :start_at, :recur_until
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
      @expression = expression
      @start_at = Parser.find_start_time(@expression)
      @recur_until = Parser.find_until_time(@expression)

      @start_at ||= Time.now
      @recur_until ||= nil
      @recurrence_amount = 1.day
    end

    def next
      @start_at + @recurrence_amount
    end
  end
end