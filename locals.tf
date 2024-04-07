locals {
  name = "${var.application_name}-${var.enviroment}"
  tags = {
    Enviroment  = var.enviroment
    Application = var.application_name
  }
}

