require 'spec_helper'

describe "Parser.parse_recurrence" do
  describe "with an 'every' specified recurrence" do

    @idiom_strings = {
      'hourly'      => 1.hour,
      'daily'       => 1.day,
      'weekly'      => 1.week,
      'monthly'     => 1.month,
      'yearly'      => 1.year,
    }
    @every_strings = {
      'every hour'  => 1.hour,
      'every day'   => 1.day,
      'every week'  => 1.week,
      'every month' => 1.month,
      'every year'  => 1.year,
    }
    @each_strings = {
      'each hour'   => 1.hour,
      'each day'    => 1.day,
      'each week'   => 1.week,
      'each month'  => 1.month,
      'each year'   => 1.year,
    }
    @weekday_strings = Date::DAYNAMES.map {|name| {"every #{name}" => 1.week}}.inject(&:merge)
    @month_strings = Date::MONTHNAMES.compact.map {|name| {"every #{name}" => 1.month}}.inject(&:merge)
    @all_strings = @idiom_strings.merge(@each_strings).merge(@every_strings)

    @all_strings.each do |expression, recurrence|
      it "should properly parse '#{expression.titlecase}'" do
        NatRecur::Parser.new(expression).parse_recurrence.should == recurrence
      end
    end

    (@weekday_strings.merge(@month_strings)).each do |expression, recurrence|
      it "should properly parse '#{expression.titlecase}'" do
        parser = NatRecur::Parser.new(expression)
        parser.parse_recurrence.should == recurrence
        parser.found_new_start_at.should be
        just_weekday = expression.gsub(/every\s*/, '')
      end
    end
  end
end