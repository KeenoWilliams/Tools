import ldap3

# LDAP server information
server = ldap3.Server("ldap://<host>:<port>")

# Connection to the LDAP server
conn = ldap3.Connection(server, user="<bind_dn>", password="<bind_password>", auto_bind=True)

# Search base DN
base_dn = "<base_dn>"

# Search filter to retrieve users
user_filter = "(&(objectClass=user)(objectCategory=person))"

# Search filter to retrieve administrators
admin_filter = "(&(objectClass=user)(memberOf=CN=Administrators,CN=Builtin,<base_dn>))"

# Retrieve all the users
conn.search(base_dn, user_filter, attributes=["cn", "displayName", "mail", "sAMAccountName"])

# Store the retrieved users in a list
users = [entry for entry in conn.response]

# Retrieve all the administrators
conn.search(base_dn, admin_filter, attributes=["cn", "displayName", "mail", "sAMAccountName"])

# Store the retrieved administrators in a list
admins = [entry for entry in conn.response]

# Print the retrieved users and administrators
print("Users:")
for user in users:
    print(user["attributes"])

print("\nAdministrators:")
for admin in admins:
    print(admin["attributes"])

# Close the connection to the LDAP server
conn.unbind()
