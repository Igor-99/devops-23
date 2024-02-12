terraform {

  backend "remote" {
    organization = "revinii"

    workspaces {
      name = "vpc-prod"
    }
  }
}
