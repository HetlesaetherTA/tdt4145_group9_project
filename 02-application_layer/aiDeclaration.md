# AI Declaration

### Part 1:

I wrote the DB schema originally in DBML with https://dbdiagram.io/d

DBML is a schema definition language that is syntactically similar to SQL but optimized for
quickly defining tables and relationships. It does not support constraints so it’s mostly effective
for translating an ER diagram to machine-readable language fast. Mainly because you can
define tables first, then relations using a single character. It also lets you see a visual
representation of your schema as an ER diagram. So I could graphically confirm that the ER
and schema matched.

ChatGPT was used to translate DBML into a SQLite .sql file, there are also multiple non-ai
solutions to do this conversion. After converting I was left with a .sql schema that only has
tables, attributes, PK and FK. Constraints were then added by working directly in the .sql file.

I also used AI to quickly look up generic examples of syntax I couldn’t recall, but nothing in the
delivery has been copy pasted or altered directly by AI (except for DBML->SQL translation)

### Part 2:

AI was used in this part mostly for string manipulation for formatted outputs and automating 
data entry tasks like 08_researchData.sql. Where AI has been used I've clearly notated this with:

```python
# Start: {AI type} {How AI was used}
code()
# End: {AI type}
```

I also used AI to look up documentation or generic examples on the sqlite3, the python sqlite API and 
general python syntax as I mainly program in Go.
