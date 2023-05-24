# How to create workspaces

1. Create a boilerplate project.
2. Create a local variable which stores the current workspace:

   ```
   locals {
       environment = terraform.workspace
   }

   ```

3. Create a variables module in which you can set the different variables for each workspace. The module should contain:

   - A main.tf which creates an object for each workspace:

   ```
   locals {
    environments = {
        "staging" : local.staging,
        "production" : local.production,
        "default" : local.default
        }
    }
   ```

   - An outputs.tf which produces the output object of the current workspace's variables, as defined in each specific file.

   ```
    output "env" {
        value = local.environments[var.environment]
    }
   ```

   - A variables.tf which creates variables for each workspace, so they can be used to access the correct output object.

   ```
    variable "environment" {
        description = "The environment used to fetch the variables."
        type        = string
    }

   ```

   - A specific .tf file for each workspace. These contain all of the workspace specific variables that you want to use, eg:

   ```
    locals {
        staging = {
            vpc_name      = "ce-vpc-staging"
            used_by       = "Developers"
            create_remote = false
        }
    }

   ```

4. Declare the module in theroot main.tf so that the variables can be used:

   ```
   module "vars" {
       source      = "./modules/vars"
       environment = local.environment
   }
   ```

5. Use the variables wherever necessary. An example usage would be:

   ```
   resource "aws_vpc" "vpc_main" {
       cidr_block = "172.31.0.0/16"
       tags = {
           Name      = module.vars.env.vpc_name
           ManagedBy = "Terraform"
           UsedBy    = module.vars.env.used_by
       }
   }

    # Here you see the variable being accessed through the module called 'vars'. The output has been defined as 'env', which is an object containing all of the workspace speicifc variables, which can be accessed in the standard way using dot notation.

   ```

6. Create a new workspace using the CLI command:

   ```
   terraform workspace new <workspace_name>
   ```

7. Select the workspace you want to use by using this command:

   ```
   terraform workspace select <workspace_name>
   ```

8. Run 'terraform init' for the first time, then 'terraform plan' and 'terraform apply' can be used as normally.

## Here is the result from this project:

![Screenshot of the AWS console showing three VPC's created by three different workspaces](/workspaces_vpcs.png)
