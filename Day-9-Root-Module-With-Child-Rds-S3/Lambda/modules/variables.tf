variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime (e.g., nodejs18.x, python3.9)"
  type        = string
}

variable "handler" {
  description = "Handler file and function (e.g., index.handler)"
  type        = string
}

variable "filename" {
  description = "Path to the ZIP file containing Lambda code"
  type        = string
}
