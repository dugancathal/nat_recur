describe "Parser.find_start_time" do
  # These do specify a start_time
  @proper_test_strings = [
    "start tomorrow",
    "starting tomorrow",
    "starts tomorrow",
    "begin tomorrow",
    "beginning tomorrow",
    "starting tomorrow every 5th of May",
    "start tomorrow recur every 5th of May",
    "starts tomorrow repeat every 5th of May",
    "every 5th of May starting tomorrow",
    "recurring the 5th of May starts tomorrow",
    "repeating on the 5th of May start tomorrow",
    "recur every 5th of May beginning tomorrow",
  ]

  # These do not specify a start_time
  @improper_test_strings = [
    "tomorrow",
    "recur every 12 hours",
    "repeating every day until one week from today",
    "yesterday",
    "next month",
  ]

  @proper_test_strings.each do |string|
    it "should properly parse '#{string.titlecase}'" do
      tomorrow = Chronic.parse('tomorrow')
      NatRecur::Parser.find_start_time(string).should == tomorrow
    end
  end

  @improper_test_strings.each do |string|
    it "should return nil for '#{string.titlecase}'" do
      NatRecur::Parser.find_start_time(string).should be_nil
    end
  end
end