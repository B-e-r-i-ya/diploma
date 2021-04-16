module PXC 1.0;

require {
        type unconfined_t;
        type init_t;
        type auditd_t;
        type mysqld_t;
        type syslogd_t;
        type NetworkManager_t;
        type unconfined_service_t;
        type system_dbusd_t;
        type tuned_t;
        type tmp_t;
        type dhcpc_t;
        type sysctl_net_t;
        type kerberos_port_t;
        type kernel_t;
        type unreserved_port_t;
        type firewalld_t;
        type systemd_logind_t;
        type chronyd_t;
        type policykit_t;
        type udev_t;
        type mysqld_safe_t;
        type postfix_pickup_t;
        type sshd_t;
        type crond_t;
        type getty_t;
        type lvm_t;
        type postfix_qmgr_t;
        type postfix_master_t;
        class process { getattr setpgid };
        class unix_stream_socket connectto;
        class system module_request;
        class netlink_tcpdiag_socket { bind create getattr nlmsg_read setopt };
        class tcp_socket { name_bind name_connect };
        class file { getattr open read write };
        class dir search;
}