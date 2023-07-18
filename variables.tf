variable "project" {
    type = string
    default = "db-cicdpipeline-wave3"
}

variable "region" {
    type = string
    default = "asia-east2"
}

variable "key_name" {

  description = "Name of the KMS key"

  type = string

}

variable "keyring_name" {

  description = "Name of the KMS Keyring"

  type = string

}

variable "algorithm" {

  description = "Algorithm for the KMS key"


  type = string

}

variable "rotation_period" {

  description = "Time in seconds to rotate key"

  type = string


}
