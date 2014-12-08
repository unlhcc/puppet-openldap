#
# openldap::client
#

class openldap::client (
    $uri            = $openldap::params::uri,
    $base           = $openldap::params::base,
    $tls_cacert     = $openldap::params::tls_cacert,
    $tls_cacertdir  = $openldap::params::tls_cacertdir,
    $tls_reqcert    = $openldap::params::tls_reqcert,
) inherits openldap::params {

    validate_string($uri)
    validate_string($base)
    if ($tls_cacert) { validate_absolute_path($tls_cacert) }
    if ($tls_cacertdir) { validate_absolute_path($tls_cacertdir) }
    validate_string($tls_reqcert)

    package { 'openldap':
        ensure => 'present'
    }

    file { '/etc/openldap/ldap.conf':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['openldap'],
        content => template('openldap/openldap-ldap.conf.erb'),
    }

}

