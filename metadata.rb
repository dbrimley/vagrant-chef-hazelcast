name             'hazelcast'
maintainer       'David Brimley'
maintainer_email 'david@hazelcast.com'
license          'Apache 2'
description      'Installs/Configures hazelcar'
long_description 'Installs/Configures hazelcar'
version          '0.1.0'

depends 'zip'
depends 'java'

%w{ ubuntu debian centos redhat amazon scientific oracle fedora }.each do |os|
  supports os
end