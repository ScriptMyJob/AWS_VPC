########################################
### IAM Policy Documents ###############
########################################

# Associate IP
####################

data "aws_iam_policy_document" "associate_ip" {
    statement {
        effect = "Allow"
        actions = [
            "ec2:AssociateAddress"
        ]
        resources = [
            "*"
        ]
    }
}

# Grimoire
####################

data "aws_iam_policy_document" "grimoire_backups" {
    statement {
        effect = "Allow"
        actions = [
            "s3:Get*",
            "s3:Put*"
        ]
        resources = [
            "arn:aws:s3:::grimoire.scriptmyjob.com-backups/*"
        ]
    }
}

########################################
### IAM Policies #######################
########################################

# Associate IP
####################

resource "aws_iam_policy" "associate_ip" {
    name    = "AssociateIP"
    policy  = "${data.aws_iam_policy_document.associate_ip.json}"
}

# Grimoire
####################

resource "aws_iam_policy" "grimoire_backups" {
    name    = "GrimoireBackups"
    policy  = "${data.aws_iam_policy_document.grimoire_backups.json}"
}

########################################
### IAM Roles ##########################
########################################

# Associate IP
####################

resource "aws_iam_role" "associate_ip" {
    name        = "AssociateIP"
    description = "This is a role to allow EC2 instance to allocate an IP for itself."
    assume_role_policy = "${lookup(var.ec2,"policy")}"
}

# Grimoire
####################

resource "aws_iam_role" "grimoire" {
    name        = "Grimoire"
    description = "This is a role to Confluence to backup to S3 as well as allocate an IP for itself"
    assume_role_policy = "${lookup(var.ec2,"policy")}"
}

########################################
### IAM Policy Attachments #############
########################################

# Associate IP
####################

resource "aws_iam_policy_attachment" "associate_ip" {
    name            = "AssociateIP"
    roles           = [
        "${aws_iam_role.associate_ip.name}",
        "${aws_iam_role.grimoire.name}"
    ]
    policy_arn      = "${aws_iam_policy.associate_ip.arn}"
}

# Grimoire
####################

resource "aws_iam_policy_attachment" "grimoire" {
    name            = "GrimoireBackups"
    roles           = [
        "${aws_iam_role.grimoire.name}",
    ]
    policy_arn      = "${aws_iam_policy.grimoire_backups.arn}"
}

########################################
### IAM Instance Profile ###############
########################################

# Associate IP
####################

resource "aws_iam_instance_profile" "associate_ip" {
    name  = "AssociateIP"
    role = "${aws_iam_role.associate_ip.name}"
}

# Grimoire
####################

resource "aws_iam_instance_profile" "grimoire" {
    name  = "Grimoire"
    role = "${aws_iam_role.grimoire.name}"
}
