#!/usr/bin/perl

@stack = ();
print "\@stack = @stack\n";

until($command == 1)
{
	print "Type 1 (quit), 2 (push), or 3 (pop): "; $command = <>;

	if($command == 2){
		print "Insert any value: "; $push = <>;
		push(@stack, $push);
	}

	if($command == 3){
		pop(@stack);
	}

	print "\@stack = @stack\n";
}
