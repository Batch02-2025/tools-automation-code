ui            = true
disable_mlock = true

storage "vault-storage" {
  path = "~/vault-storage"
}

listener "tcp" {
  address       = "127.0.0.1:8200"
}

