require 'spec_helper'

describe "NatRecur::Recurrence.new" do
  describe "with no arguments" do
    before(:each) do
      @recurrence = NatRecur::Recurrence.new
    end

    it "should respond to recur, start_at, recur_until, expression" do
      [:recur, :start_at, :recur_until, :expression].each do |method|
        @recurrence.should respond_to(method)
      end
    end

    it "should set #start_at to now" do
      @recurrence.start_at.should == Time.now
    end

    it "should set #recur to one day from now" do
      @recurrence.recur.should == (Time.now+1.day)
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

  describe "with a valid until time" do
    before(:all) do
      @recurrence = NatRecur::Recurrence.new "ending one week from tuesday"
    end

    it "should set @recur_until accordingly" do
      @recurrence.recur_until.should == Chronic.parse("one week from tuesday")
    end
  end

  it "should raise ArgumentError if the argument is not a string" do
    lambda{NatRecur::Recurrence.new(42)}.should raise_exception(ArgumentError)
  end

  shared_examples_for "recur and recur!" do
    it "should return the next iteration" do
      recurrence = NatRecur::Recurrence.new "every day starting tomorrow"
      recurrence.recur.should == (Chronic.parse('tomorrow') + 1.day)
    end

    it "should accept an integer and give that many iterations" do
      recurrence = NatRecur::Recurrence.new 'every week starting tomorrow'
      recurrence.recur(2).should == (Chronic.parse('tomorrow') + 2.weeks)
    end
  end

  describe "#recur" do
    it_behaves_like "recur and recur!"
    it "should NOT change the @current_date" do
      recurrence = NatRecur::Recurrence.new 'every week starting tomorrow'
      recurrence.recur 2
      recurrence.current_date.should == recurrence.start_at
    end
  end

  describe "#recur!" do
    it_behaves_like "recur and recur!"
    it "should change the @current_date" do
      recurrence = NatRecur::Recurrence.new 'every week starting tomorrow'
      recurrence.recur! 2
      recurrence.current_date.should == (Chronic.parse('tomorrow') + 2.weeks)
    end
  end
end