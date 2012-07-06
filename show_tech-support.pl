#!/usr/bin/perl
#	= ^ . ^ =
#	show_tech-support.pl
#	Show technical support about a Debian GNU/Linux System
#
#	This script is released under the BSD license
#
#	Copyright (c) 2012, Andrés Hernández (Tonejo)
#	All rights reserved.
#	
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
#	
#	1. Redistributions of source code must retain the above copyright 
#	notice, this list of conditions and the following disclaimer.
#
#	2. Redistributions in binary form must reproduce the above copyright 
#	notice, this list of conditions and the following disclaimer in the 
#	documentation and/or other materials provided with the distribution.
#
#	3. Neither the name of the project nor the names of its contributors 
#	may be used to endorse or promote products derived from this software 
#	without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.

use strict;
use warnings;

package tonejo;

my $PREFIX="[${0}	";
my $SUFFIX="]\n";

my $PADDING="#-------#-------#-------#-------#-------#-------#-------#-------#-------#-------";

# To extend the tests, simply add a new item on the array with the command (CMD) and 
# optionally the arguments (ARGS), both in string form (enclosed in quotes).
my @tests =
(
	{
		CMD  => "env"
	} ,
	{
		CMD  => "hostname"
	} ,
	{
		CMD  => "hostname",
		ARGS => "-f"
	} ,
	{
		CMD  => "cat",
		ARGS => "/proc/version"
	} ,
	{
		CMD  => "uname",
		ARGS => "-a"
	} ,
	{
		CMD  => "lsb_release",
		ARGS => "-a"
	} ,
	{
		CMD  => "ulimit",
		ARGS => "-a"
	} ,
	{
		CMD  => "cat",
		ARGS => "/etc/fstab"
	} ,
	{
		CMD  => "mount"
	} ,
	{
		CMD  => "df",
		ARGS => "-m"
	} ,
	{
		CMD  => "ls",
		ARGS => "-l /lib*/libc-*.so /lib*/libc.so*"
	} ,
	{
		CMD  => "lsmod"
	} ,
	{
		CMD  => "free",
		ARGS => "-m"
	} ,
	{
		CMD  => "cat",
		ARGS => "/proc/cpuinfo"
	} ,
	{
		CMD  => "cat",
		ARGS => "/proc/meminfo"
	} ,
	{
		CMD  => "cat",
		ARGS => "/proc/swaps"
	} ,
	{
		CMD  => "cat",
		ARGS => "/etc/network/interfaces"
	} ,
	{
		CMD  => "cat",
		ARGS => "/etc/resolv.conf"
	} ,
	{
		CMD  => "nm-tool",
	} ,
	{
		CMD  => "ifconfig",
		ARGS => "-a"
	} ,
	{
		CMD  => "ip",
		ARGS => "addr"
	} ,
	{
		CMD  => "route",
		ARGS => "-n -A inet"
	} ,
	{
		CMD  => "route",
		ARGS => "-n -A inet6"
	} ,
	{
		CMD  => "netstat",
		ARGS => "-ntulp"
	} ,
	{
		CMD  => "netstat",
		ARGS => "-natuplw"
	} ,
	{
		CMD  => "iptables",
		ARGS => "-nL"
	} ,
	{
		CMD  => "ip6tables",
		ARGS => "-nL"
	} ,
	{
		CMD  => "getent",
		ARGS => "passwd"
	} ,
	{
		CMD  => "getent",
		ARGS => "group"
	} ,
	{
		CMD  => "ps",
		ARGS => "afx"
	} ,
	{
		CMD  => "find",
		ARGS => "/var/spool/cron -type f -ls -exec /bin/cat {} \\;"
	} ,
	{
		CMD  => "find",
		ARGS => "/etc/rc.d/* /etc/rc.d/rc?.d/* /etc/rc?.d/* /etc/rc.local -ls"
	} ,
	{
		CMD  => "sysctl",
		ARGS => "-a"
	} ,
	{
		CMD  => "cat",
		ARGS => "/etc/apt/sources.list /etc/apt/sources.list.d/*"
	} ,
	{
		CMD  => "dpkg",
		ARGS => "--list"
	} ,
	{
		CMD  => "dpkg",
		ARGS => "--get-selections"
	} ,
	{
		CMD  => "lshw"
	} ,
);

print "# ${0}\n";

for my $test ( @tests )
{
	if (exists $test->{CMD})
	{
		# Get full path of the program
		my $CMD = $test->{CMD};
		my $WHICH = `which $CMD`;
		my $STATUS = $?;
		chomp ($CMD = $WHICH) if (!$STATUS);
		
		# bail out
		next if ($WHICH eq "");

		# concatenate arguments if present
		$CMD .= " ".$test->{ARGS} if (exists $test->{ARGS});

		# Execute program
		my $OUTPUT = `$CMD`;
		$STATUS = $?;
		print "$PADDING\n";
		print "# $CMD\n";
		print "#\t$STATUS\n"; 
		print "$OUTPUT";

		# Clean up
		$CMD = $WHICH = $STATUS = $OUTPUT = undef;
	}
}
