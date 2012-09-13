describe "Parser.find_until_time" do
  # These do specify a until_time
  @proper_test_strings = [
    "until one year from today",
    "ending one year from today",
    "ends one year from today",
    "closes one year from today",
    "concluding one year from today",
    "quitting one year from today every 5th of May",
    "stopping one year from today recur every 5th of May",
    "stops one year from today repeat every 5th of May",
    "repeating 5th of May ending one year from today",
    "recurring the 5th of May quits one year from today",
    "repeating on the 5th of May finishing one year from today",
    "recur every 5th of May finish one year from today",
  ]

  # These do not specify a until_time
  @improper_test_strings = [
    "one year from today",
    "recur every 12 hours",
    "repeating every day start one week from today",
    "yesterday",
    "next month",
  ]

  @proper_test_strings.each do |string|
    it "should properly parse '#{string.titlecase}'" do
      one_year_from_today = Chronic.parse('one year from today')
      NatRecur::Parser.find_until_time(string).should == one_year_from_today
    end
  end

  @improper_test_strings.each do |string|
    it "should return nil for '#{string.titlecase}'" do
      NatRecur::Parser.find_until_time(string).should be_nil
    end
  end
end