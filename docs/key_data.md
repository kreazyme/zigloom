```
keytool -genkey -v \

> -keystore android/keystore.jks \
>  -storepass "123456" \
>  -keypass "123456" \
>  -keyalg RSA \
>  -keysize 2048 \
>  -validity 10000 \
>  -alias "kreazy"
> What is your first and last name?
> [Unknown]: Kreazy
> What is the name of your organizational unit?
> [Unknown]: DUT
> What is the name of your organization?
> [Unknown]: DUT
> What is the name of your City or Locality?
> [Unknown]: DN
> What is the name of your State or Province?
> [Unknown]: DN
> What is the two-letter country code for this unit?
> [Unknown]: VN
> Is CN=Kreazy, OU=DUT, O=DUT, L=DN, ST=DN, C=VN correct?
> [no]:
> What is your first and last name?
> [Kreazy]: Kreazy
> What is the name of your organizational unit?
> [DUT]: DUT
> What is the name of your organization?
> [DUT]: DUT
> What is the name of your City or Locality?
> [DN]: DN
> What is the name of your State or Province?
> [DN]: DN
> What is the two-letter country code for this unit?
> [VN]: VN
> Is CN=Kreazy, OU=DUT, O=DUT, L=DN, ST=DN, C=VN correct?
> [no]: yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
for: CN=Kreazy, OU=DUT, O=DUT, L=DN, ST=DN, C=VN
[Storing android/keystore.jks]

```
