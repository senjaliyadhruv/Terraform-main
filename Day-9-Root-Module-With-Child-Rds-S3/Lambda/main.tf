module "lambda_fn" {
  source        = "./modules"
  function_name = var.function_name
  runtime       = var.runtime
  handler       = var.handler
  filename      = var.filename
}
