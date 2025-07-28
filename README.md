# Palantir PG

A tool for managing PostgreSQL databases with ease, allowing you to create, edit, and execute SQL queries efficiently.

## Installation

Install the required Ruby gems to get started:

```bash
bundle install
```

## Setting Up Aliases

Simplify command execution by setting up aliases:

```bash
chmod +x palantir_aliases.sh
./palantir_aliases.sh
```

Load new aliases

```bash
cd ~
source ~/.bashrc
```
Verify that aliases work

```bash
palantir_logo
```
## Getting Started with Palantir

Follow these steps to configure and use Palantir with your PostgreSQL database.

### 1. Register Your Database

Register your database by providing the necessary connection details:
```bash
# Using palantir alias
palantir_create_database dbname=postgres username=postgres password=postgres host=localhost port=5434

# Using palantir rake command
rake palantir:create_database dbname=postgres username=postgres password=postgres host=localhost port=5434
```

### 2. Configure the Database

Set the database for use by specifying its name:

```bash
palantir_set_database database_name=postgres
```

### 3. Verify Database Configuration

Check if the database is correctly configured:

```bash
palantir_database
```

## Working with Queries

Once the database is configured, you can create, edit, and execute SQL queries.

### Creating and Editing Queries

Use the following command to create or edit a query. By default, Palantir uses `vi` as the editor. To use a different editor (e.g., `code`), set the `EDITOR` environment variable.

```bash
palantir_edit_query query_name=create_palantir_test
```

Example query:

```sql
CREATE TABLE palantir_tests (
  id SERIAL PRIMARY KEY,
  description VARCHAR(255)
);
```

### Executing a Query

Run a query by specifying its name:

```bash
palantir_query query_name=create_palantir_test
```

### Listing Queries

View all created queries:

```bash
palantir_queries
```

### Example: Adding Records

Create a query to insert records into the table:

```bash
palantir_edit_query query_name=add_registers_in_palantir_tests
```

Example query:

```sql
INSERT INTO palantir_tests (description) VALUES
  ('First description'),
  ('Second description');
```

Execute the query:

```bash
palantir_query query_name=add_registers_in_palantir_tests
```

### Example: Retrieving Records

Create a query to select records:

```bash
palantir_edit_query query_name=palantir_tests
```

Example query:

```sql
SELECT * FROM palantir_tests;
```

Execute the query:

```bash
palantir_query query_name=palantir_tests
```

## Additional Resources

For more advanced features and commands, refer to the help documentation:

```bash
palantir_help
```
