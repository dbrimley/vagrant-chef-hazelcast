name "default"
description "AWS Default"
override_attributes "hazelcast" => { 
"group_username" => "aws-cluster",
"group_password" => "aws-cluster-password",
"network_multicast_enabled" => "false",
"network_aws_enabled" => "true" }