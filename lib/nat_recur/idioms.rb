module NatRecur
  module Idioms

    # Internal: Gets the approriate year for the given month and day
    # Suppose that we want the NEXT MLK day, then we need to make sure
    # it hasn't already happened
    #
    # Returns the next appropriate year (integer)
    def Idioms.appropriate_year month, day
      this_year = Date.today.year
      if Date.new(this_year, month, day) > Date.today
        this_year
      else
        this_year + 1
      end
    end

    # Public: A list of nubmer ordinals
    Ordinals = {
      /first/i       => '1st',
      /second/i      => '2nd',
      /third/i       => '3rd',
      /fourth/i      => '4th',
      /fifth/i       => '5th',
      /sixth/i       => '6th',
      /seventh/i     => '7th',
      /eighth/i      => '8th',
      /ninth/i       => '9th',
      /tenth/i       => '10th',
      /eleventh/i    => '11th',
      /twelfth/i     => '12th',
      /thirteenth/i  => '13th',
      /fourteenth/i  => '14th',
      /fifteenth/i   => '15th',
      /sixteenth/i   => '16th',
      /seventeenth/i => '17th',
      /eighteenth/i  => '18th',
      /nineteenth/i  => '19th',
      /twentieth/i   => '20th',
      /thirtieth/i   => '30th',
    }

    # Public: A list of the weekdays and their common misspellings
    Weekdays = {
      /\b(m[ou]n(day)?)\b/i          => 1.week,
      /\b(t(ue|eu|oo|u|)s(day)?)\b/i => 1.week,
      /\b(tue)\b/i                   => 1.week,
      /\b(we(dnes|nds|nns)day)\b/i   => 1.week,
      /\b(wed)\b/i                   => 1.week,
      /\b(th(urs|ers)day)\b/i        => 1.week,
      /\b(thu)\b/i                   => 1.week,
      /\b(fr[iy](day)?)\b/i          => 1.week,
      /\b(sat(t?[ue]rday)?)\b/i      => 1.week,
      /\b(sun(day)?)\b/i             => 1.week,
    }

    # Public: A list of months and their abbreviations
    Months = {
      /\b(jan\.?(uary)?)\b/i        => 1.month,
      /\b(feb\.?(ruary)?)\b/i       => 1.month,
      /\b(mar\.?(ch)?)\b/i          => 1.month,
      /\b(apr\.?(il)?)\b/i          => 1.month,
      /\b(may)\b/i                  => 1.month,
      /\b(jun\.?e?)\b/i             => 1.month,
      /\b(jul\.?y?)\b/i             => 1.month,
      /\b(aug\.?(ust)?)\b/i         => 1.month,
      /\b(sep\.?(t\.?|tember)?)\b/i => 1.month,
      /\b(oct\.?(ober)?)\b/i        => 1.month,
      /\b(nov\.?(ember)?)\b/i       => 1.month,
      /\b(dec\.?(ember)?)\b/i       => 1.month,
    }

    # Public: A list of recurrence units and their values
    RecurrenceUnits = {
      /\b(hour(ly)?)\b/i  => 1.hour,
      /\b(day?(ily)?)\b/i => 1.day,
      /\b(week(ly)?)\b/i  => 1.week,
      /\b(month(ly)?)\b/i => 1.month,
      /\b(year(ly)?)\b/i  => 1.year,
    }

    # Public: A list of Holidays to look for
    Holidays = {
      /\bnew\syear'?s?(\s)?(day)?\b/i              => "january 1, #{Idioms.appropriate_year(1, 1)}",
      /\bnew\syear'?s?(\s)?(eve)?\b/i              => "december 31, #{Idioms.appropriate_year(12, 31)}",
      /\bm(artin\s)?l(uther\s)?k(ing)?(\sday)?\b/i => 'third monday in january',
      /\binauguration(\sday)?\b/i                  => 'january 20',
      /\bpresident'?s?(\sday)?\b/i                 => 'third monday in february',
      /\bmemorial\sday\b/i                         => '4th monday of may',
      /\bindepend(e|a)nce\sday\b/i                 => "july 4, #{Idioms.appropriate_year(7, 4)}",
      /\blabor\sday\b/i                            => 'first monday in september',
      /\bcolumbus\sday\b/i                         => 'second monday in october',
      /\bveterans?\sday\b/i                        => "november 11, #{Idioms.appropriate_year(11, 1)}",
      /\bthanksgiving(\sday)?\b/i                  => 'fourth thursday in november',
      /\bchristmas\seve\b/i                        => "december 24, #{Idioms.appropriate_year(12, 24)}",
      /\bchristmas(\sday)?\b/i                     => "december 25, #{Idioms.appropriate_year(12, 25)}",
      /\bsuper\sbowl(\ssunday)?\b/i                => 'first sunday in february',
      /\bgroundhog(\sday)?\b/i                     => "february 2, #{Idioms.appropriate_year(2, 2)}",
      /\bvalentine'?s?(\sday)?\b/i                 => "february 14, #{Idioms.appropriate_year(2, 14)}",
      /\bs(ain)?t\spatrick'?s?(\sday)?\b/i         => "march 17, #{Idioms.appropriate_year(3, 17)}",
      /\bapril\sfool'?s?(\sday)?\b/i               => "april 1, #{Idioms.appropriate_year(4, 1)}",
      /\bearth\sday\b/i                            => "april 22, #{Idioms.appropriate_year(4, 22)}",
      /\barbor\sday\b/i                            => 'fourth friday in april',
      /\bcinco\sde\smayo\b/i                       => "may 5, #{Idioms.appropriate_year(5, 5)}",
      /\bmother'?s?\sday\b/i                       => 'second sunday in may',
      /\bflag\sday\b/i                             => "june 14, #{Idioms.appropriate_year(6, 14)}",
      /\bfather'?s?\sday\b/i                       => 'third sunday in june',
      /\bhalloween\b/i                             => "october 31, #{Idioms.appropriate_year(10, 31)}",
      /\belection\sday\b/i                         => 'second tuesday in november',
      /\bkwanzaa\b/i                               => "january 1, #{Idioms.appropriate_year(1, 1)}",
    } 
  end
end