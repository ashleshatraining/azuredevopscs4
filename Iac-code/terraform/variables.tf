variable "planname" {
    type = string
    description = "app service plan name"

  
}
variable "appname" {
  type = string
  description = "app service name"
}
variable "rg" {
    type = string
    default = "Paritala"
    
  
}