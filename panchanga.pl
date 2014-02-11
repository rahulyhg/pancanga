#!/usr/bin/perl
use strict;
use warnings;

# Version 3.20040205
#{:::::::::::::::::::::::::::}
# {addition in perl version}

my $true  = 1;
my $false = 0;

my $variabledeclaration = $true;

my $pancanga_as_sub = $true;

sub numeric_p {
    # Checks whether argument isNumeric - math.isNumber - HP
    my ($data) = @_;

    if ( $data =~ /^-?\d*\.?\d*(e\d|e-\d)?\d*$/ ) {
        $true;
    }
    else {
        $false;
    }
}

sub int_p {
    # Checks whether argument is an integer - math.isInt - HP
    my ($data) = @_;

    if ( ( &numeric_p($data) && ( int($data) == $data ) ) ) {
        $true;
    }
    else {
        $false;
    }
}

sub trunc {
    # Truncates the number towards 0  for numbers - for non-numbers returns 0 - math.truncate - HP
    my ($x) = @_;

    int($x);
}

sub floor {
    # Standard floor implementation - math.floor - HP
    my ($x) = @_;

    my ($y);

    $y = int($x);
    if ( $x < $y ) {
        $y - 1;
    }
    else {
        $y;
    }
}

sub frac {
    # Returns the fraction part of the real number - math.fractional - HP
    my ($x) = @_;

    $x - int($x);
}

sub round {
    # Standard round implementation - math.round - HP
    my ($x) = @_;

    &floor( $x + 0.5 );
}

sub sqr {
    # Squaring function - math.square - HP
    my ($x) = @_;

    $x * $x;
}

# arctan(x) --> atan2(x,1)

#{:::::::::::::::::::::::::::}
# { mathematical constants }

my $pi  = atan2( 1, 1 ) * 4;   # Math.PI constant - HP
# $pi2 = $pi * 2;
my $rad = 180 / $pi;

# {for function arcsin}
my $eps = 1e-6;

# {for calcuration cut off}
# in perl; precision changed
my $epsiron = 1e-8;

#{:::::::::::::::::::::::::::}
# { settings }

my $with_bija_pf = $false;

#    $loc_lat       = 28.6;          # {Delhi}#20011114
my $Ujjaini_lat = 23.2;            # {Ujjaini}#20020304
my $loc_lat     = $Ujjaini_lat;    #20020304
my $Ujjaini_lon = 75.8;            # {Ujjaini}#20011114#20020320
my $loc_lon     = $Ujjaini_lon;    #20020304
my $yearmax     = 3000;

#{:::::::::::::::::::::::::::}
# {planets}
#    type  planets       = (Star,
#                           Sun, Moon, Mercury, Venus, Mars, Jupiter, Saturn,
#                           Candrocca, Rahu);
my %planet_name = (
    'star',      'Star        ', 'sun',     'Sun         ',
    'moon',      'Moon        ', 'mercury', 'Mercury     ',
    'venus',     'Venus       ', 'mars',    'Mars        ',
    'jupiter',   'Jupiter     ', 'saturn',  'Saturn      ',
    'Candrocca', 'Candrocca   ', 'Rahu',    'Rahu        ',
);
my $planet = $variabledeclaration;

# (Star, Sun, Moon, Mercury, Venus, Mars, Jupiter, Saturn, Candrocca, Rahu);
my %YugaRotation;
my %PlanetRotation;
my %PlanetSighra;
my %PlanetMeanPosition;
my %PlanetTruePosition;
my %PlanetApogee;
my %PlanetCircumm;
my %PlanetCircums;

# key == $planet; value == real;

my $YugaCivilDays    = $variabledeclaration;
my $YugaSynodicMonth = $variabledeclaration;
my $YugaAdhimasa     = $variabledeclaration;
my $YugaTithi        = $variabledeclaration;
my $YugaKsayadina    = $variabledeclaration;
my $lagna            = $variabledeclaration;

#{:::::::::::::::::::::::::::}

my $back_clong_ahar  = -1;
my $back_nclong_ahar = -1;
my $back_clong       = -1;
my $back_nclong      = -1;

#    type  paksas                                =(suklapaksa, krsnapaksa);
our $year  = $variabledeclaration;
our $month = $variabledeclaration;
my $paksa = $variabledeclaration;

# (suklapaksa, krsnapaksa);
our $day               = $variabledeclaration;              # {for ahargana}
my $ahar              = $variabledeclaration;              # {for ahargana}
my $ahargana          = $variabledeclaration;
my $hours             = $variabledeclaration;
my $minutes           = $variabledeclaration;
my $JulianDay         = $variabledeclaration;              # {for Julian days}
my $YearKali          = $variabledeclaration;
my $YearSaka          = $variabledeclaration;
my $YearVikrama       = $variabledeclaration;
my $masa_num          = $variabledeclaration;
my $saura_masa        = $variabledeclaration;
my $saura_masa_num    = $variabledeclaration;              ###20000614
my $saura_masa_day    = $variabledeclaration;              ###20001231
my $tithi_day         = $variabledeclaration;
my $mslong            = $variabledeclaration;              # {solar position}
my $tslong            = $variabledeclaration;              # {solar position}
my $mllong            = $variabledeclaration;              # {lunar position}
my $tllong            = $variabledeclaration;              # {lunar position}
my $clong             = $variabledeclaration;
my $nclong            = $variabledeclaration;
my $tithi             = $variabledeclaration;
my $ftithi            = $variabledeclaration;
my $eqtime            = $variabledeclaration;              # {for equation of time}
my $sriseh            = $variabledeclaration;
my $srisem            = $variabledeclaration;
my $weekday_name      = $variabledeclaration;
my $sukla_krsna       = $variabledeclaration;
my $adhimasa          = $variabledeclaration;
my $masa              = $variabledeclaration;
my $naksatra          = $variabledeclaration;
# $Jovian_Year_north = $variabledeclaration;
# $Jovian_Year_south = $variabledeclaration;
my $samkranti         = $variabledeclaration;              ###20010310
my $samkranti_year    = $variabledeclaration;              ###20010310
my $samkranti_month   = $variabledeclaration;              ###20010310
my $samkranti_day     = $variabledeclaration;              ###20010310
my $samkranti_hour    = $variabledeclaration;              ###20010310
my $samkranti_min     = $variabledeclaration;              ###20010310
my $ayanadeg          = $variabledeclaration;              ###20010313
my $ayanamin          = $variabledeclaration;              ###20010313
my $desantara         = ( $loc_lon - $Ujjaini_lon ) / 360; #20011114 time

my $counter = $variabledeclaration;

#{:::::::::::::::::::::::::::}

sub abs {
    # Standard Math.abs function - HP
    my ($x) = @_;

    if ( $x < 0 ) {
        $x * -1;
    }
    else {
        $x;
    }
}

sub zero360 {
    # Looks to be converting negative longitudes to their positive values on a 0-360 quadrant - celestial.zero360 - HP
    my ($longitude) = @_;

    #    $longitude = $longitude - trunc($longitude / 360) * 360;
    # in perl: trunc --> int
    $longitude = $longitude - int( $longitude / 360 ) * 360;
    if ( $longitude < 0 ) {
        $longitude = $longitude + 360;
    }
    $longitude;
}

sub tan {
    # Standard Math.tan implementation - Math.tan - HP
    my ($x) = @_;

    sin($x) / cos($x);
}

sub arcsin {    ###20010316
    # Standard Math.asin implementation - Math.asin - HP
    my ($x) = @_;

    if ( $eps < &abs( 1 - &sqr($x) ) ) {
        atan2( $x / sqrt( 1 - &sqr($x) ), 1 );
    }
    elsif ( 0 < $x ) {    # {x is neary to 1}
        $pi / 2;          # {sin(pi/2)=1}
    }
    else {                # {x is neary to -1}
        3 * $pi / 2;      # {sin(3 pi/2)=-1}
    }
}

sub three_relation {
    # celestial.threeRelation - HP
    my ( $a, $b, $c ) = @_;

    if ( ( $a < $b ) && ( $b < $c ) ) {
        1;
    }
    elsif ( ( $c < $b ) && ( $b < $a ) ) {
        -1;
    }
    else {
        0;
    }
}

#{:::::::::::::::::::::::::::}
# { from one date to another date }

sub next_date {
    # calendar.nextDate - HP
    my ( $year, $month, $day ) = @_;

    $day = $day + 1;
    if ( $month == 2 ) {
        if ( 29 < $day ) {
            $day   = 1;
            $month = $month + 1;

            # ignoring the skipping year !!!
        }
    }
    elsif (( $month == 4 )
        || ( $month == 6 )
        || ( $month == 9 )
        || ( $month == 11 ) )
    {
        if ( 30 < $day ) {
            $day   = 1;
            $month = $month + 1;
        }
    }
    else {
        if ( 31 < $day ) {
            $day   = 1;
            $month = $month + 1;
        }
    }
    if ( 12 < $month ) {
        $month = 1;
        $year  = $year + 1;
    }

    if ( &ModernDate_to_JulianDay( $year, $month, $day ) ==
        &ModernDate_to_JulianDay( $year, $month + 1, 1 ) )
    {
        ( $year, $month + 1, 1 );
    }
    else {
        ( $year, $month, $day );
    }
}

# procedure prec_tithi(var YearSaka, masa_num	:integer;
#                      var paksa			:paksas;
#                      var tithi_day		:integer);
#   begin
#     if tithi_day = 1 then begin
#       tithi_day := 15;
#       if paksa = suklapaksa then begin
#         paksa := krsnapaksa;
#         dec(masa_num);
#         if masa_num < 0 then begin
#           masa_num := 11;
#           dec(YearSaka)
#         end
#       end
#       else paksa := suklapaksa;
#     end
#     else dec(tithi_day);
#   end;

# procedure next_tithi(var YearSaka, masa_num	:integer;
#                      var paksa			:paksas;
#                      var tithi_day		:integer);
#   begin
#     if tithi_day = 15 then begin
#       tithi_day := 1;
#       if paksa = krsnapaksa then begin
#         paksa := suklapaksa;
#         inc(masa_num);
#         if 11 < masa_num then begin
#           masa_num := 0;
#           inc(YearSaka)
#           end
#         end
#       else paksa := krsnapaksa;
#       end
#     else inc(tithi_day);
#   end;

