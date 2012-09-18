require 'spec_helper'

describe 'Recurrence.validate' do
  it 'should return nil if it cannot parse the recurrence time' do
    recurrence = NatRecur::Recurrence.validate 'yesterday'
    recurrence.should be_nil
  end

  it "should return a truthy value if it can parse the recurrence time" do
    recurrence = NatRecur::Recurrence.validate 'every day'
    recurrence.should be
  end
end