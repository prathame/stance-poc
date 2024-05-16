#!/bin/bash

# Exit immediately if any command fails
set -e

# Configuration variables
URL='http://localhost:4467/admin/relation-tuples'
NAMESPACE='default-namespace'
RELATION='member'

# Read JSON data from file
json=$(cat roles-permissions.json)

echo "Reading JSON data from file..."

# Iterate over roles and permissions
for role in $(echo "${json}" | jq -r '.roles | keys[]'); do

    echo -e "\n******* Processing role: ${role} *******\n"

    permissions=$(echo "${json}" | jq -r ".roles.\"${role}\"[]")
    # Iterate over permissions for each role
    for permission in ${permissions}; do

        # Create cURL request JSON
        request_data=$(jq -n --arg role "${role}" --arg permission "${permission}" --arg namespace "${NAMESPACE}" --arg relation "${RELATION}" '{
            "namespace": $namespace,
            "object": $permission,
            "relation": $relation,
            "subject_set": {
                "namespace": $namespace,
                "object": $role,
                "relation": "member"
            }
        }')

        # Send cURL request to ORY Keto
        response=$(curl --silent --location --request PUT "${URL}" \
            --header 'Content-Type: application/json' \
            --data-raw "${request_data}" 2>&1)

        if [ $? -eq 0 ]; then
            echo "Created role-permission mapping for Role: ${role}, Permission: ${permission}"
        else
            echo "Error: Failed to add permission to role."
            echo "Response: ${response}"
        fi
    done
done
