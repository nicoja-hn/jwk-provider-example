# JWK terraform provider example usage

* Uses custom JWK terraform provider from [nicoja-hn/terraform-provider-jwk](https://github.com/nicoja-hn/terraform-provider-jwk) and the official [hashicorp/terraform-provider-tls](https://github.com/hashicorp/terraform-provider-tls) for key generation
* Creates a JWK from RSA and ECDSA (public) keys for downstream usage

## Example usage

* Initialize terraform provider
```bash
terraform init
```

* Show what will be done
```bash
terraform plan
```

* Create resources (and store output)
```bash
terraform apply -auto-approve
```

* Show first JWK output (based on ECDSA key with ES256)
```bash
terraform output -raw jwk_es256 | jq
```
```json
{
  "keys": [
    {
      "use": "sig",
      "kty": "EC",
      "kid": "zF5...",
      "crv": "P-384",
      "alg": "ES256",
      "x": "DcT...",
      "y": "U_J..."
    }
  ]
}
```

* Show second JWK output (based on RSA key with RS256)
```bash
terraform output -raw jwk_rs256 | jq
```
```json
{
  "keys": [
    {
      "use": "sig",
      "kty": "RSA",
      "kid": "BCf...",
      "alg": "RS256",
      "n": "tJL...",
      "e": "AQAB"
    }
  ]
}
```

* You can also combine both into one JWKS
```bash
echo $(terraform output -raw jwk_es256 | jq -c)$(terraform output -raw jwk_rs256 | jq -c) | jq -n '{ keys: [inputs | .keys[]] }'
```
```json
{
  "keys": [
    {
      "use": "sig",
      "kty": "EC",
      "kid": "zF5...",
      "crv": "P-384",
      "alg": "ES256",
      "x": "DcT...",
      "y": "U_J..."
    },
    {
      "use": "sig",
      "kty": "RSA",
      "kid": "BCf...",
      "alg": "RS256",
      "n": "tJL...",
      "e": "AQAB"
    }
  ]
}
```

* Destroy resources
```bash
terraform destroy -auto-approve
```
