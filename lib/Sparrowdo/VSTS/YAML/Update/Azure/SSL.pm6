use v6;

unit module Sparrowdo::VSTS::YAML::Update::Azure::SSL:ver<0.0.1>;

use Sparrowdo;
use Sparrowdo::Core::DSL::Template;
use Sparrowdo::Core::DSL::File;
use Sparrowdo::Core::DSL::Directory;
use Sparrowdo::Core::DSL::Bash;

our sub tasks (%args) {


  my $build-dir = %args<build-dir> || die "usage module_run '{ ::?MODULE.^name }' ,%(build-dir => dir)";

  directory "$build-dir/.cache";
  directory "$build-dir/files";

  file "$build-dir/files/gene-arm.pl", %( content => slurp %?RESOURCES<gene-arm.pl>.Str );

  template-create "$build-dir/.cache/build.yaml.sample", %(
    source => ( slurp %?RESOURCES<build.yaml> ),
    variables => %( 
      base_dir => "$build-dir/files",
      subscription => %args<subscription>, # Azure subscription,
      keyvault-name => %args<keyvault-name>, # the name of keyvault holding certificates
      cert-name => %args<cert-name>, # certificate name in keyvault
      domain => %args<domain>, # web application domain name
      app-service => %args<app-service>, # azure app service name ( a.k web application )
    )
  );

  bash "cat $build-dir/.cache/build.yaml.sample >> $build-dir/build.yaml";

}


