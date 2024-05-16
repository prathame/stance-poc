#!/bin/bash

URL='http://localhost:4467/admin/relation-tuples'
NAMESPACE='default-namespace'
RELATION='member'

while true; do
    echo "Enter the set of roles to assign (comma-separated):"
    read -r roles
    roles=${roles// /}  # Remove spaces from roles input

    echo "Enter the set of user IDs to assign roles to (comma-separated):"
    read -r user_ids
    user_ids=${user_ids// /}  # Remove spaces from user_ids input

    # Convert comma-separated values to arrays
    IFS=',' read -ra role_array <<< "$roles"
    IFS=',' read -ra user_id_array <<< "$user_ids"

    # Iterate over each role
    for role in "${role_array[@]}"; do
        # Iterate over each user ID
        for user_id in "${user_id_array[@]}"; do
            # Create cURL request JSON
            request_data=$(jq -n --arg role "$role" --arg user_id "$user_id" --arg namespace "$NAMESPACE" --arg relation "$RELATION" '{
                "namespace": $namespace,
                "object": $role,
                "relation": $relation,
                "subject_set": {
                    "namespace": $namespace,
                    "object": $user_id,
                    "relation": $relation
                }
            }')

            # Send cURL request to assign role to user
            response=$(curl --silent --show-error --location --request PUT "${URL}" \
                --header 'Content-Type: application/json' \
                --data-raw "$request_data" 2>&1)

            if [ $? -eq 0 ]; then
                echo "Role '$role' assigned to user '$user_id' successfully."
            else
                error_message=$(echo "$response" | grep -oP '(?<=<title>)(.*)(?=</title>)')

                if [ -n "$error_message" ]; then
                    echo "Error: $error_message"
                else
                    echo "Error: Failed to assign role '$role' to user '$user_id'."
                fi
            fi
        done
    done

    echo "Do you want to assign roles to more users? (Y/N)"
    read -r choice

    if [ "$choice" != "Y" ] && [ "$choice" != "y" ]; then
        break
    fi
done
