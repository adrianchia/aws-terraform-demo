variable "default-region" {
  default = "us-east-1"
}

variable "az_config" {
  default = [
    {
      az_name = "us-east-1a"
      subnets = [
        {
          cidr_block = "10.0.0.0/19"
          is_private = true
        },
        {
          cidr_block = "10.0.128.0/20"
          is_private = false
        },
        {
          cidr_block = "10.0.192.0/21"
          is_private = true
        },
        # spare subnet
        #{
         # cidr_block = "10.0.224.0/21"
         # is_private = true
        #}
      ]
    },
    {
      az_name = "us-east-1b"
      subnets = [
        {
          cidr_block = "10.0.32.0/19"
          is_private = true
        },
        {
          cidr_block = "10.0.144.0/20"
          is_private = false
        },
        {
          cidr_block = "10.0.200.0/21"
          is_private = true
        },
        # spare subnet
        #{
         # cidr_block = "10.0.232.0/21"
         # is_private = true
        #}
      ]
    },
    {
      az_name = "us-east-1c"
      subnets = [
        {
          cidr_block = "10.0.64.0/19"
          is_private = true
        },
        {
          cidr_block = "10.0.160.0/20"
          is_private = false
        },
        {
          cidr_block = "10.0.208.0/21"
          is_private = true
        },
        # spare subnet
        #{
         # cidr_block = "10.0.240.0/21"
         # is_private = true
        #}
      ]
    },
    {
      az_name = "us-east-1d"
      subnets = [
        {
          cidr_block = "10.0.96.0/19"
          is_private = true
        },
        {
          cidr_block = "10.0.176.0/20"
          is_private = false
        },
        {
          cidr_block = "10.0.216.0/21"
          is_private = true
        },
        # spare subnet
        #{
         # cidr_block = "10.0.248.0/21"
         # is_private = true
        #}
      ]
    }
  ]
}
