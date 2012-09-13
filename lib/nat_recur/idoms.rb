module NatRecur
  module Idioms
    # Public: A list of nubmer ordinals
    Ordinals = {
      /first/       => '1st',
      /second/      => '2nd',
      /third/       => '3rd',
      /fourth/      => '4th',
      /fifth/       => '5th',
      /sixth/       => '6th',
      /seventh/     => '7th',
      /eighth/      => '8th',
      /ninth/       => '9th',
      /tenth/       => '10th',
      /eleventh/    => '11th',
      /twelfth/     => '12th',
      /thirteenth/  => '13th',
      /fourteenth/  => '14th',
      /fifteenth/   => '15th',
      /sixteenth/   => '16th',
      /seventeenth/ => '17th',
      /eighteenth/  => '18th',
      /nineteenth/  => '19th',
      /twentieth/   => '20th',
      /thirtieth/   => '30th',
    }

    # Public: A list of the weekdays and their common misspellings
    Weekdays = {
      /\bm[ou]n(day)?\b/          => :monday,
      /\bt(ue|eu|oo|u|)s(day)?\b/ => :tuesday,
      /\btue\b/                   => :tuesday,
      /\bwe(dnes|nds|nns)day\b/   => :wednesday,
      /\bwed\b/                   => :wednesday,
      /\bth(urs|ers)day\b/        => :thursday,
      /\bthu\b/                   => :thursday,
      /\bfr[iy](day)?\b/          => :friday,
      /\bsat(t?[ue]rday)?\b/      => :saturday,
      /\bsu[nm](day)?\b/          => :sunday,
    }

    # Public: A list of months and their abbreviations
    Months = {
      /\bjan\.?(uary)?\b/i        => 1,
      /\bfeb\.?(ruary)?\b/i       => 2,
      /\bmar\.?(ch)?\b/i          => 3,
      /\bapr\.?(il)?\b/i          => 4,
      /\bmay\b/i                  => 5,
      /\bjun\.?e?\b/i             => 6,
      /\bjul\.?y?\b/i             => 7,
      /\baug\.?(ust)?\b/i         => 8,
      /\bsep\.?(t\.?|tember)?\b/i => 9,
      /\boct\.?(ober)?\b/i        => 10,
      /\bnov\.?(ember)?\b/i       => 11,
      /\bdec\.?(ember)?\b/i       => 12,
    }

    # Public: A list of recurrence units and their values
    RecurrenceUnits = {
      /hour(ly)?/  => 1.hour,
      /day?(ily)?/ => 1.day,
      /week(ly)?/  => 1.week,
      /month(ly)?/ => 1.month,
      /year(ly)?/  => 1.year,
    }

    # Public: A list of Holidays to look for
    Holidays = {
      /\bnew\syear'?s?(\s)?(day)?\b/              => "january 1 => #{next_appropriate_year(1 => 1)}"
      /\bnew\syear'?s?(\s)?(eve)?\b/              => "december 31 => #{next_appropriate_year(12 => 31)}"
      /\bm(artin\s)?l(uther\s)?k(ing)?(\sday)?\b/ => 'third monday in january'
      /\binauguration(\sday)?\b/                  => 'january 20'
      /\bpresident'?s?(\sday)?\b/                 => 'third monday in february'
      /\bmemorial\sday\b/                         => '4th monday of may'
      /\bindepend(e|a)nce\sday\b/                 => "july 4 => #{next_appropriate_year(7 => 4)}"
      /\blabor\sday\b/                            => 'first monday in september'
      /\bcolumbus\sday\b/                         => 'second monday in october'
      /\bveterans?\sday\b/                        => "november 11 => #{next_appropriate_year(11 => 1)}"
      /\bthanksgiving(\sday)?\b/                  => 'fourth thursday in november'
      /\bchristmas\seve\b/                        => "december 24 => #{next_appropriate_year(12 => 24)}"
      /\bchristmas(\sday)?\b/                     => "december 25 => #{next_appropriate_year(12 => 25)}"
      /\bsuper\sbowl(\ssunday)?\b/                => 'first sunday in february'
      /\bgroundhog(\sday)?\b/                     => "february 2 => #{next_appropriate_year(2 => 2)}"
      /\bvalentine'?s?(\sday)?\b/                 => "february 14 => #{next_appropriate_year(2 => 14)}"
      /\bs(ain)?t\spatrick'?s?(\sday)?\b/         => "march 17 => #{next_appropriate_year(3 => 17)}"
      /\bapril\sfool'?s?(\sday)?\b/               => "april 1 => #{next_appropriate_year(4 => 1)}"
      /\bearth\sday\b/                            => "april 22 => #{next_appropriate_year(4 => 22)}"
      /\barbor\sday\b/                            => 'fourth friday in april'
      /\bcinco\sde\smayo\b/                       => "may 5 => #{next_appropriate_year(5 => 5)}"
      /\bmother'?s?\sday\b/                       => 'second sunday in may'
      /\bflag\sday\b/                             => "june 14 => #{next_appropriate_year(6 => 14)}"
      /\bfather'?s?\sday\b/                       => 'third sunday in june'
      /\bhalloween\b/                             => "october 31 => #{next_appropriate_year(10 => 31)}"
      /\belection\sday\b/                         => 'second tuesday in november'
      /\bkwanzaa\b/                               => "january 1 => #{next_appropriate_year(1 => 1)}"
    }
  end
end

      