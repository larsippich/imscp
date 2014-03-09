#!/usr/bin/perl

# i-MSCP - internet Multi Server Control Panel
# Copyright (C) 2010-2014 by internet Multi Server Control Panel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# @category    i-MSCP
# @copyright   2010-2014 by i-MSCP | http://i-mscp.net
# @author      Daniel Andreca <sci2tech@gmail.com>
# @link        http://i-mscp.net i-MSCP Home Site
# @license     http://www.gnu.org/licenses/gpl-2.0.html GPL v2

package Servers::named;

use strict;
use warnings;

use iMSCP::Debug;

sub factory
{
	my $self = $_[0];
	my $server = $_[1] || $main::imscpConfig{'NAMED_SERVER'};

	my ($file, $class);

	if($server eq 'external_server') {
		my $oldServer = $main::imscpOldConfig{'NAMED_SERVER'} || 'external_server';

		unless($oldServer eq 'external_server') {
			$file = "Servers/named/$oldServer.pm";
			$class = "Servers::named::$oldServer";

			require $file;

			my $rs = $class->getInstance()->uninstall();
			fatal("Unable to uninstall $oldServer server") if $rs;
		}

		$file = 'Servers/noserver.pm';
		$class = 'Servers::noserver';
	} else {
		$file = "Servers/named/$server.pm";
		$class = "Servers::named::$server";
	}

	require $file;
	$class->getInstance();
}

1;
