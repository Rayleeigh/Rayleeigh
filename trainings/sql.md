# Database Engineering – Theory & Hands-on Projects

## Overview

A project-based learning path covering relational database modelling, relational design theory, SQL, database integrity, transactions, query optimization, advanced database engines, and Python-based data processing.

The learning approach combines **theoretical research, visual explanations, practical implementation, experimentation, and documentation**.

### Technology Stack

| Technology | Purpose |
|---|---|
| MySQL 8.4 LTS | Relational database management system |
| MySQL Workbench | Entity Relationship Modelling and SQL development |
| Docker Compose | Containerized database environments |
| Python | Database automation and data processing |
| Pandas | Data analysis and transformation |
| SQLAlchemy | Python database connectivity |
| Jupyter Notebook | Interactive data analysis and documentation |

### Learning Resources

- [MySQL 8.4 Reference Manual](https://dev.mysql.com/doc/refman/8.4/en/)
- [MySQL Workbench Manual](https://dev.mysql.com/doc/workbench/en/)
- [GeeksforGeeks – DBMS Tutorial](https://www.geeksforgeeks.org/dbms/dbms/)
- [W3Schools – SQL Tutorial](https://www.w3schools.com/sql/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

---

## Project 01 – Fundamentals of Relational Database Design

**Difficulty:** Beginner  
**Focus:** Relational data models, keys, relationships, cardinalities, and normalization.

### Learning Objectives

Understand how relational databases represent entities, organize attributes, enforce relationships, and reduce data redundancy.

### Theory

| Topic | Description | Reference |
|---|---|---|
| Entity Relationship Model | Representation of entities, attributes, and relationships | [GeeksforGeeks – ER Model](https://www.geeksforgeeks.org/dbms/introduction-of-er-model/) |
| Cardinality | One-to-one, one-to-many, and many-to-many relationships | [GeeksforGeeks – Cardinality](https://www.geeksforgeeks.org/dbms/mapping-cardinalities/) |
| Primary Keys | Unique, non-null identifiers for table records | [MySQL – Primary Key Constraints](https://dev.mysql.com/doc/refman/8.4/en/constraint-primary-key.html) |
| Foreign Keys | References between related tables | [MySQL – Foreign Key Constraints](https://dev.mysql.com/doc/refman/8.4/en/create-table-foreign-keys.html) |
| Normalization | Relational design rules for minimizing redundancy and anomalies | [GeeksforGeeks – Normal Forms](https://www.geeksforgeeks.org/dbms/normal-forms-in-dbms/) |
| Functional Dependencies | Relationships in which attributes determine other attributes | [GeeksforGeeks – Functional Dependency](https://www.geeksforgeeks.org/dbms/functional-dependency-and-attribute-closure/) |
| Database Integrity | Constraints that preserve valid and consistent data | [MySQL – Constraints](https://dev.mysql.com/doc/refman/8.4/en/constraints.html) |

### Key Concepts

**Cardinality**

- `1:1` – One record relates to at most one record on the other side.
- `1:N` – One record can relate to multiple records.
- `M:N` – Multiple records can relate to multiple records, generally implemented through a junction table.

Cardinality defines the maximum participation. Optionality defines whether a relationship is mandatory or optional.

**Attribute Atomicity**

First Normal Form requires atomic attribute values relative to the chosen relational model, rather than storing lists or repeating groups in individual fields.

Attribute atomicity must not be confused with the **Atomicity property of ACID transactions**.

**Normalization**

- `1NF` – Atomic column values, no repeating groups.
- `2NF` – 1NF plus no partial dependency of a non-prime attribute on a candidate key.
- `3NF` – 2NF plus elimination of transitive dependencies that violate 3NF.
- `BCNF` – Every determinant of a nontrivial functional dependency must be a superkey.

### Practical Exercises

1. Identify entities, attributes, and relationships in an example business process.
2. Draw examples of `1:1`, `1:N`, and `M:N` relationships.
3. Create a junction table for an `M:N` relationship.
4. Assign primary and foreign keys.
5. Identify candidate and composite keys.
6. Convert a denormalized table into 1NF, 2NF, and 3NF.
7. Demonstrate insertion, update, and deletion anomalies.

### Deliverable

A documented relational model containing example tables, relationship diagrams, explanations of keys, and normalization exercises.

---

## Project 02 – Entity Relationship Modelling with MySQL Workbench

**Difficulty:** Beginner  
**Focus:** Designing an ERD for a realistic business scenario.

### Scenario

Design an **e-commerce order management database**.

The system should manage:

- Customers and customer addresses
- Products and categories
- Orders and order items
- Payments and payment statuses
- Product inventory

### Theory and References

| Topic | Reference |
|---|---|
| Workbench Data Modelling | [MySQL – Database Design and Modeling](https://dev.mysql.com/doc/workbench/en/wb-data-modeling.html) |
| EER Diagrams | [MySQL – EER Diagram Editor](https://dev.mysql.com/doc/workbench/en/wb-eer-diagram-editor.html) |
| Creating Relationships | [MySQL – Foreign Key Relationships](https://dev.mysql.com/doc/workbench/en/wb-relationship-tools.html) |
| Normalization | [GeeksforGeeks – Normal Forms](https://www.geeksforgeeks.org/dbms/normal-forms-in-dbms/) |

### Practical Exercises

1. Gather database requirements.
2. Identify entities and their attributes.
3. Determine primary keys, foreign keys, and cardinalities.
4. Create an EER diagram in MySQL Workbench.
5. Model mandatory and optional relationships.
6. Normalize the schema to 3NF.
7. Define data types, uniqueness requirements, and other constraints.
8. Document business assumptions and design decisions.

### Deliverable

- `.mwb` MySQL Workbench model
- Exported ERD diagram
- Database schema documentation
- Normalization explanations

---

## Project 03 – MySQL Workbench + Docker Container

**Difficulty:** Beginner–Intermediate  
**Focus:** Turning a logical design into a deployed relational database.

### Technologies

MySQL 8.4 LTS, Docker Compose, MySQL Workbench.

### Theory and References

| Topic | Reference |
|---|---|
| Docker Compose | [Docker – Compose Documentation](https://docs.docker.com/compose/) |
| Persistent Storage | [Docker – Compose Volumes](https://docs.docker.com/reference/compose-file/volumes/) |
| MySQL Docker Image | [Docker Hub – MySQL](https://hub.docker.com/_/mysql) |
| Forward Engineering | [MySQL Workbench – Forward Engineering](https://dev.mysql.com/doc/workbench/en/wb-forward-engineering.html) |
| Reverse Engineering | [MySQL Workbench – Reverse Engineering Live Databases](https://dev.mysql.com/doc/workbench/en/wb-reverse-engineer-live.html) |

### Practical Exercises

1. Create a Docker Compose configuration.
2. Deploy MySQL with persistent storage.
3. Configure initial database credentials.
4. Configure local database connectivity.
5. Connect MySQL Workbench.
6. Forward-engineer the Project 02 database schema.
7. Inspect the generated SQL statements.
8. Insert sample data.
9. Test foreign key enforcement.
10. Reverse-engineer the running database back into an EER diagram.
11. Restart or recreate the container and verify data persistence.

### Deliverable

A fully reproducible containerized database environment with its schema, initialization scripts, and setup documentation.

---

## Project 04 – SQL Fundamentals: Five SQL Language Categories

**Difficulty:** Intermediate  
**Focus:** Understanding and practising SQL operations using an existing dataset.

### Recommended Dataset

**Sakila Sample Database**

- [Official Sakila Documentation](https://dev.mysql.com/doc/sakila/en/)
- [Installation Instructions](https://dev.mysql.com/doc/sakila/en/sakila-installation.html)
- [Database Structure](https://dev.mysql.com/doc/sakila/en/sakila-structure.html)

Sakila represents a fictional DVD rental business and includes customers, inventory, rentals, payments, films, and employees.

### Theory

| Category | Purpose | Statements |
|---|---|---|
| DQL | Read and retrieve data | SELECT |
| DML | Manipulate table data | INSERT, UPDATE, DELETE |
| DDL | Define or change database structures | CREATE, ALTER, DROP, TRUNCATE |
| DCL | Manage privileges and access | GRANT, REVOKE |
| TCL | Control transactions | START TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT |

These categories are pedagogical conventions; certain SQL statements may be classified differently across learning resources.

### Learning Resources

- [W3Schools – SELECT](https://www.w3schools.com/sql/sql_select.asp)
- [W3Schools – INSERT INTO](https://www.w3schools.com/sql/sql_insert.asp)
- [W3Schools – UPDATE](https://www.w3schools.com/sql/sql_update.asp)
- [W3Schools – DELETE](https://www.w3schools.com/sql/sql_delete.asp)
- [W3Schools – CREATE TABLE](https://www.w3schools.com/sql/sql_create_table.asp)
- [MySQL – GRANT](https://dev.mysql.com/doc/refman/8.4/en/grant.html)
- [MySQL – REVOKE](https://dev.mysql.com/doc/refman/8.4/en/revoke.html)
- [MySQL – Transaction Statements](https://dev.mysql.com/doc/refman/8.4/en/commit.html)

### Practical Exercises

1. Import Sakila into MySQL.
2. Write queries for filtering, grouping, sorting, and joining records.
3. Insert, update, and delete test records.
4. Create new tables and modify existing schemas.
5. Create database accounts with different privileges.
6. Test access using separate user accounts.
7. Execute multi-statement transactions.
8. Demonstrate COMMIT, ROLLBACK, and SAVEPOINT behavior.
9. Observe which DDL statements cause implicit commits.

**Important:** Execute destructive exercises in dedicated test tables or disposable database copies.

### Deliverable

A categorized SQL script collection with results, explanations, and documented transaction behavior.

---

## Project 05 – Advanced SQL Querying

**Difficulty:** Intermediate  
**Focus:** Complex queries, operators, joins, subqueries, and analytical functions.

### Theory and References

| Topic | Reference |
|---|---|
| Comparison Operators | [MySQL – Comparison Functions and Operators](https://dev.mysql.com/doc/refman/8.4/en/comparison-operators.html) |
| Logical Operators | [MySQL – Logical Operators](https://dev.mysql.com/doc/refman/8.4/en/logical-operators.html) |
| LIKE and Wildcards | [W3Schools – Wildcards](https://www.w3schools.com/sql/sql_wildcards.asp) |
| SQL JOINs (Visual) | [GeeksforGeeks – SQL JOIN Types](https://www.geeksforgeeks.org/sql/sql-join-set-1-inner-left-right-and-full-joins/) |
| JOINs (Interactive Examples) | [W3Schools – SQL JOINs](https://www.w3schools.com/sql/sql_join.asp) |
| Subqueries | [MySQL – Subqueries](https://dev.mysql.com/doc/refman/8.4/en/subqueries.html) |
| Common Table Expressions | [MySQL – WITH / CTE](https://dev.mysql.com/doc/refman/8.4/en/with.html) |
| Window Functions | [MySQL – Window Functions](https://dev.mysql.com/doc/refman/8.4/en/window-functions.html) |
| Views | [MySQL – CREATE VIEW](https://dev.mysql.com/doc/refman/8.4/en/create-view.html) |

### Understanding JOINs Visually

<escape>
INNER JOIN        Matching records in both tables
LEFT JOIN         All left records + matching right records
RIGHT JOIN        All right records + matching left records
CROSS JOIN        Cartesian product of both tables
SELF JOIN         A table joined to itself
FULL OUTER JOIN   All matched and unmatched records on both sides
</escape>

MySQL does not directly support `FULL OUTER JOIN`. An equivalent result can be constructed using a combination of outer joins and `UNION`.

Visual JOIN diagrams are helpful for learning, but should be supplemented with actual row-based examples because joins can produce duplicate combinations.

### Practical Exercises

1. Combine multiple logical and comparison operators.
2. Search for patterns using `%` and `_`.
3. Compare INNER, LEFT, RIGHT, and CROSS JOIN.
4. Implement a self join.
5. Simulate FULL OUTER JOIN.
6. Implement nested and correlated subqueries.
7. Write queries using CTEs.
8. Use CASE expressions.
9. Perform aggregations using GROUP BY and HAVING.
10. Use `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()`.
11. Create reusable database views.
12. Compare multiple solutions to the same query problem.

### Deliverable

An advanced SQL query library containing query descriptions, expected results, alternative solutions, and annotated examples.

---

## Project 06 – Efficient Database Querying Through Indexing

**Difficulty:** Intermediate–Advanced  
**Focus:** Database indexing, execution plans, and performance optimization.

### Recommended Dataset

**MySQL Employees Sample Database**

- [Official Employees Dataset](https://dev.mysql.com/doc/employee/en/)
- [Installation](https://dev.mysql.com/doc/employee/en/employees-installation.html)
- [Dataset Structure](https://dev.mysql.com/doc/employee/en/employees-structure.html)

Contains approximately four million records across six tables.

### Theory and References

| Topic | Reference |
|---|---|
| Database Indexing | [GeeksforGeeks – Indexing in Databases](https://www.geeksforgeeks.org/dbms/indexing-in-databases-set-1/) |
| MySQL Indexes | [MySQL – How MySQL Uses Indexes](https://dev.mysql.com/doc/refman/8.4/en/mysql-indexes.html) |
| Clustered and Secondary Indexes | [MySQL – InnoDB Index Types](https://dev.mysql.com/doc/refman/8.4/en/innodb-index-types.html) |
| Composite Indexes | [MySQL – Multiple-Column Indexes](https://dev.mysql.com/doc/refman/8.4/en/multiple-column-indexes.html) |
| EXPLAIN | [MySQL – EXPLAIN Statement](https://dev.mysql.com/doc/refman/8.4/en/explain.html) |
| Optimization | [MySQL – Optimization](https://dev.mysql.com/doc/refman/8.4/en/optimization.html) |

### Practical Exercises

1. Import the Employees dataset.
2. Create representative queries and benchmark their performance.
3. Analyze execution plans using EXPLAIN.
4. Run EXPLAIN ANALYZE on selected queries.
5. Add secondary indexes.
6. Compare single-column and composite indexes.
7. Investigate the leftmost-prefix behavior of composite indexes.
8. Demonstrate covering-index queries.
9. Compare indexed lookups with full table scans.
10. Benchmark INSERT, UPDATE, and DELETE operations before and after adding indexes.
11. Measure index storage overhead.
12. Identify redundant or ineffective indexes.

### Benchmarking Guidelines

- Run each query multiple times.
- Use equivalent datasets for each test.
- Record execution time, scanned rows, and execution plans.
- Distinguish cold-cache and warm-cache measurements.
- Consider optimizer statistics and caching effects.
- Do not assume using an index is always faster.

### Deliverable

A performance comparison report containing benchmarking results, query execution plans, indexing decisions, and optimization recommendations.

---

## Project 07 – Large-Scale Database Analysis with Python and Pandas

**Difficulty:** Advanced  
**Focus:** Database connectivity, large dataset processing, analytics, and automation.

### Technologies

MySQL, Docker Compose, Python, Pandas, SQLAlchemy, and optionally Jupyter Notebook.

### Recommended Dataset

Reuse the official Employees database from Project 06 to compare database-side processing against Python-side processing.

### Theory and References

| Topic | Reference |
|---|---|
| Python Database Connectivity | [SQLAlchemy – Engine Configuration](https://docs.sqlalchemy.org/en/20/core/engines.html) |
| SQL Data Extraction | [Pandas – read_sql](https://pandas.pydata.org/docs/reference/api/pandas.read_sql.html) |
| SQL Query Loading | [Pandas – read_sql_query](https://pandas.pydata.org/docs/reference/api/pandas.read_sql_query.html) |
| DataFrames | [Pandas – DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html) |
| Data Aggregation | [Pandas – GroupBy](https://pandas.pydata.org/docs/reference/groupby.html) |
| Combining Datasets | [Pandas – Merge](https://pandas.pydata.org/docs/reference/api/pandas.merge.html) |
| Data Processing | [Pandas – User Guide](https://pandas.pydata.org/docs/user_guide/index.html) |
| Parquet Export | [Pandas – to_parquet](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_parquet.html) |

### Practical Exercises

1. Deploy MySQL and import the Employees dataset.
2. Connect Python to MySQL using SQLAlchemy.
3. Execute parameterized SQL queries.
4. Load query results into Pandas.
5. Detect missing values and duplicate rows.
6. Transform, filter, and aggregate data.
7. Merge multiple DataFrames.
8. Compare SQL-based aggregation with Pandas aggregation.
9. Process datasets using chunked reads.
10. Measure memory consumption and execution times.
11. Export results into CSV and Parquet formats.
12. Generate visualizations and statistical summaries.
13. Implement error handling, logging, and configuration.
14. Create an executable and reproducible Python analysis script.

### Example Analysis Questions

- How does employee distribution change over time?
- Which departments have the highest salary expenditure?
- How do salaries vary by department and employment period?
- Which calculations are faster directly in MySQL?
- How much memory is required to process all employees in Pandas?
- How do chunked queries affect runtime and memory consumption?

### Deliverable

A complete Python analytics project containing reproducible Docker infrastructure, Python source code, SQL scripts, analysis outputs, and documented performance comparisons.

---

## Project 08 – Database Integrity and Transaction Management

**Difficulty:** Advanced  
**Focus:** Transaction guarantees, integrity constraints, concurrency, and isolation.

### Theory and References

| Topic | Reference |
|---|---|
| ACID Properties | [MySQL – InnoDB and the ACID Model](https://dev.mysql.com/doc/refman/8.4/en/mysql-acid.html) |
| Transaction Control | [MySQL – COMMIT and ROLLBACK](https://dev.mysql.com/doc/refman/8.4/en/commit.html) |
| Isolation Levels | [MySQL – Transaction Isolation Levels](https://dev.mysql.com/doc/refman/8.4/en/innodb-transaction-isolation-levels.html) |
| Foreign Key Integrity | [MySQL – FOREIGN KEY Constraints](https://dev.mysql.com/doc/refman/8.4/en/create-table-foreign-keys.html) |
| Locking | [MySQL – InnoDB Locking](https://dev.mysql.com/doc/refman/8.4/en/innodb-locking.html) |
| Deadlocks | [MySQL – Deadlocks in InnoDB](https://dev.mysql.com/doc/refman/8.4/en/innodb-deadlocks.html) |
| Implicit Commits | [MySQL – Statements Causing Implicit Commits](https://dev.mysql.com/doc/refman/8.4/en/implicit-commit.html) |

### ACID Properties

- **Atomicity:** A transaction's changes are committed together or rolled back.
- **Consistency:** Transactions preserve the database's defined integrity rules.
- **Isolation:** Concurrent transactions behave according to the configured isolation level.
- **Durability:** Committed changes survive failures within the database engine's durability guarantees.

### Practical Exercises

1. Create constraints using PK, FK, UNIQUE, NOT NULL, and CHECK.
2. Attempt invalid inserts and updates.
3. Demonstrate successful and failed transactions.
4. Simulate bank transfers between accounts.
5. Implement rollback and savepoints.
6. Open multiple SQL sessions and execute concurrent transactions.
7. Compare READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, and SERIALIZABLE.
8. Demonstrate dirty reads and non-repeatable reads where supported.
9. Investigate phantom reads and InnoDB's locking/snapshot behavior.
10. Simulate and analyze deadlocks.
11. Investigate implicit commits caused by DDL.

### Deliverable

A transaction simulation environment with concurrent SQL sessions, documented isolation behavior, and reproducible integrity and deadlock tests.

---

## Project 09 – Advanced Database Engines and Administration

**Difficulty:** Advanced  
**Focus:** Database internals, storage engines, observability, administration, and recovery.

### Theory and References

| Topic | Reference |
|---|---|
| InnoDB Architecture | [MySQL – InnoDB Architecture](https://dev.mysql.com/doc/refman/8.4/en/innodb-architecture.html) |
| Buffer Pool | [MySQL – InnoDB Buffer Pool](https://dev.mysql.com/doc/refman/8.4/en/innodb-buffer-pool.html) |
| Redo Logs | [MySQL – Redo Log](https://dev.mysql.com/doc/refman/8.4/en/innodb-redo-log.html) |
| Undo Logs | [MySQL – Undo Logs](https://dev.mysql.com/doc/refman/8.4/en/innodb-undo-logs.html) |
| MVCC | [MySQL – InnoDB Multi-Versioning](https://dev.mysql.com/doc/refman/8.4/en/innodb-multi-versioning.html) |
| Storage Engines | [MySQL – Storage Engines](https://dev.mysql.com/doc/refman/8.4/en/storage-engines.html) |
| Performance Schema | [MySQL – Performance Schema](https://dev.mysql.com/doc/refman/8.4/en/performance-schema.html) |
| Backups | [MySQL – InnoDB Backup](https://dev.mysql.com/doc/refman/8.4/en/innodb-backup.html) |
| Replication | [MySQL – Replication](https://dev.mysql.com/doc/refman/8.4/en/replication.html) |

### Practical Exercises

1. Inspect the current database storage engine.
2. Investigate InnoDB's internal storage structure.
3. Monitor buffer pool statistics.
4. Observe the impact of database caching.
5. Investigate redo and undo logging concepts.
6. Explore MVCC using concurrent transactions.
7. Enable and query Performance Schema metrics.
8. Create logical database backups.
9. Restore a database into a fresh MySQL container.
10. Validate restored data and constraints.
11. Explore binary logging and point-in-time recovery.
12. Deploy a basic primary-replica configuration.
13. Monitor replication status and lag.
14. Document recovery procedures and operational limitations.

### Deliverable

A reproducible MySQL administration laboratory with backup and restore scripts, internal engine observations, monitoring queries, and recovery documentation.

---

## Project Documentation Standard

Each project should contain the following sections.

### 1. Objective

Describe the problem, expected outcomes, and skills being developed.

### 2. Prerequisites

List software requirements, background knowledge, and dependencies.

### 3. Theoretical Background

Explain relevant database principles, definitions, and technical terminology, supported by authoritative documentation and visual learning resources.

### 4. Architecture and Design

Document the database schema, ER diagrams, container infrastructure, and relevant configuration decisions.

### 5. Implementation

Provide step-by-step installation, configuration, SQL statements, and example commands.

### 6. Practical Exercises

Present executable tasks that apply the theoretical knowledge.

### 7. Validation

Explain how to verify correct functionality, including expected results and negative tests.

### 8. Results and Findings

Record observations, measurements, query plans, screenshots, and lessons learned.

### 9. Troubleshooting

Document encountered errors, root causes, and resolutions.

### 10. References

Provide direct links to technical sources, documentation, visual explanations, and further reading.

---

## Completion Criteria

The learning path is complete when all nine projects can be reproduced and explained, with supporting documentation demonstrating an understanding of:

- Relational database modelling and normalization
- ER diagrams, keys, relationships, and cardinalities
- SQL querying and database manipulation
- Database constraints and referential integrity
- Transaction processing and concurrency control
- Database indexing and query optimization
- MySQL storage-engine behavior
- Database administration and recovery
- Python-based data analysis and automation

**Final Objective:** Build a portfolio of technically accurate, documented database engineering projects progressing from foundational relational modelling to practical database operations, performance engineering, and large-scale data analysis.
