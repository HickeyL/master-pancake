#!c:/Perl/bin/perl
use strict;
#use File::Copy;
#use XML::Writer();
#use HTML::Scrubber();
use WWW::Mechanize;
STDOUT->autoflush(1);

my $mech = WWW::Mechanize->new();
my $ritz = "0002";
my $slaughter = "0006";
my $southLamar = "0004";
my $village = "0003";
my $lakeLine = "0007";
my @theaterArray = ($ritz, $slaughter, $southLamar, $village, $lakeLine);
my @theaterArray = ($ritz); #, $slaughter, $southLamar, $village, $lakeLine);
my @theaterURLArray;
my $baseJSONCall = "http://d20ghz5p5t1zsc.cloudfront.net/adcshowtimeJson/CinemaCalendar.aspx?callback=&cinemaid=";
my $baseJSONCallAppend = "&callback=tix.calendarLinks";

my $value;
my $url;

my @desiredUrls;

open OUT, ">", "output.txt" or die$!;
close(OUT);


foreach my $arg (@theaterArray) {
	my $value = urlConstructor($arg);
	push(@theaterURLArray, $value);
}

#print @theaterURLArray;

foreach my $url (@theaterURLArray) {
	mecha($url);
}

foreach my $finalData (@desiredUrls) {
	print OUT ($finalData)."\n";
}

sub mecha {
	print "hi";
	my $currentUrl = $_[0];
	$mech->get($currentUrl);
	my $baseHtml = $mech->content;
	open RAW, ">>", "raw.txt" or die$!;
	open OUT, ">>", "output.txt" or die$!;
	#print OUT $baseHtml;
	my (@calendarHtml) = $baseHtml =~ m|Master Pancake:(.*?)",.*?SessionTime":"(.*?)",.*?SessionSalesURL":"(.*?)"}|sig;
	foreach my $arg (@calendarHtml) {
		print OUT "Start-->".$arg."<--Stop\n";
	}
	
	if(@calendarHtml) {
		(@desiredUrls) = @calendarHtml =~ m|(.*?)",.*?SessionSalesURL":"(http.*?)"}|gis;
		
	}
}
#

sub urlConstructor {
	my $output = $baseJSONCall.$_[0].$baseJSONCallAppend;
}

#  my $hostname = File->new(
#      path          => '/etc/hostname',
 #     content       => "foo\n",
  #    last_mod_time => 1304974868,
  #);