sub ModernDate_to_JulianDay {
    # calendar.gregorianDateToJulianDay - HP
    my ( $year, $month, $day ) = @_;

    my ($julian_day);

    if ( $month < 3 ) {
        $year  = $year - 1;
        $month = $month + 12;
    }

    $julian_day =
      int( 365.25 * $year ) + int( 30.59 * ( $month - 2 ) ) + $day + 1721086.5;
    if ( $year < 0 ) {
        $julian_day = $julian_day - 1;
        if ( ( ( $year % 4 ) == 0 ) && ( 3 <= $month ) ) {
            $julian_day = $julian_day + 1;
        }
    }
    if ( 2299160 < $julian_day ) {
        $julian_day = $julian_day + int( $year / 400 ) - int( $year / 100 ) + 2;
    }

    $julian_day;
}

sub Julian_in_England_p {    ###20030331
    # calendar.julianInEngland - HP
    # Start Comment - HP
    # Gregorian calendar was first introduced in most of Europe in 1582,
    # but it wasn't adopted in England (and so in US and Canada) until 1752
    #
    # - http://www.timeanddate.com/calendar/julian-gregorian-switch.html
    #
    # This function returns true between
    #      October 14th, 1582 and September 14th, 1752, both dates exclusive
    # End Comment - HP
    my ($JulianDay) = @_;

    if ( ( 2299160 < $JulianDay ) && ( $JulianDay <= 2361221 ) ) {
        $true;
    }
    else {
        $false;
    }

}

sub JulianDay_to_JulianDate {    ###20040205
    # calendar.julianDayToJulianDate - HP
    my ($JulianDay) = @_;

    my ( $j, $k, $l, $n, $i, $J, $I );
    my ( $year, $month, $day );

    $j     = int($JulianDay) + 1402;
    $k     = int( ( $j - 1 ) / 1461 );
    $l     = $j - 1461 * $k;
    $n     = int( ( $l - 1 ) / 365 ) - int( $l / 1461 );
    $i     = $l - 365 * $n + 30;
    $J     = int( 80 * $i / 2447 );
    $day   = $i - int( 2447 * $J / 80 );
    $I     = int( $J / 11 );
    $month = $J + 2 - 12 * $I;
    $year  = 4 * $k + $n + $I - 4716;
    ( $year, $month, $day );
}

sub JulianDay_to_GregorianDate {    ###20030331
    # calendar.julianDayToGregorianDate - HP
    my ($JulianDay) = @_;

    my ( $a, $b, $c, $e, $f, $g, $h );
    my ( $year, $month, $day );    ###20010313

    $a = $JulianDay + 68569;
    $b = int( $a / 36524.25 );
    $c = $a - int( 36524.25 * $b + 0.75 );
    $e = int( ( $c + 1 ) / 365.2425 );

    $f   = $c - int( 365.25 * $e ) + 31;
    $g   = int( $f / 30.59 );
    $h   = int( $g / 11 );
    $day = &trunc( $f - int( 30.59 * $g ) + ( $JulianDay - int($JulianDay) ) );
    $month = &trunc( $g - 12 * $h + 2 );
    $year = &trunc( 100 * ( $b - 49 ) + $e + $h );
    ( $year, $month, $day );
}

sub JulianDay_to_ModernDate {    ###20030331
    # calendar.julianDayToModernDate - HP
    my ($JulianDay) = @_;

    my ( $year, $month, $day );

    if ( $JulianDay < 2299239 ) {
        &JulianDay_to_JulianDate($JulianDay);
    }
    else {
        &JulianDay_to_GregorianDate($JulianDay);
    }

}

# killed ###20030331
#sub JulianDay_to_ModernDate {
#    my( $JulianDay) = @_;
#
#    my( $a, $b, $c, $e, $f, $g, $h);
#    my( $year, $month, $day); ###20010313
#
#    if ($JulianDay < 2299239) {
#        $a = int($JulianDay) + 68607;
#        $b = int($a / 36525);
#        $c = $a - int(36525 * $b);
#        $e = int(($c + 1) / 365.25);
#    } else {
#        $a = $JulianDay + 68569;
#        $b = int($a / 36524.25);
#        $c = $a - int(36524.25 * $b + 0.75);
#        $e = int(($c + 1) / 365.2425);
#    }
#
#    $f = $c - int(365.25 * $e) + 31;
#    $g = int($f / 30.59);
#    $h = int($g / 11);
#    $day = &trunc($f - int(30.59 * $g) + ($JulianDay - int($JulianDay)));
#    $month = &trunc($g - 12 * $h + 2);
#    $year = &trunc(100 * ($b - 49) + $e + $h);
#    ($year, $month, $day);
#}

sub JulianDay_to_Ahargana {
    # calendar.julianDayToAhargana - HP

    # {from epoch midnight to given midnight}
    my ($julian_day) = @_;

    $julian_day - 588465.50;
}

sub Ahargana_to_JulianDay {
    # calendar.aharganaToJulianDay - HP
    my ($ahar) = @_;

    588465.50 + $ahar;
}

sub Ahargana_to_Kali {
    # calendar.aharganaToKali - HP
    my ($ahar) = @_;

    # global variables: $YugaRotation{'sun'}, $YugaCivilDays

    &trunc( $ahar * $YugaRotation{'sun'} / $YugaCivilDays );
}

sub Kali_to_Ahargana {
    my ( $YearKali, $masa_num, $tithi_day ) = @_;

# global variables: $YugaAdhimasa, $YugaRotation{'sun'}, $YugaKsayadina, $YugaTithi

    my ( $sm, $cm, $adhim, $avama, $tithi );

    $sm = $YearKali;
    $sm = $sm * 12 + $masa_num;    # {expired saura masas}
    $adhim =
      int( $sm * $YugaAdhimasa / ( 12 * $YugaRotation{'sun'} ) )
      ;                            # {expired adhimasas}
    $cm    = $sm + $adhim;                 # {expired candra masas}
    $tithi = 30 * $cm + $tithi_day - 1;    # {expired tithis}
    $avama = int( $tithi * $YugaKsayadina / $YugaTithi );    # {expired avamas}

    $tithi - $avama;    # {ahargana from Kali epoch to given date}
}

sub Kali_to_Saka {
    # calendar.kaliToSaka - HP
    my ($YearKali) = @_;

    $YearKali - 3179;
}

sub Saka_to_Kali {
    my ($YearSaka) = @_;

    $YearSaka + 3179;
}

#{:::::::::::::::::::::::::::}
# { condition check }

sub adhimasa_p {
    # this puny method has been absorbed into its caller - HP
    my ( $clong, $nclong ) = @_;

    if ( &trunc( $clong / 30 ) == &trunc( $nclong / 30 ) ) {
        $true;
    }
    else {
        $false;
    }
}

#{:::::::::::::::::::::::::::}
#  { INPUT }

sub read_real {
    my ( $message, $min, $max ) = @_;

    my ($number);

    print $message;
    chop( $number = <> );
    if (   ( $number =~ /^$/ )
        || !&numeric_p($number)
        || ( $number < $min )
        || ( $max < $number ) )
    {
        print " Number is not appropriate.\n";
        &read_real( $message, $min, $max );
    }
    else {
        $number;
    }
}

sub read_integer {
    my ( $message, $min, $max ) = @_;

    my ($number);

    print $message;
    chop( $number = <> );
    if (   ( $number =~ /^$/ )
        || !&int_p($number)
        || ( $number < $min )
        || ( $max < $number ) )
    {
        print " Number is not appropriate.\n";
        &read_integer( $message, $min, $max );
    }
    else {
        $number;
    }
}

sub show_map_of_india {

    print " ------------------------------------------------------------ \n";
    print "|                  Latitude                                  |\n";
    print "|                                                            |\n";
    print "|_____                              ______36                 |\n";
    print "|                  *                         Srinagar:34.1   |\n";
    print "|_____                              ______32                 |\n";
    print "|                    *                       Delhi:28.6      |\n";
    print "|_____                         *    ______28 Kathmandu:27.7  |\n";
    print "|                          *                 Varanasi:25.3   |\n";
    print "|_____ ---\\                         ______24 Ujjain:23.2     |\n";
    print "|          \\//      *           *___         Calcutta:22.6   |\n";
    print "|_____       \\_/|             _/~   ~_____20                 |\n";
    print "|               |*          _/               Bombay:19.0      |\n";
    print "|_____           \\     *  _/        ______16 Hyderabad:17.4  |\n";
    print "|                 \\      |                                   |\n";
    print "|_____             \\    *|          ______12 Madras:13.1     |\n";
    print "|                   \\   /                                    |\n";
    print "|_____               \\*/ /\\         ______08 Trivandrum:8.5  |\n";
    print "|                       |* |                 Colombo:6.9     |\n";
    print "|_____                   --         ______04                 |\n";
    print "|                                                            |\n";
    print " ------------------------------------------------------------ \n";

}

sub read_local_latitude {

    &read_real( " Input local latitude in degree = ", -80, 80 );
}

sub show_map_of_india_longitude {    #20011114

    print " ------------------------------------------------------------ \n";
    print "|                  Longitude                                 |\n";
    print "|            |     |     |     |     |                       |\n";
    print "|            |     |     |     |     |                       |\n";
    print "|                  *                         Srinagar:74.8   |\n";
    print "|                                                            |\n";
    print "|                    *                       Delhi:77.2      |\n";
    print "|                              *             Kathmandu:85.2  |\n";
    print "|                          *                 Varanasi:83.0   |\n";
    print "|      ---\\                                  Ujjain:75.8     |\n";
    print "|          \\//      *           *___         Calcutta:88.4   |\n";
    print "|            \\_/|             _/~   ~                        |\n";
    print "|               |*          _/               Bombay:72.8     |\n";
    print "|                \\     *  _/                 Hyderabad:78.5  |\n";
    print "|                 \\      |                                   |\n";
    print "|                  \\    *|                   Madras:80.2     |\n";
    print "|                   \\   /                                    |\n";
    print "|                    \\*/ /\\                  Trivandrum:77.0 |\n";
    print "|                       |* |                 Colombo:79.9    |\n";
    print "|            |     |     --    |     |                       |\n";
    print "|            |     |           |     |                       |\n";
    print "|            70          80          90                      |\n";
    print " ------------------------------------------------------------ \n";

}

sub read_local_longitude {    #20011114

    &read_real( " Input local longitude in degree = ", -180, 180 );
}

