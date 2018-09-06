# Sparrowdo::VSTS::YAML::Update::Azure::SSL

Sparrowdo module to generate VSTS yaml build definitions to update Azure ssl certs.

    $ cat sparrowfile

    module_run "VSTS::YAML::Update::Azure::SSL", %(
      build-dir => ".build",
      subscription => "Dev01", # Azure subscription,
      keyvault-name => "app-01-02", # the name of keyvault holding certificates 
      cert-name => app-dev, # certificate name in keyvault 
      domain => "foo.bar", # web application domain name
      app-service => "foo-bar", # azure app service name ( a.k web application )
    );

    $ sparrowdo --local_mode --no_sudo

# Author

Alexey Melezhik

