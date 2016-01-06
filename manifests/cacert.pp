#
# openldap::cacert
#

define openldap::cacert (
    $cert           = undef,
    $hash           = undef,
    $tls_cacertdir  = hiera('openldap::client::tls_cacertdir'),
    $ensure         = 'present',
) {

    # sssd loads certs on startup
    if defined(Service['sssd']) {
        $cert_notify = [ Service['sssd'] ]
    }

    file { "${tls_cacertdir}/${name}.crt":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => $cert,
        require => File[$tls_cacertdir],
        notify  => $cert_notify,
    }

    $link_state = $ensure ? { default => 'link', 'absent' => 'absent' }

    file { "${tls_cacertdir}/${hash}.0":
        ensure => $link_state,
        target => "${name}.crt",
        require => File[$tls_cacertdir],
        notify  => $cert_notify,
    }

}
