#!/bin/bash

# load environment variables
set -a && source .env && set +a

required_vars=(
    "location"
    "environment"
    "network_resource_group_name"
    "virtual_wan_name"
    "virtual_hub_address_prefix"
    "management_resource_group_name"
    "la_workspace_name"
)

# Set the current directory to where the script lives.
cd "$(dirname "$0")"


# Function to check if all required arguments have been set
check_required_arguments() {
    # Array to store the names of the missing arguments
    local missing_arguments=()

    # Loop through the array of required argument names
    for arg_name in "${required_vars[@]}"; do
        # Check if the argument value is empty
        if [[ -z "${!arg_name}" ]]; then
            # Add the name of the missing argument to the array
            missing_arguments+=("${arg_name}")
        fi
    done

    # Check if any required argument is missing
    if [[ ${#missing_arguments[@]} -gt 0 ]]; then
        echo -e "\nError: Missing required arguments:"
        printf '  %s\n' "${missing_arguments[@]}"
        [ ! \( \( $# == 1 \) -a \( "$1" == "-c" \) \) ] && echo "  Either provide a config file path or all the arguments, but not both at the same time."
        [ ! \( $# == 22 \) ] && echo "  All arguments must be provided."
        echo ""
        exit 1
    fi
}

####################################################################################

# Check if all required arguments have been set
check_required_arguments


# Variables
export TF_VAR_location=$location
export TF_VAR_environment=$environment
export TF_VAR_network_resource_group_name=$network_resource_group_name
export TF_VAR_virtual_wan_name=$virtual_wan_name
export TF_VAR_virtual_hub_address_prefix=$virtual_hub_address_prefix
export TF_VAR_management_resource_group_name=$management_resource_group_name
export TF_VAR_la_workspace_name=$la_workspace_name
 

########################################
# Terraform steps
terraform init

terraform plan -out main.tfplan

terraform apply main.tfplan
