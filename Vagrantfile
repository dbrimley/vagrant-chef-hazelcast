# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

NUM_BOXES=10

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # A Vagrant plugin that ensures the desired version of Chef is installed via the platform-specific Omnibus packages. 
  # This proves very useful when using Vagrant with provisioner-less baseboxes OR cloud images.
  #
  # Make sure you've pre-installed vagrant-omnibus by running this on the command line :-
  #
  # vagrant plugin install vagrant-omnibus
  
  config.omnibus.chef_version = :latest

  # Enable Berkshelf cookbook dependency manager (http://berkshelf.com/)
  #
  # Make sure you've pre-installed berkshelf by running this on the command line :-
  #
  # vagrant plugin install vagrant-berkshelf

  #config.berkshelf.enabled = true

  # VIRTUAL BOX PROVIDER

  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = "ubuntu/trusty64"
  
        override.vm.provision "chef_solo" do |chef|
          #chef.log_level = :debug
          chef.cookbooks_path = "../../../chef-repo/cookbooks"
          chef.environments_path = "./environments/virtualbox"
          chef.environment = "default"
          chef.add_recipe "hazelcast"
        end
  end

  # AMAZON EC2 PROVIDER

  # To use the Amazon provider you'll need to install the AWS Vagrant Plugin
  # Follow the instructions found here :-
  # https://github.com/mitchellh/vagrant-aws

  config.vm.provider :aws do |aws, override|

    override.vm.box = "dummy"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    aws.region =  "us-east-1"
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']
    aws.instance_type = 'm3.medium'
    aws.ami = "ami-9eaa1cf6" # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type
    aws.keypair_name = ENV['AWS_KEY_PAIR_NAME']
    aws.security_groups = ENV['AWS_SECURITY_GROUPS']

    aws.tags = {'hazelcast_service' => 'true'}

    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = "/Users/dbrimley/Dev/aws/wan-rep-demo/us-east-1/david.pem"

    override.vm.provision "chef_solo" do |chef|

      chef.log_level = :debug
      chef.cookbooks_path = "../../../chef-repo/cookbooks"
      chef.environments_path = "./environments/aws"
      chef.environment = "default"        
      chef.json = {
                      :hazelcast => {
                      :network_aws_access_key => ENV['AWS_ACCESS_KEY'],
                      :network_aws_secret_key => ENV['AWS_SECRET_KEY'],
                      :network_aws_region => "us-east-1",
                      :network_aws_host_header => "https://ec2.us-east-1.amazonaws.com",
                      :network_aws_security_group => ENV['AWS_SECURITY_GROUPS'],
                      :network_aws_tag_key => "hazelcast_service",
                      :network_aws_tag_value => "true"
                    }}
      chef.add_recipe "hazelcast"

    end

  end

  (1..NUM_BOXES).each do |i|
    
    config.vm.define "hazelcast#{i}".to_sym do |vm|
    end

  end

end



