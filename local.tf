# local variables
locals {
    location="East US"
    
    virtual_network_address_space= {
        development = "10.0.0.0/16"
        staging = "10.1.0.0/16"
        production = "10.2.0.0/16"
    }

    subnet_address_prefix = {
        development = ["10.0.0.0/24", "10.0.1.0/24"]
        staging = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
        production = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
    }

    common_tags = {
        development = {"department" = "IT", "enviornment" = "development", "tier" = "1"}
        staging = {"department" = "IT", "enviornment" = "staging", "tier" = "2"}
        production = {"department" = "IT", "enviornment" = "production", "tier" = "3"}
    }
}