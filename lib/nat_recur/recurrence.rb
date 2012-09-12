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
    #
    # == Returns
    # A Recurrence object
    #  
    # == Examples
    #
    # NatRecur::Recurrence.new #=> <#Nat 
    def initialize expression = "now"
      @expression = "now"
      @start_at = Time.now
      @recurrence_amount = 1.day
      @recur_until = nil
    end

    def next
      @start_at + @recurrence_amount
    end
  end
end