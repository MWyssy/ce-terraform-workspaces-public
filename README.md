# Terraform workspaces

At some point in your terraform journey you will encounter having to run terraform against [mutliple environments](https://codebots.com/app-development/what-are-environments-in-software-development-a-guide-to-the-development-beta-and-production-environments).

Having a consistency across environments, staging being similar to production for example, helps debug if things are going wrong.

In order to do that we ideally want to run the exact same terraform files against different environments with only the configuration between the environments being different. 

For example the config for the staging environment might make set a certain key/pair for staging and a different key/pair for production.

The terraform code would be the same it is just the tfvars that could change.

A way of doing this in terraform is to utilise [workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces).

## Pre-requisites

- You have completed the [remote state exercise](https://github.com/northcoders/ce-terraform-remote-state)

## Instructions

In this exercise we would like you to create a VPC, via Terraform. 

The terraform state should be configured such that it uses remote state stored in S3 and DynamoDB.

**🗒️ Note:** You do not need to create subnets etc - this exercise is to learn workspaces so just making the VPC for now is fine.

You should have two workspaces - one called "staging" and one called "production"

For the staging environment when you run the terraform apply it should create a VPC called "ce-vpc-staging" and for the production environment it should be "ce-vpc-production".

The VPC should also have a tag called "UsedBy" and if it is the staging environment then the value for the tag should be "Developers", if it is the production environment then the value should be "Customers".

Your submission should include:

* A **main.tf** that creates your VPC
* A **providers.tf** that configures the AWS provider
* A **backend.tf** that configures your remote state settings

## Tearing things down

You should run `terraform destroy` to remove everything.

**🗒️ Note:** When using remote state sometimes the terraform destroy has a problem trying to remove your S3 bucket and DynamoDB table. if you experience this issue you can manually delete them using the AWS console.

## Submission process

1. Fork this GitHub repository

2. Make regular commits and pushes back to your repository as you write your code. It help us to see the journey you worked through when completing the task.

3. Create a SOLUTION.md that outlines the following:
    - A screenshot showing the two VPC's and their tags.
    
4. Share your GitHub link

5. Tear things down as described above

## Further reading

[Concept of software environments](https://codebots.com/app-development/what-are-environments-in-software-development-a-guide-to-the-development-beta-and-production-environments)

[What are terraform workspaces](https://spacelift.io/blog/terraform-workspaces)

[Environment variables with Terraform workspaces](https://medium.com/@milescollier/handling-environmental-variables-in-terraform-workspaces-27d0278423df)



