require 'spec_helper'

describe "NatRecur::Recurrence.new" do
  describe "with no arguments" do
    before(:each) do
      @recurrence = NatRecur::Recurrence.new
    end

    it "should respond to next, start_at, recur_until, expression" do
      [:next, :start_at, :recur_until, :expression].each do |method|
        @recurrence.should respond_to(method)
      end
    end

    it "should set #start_at to now" do
      @recurrence.start_at.should == Time.now
    end

    it "should set #next to one day from now" do
      @recurrence.next.should == (Time.now+1.day)
    end

    it "should set #recur_until to nil" do
      @recurrence.recur_until.should be_nil
    end

    it "should set #expression to 'now'" do
      @recurrence.expression.should == 'now'
    end
  end

  describe "with a valid start time" do
    before(:all) do
      @recurrence = NatRecur::Recurrence.new "starting tomorrow"
    end

    it "should set @start_at accordingly" do
      @recurrence.start_at.should == Chronic.parse('tomorrow')
    end
  end

  it "should raise ArgumentError if the argument is not a string" do
    lambda{NatRecur::Recurrence.new(42)}.should raise_exception(ArgumentError)
  end
end