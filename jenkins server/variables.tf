variable "vpc_cidr" {
  description = "vpc CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

#Variable Declaration
variable "key_name" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD3BVBp88VgmeWU0ERBBP0C0wIvC9iaFuvOrwwU01EF13e2wjT7XQ8aIvj3CvvVXvoFK5rbms+i2Ky6F0okAS/M+il2PJgKfSUZuKiLUgr652NTADyBTxmDiMCVg/ytT/oBWxW8EF0Iu8cHkjxr1a+gIxQAZV3AgAsCVhs7gYdT5n28gZncYdCfuUp2+dAe9QvJ6RkBSy/ObaC7WrnXI/ld6BsZNJeLVpOzPjbgbRgmMOXKX87vERdi0vQ64QW7DnE/AjhR4SZ8GWxsty8sJvcuvzX2QOA5TUFtteuFE0rqFjXXCwzuysveXYwHqphs0d6LneHkRDj23ChGKaha8pLvharjq8DUtlVZ3UCBRbsT4/joeM/S71LANkhnatqTsIISP+Sg8MCt21oABvQLAcTV0j/OuDH3h+iPavkm5/Ehjkhkgkg+z/niiEOTAfYfB0X9jqmx9r1a+iOoiPc4NBOVBWxBzq718G6xt1rEXwfmOQol0LI+mVGRBmMLgPGBvniXQv04rQqhQmRvkXHDj8nlXhNoaoXMR0pzvFuxRq/AZnCbaDRRWbEbmUREWLNFB+ZPa0qSMIBH1u8+3p3TxOumnQWw3TxRtSVfTwIPuxjFNyjCe4SyEh90aEK5P/IAPhe9x+O435Z+Es9331Q== preeti@ExampleMachine"
}