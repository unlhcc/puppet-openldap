puppet-openldap
===============

Basic OpenLDAP client module for HCC

Example usage
-------------

### Profile
```
class profile::base {

    include openldap::client

    $openldap_cacerts = hiera("openldap::cacerts", {})
    create_resources('openldap::cacert', $openldap_cacerts)

}
```

### Hiera
```
openldap::client::uri: 'ldap://ldap1.example.edu ldap://ldap2.example.edu'
openldap::client::base: 'dc=example,dc=edu'
openldap::client::tls_cacertdir: '/etc/openldap/cacerts'

openldap::cacerts:
    demo-ca-01:
        cert: |
            -----BEGIN CERTIFICATE-----
            4ixSbovCjXRwPkKYx6OsmHKNQJtoi1pn43NGjMl4ZSiUq2q0M6jhw42rEVeje9yP
            -----END CERTIFICATE-----
        hash: a07ed8f1
    bad-ca-02:
        ensure: absent
        cert: |
            -----BEGIN CERTIFICATE-----
            4Xq7z4nn13vpkj6FnIPhcZJKsQxwdXQuu170ck7PYCAEyy91UpEkIkMaKD2B8Djg
            -----END CERTIFICATE-----
        hash: c57d9832
```

To generate the hash value for a certificate, use the OpenSSL x509 utility:
```
openssl x509 -noout -hash -in file.crt
```
