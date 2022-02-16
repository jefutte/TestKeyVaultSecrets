terraform {
  backend "azurerm" {
    key                  = "gh_actions_test.tfstate"
  }
}
