#!/usr/bin/perl 
#       snort-alert-db.pl
#       @WizardIP
#       Script que permite visualizar los logs de Snort almacenados en MySQL. 
#
#       This script is released under the GPLv2
#
 use warnings;
 use DBI;
 $dbh = DBI->connect('dbi:mysql:[Usuario BD]','[nombre BD]','[Password]')
 or die "Connection Error: $DBI::errstr\n";
 $sql = "SELECT inet_ntoa(ip_src), inet_ntoa(ip_dst) FROM iphdr;";
 $sth = $dbh->prepare($sql);
 $sth->execute
 or die "SQL Error: $DBI::errstr\n";
 print "IP Origen       IP Destino       Timestamp\n";
 $sql = "select timestamp from event;";
 $sth1 = $dbh->prepare($sql);
 $sth1->execute
 or die "SQL Error: $DBI::errstr\n";
 $sql = "select sig_id,sig_name from signature;";
 $sth2 = $dbh->prepare($sql);
 $sth2->execute
 or die "SQL Error: $DBI::errstr\n";
 while ((@row = $sth->fetchrow_array) && (@row1 = $sth1->fetchrow_array)) {
 print "@row     @row1  \n";
 }
 print "Eventos\n";
 while (@row2 = $sth2->fetchrow_array) {
 print "@row2\n";
 }

