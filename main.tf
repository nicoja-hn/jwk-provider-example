terraform {
  required_providers {
    jwk = {
      source  = "nicoja-hn/jwk"
      version = "1.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "jwk" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}

# ECDSA key with P384 elliptic curve
resource "tls_private_key" "ecdsa-p384-example" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ECDSA JWK with ES384
data "jwk_extract" "ecdsa-p384-example" {
  public_certificate = tls_private_key.ecdsa-p384-example.public_key_pem
  signing_algorithm  = "ES384"
}

# RSA JWK with RS256
data "jwk_extract" "rsa-4096-example" {
  public_certificate = tls_private_key.rsa-4096-example.public_key_pem
  signing_algorithm  = "RS256"
}

output "jwk_es384" {
  value = data.jwk_extract.ecdsa-p384-example.jwk
}

output "jwk_rs256" {
  value = data.jwk_extract.rsa-4096-example.jwk
}
