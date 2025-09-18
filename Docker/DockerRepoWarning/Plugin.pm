package Slim::Plugin::DockerRepoWarning::Plugin;

use strict;

use base qw(Slim::Plugin::OPMLBased);

sub initPlugin {
	my $class = shift;

	Slim::Utils::Log::logWarning(qq(\n
The lmscommunity/logitechmediaserver Docker image is deprecated.
Please migrate to lmscommunity/lyrionmusicserver instead.
	));

	$class->SUPER::initPlugin(
		feed   => sub {
			my ($client, $cb, $args) = @_;
			$cb->([{
				name => Slim::Utils::Strings::cstring($client, 'PLUGIN_DOCKER_REPO_WARNING_INFO'),
				type => 'textarea'
			}]);
		},
		tag    => 'dockerimagemigration',
		# node   => 'home',
		weight => 1,
		is_app => 1,
	);
}


sub getDisplayName {
	return 'PLUGIN_DOCKER_REPO_WARNING';
}


1;