sub read_date {

    # global variables: $yearmax

    my ( $year, $month, $day );
    my ($inputdata);

    print " Year  Month  Day = ";
    chop( $inputdata = <> );
    ( $year, $month, $day ) = split( / +/, $inputdata, 3 );

    if (
           !defined($day)
        || !&int_p($year)
        ||

        #        ($year < -$yearmax) ||
        ( $yearmax < $year )
        || !&int_p($month)
        || ( $month < 1 )
        || ( 12 < $month )
        || ( $day < 0 )
        || ( 32 < $day )
      )
    {
        print " Date is not appropriate.\n";
        &read_date;
    }
    elsif (
        &JulianDay_to_Ahargana(
            &ModernDate_to_JulianDay( $year, $month, $day )
        ) < -1
      )
    {

      #        print " The days before the epoc of Kali are not known to us.\n";
        print " Date is not appropriate.\n";
        &read_date;
    }
    else {
        ( $year, $month, $day );
    }
}

sub read_time {

    my ( $hours, $minutes );
    my ($inputdata);

    print " Time in hours and minutes = ";
    chop( $inputdata = <> );
    ( $hours, $minutes ) = split( / +/, $inputdata, 2 );

    if (   !defined($minutes)
        || !&int_p($hours)
        || ( $hours < 0 )
        || ( 24 <= $hours )
        || ( $minutes < 0 )
        || ( 60 <= $minutes ) )
    {
        print " Time is not appropriate.\n";
        &read_time;
    }
    else {
        ( $hours, $minutes );
    }
}

sub read_char {
    my ($message) = @_;

    my ($character);

    print $message;
    chop( $character = <> );
    $character =~ y/a-z/A-Z/;
    $character = substr( $character, 0, 1 );
    $character = $character . " ";
    $character = substr( $character, 0, 1 );

}

sub read_indian_date {

    my ( $saka_year, $vikrama_year, $masa_num, $paksa, $tithi_day );
    my ($paksa_ans);

    print " 0(11).Caitra    1( 0).Vaisakha   2( 1).Jyaistha 3( 2).Asadha\n";
    print " 4( 3).Sravana   5( 4).Bhadrapada 6( 5).Asvina   7( 6).Karttika\n";
    print " 8( 7).Margasira 9( 8).Pausa     10( 9).Magha   11(10).Phalguna\n";

    my $year_ans = &read_char("Saka years or Vikrama years? ...S/V      ");
    while ( $year_ans !~ /[SV]/ ) {
        $year_ans = &read_char("Saka years or Vikrama years? ...S/V      ");
    }
    if ( $year_ans eq "S" ) {
        $saka_year =
          &read_integer( "Saka years expired:                ", 0, $yearmax );
    }
    else {
        $vikrama_year =
          &read_integer( "Vikrama years expired:                ", 0,
            $yearmax );
        $saka_year = $vikrama_year - 135;
    }
    print "If purnimanta and krsna-paksa, enter the number in brackets\n";
    $masa_num = &read_integer( "Enter masa by the number:          ", 0, 11 );
    $paksa_ans = &read_char("Sukla- or Krsnapaksa ? ...s/k      ");
    while ( $paksa_ans !~ /[KS]/ ) {
        $paksa_ans = &read_char("Sukla- or Krsnapaksa ? ...s/k      ");
    }
    if ( $paksa_ans eq "S" ) {
        $paksa = 'Suklapaksa';
    }
    else {
        $paksa = 'Krsnapaksa';
    }
    $tithi_day = &read_integer( "Enter tithi by the number 1 to 15: ", 1, 15 );

    ( $saka_year, $masa_num, $paksa, $tithi_day );
}

#{:::::::::::::::::::::::::::}
# { get names }
sub get_weekday_name {
    # calendar.julianDayToWeekday - HP
    my ($JulianDay) = @_;

    my %weekday_name = (
        0, 'Monday', 1, 'Tuesday',  2, 'Wednesday', 3, 'Thursday',
        4, 'Friday', 5, 'Saturday', 6, 'Sunday'
    );

    $weekday_name{ &trunc( $JulianDay + 0.5 ) % 7 };
}

sub get_sukla_krsna {
    # we don't really need this function - HP
    my ($paksa) = @_;

    $paksa;
}

sub get_adhimasa {
    # calendar.getAdhimasa - HP
    my ( $clong, $nclong ) = @_;

    if ( &adhimasa_p( $clong, $nclong ) ) {
        "Adhika-";
    }
    else {
        "";
    }
}

sub get_masa_name {
    # calendar.getMasaName - HP
    my ($number) = @_;

    my %masa_name = (
        0, 'Caitra    ', 1,  'Vaisakha  ', 2,  'Jyaistha  ',
        3, 'Asadha    ', 4,  'Sravana   ', 5,  'Bhadrapada',
        6, 'Asvina    ', 7,  'Karttika  ', 8,  'Margasirsa',
        9, 'Pausa     ', 10, 'Magha     ', 11, 'Phalguna  '
    );

    $masa_name{$number};
}

sub get_saura_masa_name {    ###20000613
    # calendar.getSauraMasaName - HP
    my ($number) = @_;

    my %saura_masa_name = (
    0, 'Mesa   ', 1, 'Vrsa   ', 2,  'Mithuna', 3,  'Karkata',
    4, 'Simha  ', 5, 'Kanya  ', 6,  'Tula   ', 7,  'Vrscika',
    8, 'Dhanus ', 9, 'Makara ', 10, 'Kumbha ', 11, 'Mina   '
    );

    # For use with Kollavarsham - HP
#    my %saura_masa_name = (
#    0, 'Medam     ', 1, 'Idavam    ', 2,  'Mithunam  ', 3,  'Karkitakam',
#    4, 'Chingam   ', 5, 'Kanni     ', 6,  'Thulam    ', 7,  'Vrischikam',
#    8, 'Dhanu     ', 9, 'Makaram   ', 10, 'Kumbham   ', 11, 'Meenam    '
#    );
#    
    $saura_masa_name{$number};
}

sub get_karana_name {
    my ($tithi) = @_;

    my %karana_name = (
        0, 'kiMstughna', 1,  'bava      ', 2, 'bAlava    ',
        3, 'kaulava   ', 4,  'taitila   ', 5, 'gara      ',
        6, 'vaNij     ', 7,  'viSTi     ', 8, 'zakuni    ',
        9, 'catuSpada ', 10, 'nAga      '
    );
    my ($karana);

    $karana = &trunc( 2 * $tithi );
    if ( $karana == 0 ) {
        $karana_name{0};
    }
    elsif ( $karana < 57 ) {
        $karana = $karana % 7;    ####20000910 few lines modified
        if ( $karana == 0 ) {
            $karana_name{7};
        }
        elsif ( $karana != 0 ) {
            $karana_name{$karana};
        }
    }
    elsif ( $karana == 57 ) {     ####20010409
        $karana_name{8};
    }
    elsif ( $karana == 58 ) {
        $karana_name{9};
    }
    elsif ( $karana == 59 ) {
        $karana_name{10};
    }
}

sub get_yoga_name {
    my ( $tslong, $tllong ) = @_;

    my %yoga_name = (
        0,  'viSkambha',
        1,  'prIti',
        2,  'AyuSmat',
        3,  'saubhAgya',
        4,  'zobhana',
        5,  'atigaNDa',
        6,  'sukarman',
        7,  'dhRti',
        8,  'zUla',
        9,  'gaNDa',       #20010312
        10, 'vRddhi',
        11, 'dhruva',
        12, 'vyAghAta',
        13, 'harSaNa',
        14, 'vajra',
        15, 'siddhi',
        16, 'vyatIpAta',
        17, 'varIyas',
        18, 'parigha',
        19, 'ziva',
        20, 'siddha',
        21, 'sAdhya',
        22, 'zubha',
        23, 'zukla',
        24, 'brahman',
        25, 'aindra',
        26, 'vaidhRti',
        27, 'viSkambha'
    );
    my ( $yoga1, $yoga );

    $yoga1 = &zero360( $tslong + $tllong );
    $yoga  = &trunc( $yoga1 * 27 / 360 );
    $yoga_name{$yoga};
}

sub get_naksatra_name {
    # calendar.getNaksatraName - HP
    my ($tllong) = @_;

    my %naksatra_name = (
    0,  'Asvini',       1,  'Bharani',      2,  'Krttika',
    3,  'Rohini',       4,  'Mrgasira',     5,  'Ardra',
    6,  'Punarvasu',    7,  'Pusya',        8,  'Aslesa',
    9,  'Magha',        10, 'P-phalguni',   11, 'U-phalguni',
    12, 'Hasta',        13, 'Citra',        14, 'Svati',
    15, 'Visakha',      16, 'Anuradha',     17, 'Jyestha',
    18, 'Mula',         19, 'P-asadha',     20, 'U-asadha',
    21, 'Sravana',      22, 'Dhanistha',    23, 'Satabhisaj',
    24, 'P-bhadrapada', 25, 'U-bhadrapada', 26, 'Revati',
    27, 'Asvini'
    );
    
    # For use with Kollavarsham - HP
#    my %naksatra_name = (
#    0,  'Ashwathi',     1,  'Bharani',      2,  'Karthika',
#    3,  'Rohini',       4,  'Makeeryam',    5,  'Thiruvathira',
#    6,  'Punartham',    7,  'Pooyam',       8,  'Aayilyam',
#    9,  'Makam',        10, 'Pooram',       11, 'Uthram',
#    12, 'Atham',        13, 'Chithira',     14, 'Chothi',
#    15, 'Visakham',     16, 'Anizham',      17, 'Thrikketta',
#    18, 'Moolam',       19, 'Pooradam',     20, 'Uthradam',
#    21, 'Thiruvonam',   22, 'Avittam',      23, 'Chathayam',
#    24, 'Poororuttathi',25, 'Uthratathi',   26, 'Revathi',
#    27, 'Ashwathi'
#    );
#    
    $naksatra_name{ &trunc( $tllong * 27 / 360 ) };
}

