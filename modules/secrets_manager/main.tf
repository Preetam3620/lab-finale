resource "aws_secretsmanager_secret" "main" {
  name        = "invoice-processing-secrets"
  description = "Secrets for Invoice Processing System"

  # rotation_rules {
  #   automatically_after_days = 30
  # }
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id
  secret_string = jsonencode({
    DB_USERNAME = "admin"
    DB_PASSWORD = random_password.db_password.result
    API_KEY     = random_password.api_key.result
  })
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "random_password" "api_key" {
  length  = 32
  special = true
}
