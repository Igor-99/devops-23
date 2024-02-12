terraform {

  backend "remote" {
    organization = "revinii"

    workspaces {
      name = "vpc-stage"
    }
  }
}