sub get_Jovian_Year_name {
    my ($YearKali) = @_;

    my %Jovian_Year_name = (
        0,  'kSaya(60)',       1,  'prabhava(1)',
        2,  'vibhava(2)',      3,  'sukha(3)',
        4,  'pramoda(4)',      5,  'prajApati(5)',
        6,  'aGgiras(6)',      7,  'zrImukha(7)',
        8,  'bhAva(8)',        9,  'yuvan(9)',
        10, 'dhAtR(10)',       11, 'Izvara(11)',
        12, 'bahudhArya(12)',  13, 'pramAthin(13)',
        14, 'vikrama(14)',     15, 'vRSa(15)',
        16, 'citrabhAnu(16)',  17, 'subhAnu(17)',
        18, 'tAraNa(18)',      19, 'pArthiva(19)',
        20, 'vyaya(20)',       21, 'sarvajit(21)',
        22, 'sarvadhArin(22)', 23, 'virodhin(23)',
        24, 'vikRta(24)',      25, 'khara(25)',
        26, 'nandana(26)',     27, 'vijaya(27)',
        28, 'jaya(28)',        29, 'manmatha(29)',
        30, 'durmukha(30)',    31, 'hemalamba(31)',
        32, 'vilambin(32)',    33, 'vikArin(33)',
        34, 'zArvari(34)',     35, 'plava(35)',
        36, 'zubhakRt(36)',    37, 'zobhana(37)',
        38, 'krodhin(38)',     39, 'vizvAvasu(39)',
        40, 'parAbhava(40)',   41, 'plavaGga(41)',
        42, 'kIlaka(42)',      43, 'saumya(43)',
        44, 'sAdhAraNa(44)',   45, 'virodhakRt(45)',
        46, 'paridhAvin(46)',  47, 'pramAdin(47)',
        48, 'Ananda(48)',      49, 'rAkSasa(49)',
        50, 'anala(50)',       51, 'piGgala(51)',
        52, 'kAlayukta(52)',   53, 'siddhArthin(53)',
        54, 'raudra(54)',      55, 'durmati(55)',
        56, 'dundubhi(56)',    57, 'rudhirodgArin(57)',
        58, 'raktAkSa(58)',    59, 'krodhana(59)'
    );
    my ($Jovian_Year);

    $Jovian_Year =
      ( &trunc( ( $YearKali * 211 - 108 ) / 18000 ) + $YearKali + 27 ) % 60;
    $Jovian_Year_name{$Jovian_Year};
}

sub get_Jovian_Year_name_south {
    my ($YearKali) = @_;

    my ($Jovian_Year);

    if ( $YearKali < 4009 ) {
        $Jovian_Year = $YearKali;
    }
    else {
        $Jovian_Year = ( $YearKali - 14 ) % 60;
    }
    &get_Jovian_Year_name($Jovian_Year);
}

#{:::::::::::::::::::::::::::}

sub set_primary_constant {
    # celestial.setPrimaryConstants - HP
    $YugaRotation{'star'}      = 1582237800;    ###20020331
    $YugaRotation{'sun'}       = 4320000;
    $YugaRotation{'moon'}      = 57753336;
    $YugaRotation{'mercury'}   = 17937000;      ###20010328
    $YugaRotation{'venus'}     = 7022388;       ###20010328
    $YugaRotation{'mars'}      = 2296824;       ###20010328
    $YugaRotation{'jupiter'}   = 364220;
    $YugaRotation{'saturn'}    = 146564;        ###20010328
    $YugaRotation{'Candrocca'} = 488219;
    $YugaRotation{'Rahu'}      = -232226;
}

sub add_bija {
    # celestial.applyBija - HP
    # global variables: $with_bija_pf
    if ($with_bija_pf) {
        $YugaRotation{'star'}    = $YugaRotation{'star'} + 28;       ###20020331
        $YugaRotation{'sun'}     = $YugaRotation{'sun'};
        $YugaRotation{'moon'}    = $YugaRotation{'moon'};
        $YugaRotation{'mercury'} = $YugaRotation{'mercury'} + 60;    ###20020331
        $YugaRotation{'venus'}   = $YugaRotation{'venus'} - 12;      ###20010328
        $YugaRotation{'mars'}    = $YugaRotation{'mars'} + 8;        ###20010328
        $YugaRotation{'jupiter'} = $YugaRotation{'jupiter'};         ###20010328
        $YugaRotation{'saturn'}  = $YugaRotation{'saturn'} + 4;      ###20010328
        $YugaRotation{'Candrocca'} = $YugaRotation{'Candrocca'} - 16; ###20010328
        $YugaRotation{'Rahu'} = $YugaRotation{'Rahu'} - 12;          ###20010328
    }
}

sub set_secondary_constant {
    # celestial.setSecondaryConstants - HP
    $YugaCivilDays    = $YugaRotation{'star'} - $YugaRotation{'sun'};
    $YugaSynodicMonth = $YugaRotation{'moon'} - $YugaRotation{'sun'};
    $YugaAdhimasa     = $YugaSynodicMonth - 12 * $YugaRotation{'sun'};
    $YugaTithi        = 30 * $YugaSynodicMonth;
    $YugaKsayadina    = $YugaTithi - $YugaCivilDays;
}

sub set_planetary_constant {
    # celestial.setPlanetaryConstants - HP

    $PlanetRotation{'star'} = 0;
    $PlanetSighra{'star'}   = 0;
    $PlanetApogee{'star'}   = 0;
    $PlanetCircumm{'star'}  = 0;
    $PlanetCircums{'star'}  = 0;

    $PlanetRotation{'sun'} = $YugaRotation{'sun'};
    $PlanetSighra{'sun'}   = $YugaRotation{'sun'};
    $PlanetApogee{'sun'}   = 77 + 17 / 60;
    $PlanetCircumm{'sun'}  = 13 + 50 / 60;
    $PlanetCircums{'sun'}  = 0;

    $PlanetRotation{'moon'} = $YugaRotation{'moon'};
    $PlanetSighra{'moon'}   = 0;
    $PlanetApogee{'moon'}   = 0;
    $PlanetCircumm{'moon'}  = 31 + 50 / 60;
    $PlanetCircums{'moon'}  = 0;

    $PlanetRotation{'mercury'} = $YugaRotation{'sun'};
    $PlanetSighra{'mercury'}   = $YugaRotation{'mercury'};
    $PlanetApogee{'mercury'}   = 220 + 27 / 60;
    $PlanetCircumm{'mercury'}  = 29;
    $PlanetCircums{'mercury'}  = 131.5;

    $PlanetRotation{'venus'} = $YugaRotation{'sun'};
    $PlanetSighra{'venus'}   = $YugaRotation{'venus'};
    $PlanetApogee{'venus'}   = 79 + 50 / 60;
    $PlanetCircumm{'venus'}  = 11.5;
    $PlanetCircums{'venus'}  = 261;

    $PlanetRotation{'mars'} = $YugaRotation{'mars'};
    $PlanetSighra{'mars'}   = $YugaRotation{'sun'};
    $PlanetApogee{'mars'}   = 130 + 2 / 60;
    $PlanetCircumm{'mars'}  = 73.5;
    $PlanetCircums{'mars'}  = 233.5;

    $PlanetRotation{'jupiter'} = $YugaRotation{'jupiter'};
    $PlanetSighra{'jupiter'}   = $YugaRotation{'sun'};
    $PlanetApogee{'jupiter'}   = 171 + 18 / 60;
    $PlanetCircumm{'jupiter'}  = 32.5;
    $PlanetCircums{'jupiter'}  = 71;

    $PlanetRotation{'saturn'} = $YugaRotation{'saturn'};
    $PlanetSighra{'saturn'}   = $YugaRotation{'sun'};
    $PlanetApogee{'saturn'}   = 236 + 37 / 60;
    $PlanetCircumm{'saturn'}  = 48.5;
    $PlanetCircums{'saturn'}  = 39.5;

    $PlanetRotation{'Candrocca'} = $YugaRotation{'Candrocca'};
    $PlanetSighra{'Candrocca'}   = 0;
    $PlanetApogee{'Candrocca'}   = 0;
    $PlanetCircumm{'Candrocca'}  = 0;
    $PlanetCircums{'Candrocca'}  = 0;

    $PlanetRotation{'Rahu'} = $YugaRotation{'Rahu'};
    $PlanetSighra{'Rahu'}   = 0;
    $PlanetApogee{'Rahu'}   = 0;
    $PlanetCircumm{'Rahu'}  = 0;
    $PlanetCircums{'Rahu'}  = 0;
}

sub get_mean_long {
    # celestial.getMeanLongitude - HP
    my ( $ahar, $rotation ) = @_;

    # definition
    360 * &frac( $rotation * $ahar / $YugaCivilDays );

  # {consider rounding}
  #
  # transformation 1 of original definition
  #    --> 360 * &frac($rotation * (int($ahar) + &frac($ahar)) / $YugaCivilDays)
  #    --> 360 * &frac(($rotation * int($ahar) / $YugaCivilDays) +
  #                    ($rotation * &frac($ahar) / $YugaCivilDays))
  #    --> 360 * &frac(&frac($rotation * int($ahar) / $YugaCivilDays) +
  #                    &frac($rotation * &frac($ahar) / $YugaCivilDays))
  # ok! difference from original is 1/100000000 degree.

    #    --> 360 * &frac(&frac(($rotation * int($ahar) % $YugaCivilDays) /
    #                          $YugaCivilDays) +
    #                    &frac($rotation * &frac($ahar) / $YugaCivilDays))
    #    --> 360 * &frac(&frac((($rotation % $YugaCivilDays) *
    #                           (int($ahar) % $YugaCivilDays)) /
    #                          $YugaCivilDays) +
    #                    &frac($rotation * &frac($ahar) / $YugaCivilDays))
    # no good transformation. why ???

  # transformation 2 of original definition
  #    &zero360(($rotation / $YugaCivilDays) * $ahar * 360);
  #    --> &zero360((360 * $rotation * int($ahar) / $YugaCivilDays) +
  #                 (360 * $rotation * &frac($ahar) / $YugaCivilDays))
  #    --> &zero360(&zero360((360 * $rotation * int($ahar) / $YugaCivilDays)) +
  #                 &zero360((360 * $rotation * &frac($ahar) / $YugaCivilDays)))
  # ok! difference from original is 1/10000000000 degree.
}

sub declination {
    # celestial.declination - HP
    my ($long) = @_;
    
    &arcsin( sin( $long / $rad ) * sin( 24 / $rad ) ) * $rad;
}

sub get_daylight_equation {
    # celestial.getDaylightEquation - HP

    # global variables: $ahar, $YugaRotation{'sun'}
    my ( $year, $loc_lat ) = @_;

    my ( $mslong, $samslong, $sdecl, $x );

    $mslong = &get_mean_long( $ahar, $YugaRotation{'sun'} );

    # {debugging for sunrise time}
    # printf "ahar=%15s\n", $ahar;
    # printf "mslong=%15s\n", $mslong;
    # {end of debugging for sunrise time}
    # {sayana solar longitude and declination}
    $samslong = $mslong + ( 54 / 3600 ) * ( $year - 499 );

    # {debugging for sunrise time}
    # printf "samslong=%15s\n", $samslong;
    # $samslong = 270;
    # {end of debugging for sunrise time}
    # {See Sewell, p.10}
    $sdecl = &declination($samslong);

    # {debugging for sunrise time}
    # printf "sdecl=%15s\n", $sdecl;
    # {end of debugging for sunrise time}
    # {equation of daylight by analemma}
    $x = &tan( $loc_lat / $rad ) * &tan( $sdecl / $rad );
    0.5 * &arcsin($x) / $pi;
}

