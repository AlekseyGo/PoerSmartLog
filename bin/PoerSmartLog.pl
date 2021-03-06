#!/usr/bin/perl
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
use strict;
use warnings;

# use ../../ as lib location
use FindBin qw($Bin);
use lib "$Bin/..";
use lib "$Bin/../Kernel/cpan-lib";

use Kernel::System::PoerSmart;

# 0=off;1=on;
my $Debug = 1;

my $PoerSmartObject = Kernel::System::PoerSmart->new();

# Get current heating parameters.
my @Result = $PoerSmartObject->ParametersGet();

return if !@Result;
return if !%{$Result[0]};

for my $Item (@Result) {
    my $Success = $PoerSmartObject->LogAdd(
        Data => $Item,
    );

    if (!$Success) {
        # TODO: Log.
        print "System was unable to save log entry!\n";
    }
}