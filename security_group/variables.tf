variable "vpc_id" {
    type = string
}

# variable "cidr_block" {
#     type = string
#     # default = ["10.0.0.0/16"]
# }


variable "ports" {
    type = list(number)
    default = [ 22,443,80, 3306, 27017 ]
}