sub get_sun_rise_time {
    # celestial.setSunriseTime - HP
    my ($eqtime) = @_;

    my ( $sriseh, $srisem );

    $sriseh = &trunc( ( 0.25 - $eqtime ) * 24 );
    $srisem = &trunc( 60 * &frac( ( 0.25 - $eqtime ) * 24 ) );
    ( $sriseh, $srisem );
}

sub get_ayana_amsa {    ###20010313
    # celestial.setAyanamsa - HP
    # Good reads: - HP
    # https://en.wikipedia.org/wiki/Ayanamsa - HP
    # http://pidaparthypanchangam.com/?m=201306&paged=2 - HP
    my ($ahar) = @_;

    my ( $ayanadeg, $ayanamin );

    $ayanadeg =
      &trunc( ( 54 * 4320000 / $YugaCivilDays / 3600 ) * ( $ahar - 1314930 ) );
    $ayanamin = &trunc(
        60 * &frac(
            ( 54 * 4320000 / $YugaCivilDays / 3600 ) * ( $ahar - 1314930 )
        )
    );
    ( $ayanadeg, $ayanamin );
}

sub get_manda_equation {
    # celestial.getMandaEquation - HP
    my ( $argument, $planet ) = @_;

    &arcsin( $PlanetCircumm{$planet} / 360 * sin( $argument / $rad ) ) * $rad;
}

sub get_sighra_equation {
    # celestial.getSighraEquation
    my ( $anomaly, $planet ) = @_;

    my ( $bhuja, $koti, $karna );

    $bhuja = $PlanetCircums{$planet} / 360 * sin( $anomaly / $rad ) * $rad;
    $koti  = $PlanetCircums{$planet} / 360 * cos( $anomaly / $rad ) * $rad;
    $karna = sqrt( &sqr( $rad + $koti ) + &sqr($bhuja) );
    &arcsin( $bhuja / $karna ) * $rad;
}

sub get_true_long {
    # celestial.getTrueLongitude
    my ( $ahar, $mslong, $planet ) = @_;

    my ( $mean_long1, $mean_long2, $mean_long3 );
    my ($argument);
    my ( $anomaly1, $anomaly2 );
    my ( $equ1, $equ2, $equ3, $equ4, $equ5 );

    # {first sighra correction}
    if (   ( $planet eq 'mercury' )
        || ( $planet eq 'venus' ) )
    {
        $anomaly1 = &get_mean_long( $ahar, $PlanetSighra{$planet} ) - $mslong;
    }
    else {
        $anomaly1 =
          &get_mean_long( $ahar, $PlanetSighra{$planet} ) -
          $PlanetMeanPosition{$planet};
    }
    $equ1 = &get_sighra_equation( $anomaly1, $planet );

    # {first manda correction}
    $mean_long1 = $PlanetMeanPosition{$planet} + $equ1 / 2;
    $argument   = $mean_long1 - $PlanetApogee{$planet};
    $equ2       = &get_manda_equation( $argument, $planet );

    # {second manda correction}
    $mean_long2 = $mean_long1 - $equ2 / 2;
    $argument   = $mean_long2 - $PlanetApogee{$planet};
    $equ3       = &get_manda_equation( $argument, $planet );

    # {second sighra correction}
    $mean_long3 = $PlanetMeanPosition{$planet} - $equ3;
    $anomaly2   = &get_mean_long( $ahar, $PlanetSighra{$planet} ) - $mean_long3;
    $equ4       = &get_sighra_equation( $anomaly2, $planet );
    $equ5       = 0;

    # {$ifdef suryasiddhanta}
    # {$else}
    #    if (($planet eq 'mercury') ||
    #        ($planet eq 'venus')) {
    #        $argument = $mslong - (77 + 17 / 60);
    #        $equ5 = (13.5 / 360 * sin($argument / $rad)) * $rad;
    #    }
    #    if ($planet eq 'venus') {
    #        $equ5 = $equ5 - (1 + 7 / 60);
    #    }
    # {$endif}

    &zero360( $mean_long3 + $equ4 + $equ5 );

}

sub right_ascension {
    my ( $long, $decl ) = @_;

    my ( $DayRadius, $Radius90, $x, $ra );

    $DayRadius = cos( $decl / $rad );
    $Radius90  = cos( 24 / $rad );
    $x         = $Radius90 / $DayRadius * sin( $long / $rad );
    $ra        = &arcsin($x) * $rad;

    if ( $long < 90 ) {
    }
    elsif ( $long < 270 ) {
        $ra = 180 - $ra;
    }
    elsif ( $long == 270 ) {
        $ra = 270;
    }
    else {
        $ra = 360 + $ra;
    }
    $ra;
}

sub ascendant {
    my ( $hrasc, $loc_lat ) = @_;

    my ( $asc, $x, $y );    # {Modern method, see North, p.50}

    $x = sin( $hrasc / $rad );
    $y =
      cos( $hrasc / $rad ) * cos( 24 / $rad ) -
      sin( 24 / $rad ) * &tan( $loc_lat / $rad );
    $asc = atan2( $x / $y, 1 ) * $rad;

    if ( 180 <= $hrasc ) {
        if ( 0 < $y ) {
            $asc = $asc;
        }
        else {
            $asc = $asc + 180;
        }
    }
    else {
        if ( 0 < $y ) {
            $asc = $asc + 360;
        }
        else {
            $asc = $asc + 180;
        }
    }
}

sub get_tithi {
    # celestial.getTithi - HP
    my ( $tllong, $tslong ) = @_;

    my ($elong);

    $elong = $tllong - $tslong;
    $elong = &zero360($elong);

    $elong / 12;
}

sub get_tithi_set {
    # celestial.setTithiSet - HP
    my ($tithi) = @_;

    my ( $tithi_day, $ftithi );

    $tithi_day = &trunc($tithi) + 1;
    $ftithi    = &frac($tithi);

    ( $tithi_day, $ftithi );
}

sub set_sukla_krsna {
    # celestial.setSuklaKrsna - HP
    my ($tithi_day) = @_;

    my ( $sukla_krsna, $paksa );

    if ( 15 < $tithi_day ) {
        $tithi_day = $tithi_day - 15;
        $paksa     = 'Krsnapaksa';
    }
    else {
        $paksa = 'Suklapaksa';
    }
    $sukla_krsna = &get_sukla_krsna($paksa);

    ( $tithi_day, $sukla_krsna, $paksa );
}

sub get_tslong {
    # celestial.getTslong - HP
    my ($ahar) = @_;

    my ($mslong);

    $mslong = &get_mean_long( $ahar, $YugaRotation{'sun'} );
    my $get_tslong =
      &zero360( $mslong -
          &get_manda_equation( ( $mslong - $PlanetApogee{'sun'} ), 'sun' ) );
}

sub get_tllong {
    # celestial.getTllong - HP
    my ($ahar) = @_;

    my ( $mllong, $apogee );

    $mllong = &get_mean_long( $ahar, $YugaRotation{'moon'} );
    $apogee = &get_mean_long( $ahar, $YugaRotation{'Candrocca'} ) + 90;
    &zero360( $mllong - &get_manda_equation( ( $mllong - $apogee ), 'moon' ) );
}

sub get_elong {
    # celestial.getElong - HP
    my ($ahar) = @_;

    my ($elong);

    $elong = &abs( &get_tllong($ahar) - &get_tslong($ahar) );
    if ( 180 < $elong ) {
        $elong = 360 - $elong;
    }
    $elong;
}

sub find_conj {
    # celestial.findConj - HP
    my ( $leftx, $lefty, $rightx, $righty ) = @_;

    my ( $width, $centrex, $centrey, $relation );

#{$ifdef conj_debug}
#    printf "lx=%15s rx=%15s ly=%15s ry=%15s\n", $leftx, $rightx, $lefty, $righty;
#    printf "%18s %18s %18s\n", $leftx, $rightx, $rightx - $leftx;
#    printf "%18s %18s %18s\n", $leftx, $rightx, ($rightx + $leftx)/2;
#{$endif}
    $width   = ( $rightx - $leftx ) / 2;
    $centrex = ( $rightx + $leftx ) / 2;
    if ( $width < $epsiron ) {
        &get_tslong($centrex);
    }
    else {
        $centrey = &get_elong($centrex);
        $relation = &three_relation( $lefty, $centrey, $righty );
        if ( $relation < 0 ) {
            $rightx = $rightx + $width;
            $righty = &get_elong($rightx);
            &find_conj( $centrex, $centrey, $rightx, $righty );
        }
        elsif ( 0 < $relation ) {
            $leftx = $leftx - $width;
            $lefty = &get_elong($leftx);
            &find_conj( $leftx, $lefty, $centrex, $centrey );
        }
        else {
            $leftx  = $leftx + $width / 2;
            $lefty  = &get_elong($leftx);
            $rightx = $rightx - $width / 2;
            $righty = &get_elong($rightx);
            &find_conj( $leftx, $lefty, $rightx, $righty );
        }
    }
}

sub get_conj {
    # celestial.getConj - HP
    my ($ahar) = @_;

    &find_conj( $ahar - 2, &get_elong( $ahar - 2 ),
        $ahar + 2, &get_elong( $ahar + 2 ) );
}

sub get_clong {
    # celestial.getClong - HP
    my ( $ahar, $tithi ) = @_;

    my ($new_new);

    $new_new =
      $YugaCivilDays / ( $YugaRotation{'moon'} - $YugaRotation{'sun'} );
    $ahar = $ahar - $tithi * ( $new_new / 30 );

    if ( &abs( $ahar - $back_clong_ahar ) < 1 ) {
        $back_clong;
    }
    elsif ( &abs( $ahar - $back_nclong_ahar ) < 1 ) {
        $back_clong_ahar = $back_nclong_ahar;
        $back_clong      = $back_nclong;
        $back_nclong;
    }
    else {
        $back_clong_ahar = $ahar;
        $back_clong      = &get_conj($ahar);
        $back_clong;
    }
}

