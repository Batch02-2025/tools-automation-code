# Enable the UI
ui = true

# Disable mlock (required if not running as root or without privileges)
# disable_mlock = true

# Listener for external access (HTTP for testing)
listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = 1
}

# File storage backend
storage "file" {
  path = "/var/lib/openbao/data"
}
