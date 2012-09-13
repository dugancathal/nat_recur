describe "Parser.find_start_time" do
  @test_strings = [
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

  @test_strings.each do |string|
    it "should properly parse '#{string.titlecase}'" do
      tomorrow = Chronic.parse('tomorrow')
      NatRecur::Parser.find_start_time(string).should == tomorrow
    end
  end
end