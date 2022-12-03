#!/usr/bin/env perl

use strict;
use warnings;

our %rock_paper_scissors = (
    rock => 1,
    paper => 2,
    scissors => 3,
);

our %rev_rock_paper_scissors = (
    1 => "rock",
    2 => "paper",
    3 => "scissors",
);

our %round_outcome = (
    loss => 0,
    draw => 3,
    victory => 6,
);

sub score {
    my ($they, $me) = @{$_[0]};
    my $their_selection = $rock_paper_scissors{$they};
    my $my_selection = $rock_paper_scissors{$me};

    if ($their_selection == $my_selection) {
        return $my_selection + $round_outcome{draw};
    }
    elsif ($their_selection % 3 == $my_selection - 1) {
        return $my_selection + $round_outcome{victory};
    }
    return $my_selection + $round_outcome{loss};
}

sub score_all {
    my @scores = @_;
    my $total_score = 0;

    foreach my $score (@scores) {
        $total_score += score($score);
    }
    return $total_score;
}

=pod
In part one we assume X = rock, Y = paper, Z = scissors and immediately calculate the scores.
=cut
sub part_one {
    my @data = @_;
    foreach my $record (@data) {
        $record->[1] =~ s/X/rock/g;
        $record->[1] =~ s/Y/paper/g;
        $record->[1] =~ s/Z/scissors/g;
    }    

    print "Your total score for variant 1 is " . score_all(@data) . "!\n";
}

=pod
Changed assumption: X = loss, Y = draw, Z = victory -> preprocessing necessary
=cut
sub part_two {
    my @data = @_;
    my %outcomes = ( X => -1, Y => 0, Z => 1);
    foreach my $record (@data) {
        my $answer = ($rock_paper_scissors{$record->[0]} - 1 + $outcomes{$record->[1]}) % 3 + 1;
        $record->[1] = $rev_rock_paper_scissors{$answer};
    } 

    print "Your total score for variant 2 is " . score_all(@data) . "!\n";
}

open my $fh, '<', 'input.txt' or die;
local $/ = undef;
my $contents = <$fh>;
close $fh;

$contents =~ s/A/rock/g;
$contents =~ s/B/paper/g;
$contents =~ s/C/scissors/g;

part_one(map { [ split / /, $_ ] } split /\n/, $contents);
part_two(map { [ split / /, $_ ] } split /\n/, $contents);