sub get_nclong {
    # celestial.getNclong - HP
    my ( $ahar, $tithi ) = @_;

    my ($new_new);

    $new_new =
      $YugaCivilDays / ( $YugaRotation{'moon'} - $YugaRotation{'sun'} );
    $ahar = $ahar + ( 30 - $tithi ) * ( $new_new / 30 );

    if ( &abs( $ahar - $back_nclong_ahar ) < 1 ) {
        $back_nclong;
    }
    else {
        $back_nclong_ahar = $ahar;
        $back_nclong      = &get_conj($ahar);
        $back_nclong;
    }
}

sub get_masa_num {
    # calendar.getMasaNum - HP
    my ( $tslong, $clong ) = @_;

    my ($masa_num);

    $masa_num = ( &trunc( $tslong / 30 ) ) % 12;
    if ( ( &trunc( $clong / 30 ) % 12 ) == $masa_num ) {
        $masa_num = $masa_num + 1;
    }
    $masa_num = ( $masa_num + 12 ) % 12;
    $masa_num;
}

#{:::::::::::::::::::::::::::}
#{ saura_masa calculations }

sub find_samkranti {    #find out samkranti in ahargana #20010311
    # calendar.findSamkranti - HP
    my ( $o_ahar, $n_ahar ) = @_;

    my ( $o_tslong, $n_tslong, $c_ahar, $c_tslong, $width );

    $o_tslong = &get_tslong($o_ahar);
    $n_tslong = &get_tslong($n_ahar);

    $o_tslong = $o_tslong - int( $o_tslong / 30 ) * 30;
    $n_tslong = $n_tslong - int( $n_tslong / 30 ) * 30;

#{for debug}
#    printf "lx=%15s rx=%15s ly=%15s ry=%15s\n", $o_ahar, $n_ahar, $o_tslong, $n_tslong;
#
    $width  = ( $n_ahar - $o_ahar ) / 2;
    $c_ahar = ( $n_ahar + $o_ahar ) / 2;
    if ( $width < $epsiron ) {
        $c_ahar;
    }
    else {
        $c_tslong = &get_tslong($c_ahar);
        $c_tslong = $c_tslong - int( $c_tslong / 30 ) * 30;
        if ( $c_tslong < 5 ) {
            &find_samkranti( $o_ahar, $c_ahar );
        }
        else {
            &find_samkranti( $c_ahar, $n_ahar );
        }
    }
}

sub set_samkranti {    ###20010311
    # calendar.setSamkranti - HP
    my ($ahar) = @_;

    #    if (&abs($ahar - $samkranti) < 1) { #20020308
    #    } else { #20020308
    $samkranti = &find_samkranti( $ahar, $ahar + 1 );    #20010311
    $samkranti = $samkranti + $desantara;                #20011114
    ( $samkranti_year, $samkranti_month, $samkranti_day ) =
      &JulianDay_to_ModernDate( &Ahargana_to_JulianDay($samkranti) );  #20010310
    $samkranti_hour = &trunc( &frac($samkranti) * 24 );                #20010310
    $samkranti_min  = &trunc( 60 * &frac( &frac($samkranti) * 24 ) );  #20010310

    #    } #20020308
}

sub today_saura_masa_first_p {    ###20001231
    # calendar.isTodaySauraMasaFirst - HP
    #
    # Definition of the first day
    # samkranti is between today's 0:00 and 24:00
    # ==
    # at 0:00 before 30x, at 24:00 after 30x

    my ($ahar) = @_;
    my ( $tslong_today, $tslong_tomorrow );

    $tslong_today    = &get_tslong( $ahar - $desantara );        #20011118
    $tslong_tomorrow = &get_tslong( $ahar - $desantara + 1 );    #20011118

    $tslong_today    = $tslong_today - int( $tslong_today / 30 ) * 30;
    $tslong_tomorrow = $tslong_tomorrow - int( $tslong_tomorrow / 30 ) * 30;

    if ( ( 25 < $tslong_today ) && ( $tslong_tomorrow < 5 ) ) {
        &set_samkranti($ahar);
        $true;
    }
    else {
        $false;
    }

}

sub get_saura_masa_day {    ###20001231
    # calendar.getSauraMasaMonthDay - HP

    # If today is the first day then 1
    # Otherwies yesterday's + 1
    my ($ahar) = @_;
    my ( $tslong_tomorrow, $month, $day );

    $ahar = &trunc($ahar);
    if ( &today_saura_masa_first_p($ahar) ) {
        $day             = 1;
        $tslong_tomorrow = &get_tslong( $ahar + 1 );
        $month           = ( &trunc( $tslong_tomorrow / 30 ) ) % 12;
        $month           = ( $month + 12 ) % 12;
    }
    else {
        ( $month, $day ) = &get_saura_masa_day( $ahar - 1 );
        $day = $day + 1;
    }
    ( $month, $day );
}

#{:::::::::::::::::::::::::::}
#{ set of calculations }

sub calculations {
    # calculations.main - HP

    &set_primary_constant;
    &add_bija;
    &set_secondary_constant;
    &set_planetary_constant;
    $JulianDay    = &ModernDate_to_JulianDay( $year, $month, $day );
    $ahar         = &JulianDay_to_Ahargana($JulianDay);
    $JulianDay    = int( $JulianDay + 0.5 );
    $ahargana     = int( $ahar + 0.5 );                              ###20010325
    $weekday_name = &get_weekday_name($JulianDay);
    ( $ayanadeg, $ayanamin ) = &get_ayana_amsa($ahar);               ###20010313

    # {at 6 o'clock}
    $ahar = $ahar + 0.25;

    # {desantara} #20011114
    $ahar = $ahar - $desantara;                                      #20011114

    # {time of sunrise at local latitude}
    $eqtime = &get_daylight_equation( $year, $loc_lat );
    $ahar = $ahar - $eqtime;
    ( $sriseh, $srisem ) = &get_sun_rise_time($eqtime);

    # {Lunar apogee and node at sunrise}
    $PlanetMeanPosition{'Candrocca'} =
      &get_mean_long( $ahar, $YugaRotation{'Candrocca'} ) + 90;
    $PlanetMeanPosition{'Candrocca'} =
      &zero360( $PlanetMeanPosition{'Candrocca'} );

    $PlanetMeanPosition{'Rahu'} =
      &get_mean_long( $ahar, $YugaRotation{'Rahu'} ) + 180;
    $PlanetMeanPosition{'Rahu'} = &zero360( $PlanetMeanPosition{'Rahu'} );

    # {mean and true sun at sunrise}
    $mslong = &get_mean_long( $ahar, $YugaRotation{'sun'} );
    $PlanetMeanPosition{'sun'} = $mslong;
    $tslong =
      &zero360( $mslong -
          &get_manda_equation( ( $mslong - $PlanetApogee{'sun'} ), 'sun' ) );
    $PlanetTruePosition{'sun'} = $tslong;

    # {mean and true moon at sunrise}
    $mllong = &get_mean_long( $ahar, $YugaRotation{'moon'} );
    $PlanetMeanPosition{'moon'} = $mllong;
    $PlanetApogee{'moon'}       = $PlanetMeanPosition{'Candrocca'};
    $tllong =
      &zero360( $mllong -
          &get_manda_equation( ( $mllong - $PlanetApogee{'moon'} ), 'moon' ) );
    $PlanetTruePosition{'moon'} = $tllong;

    # {finding tithi and longitude of conjunction}
    $tithi = &get_tithi( $tllong, $tslong );
    ( $tithi_day, $ftithi ) = &get_tithi_set($tithi);
    ( $tithi_day, $sukla_krsna, $paksa ) = &set_sukla_krsna($tithi_day);

    # {last conjunction}
    $clong = &get_clong( $ahar, $tithi );

    # {next conjunction}
    $nclong = &get_nclong( $ahar, $tithi );

    $adhimasa = &get_adhimasa( $clong, $nclong );
    $masa_num = &get_masa_num( $tslong, $clong );
    $masa = &get_masa_name($masa_num);

 #    $saura_masa_day = &get_saura_masa_day($ahar); #20001231
 #    $saura_masa_num = &get_saura_masa_num($tslong, $saura_masa_day); #20000614
    ( $saura_masa_num, $saura_masa_day ) = &get_saura_masa_day($ahar); #20001231
    $saura_masa = &get_saura_masa_name($saura_masa_num);               #20001231
    $naksatra   = &get_naksatra_name($tllong);

    #{kali and Saka era}
    $YearKali    = &Ahargana_to_Kali( $ahar + ( 4 - $masa_num ) * 30 );
    $YearSaka    = &Kali_to_Saka($YearKali);
    $YearVikrama = $YearSaka + 135;
}

sub planetary_calculations {
    # calculations.planetary

    # {mean and true planets at sunrise}
    for ( 'mercury', 'venus', 'mars', 'jupiter', 'saturn' ) {
        $planet = $_;
        $PlanetMeanPosition{$planet} =
          &get_mean_long( $ahar, $PlanetRotation{$planet} );
        $PlanetTruePosition{$planet} =
          &get_true_long( $ahar, $mslong, $planet );
    }
}

sub try_calculations {
    &set_primary_constant;
    &add_bija;
    &set_secondary_constant;
    &set_planetary_constant;
    $masa = &get_masa_name($masa_num);
    if ( $paksa eq 'Krsnapaksa' ) {
        $tithi_day = $tithi_day + 15;
    }
    $YearKali = &Saka_to_Kali($YearSaka);
    $ahar = &Kali_to_Ahargana( $YearKali, $masa_num, $tithi_day );
    ( $tithi_day, $sukla_krsna, $paksa ) = &set_sukla_krsna($tithi_day);
    $JulianDay = &Ahargana_to_JulianDay($ahar);
    $JulianDay = $JulianDay + 0.5;
    ( $year, $month, $day ) = &JulianDay_to_ModernDate($JulianDay);
    $weekday_name = &get_weekday_name($JulianDay);
}

sub horoscope_calculation {

    my ( $saslong, $sdecl, $srasc, $time_degree, $hrasc, $ascend );

    &set_primary_constant;
    &add_bija;
    &set_secondary_constant;
    &set_planetary_constant;
    $JulianDay = &ModernDate_to_JulianDay( $year, $month, $day );
    $ahar      = &JulianDay_to_Ahargana($JulianDay);
    $ahar      = $ahar + $hours / 24 + $minutes / 24 / 60;

    $ahar = $ahar - $desantara;    #20011114

    $mslong = &get_mean_long( $ahar, $YugaRotation{'sun'} );
    $tslong = &get_tslong($ahar);

    $saslong = $tslong + ( 54 / 3600 ) * ( $year - 499 );   # {See Sewell, p.10}

    $sdecl = &declination($saslong);
    $srasc = &right_ascension( $saslong, $sdecl );

    $time_degree = $hours * 15 + $minutes / 4;
    $hrasc       = $time_degree - 90 + $srasc;
    $hrasc       = &zero360($hrasc);

    $ascend = &ascendant( $hrasc, $loc_lat );               # {sayana lagna}
    $ascend = &zero360($ascend);
    $lagna  = $ascend - ( 54 / 3600 ) * ( $year - 499 );    # {nirayana lagna}
    $lagna  = &zero360($lagna);
}

