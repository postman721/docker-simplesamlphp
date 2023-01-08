FROM  jjposti/saml20

#Adding custom theme
#To use this theme, add
# 'theme.use' => '62086817cf3b:62086817cf3b',
#into config/config.php

#Add theme into place
ADD mytheme /var/www/simplesamlphp/modules/

#Copy config into place
COPY config.php /var/www/simplesamlphp/config/
