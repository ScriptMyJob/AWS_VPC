# Written by: Robert J.
# Email: Robert@scriptmyjob.com
################################

########################################
### Creds: #############################
########################################

provider "aws" {
    region     = "${lookup(var.global,"region")}"
}
