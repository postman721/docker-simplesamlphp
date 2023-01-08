 A custom template theme is added to this image.
 Otherwise, this is the same as the main image.
 
 Using docker run command

docker run --name=idp \
  -p 8080:8080 \
  -e SIMPLESAMLPHP_SP_ENTITY_ID=http://app.example.com \
  -e SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE=http://localhost/simplesaml/module.php/saml/sp/saml2-acs.php/test-sp \
  -e SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE=http://localhost/simplesaml/module.php/saml/sp/saml2-logout.php/test-sp \
  -d jjposti/saml20:themed
 
