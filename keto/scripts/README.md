# Role-Permission Mapping Script

This script allows you to create role-permission mappings by sending cURL requests to a specified URL(ory keto). It reads JSON data from a file and iterates over roles and permissions to create the mappings.

## Prerequisites

- cURL: Make sure cURL is installed on your system.
- `jq`: Install `jq` to parse JSON data. You can download it from [https://stedolan.github.io/jq/](https://stedolan.github.io/jq/).

## Usage

1. Prepare the JSON file: Create a file named `roles-permissions.json` and populate it with the role-permission mappings in the following format:
```
   {
     "roles": {
       "role1": ["permission1", "permission2"],
       "role2": ["permission3", "permission4"]
     }
   }
```
2. Update the roles and permissions according to your requirements.

3. Open a terminal and navigate to the directory where the script is located.

4. Make the script executable, if necessary, using the following command:
```
chmod +x script.sh
```
5. Execute the script by running the following command:
```
./script.sh
```
The script will read the JSON data from the roles-permissions.json file and process each role with its corresponding permissions.

It will send cURL requests to create the role-permission mappings for each role and permission combination.

You will see success messages for each role-permission mapping created, or error messages if any failures occur.

**Note:** Ensure that the configuration variables URL, NAMESPACE, and RELATION in the script are correctly set according to your requirements before running the script.

Caution: Make sure to review the JSON file and script logic to ensure it aligns with your desired role-permission mapping requirements.



# User Role Assignment Script

This script allows you to assign roles to users using a cURL request to a specified URL. It takes input for roles and user IDs, and sends requests to assign each role to each user ID.

## Prerequisites

- cURL: Make sure cURL is installed on your system.

## Usage

1. Open a terminal and navigate to the directory where the script is located.

2. Make the script executable, if necessary, using the following command:

```
chmod +x script.sh
```

3. Execute the script by running the following command:
```
./script.sh
```

4. The script will prompt you to enter the set of roles to assign, comma-separated. For example:
Enter the set of roles to assign (comma-separated): role1, role2, role3

5. Next, the script will prompt you to enter the set of user IDs to assign roles to, comma-separated. For example:
Enter the set of user IDs to assign roles to (comma-separated): user1, user2, user3

6. The script will send cURL requests to assign each role to each user ID. You will see success or error messages for each assignment.

7. After all role assignments are completed, the script will ask if you want to assign roles to more users. If you choose to continue, repeat steps 4-7. If not, the script will exit.

**Note:** Ensure that the URL, namespace, and relation variables in the script are correctly set according to your requirements before running the script.






