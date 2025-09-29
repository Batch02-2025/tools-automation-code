ui            = true

storage "vfile" {
  path = "~/vault-storage"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = true
}

