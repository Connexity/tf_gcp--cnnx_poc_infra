import {
  id = "terraform_import_multi1"
  to = module.infrastructure.google_secret_manager_secret.secret--terraform_import_multi1
}

import {
  id = "terraform_import_multi2"
  to = module.infrastructure.google_secret_manager_secret.secret--terraform_import_multi2
}

import {
  id = "terraform_import_multi3"
  to = module.infrastructure.google_secret_manager_secret.secret--terraform_import_multi3
}
