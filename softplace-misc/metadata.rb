name              "softplace-misc"
maintainer        "Softplace"
maintainer_email  "info@softplace.it"
license           "MIT"
description       "Miscellaneous small tasks"
recipe            "softplace-misc::server", "Install PHP server"

%w{ ubuntu }.each do |os|
  supports os
end

depends "apache2"
depends "php"
depends "apt"
depends "openssl"
depends "mysql"