sub tithi_naksatra_karana_yoga_at_any_given_ahar {          ###20011106
    my ($ahar) = @_;
    my ( $tithi_day, $ftithi, $naksatra, $karana, $yoga );

    &set_primary_constant;
    &add_bija;
    &set_secondary_constant;
    &set_planetary_constant;

    $mslong = &get_mean_long( $ahar, $YugaRotation{'sun'} );
    $PlanetMeanPosition{'sun'} = $mslong;
    $tslong =
      &zero360( $mslong -
          &get_manda_equation( ( $mslong - $PlanetApogee{'sun'} ), 'sun' ) );
    $PlanetTruePosition{'sun'} = $tslong;
    $mllong = &get_mean_long( $ahar, $YugaRotation{'moon'} );
    $PlanetMeanPosition{'moon'} = $mllong;
    $PlanetApogee{'moon'}       = $PlanetMeanPosition{'Candrocca'};
    $tllong =
      &zero360( $mllong -
          &get_manda_equation( ( $mllong - $PlanetApogee{'moon'} ), 'moon' ) );
    $PlanetTruePosition{'moon'} = $tllong;
    $tithi = &get_tithi( $tllong, $tslong );
    ( $tithi_day, $ftithi ) = &get_tithi_set($tithi);
    ( $tithi_day, $sukla_krsna, $paksa ) = &set_sukla_krsna($tithi_day);
    $naksatra = &get_naksatra_name($tllong);
    $karana   = &get_karana_name($tithi);
    $yoga     = &get_yoga_name( $tslong, $tllong );

    ( $tithi_day, $ftithi, $naksatra, $karana, $yoga );
}

sub wechseln_calc_write {    ###20011109
    my ( $tithi_day, $ftithi, $naksatra, $karana, $yoga );
    my ( $otithi_day, $onaksatra, $okarana, $oyoga );

    # {at 0 o'clock}

    $JulianDay = &ModernDate_to_JulianDay( $year, $month, $day );
    $ahar = &JulianDay_to_Ahargana($JulianDay);

    #    $JulianDay = int($JulianDay + 0.5); #20011114
    #    $ahargana = int($ahar + 0.5); ###20010325 #20011114

    $ahar = $ahar - $desantara;    #20011114

    ( $tithi_day, $ftithi, $naksatra, $karana, $yoga ) =
      &tithi_naksatra_karana_yoga_at_any_given_ahar($ahar);
    ( $otithi_day, $onaksatra, $okarana, $oyoga ) =
      ( $tithi_day, $naksatra, $karana, $yoga );

    #        printf " tithi: %s\n", $tithi; ###20011107
    #        printf " ftithi: %s\n", $ftithi; ###20011107
    printf "%2sh ", &trunc( &frac( $ahar + $desantara ) * 24 );    #20011114
    printf "%2sm ",
      &trunc( 60 * &frac( &frac( $ahar + $desantara ) * 24 ) );    #20011114
    printf " tithi: %2s (0.%s)", $tithi_day, substr( 1 + $ftithi, 2, 3 );
    printf " nak: %-12s",        $naksatra;
    printf " kar: %s",           $karana;
    printf " yog: %-10s\n",      $yoga;

    for ( $counter = 0 ; $counter < 4000 ; $counter++ ) {
        $ahar = $ahar + 0.00025;

        ( $tithi_day, $ftithi, $naksatra, $karana, $yoga ) =
          &tithi_naksatra_karana_yoga_at_any_given_ahar($ahar);

        if (   ( $otithi_day != $tithi_day )
            || ( $onaksatra ne $naksatra )
            || ( $okarana   ne $karana )
            || ( $oyoga     ne $yoga ) )
        {

            #        printf " tithi: %s\n", $tithi; ###20011107
            #        printf " ftithi: %s\n", $ftithi; ###20011107
            printf "%2sh ",
              &trunc( &frac( $ahar + $desantara ) * 24 );    #20011114
            printf "%2sm ",
              &trunc( 60 * &frac( &frac( $ahar + $desantara ) * 24 ) )
              ;                                              #20011114
            printf " tithi: %2s (0.%s)", $tithi_day,
              substr( 1 + $ftithi, 2, 3 );                   ###20011107
            printf " nak: %-12s",   $naksatra;
            printf " kar: %s",      $karana;
            printf " yog: %-10s\n", $yoga;
            ( $otithi_day, $onaksatra, $okarana, $oyoga ) =
              ( $tithi_day, $naksatra, $karana, $yoga );
        }
    }

}

#{:::::::::::::::::::::::::::}
# { OUTPUT }

sub write_opening_message {
    print
      "   ********* Pancanga vers.3.13 **********   M. YANO and M. FUSHIMI \n";
    print
"   ----------------- perl version ------------- February 2004            \n";
    print
      "       This program is based on the Suryasiddhanta.   The constants \n";
    print
      "   of the text were modified  around AD 1000 by the elements called \n";
    print
      "   bija. You can choose with or without bija by entering <B> in <S>.\n";
    print
      "   <MENUES>                                                         \n";
    print
      "   <T>:   To find the modern date from the given Indian date.   The \n";
    print
      "       result is not always correct.  (Sometimes error is one month \n";
    print
      "       because of adhimasa.) You should confirm it by menu <L>.     \n";
    print
      "   <L>:   To find the Indian date (in amanta) from the given modern \n";
    print
      "       date.  The result is considerably reliable:  the month names \n";
    print
      "       are almost always correct;only the error of 1 tithi is to be \n";
    print
      "       admitted because of occurrence of ksayadina or adhidina.     \n";
    print
      "   <V>:   To get the further details of <L>.                        \n";

# print "   <H>:   To get horoscope (at present only lagna).                 \n"; #20010416
    print
      "   <S>:   To set local <L>atitude, l<O>ngitude, <B>ija.             \n"
      ;    #20020304
    print
      "   NOTICE ... Remember the difference of amanta and purnimanta.     \n";
    print
      "              Beginning of the year is set for Caitra sukla 1.      \n";
    print
      "   ***** This program should not be copied without our permission.  \n";
    print
      "     Please contact:                                                \n";
    print
      "         M.YANO (for Indian astronomy): yanom\@cc.kyoto-su.ac.jp    \n";
    print
      "         M.FUSHIMI (for programming): fushimi\@fas.harvard.edu      \n";
}

sub write_settings {

    print " Local latitude is set to $loc_lat.\n";
    print " Local longitude is set to $loc_lon.\n";    #20020304
    if ($with_bija_pf) {
        print " With bija.\n";
    }
    else {
        print " Without bija.\n";
    }
}

sub write_sig_deg_min_sec {
    my ($decimal) = @_;

    my ( $sig, $deg, $min, $sec, $remain );

    $decimal = &zero360($decimal);
    $sig     = &trunc( $decimal / 30 );
    $remain  = $decimal - $sig * 30;
    $deg     = &trunc($remain);
    $remain  = $remain - $deg;
    $min     = &trunc( 60 * $remain );
    $remain  = 60 * $remain - $min;
    $sec     = &round( 60 * $remain );
    printf "%3ss%3sd%3s'%3s%s", $sig, $deg, $min, $sec, pack( "C", 34 );
}

sub write_nirayana_longitude {

    my ($counter);

    $counter = -1;
    for (
        'sun',     'moon',   'mercury',   'venus', 'mars',
        'jupiter', 'saturn', 'Candrocca', 'Rahu',
      )
    {
        $planet = $_;
        printf "   %s", $planet_name{$planet};

       #        &write_sig_deg_min_sec($PlanetMeanPosition{$planet});###20000613
       #        print  "   ";###20000613
        if ( $planet =~ /(Candrocca|Rahu)/ ) {

            #            print "                ";###20000613
            &write_sig_deg_min_sec( $PlanetMeanPosition{$planet} );
        }
        else {
            &write_sig_deg_min_sec( $PlanetTruePosition{$planet} );
        }
        print "  |  ";
        if ( ( 0 <= $counter ) && ( $counter < 6 ) ) {
            printf "%s  ", &get_masa_name($counter);
            printf "%s",   &get_masa_name( $counter + 6 );
        }
        if ( ( 0 <= $counter ) && ( $counter < 6 ) ) {    ###20000613
            print " |  ";                                 ###20000613
            printf "%s  ", &get_saura_masa_name($counter);          ###20000613
            printf "%s",   &get_saura_masa_name( $counter + 6 );    ###20000613
        }    ###20000613
        print "\n";
        $counter = $counter + 1;
    }
}

sub write_list {
    printf "%4s ", $year;                            ###20010409
    printf "%2s ", $month;
    printf "%2s ", &trunc($day);
    printf "%s",   substr( $weekday_name, 0, 3 );    ###20010409
    printf "|Saka ";
    printf "%4s", $YearSaka;
    printf "|V.S.";                                  ###20010409
    printf "%4s ",  $YearVikrama;
    printf "%17s ", $adhimasa . $masa;
    printf "%5s ",  $sukla_krsna;
    printf "%2s ",  $tithi_day;                      ###20000522

    #    printf "(%4s) ", substr($ftithi, 0, 4);###20000522
    printf "%s", $naksatra;
    printf "\n";
    if ( &Julian_in_England_p($JulianDay) ) {        ###20030430
        printf "(=%5s %2s %3s in Julian) ",
          &JulianDay_to_JulianDate($JulianDay);
        printf "=====================================================\n";
    }
    else {
        printf
"===============================================================================\n";
    }
}

sub write_table {
    printf "  AD%5s %2s %3s %4s ", $year, $month, $day,
      $weekday_name;    ###20010325
    printf "| JD (at noon)=%8s ",    $JulianDay;    ###20010412
    printf "| Kali-ahargana=%8s \n", $ahargana;     ###20010412
    if ( &Julian_in_England_p($JulianDay) ) {       ###20030331
        printf "  (=%5s %2s %3s in Julian) ",
          &JulianDay_to_JulianDate($JulianDay);
        printf "===================================================\n";
    }
    else {
        printf
"===============================================================================\n";
    }

    #    printf "  Pancanga based on the Suryasiddhanta (at sunrise)";
    printf "  Pancanga based on Suryasiddhanta (sunrise)";    #20020304
    printf " at latitude=%3s,", $loc_lat;                     #20020304
    printf " longitude=%3s\n",  $loc_lon;                     #20020304
    printf
"-------------------------------------------------------------------------------\n";

#    printf "      Nirayana  Mean Longitude     True Longitude    |  Month Names\n";###20000613
    printf
"      Nirayana  True Longitude   |  Lunar Month Names      |  Solar Month Names\n";
    &write_nirayana_longitude;
    printf
"-------------------------------------------------------------------------------\n";
    printf
" Indian date (luni-solar year and amanta month)  (*) local sunrise...%2sh %2sm\n",
      $sriseh, $srisem;                                       ###20010313
    printf " year(atita):Saka %4s",    $YearSaka;
    printf " |Vikrama %4s",            $YearVikrama;
    printf " |Kali %4s",               $YearKali;               ###20010313
    printf " | ayanamsa: %2sd %2sm\n", $ayanadeg, $ayanamin;    ###20010313
    printf "             Jovian(North):%s",
      &get_Jovian_Year_name($YearKali);                         ###20001231
    printf " |Jovian(South):%s\n",
      &get_Jovian_Year_name_south($YearKali);                   ###20001231
    printf " lunar month, paksa, and tithi(at sunrise): \n";    ###20010313
    printf "       %s%s", $adhimasa, $masa;                     ###20001231
    printf " %s",                      $sukla_krsna;            ###20000522
    printf " %2s (fraction = 0.%s)\n", $tithi_day,
      substr( 1 + $ftithi, 2, 3 );                              ###20011107
    printf " solar month and day: %s", $saura_masa;             ###20010313
    printf " %s",                      $saura_masa_day;         ###20010310
    printf " (samkranti: on %4s %2s %2s", $samkranti_year, $samkranti_month,
      $samkranti_day;                                           ###20010311
    printf " at %2sh %2sm)\n", $samkranti_hour, $samkranti_min; ###20010310
    printf " naksatra.... %s", $naksatra;
    printf "  /  karana...%s", &get_karana_name($tithi);
    printf "  /  yoga...%s\n", &get_yoga_name( $tslong, $tllong );

#   printf " (Jovian year, karana, and yoga are in the Kyoto-Harvard transliteration system)\n";###20010412
#    printf "    NOTICE: if PURNIMANTA K-paksa month names appear a month earlier\n";
#    printf "===============================================================================\n"; #20010416
}

sub write_try_list {
    printf
"===============================================================================\n";
    printf "Saka %4s",        $YearSaka;
    printf " Vikrama %4s",    $YearSaka + 135;                ###20000522
    printf " | %s %s",        $masa, $sukla_krsna;
    printf "%3s  ",           $tithi_day;
    printf "| AD%5s %2s %2s", $year, $month, &trunc($day);    ###20030331
    printf " %s",             $weekday_name;
    printf "\n";

    if ( &Julian_in_England_p($JulianDay) ) {                 ###20030331
        printf "====================================================";
        printf " (=%5s %2s %3s in Julian)\n",
          &JulianDay_to_JulianDate($JulianDay);
    }
    else {
        printf
"===============================================================================\n";
    }
}

sub write_horoscope {
    printf
"===============================================================================\n";
    printf "Date: %4s%3s%3s", $year, $month, $day;
    printf " Time: %2sh%2sm", $hours, $minutes;
    printf "  Lat.:%3s", $loc_lat;
    printf " | Lagna =";
    &write_sig_deg_min_sec($lagna);
    printf "\n";
    printf
"===============================================================================\n";
}

#{:::::::::::::::::::::::::::}
# {programme choice}
my $prog_mode_message =

#              "<T>ry, <L>ist, <V>erbose, <H>oroscope, <S>etting, <E>nd: "; #20010416
  "<T>ry, <L>ist, <V>erbose, <S>etting, <E>nd: ";
my $prog_mode_message_cont =

#              "<Return>:continue, <T>ry, <L>ist, <V>erbose, <H>oroscope, <S>etting, <E>nd: "; #20010416
  "<Return>:continue, <T>ry, <L>ist, <V>erbose, <S>etting, <E>nd: ";
my $prog_setting_mode_message =
  "<L>atitude, l<O>ngitude, <B>ija, <E>xit from Setting: ";    #20020304

# type  prog_modes =
# (continue, try, list, verbose, wechseln, horoscope, setting, latitude, longitude, bija, prog_end); #20020304

my $prog_mode = $variabledeclaration;

sub set_prog_mode {
    my ($message) = @_;

    my ($ans);

    $ans = &read_char($message);
    if ( $ans eq 'T' ) {
        $prog_mode = 'try';
    }
    elsif ( $ans eq 'L' ) {
        $prog_mode = 'list';
    }
    elsif ( $ans eq 'V' ) {
        $prog_mode = 'verbose';
    }
    elsif ( $ans eq 'W' ) {
        $prog_mode = 'wechseln';
    }
    elsif ( $ans eq 'H' ) {
        $prog_mode = 'horoscope';
    }
    elsif ( $ans eq 'S' ) {
        $prog_mode = 'setting';
    }
    elsif ( $ans eq 'E' ) {
        $prog_mode = 'prog_end';
    }
    else {
        $prog_mode = 'continue';
    }
}

sub set_prog_setting_mode {
    my ($message) = @_;

    my ($ans);

    $ans = &read_char($message);
    if ( $ans eq 'L' ) {
        $prog_mode = 'latitude';
    }
    elsif ( $ans eq 'O' ) {
        $prog_mode = 'longitude';    #20011114
    }
    elsif ( $ans eq 'B' ) {
        $prog_mode = 'bija';
    }
    elsif ( $ans eq 'E' ) {
        $prog_mode = 'prog_end';
    }
    else {
        $prog_mode = 'continue';
    }
}

sub cache_variable_clear {
    $back_clong_ahar  = -1;
    $back_nclong_ahar = -1;
    $back_clong       = -1;
    $back_nclong      = -1;
}

#{:::::::::::::::::::::::::::}
#{main routine}
if ( $pancanga_as_sub ) {
    1;
}
else {
    &write_opening_message;
    print "If there is no need to change default settings, type E.";
    $prog_mode = 'setting';
    while ( $prog_mode ne 'prog_end' ) {
        if ( $prog_mode eq 'continue' ) {
            &set_prog_mode($prog_mode_message);
        }
        elsif ( $prog_mode eq 'try' ) {
            print "\n";
            ( $YearSaka, $masa_num, $paksa, $tithi_day ) = &read_indian_date;
            &try_calculations;
            print "\n";
            &write_try_list;
            &set_prog_mode($prog_mode_message);
        }
        elsif ( $prog_mode eq 'list' ) {
            print "\n";
            ( $year, $month, $day ) = &read_date;
            print "\n";
            for ( $counter = 1 ; $counter < 11 ; $counter++ ) {
                &calculations;
                &write_list;
                ( $year, $month, $day ) = &next_date( $year, $month, $day );
            }
            &set_prog_mode($prog_mode_message_cont);
            while ( $prog_mode eq 'continue' ) {
                print "\n";
                for ( $counter = 1 ; $counter < 11 ; $counter++ ) {
                    &calculations;
                    &write_list;
                    ( $year, $month, $day ) = &next_date( $year, $month, $day );
                }
                &set_prog_mode($prog_mode_message_cont);
            }
        }
        elsif ( $prog_mode eq 'verbose' ) {
            print "\n";
            ( $year, $month, $day ) = &read_date;
            &calculations;
            &planetary_calculations;

            print "\n";
            &write_table;
            &set_prog_mode($prog_mode_message_cont);
            while ( $prog_mode eq 'continue' ) {
                print "\n";
                ( $year, $month, $day ) = &next_date( $year, $month, $day );
                &calculations;
                &planetary_calculations;
                &write_table;
                &set_prog_mode($prog_mode_message_cont);
            }
        }
        elsif ( $prog_mode eq 'horoscope' ) {
            print "\n";
            ( $year, $month, $day ) = &read_date;
            ( $hours, $minutes ) = &read_time;
            &horoscope_calculation;
            print "\n";
            &write_horoscope;
            &set_prog_mode($prog_mode_message);
        }
        elsif ( $prog_mode eq 'wechseln' ) {    #20011109
            print "\n";
            ( $year, $month, $day ) = &read_date;
            &wechseln_calc_write;
            &set_prog_mode($prog_mode_message_cont);
            while ( $prog_mode eq 'continue' ) {    #20011114
                print "\n";
                ( $year, $month, $day ) = &next_date( $year, $month, $day );
                &wechseln_calc_write;
                &set_prog_mode($prog_mode_message_cont);
            }
        }
        elsif ( $prog_mode eq 'setting' ) {
            print "\n";
            &set_prog_setting_mode($prog_setting_mode_message);
            while ( $prog_mode ne 'prog_end' ) {
                if ( $prog_mode eq 'continue' ) {
                    &set_prog_setting_mode($prog_setting_mode_message);
                }
                elsif ( $prog_mode eq 'latitude' ) {
                    &show_map_of_india;
                    $loc_lat = &read_local_latitude;
                    printf " Local latitude is set to %3s.\n", $loc_lat;
                    &set_prog_setting_mode($prog_setting_mode_message);
                }
                elsif ( $prog_mode eq 'longitude' ) {    #20011114
                    &show_map_of_india_longitude;
                    $loc_lon   = &read_local_longitude;
                    $desantara = ( $loc_lon - $Ujjaini_lon ) / 360;
                    printf " Local longitude is set to %3s.\n", $loc_lon;
                    printf " dezantara is ";
                    printf " %3sh ", &trunc( &frac($desantara) * 24 );
                    printf "%2sm ",
                      &trunc( 60 * &frac( &frac($desantara) * 24 ) );
                    printf "\n";
                    &set_prog_setting_mode($prog_setting_mode_message);
                }
                elsif ( $prog_mode eq 'bija' ) {
                    if ($with_bija_pf) {
                        $with_bija_pf = $false;
                        print " Without bija.\n";
                    }
                    else {
                        $with_bija_pf = $true;
                        print " With bija.\n";
                    }
                    &set_prog_setting_mode($prog_setting_mode_message);
                }
            }
            print "\n";
            &write_settings;
            &cache_variable_clear;
            &set_prog_mode($prog_mode_message);
        }
    }
}
