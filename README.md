# MongoDB Command Reference

This repository contains a comprehensive reference of MongoDB commands for database operations, collection management, and document manipulation. MongoDB is a NoSQL document database that stores data in flexible, JSON-like documents.

## Contents

MongoDB organizes data in the following hierarchy:
- **Database** → Contains multiple collections
- **Collection** → Contains multiple documents (similar to tables in SQL)
- **Document** → Individual records stored in BSON format (similar to rows in SQL)

### MongoDB Data Types
MongoDB supports various data types:
- **String:** Text data `"Hello World"`
- **Number:** Integer or floating point `25`, `3.14`
- **Boolean:** True/false values `true`, `false`
- **Date:** Date and time `new Date()`, `ISODate("2024-01-01")`
- **Array:** List of values `["item1", "item2", "item3"]`
- **Object:** Embedded documents `{ name: "John", age: 30 }`

### 1. Database Commands

**Listing Databases:**
```javascript
show dbs;
```
- **Purpose:** Lists all databases available on the MongoDB server
- **Output:** Shows database names along with their sizes
- **Note:** Only databases with data will be displayed

**Switching/Creating Database:**
```javascript
use studentdb;
```
- **Purpose:** Switches to the specified database, or creates it if it doesn't exist
- **Behavior:** The database is only created when you insert your first document
- **Example:** `use mitan` switches to "mitan" database

**Check Current Database:**
```javascript
db;
```
- **Purpose:** Shows the name of the currently active database
- **Usage:** Helpful to confirm which database you're working with
- **Default:** If no database is selected, it defaults to "test"

**Delete Database:**
```javascript
db.dropDatabase();
```
- **Purpose:** Completely removes the current database and all its collections
- **Warning:** This operation is irreversible - all data will be lost
- **Returns:** Confirmation message with deletion status

### 2. Collection Commands

**List Collections:**
```javascript
show collections;
```
- **Purpose:** Displays all collections in the current database
- **Output:** Names of all collections
- **Note:** Empty collections created explicitly will also be shown

**Create Collection:**
```javascript
db.createCollection("student");
```
- **Purpose:** Explicitly creates a new collection with the specified name
- **Behavior:** Collections are usually created automatically when you insert documents
- **Options:** Can include configuration options like validation rules, capped collections
- **Example:** Creates a collection named "student"

**Drop Collection:**
```javascript
db.users.drop();
```
- **Purpose:** Completely removes a collection and all its documents
- **Warning:** This operation permanently deletes all data in the collection
- **Returns:** `true` if successful, `false` if collection doesn't exist
- **Alternative:** You can also use `db.getCollection("collection-name").drop()` for collections with special characters

**Rename Collection:**
```javascript
db.students.renameCollection("newStudents");
```
- **Purpose:** Changes the name of a collection
- **Syntax:** `db.oldName.renameCollection("newName")`
- **Note:** Collection must exist and new name must not be taken
- **Alternative:** `db.adminCommand({renameCollection: "db.old", to: "db.new"})`

### 3. Insert Documents

Documents are JSON-like objects that store data. Each document automatically gets a unique `_id` field.

**Single Document Insert:**
```javascript
db.student.insertOne({
  name: "Khushi",
  gender: "female",
  department: "FCAIT",
  dob: "12-05-2004"
});
```
- **Purpose:** Inserts one document into the collection
- **Behavior:** Creates the collection if it doesn't exist
- **Returns:** Acknowledgment with the inserted document's `_id`
- **Auto-Generated:** MongoDB automatically adds an `_id` field if not provided

```javascript
db.students.insertOne({
  name: "Alice",
  age: 22,
  skills: ["Java", "Python", "MongoDB"]
});
```
- **Flexible Schema:** Different documents can have different fields
- **Data Types:** Supports strings, numbers, arrays, objects, dates, etc.
- **Arrays:** The `skills` field demonstrates array storage

**Multiple Documents Insert:**
```javascript
db.student.insertMany([
  { name: "Mitan",  gender: "male",   department: "FCAIT", dob: "09-02-2004" },
  { name: "Raj",    gender: "male",   department: "FCAIT", dob: "07-01-2004" },
  { name: "Pranay", gender: "male",   department: "FCAIT", dob: "09-02-2003" },
  { name: "Shaily", gender: "female", department: "FCAIT", dob: "22-06-2004" }
]);
```
- **Purpose:** Inserts multiple documents in a single operation
- **Performance:** More efficient than multiple `insertOne()` calls
- **Atomic:** All documents are inserted as a group
- **Returns:** Array of inserted document `_id`s

```javascript
db.students.insertMany([
  { name: "Bob", age: 20, skills: ["C++", "Go"] },
  { name: "Clara", age: 23, skills: ["JavaScript", "React"] }
]);
```
- **Ordered:** By default, documents are inserted in order
- **Error Handling:** If one fails, subsequent documents won't be inserted (unless `ordered: false` is specified)

**Save Document:**
```javascript
db.student.save({
  _id: ObjectId("64f9a2c12b3e5a7d8c9e1234"),
  name: "Updated Name",
  department: "IT"
});
```
- **Purpose:** Inserts a new document or updates existing one based on `_id`
- **Behavior:** If `_id` exists, it updates; if not, it inserts
- **Note:** Deprecated in newer MongoDB versions, use `insertOne()` or `updateOne()` instead

### 4. Update Documents

Update operations modify existing documents. MongoDB provides various update operators to perform different types of modifications.

**Update Many Documents:**
```javascript
db.student.updateMany(
  { gender: "male" },           // filter (condition)
  { $set: { department: "IT" } } // update operation
);
```
- **Purpose:** Updates all documents that match the filter condition
- **Filter:** `{ gender: "male" }` selects all male students
- **$set Operator:** Sets or updates the specified field(s)
- **Result:** All male students will have their department changed to "IT"
- **Returns:** Information about matched and modified document counts

```javascript
db.student.updateMany(
  {},                           // empty filter = all documents
  { $set: { status: "active" } }
);
```
- **Empty Filter:** `{}` matches all documents in the collection
- **Effect:** Adds a new field "status" with value "active" to every document
- **New Fields:** If the field doesn't exist, `$set` creates it

**Update Single Document:**
```javascript
db.student.updateOne(
  { _id: ObjectId("64f9a2c12b3e5a7d8c9e1234") },  // filter by unique _id
  { $set: { department: "CSE" } }                // update operation
);
```
- **Purpose:** Updates only the first document that matches the filter
- **ObjectId:** Uses the unique `_id` field for precise targeting
- **Safety:** Updating by `_id` ensures you modify the exact document intended

```javascript
// Adding roll numbers to specific students
db.student.updateOne({ name: "Mitan" },  { $set: { rollno: 1 } });
db.student.updateOne({ name: "Raj" },    { $set: { rollno: 2 } });
db.student.updateOne({ name: "Shaily" }, { $set: { rollno: 3 } });
```
- **Sequential Updates:** Each command updates one specific student
- **Field Addition:** Adds a new "rollno" field to each targeted document
- **Name-based Filter:** Uses the name field to identify students

**Rename Field in Document:**
```javascript
db.student.updateMany(
  {},
  { $rename: { "dob": "dateOfBirth" } }
);
```
- **Purpose:** Renames a field in documents
- **$rename Operator:** Changes field names without affecting values
- **Syntax:** `{ $rename: { "oldFieldName": "newFieldName" } }`

**Common Update Operators:**
- **$set:** Sets field values
- **$unset:** Removes fields
- **$inc:** Increments numeric values
- **$push:** Adds elements to arrays
- **$pull:** Removes elements from arrays
- **$rename:** Renames fields

### Array Update Operators (push, pull, pullAll)
MongoDB provides several operators specialized for updating array fields. These are essential when you need to add or remove items inside array fields without replacing the entire array.

**$push (single element)**
```javascript
// Add a single element to an array field
db.students.updateOne({ name: "Alice" }, { $push: { skills: "TypeScript" } });
```
- Appends the element to the end of the array.

**$push with $each (multiple elements)**
```javascript
// Add multiple elements to an array in a single operation
db.students.updateOne({ name: "Bob" }, { $push: { skills: { $each: ["Go", "Rust"] } } });
```
- Use `$each` to push multiple values in one operation. More efficient and atomic than multiple $push calls.

**$pushwith $position and $slice (controlled insert / keep top N)**
```javascript
// Insert 'x' at the beginning of the array
db.collection.updateOne({ _id: 1 }, { $push: { tags: { $each: ["x"], $position: 0 } } });
```

**$pull (remove matching values or by condition)**
```javascript
// Remove the element 'Panner' from the items array
db.shoppingCart.updateOne({ cart_id: 5 }, { $pull: { items: "Panner" } });

// Remove all scores less than 50 from every document
db.collection.updateMany({}, { $pull: { scores: { $lt: 50 } } });
```
- `$pull` removes elements that match the given value or query expression.

**$pullAll (remove multiple specified values)**
```javascript
// Remove all occurrences of 'a' and 'b' from tags array
db.collection.updateOne({ _id: 1 }, { $pullAll: { tags: ["a", "b"] } });
```
- `$pullAll` removes all matching elements listed in the array argument.

**Notes and tips:**
- Use `$each` when pushing multiple values to avoid multiple round-trips and to keep the operation atomic.
- Use conditional `$pull` queries (e.g., `$lt`, `$gte`) to remove items by predicate.
- When performing many array updates, consider schema design and whether storing subdocuments or separate collections is more appropriate for performance and querying.

### 5. Delete Documents

Delete operations permanently remove documents from collections. Use with caution as these operations cannot be undone.

**Delete Single Document:**
```javascript
db.users.deleteOne({ name: "Bob" });
```
- **Purpose:** Removes only the first document that matches the filter
- **Behavior:** Even if multiple documents match, only one is deleted
- **Filter:** `{ name: "Bob" }` targets documents where name equals "Bob"
- **Safety:** Limits deletion to one document, reducing risk of accidental data loss
- **Returns:** Acknowledgment with count of deleted documents (0 or 1)
- **Use Case:** When you want to remove a specific record

**Delete Multiple Documents:**
```javascript
db.users.deleteMany({ status: "archived" });
```
- **Purpose:** Removes all documents that match the filter condition
- **Filter:** `{ status: "archived" }` targets all archived users
- **Scope:** If 50 users have status "archived", all 50 will be deleted
- **Performance:** More efficient than multiple `deleteOne()` operations
- **Returns:** Acknowledgment with count of deleted documents
- **Warning:** Can delete large numbers of documents - verify filter carefully

**Important Considerations:**
- **No Undo:** Delete operations are permanent
- **Empty Filter:** `deleteMany({})` would delete ALL documents in the collection
- **Validation:** Always test filters with `find()` before using with delete operations
- **Backup:** Consider backing up important data before bulk deletions

### 6. Query Documents

Querying allows you to retrieve documents from collections based on specified criteria. MongoDB provides powerful query operators for flexible data retrieval.

**Basic Query - Find All:**
```javascript
db.users.find();
```
- **Purpose:** Retrieves all documents from the collection
- **Output:** Returns all documents in the users collection
- **Format:** Documents are displayed in JSON-like format
- **Limit:** By default, shows first 20 documents (can iterate for more)
- **Use Case:** When you need to see all data in a collection

**Conditional Queries with Comparison Operators:**
```javascript
db.users.find({ age: { $gt: 25 } });
```
- **$gt Operator:** "Greater than" - finds documents where age > 25
- **Syntax:** `{ field: { $operator: value } }`
- **Result:** Returns all users older than 25 years
- **Performance:** MongoDB can use indexes to speed up these queries

**Complete List of Comparison Operators:**
```javascript
// $lt → less than
db.users.find({ age: { $lt: 30 } });        // age < 30

// $gte → greater than or equal
db.users.find({ age: { $gte: 18 } });       // age >= 18

// $lte → less than or equal  
db.users.find({ age: { $lte: 65 } });       // age <= 65

// $ne → not equal
db.users.find({ status: { $ne: "inactive" } }); // status != "inactive"
```

**Query with Limits and Skip (Pagination):**
```javascript
db.users.find({ name: "Alice" }).limit(1);
```
- **Filter:** `{ name: "Alice" }` finds documents where name equals "Alice"
- **Limit:** `.limit(1)` restricts results to only one document
- **Behavior:** Returns the first matching document found
- **Use Case:** When you expect multiple matches but only need one result
- **Performance:** Stops searching after finding the specified number of documents

```javascript
// Skip the first result and return the next 2
db.music.find().limit(2).skip(1)
```
- **Skip:** `.skip(n)` bypasses the first `n` documents in the result set.
- **Pagination:** Combining `limit()` and `skip()` is a common way to implement pagination. For example, to show 10 items per page, you would use `limit(10)` and adjust `skip()` for each page (`skip(0)`, `skip(10)`, `skip(20)`, etc.).

**Advanced Query Features:**
- **Multiple Conditions:** `db.users.find({ age: { $gte: 18, $lt: 65 } })`
- **Counting:** `db.users.find({ age: { $gt: 25 } }).count()`

**Pattern Matching (LIKE using $regex):**
```javascript
// Sample data
db.users.insertMany([
  { name: "Alice",   username: "user.01", status: "active",   age: 22 },
  { name: "ALIyah",  username: "user02",  status: "inactive", age: 17 },
  { name: "Binali",  username: "user03",  status: "active",   age: 30 },
  { name: "Kalindi", username: "user04",  status: "active",   age: 28 }
]);

// Contains (LIKE "%ali%")
db.users.find({ name: { $regex: "ali" } });
// Matches: "Alice", "Binali" (because both contain "ali")

// Starts with (LIKE "Ali%")
db.users.find({ name: { $regex: "^Ali" } });
// Matches: "Alice" only (must start with Ali)

// Ends with (LIKE "%ali")
db.users.find({ name: { $regex: "ali$" } });
// Matches: "Binali" (name ends with ali)

// Case-insensitive (i flag)
db.users.find({ name: { $regex: "ali", $options: "i" } });
// Matches: "Alice", "ALIyah", "Binali", "Kalindi" (any case of ali)

// Match a specific length (8 characters)
db.music.find({title : { $regex: "^.{8}$"}})

// Match a string starting with 'S' and having a total length of 8 characters
db.music.find({ title : { $regex: "^S.{7}$"}})

// Escape special characters (e.g., a dot)
db.users.find({ username: { $regex: "^user\\.01$" } });
// Matches: username exactly "user.01"
```
- **LIKE equivalent:** MongoDB does not have SQL `LIKE`; use `$regex`.
- **Anchors:** `^` start, `$` end. `.*` matches any characters.
- **Performance:** Prefix-anchored patterns like `^Ali` can use an index on the field.

Quick examples (movies):
```javascript
// Starts with 3 and ends with s → matches: "3 Idiots"
db.movies.find({ title: { $regex: "^3.*s$" } });

// Case-insensitive variant
db.movies.find({ title: { $regex: "^3.*s$", $options: "i" } });
```

**Logical Operators ($or, $and, $not):**
```javascript
// Using the same sample data inserted above

// $or: either condition matches
db.users.find({ $or: [{ age: { $lt: 18 } }, { status: "inactive" }] });
// Matches: any user younger than 18 OR with status inactive
// From sample: "ALIyah" (age 17 AND inactive)

// $and: both conditions must match (equivalent to combining in one object)
db.users.find({ $and: [{ age: { $gte: 18 } }, { age: { $lt: 65 } }] });
// Equivalent shorter form:
db.users.find({ age: { $gte: 18, $lt: 65 } });
// Matches: all adults between 18 and 64 inclusive of lower bound, exclusive of 65
// From sample: "Alice" (22), "Binali" (30), "Kalindi" (28)

// $not: negates a condition (wraps an operator expression)
db.users.find({ age: { $not: { $lt: 18 } } }); // age >= 18
// Matches: users NOT younger than 18 (i.e., 18 and above)
// From sample: "Alice", "Binali", "Kalindi"

// $nor: none of the conditions match
db.users.find({ $nor: [{ status: "active" }, { role: "admin" }] });
// Matches: users who are NOT active AND do NOT have role admin
// From sample: "ALIyah" (inactive; assuming no role field)
```
- **$or:** Array of expressions; matches if any are true.
- **$and:** Usually unnecessary; combine operators on the same field in one object.
- **$not:** Use to negate an operator expression; it does not mean "field not equal" by itself.
- **Tip:** Prefer direct operators like `{ field: { $ne: value } }` over `$not` when possible.

**Field Selection (Projection):**
```javascript
db.users.find({}, { name: 1, age: 1 });
```
- **Purpose:** Controls which fields are returned in query results
- **Syntax:** Second parameter in find() specifies which fields to include/exclude
- **Include Fields:** Use `1` to include specific fields in results
- **Example Result:** Only returns `_id`, `name`, and `age` fields, ignoring other fields like `email`, `address`, etc.
- **Performance:** Reduces network traffic and memory usage by returning only needed data
- **Default:** `_id` field is always included unless explicitly excluded with `_id: 0`

**Projection Examples:**
```javascript
// Include only specific fields
db.users.find({}, { name: 1, email: 1 });        // Returns: _id, name, email

// Exclude specific fields  
db.users.find({}, { password: 0, secretKey: 0 }); // Returns: all fields except password and secretKey

// Exclude _id field
db.users.find({}, { name: 1, age: 1, _id: 0 });   // Returns: only name and age (no _id)

// Combined with query conditions
db.users.find({ age: { $gte: 18 } }, { name: 1, age: 1 }); // Find adults, return only name and age
```
- **Include vs Exclude:** Cannot mix include (1) and exclude (0) except for `_id` field
- **Use Case:** When you only need specific fields for display or processing
- **Security:** Useful for hiding sensitive fields like passwords

### 7. Sorting Documents

Sorting arranges query results in a specific order based on field values. This is essential for organizing data for display or analysis.

**Basic Sorting:**
```javascript
db.users.find().sort({ age: 1 });        // Sort by age ascending (18, 22, 25, 30...)
db.users.find().sort({ age: -1 });       // Sort by age descending (30, 25, 22, 18...)
```
- **Purpose:** Orders query results by specified field(s)
- **Ascending (1):** Arranges from smallest to largest (A-Z, 0-9, oldest to newest)
- **Descending (-1):** Arranges from largest to smallest (Z-A, 9-0, newest to oldest)
- **Return Order:** Results are returned in the specified order
- **Memory Usage:** Sorting operations use memory; large sorts may require indexes

**Multiple Field Sorting:**
```javascript
db.users.find().sort({ age: 1, name: 1 });
// First sorts by age (18, 18, 22, 22), then by name within same age (Alice, Bob)
```
- **Priority:** Primary sort field comes first, secondary fields break ties
- **Example:** Students with same age will be sorted alphabetically by name
- **Mixed Order:** `db.users.find().sort({ age: -1, name: 1 })` - age descending, name ascending
- **Multiple Levels:** Can sort by many fields: `{ dept: 1, age: -1, name: 1 }`

**Sorting with Queries and Limits:**
```javascript
db.users.find({ age: { $gte: 18 } }).sort({ name: 1 }).limit(5);
// Find adults, sort by name, return first 5 results
```
- **Operation Order:** MongoDB optimizes the order of find, sort, and limit
- **Chaining:** Can combine multiple operations for complex queries
- **Use Case:** Getting top N results after filtering and sorting
- **Performance:** Adding limit() reduces the amount of data that needs sorting

**Sorting Different Data Types:**
```javascript
db.products.find().sort({ price: 1 });           // Numbers: 10, 25, 100
db.products.find().sort({ name: 1 });            // Strings: "Apple", "Banana", "Cherry"
db.events.find().sort({ date: -1 });             // Dates: newest first
```
- **Numbers:** Sorted numerically (10 comes before 100)
- **Strings:** Sorted alphabetically (case-sensitive: uppercase before lowercase)
- **Dates:** Sorted chronologically
- **Mixed Types:** Different data types have a sorting precedence order


## Database Schema Examples

This reference demonstrates two main document structures:

### Student Collection Schema
```javascript
{
  _id: ObjectId("..."),          // Auto-generated unique identifier
  name: "Mitan",                 // String: Student's full name
  gender: "male",                // String: Gender information
  department: "FCAIT",           // String: Academic department
  dob: "09-02-2004",            // String: Date of birth
  rollno: 1,                     // Number: Roll number (added via updates)
  status: "active"               // String: Status field (added via updates)
}
```

### Users Collection Schema
```javascript
{
  _id: ObjectId("..."),          // Auto-generated unique identifier
  name: "Alice",                 // String: User's name
  age: 22,                       // Number: User's age
  skills: ["Java", "Python", "MongoDB"], // Array: List of skills
  status: "active"               // String: Account status
}
```

### 8. Indexing

Indexes support the efficient execution of queries in MongoDB. Without indexes, MongoDB must perform a collection scan, i.e., scan every document in a collection, to select those documents that match the query statement.

**Create an Index:**
```javascript
// Create a single field index on the 'title' field in descending order
db.movie.createIndex({title: -1})
```
- **Purpose:** Creates an index on a specified field. `1` is for ascending order and `-1` is for descending order.
- **Behavior:** Speeds up queries that sort or filter on the indexed field.

**List Indexes:**
```javascript
db.movie.getIndexes()
```
- **Purpose:** Returns an array of documents that describe the existing indexes on the collection.

**Drop an Index:**
```javascript
db.movie.dropIndex({title: 1})
```
- **Purpose:** Removes a specified index from a collection. The argument to `dropIndex` should be the key pattern of the index to drop.

### 9. Aggregation & Pipeline Topics

This section summarizes common aggregation and pipeline concepts demonstrated in sample scripts: `$match`, `$project`, `$addFields`, `$group`, `$count`, `$lookup`, and related operators.

#### 1) Aggregation pipeline structure
- Use `db.collection.aggregate([ ... ])` to run a sequence of stages where each stage transforms the documents.
- Stages run in order and include `$match`, `$group`, `$project`, `$addFields`, `$sort`, `$limit`, `$lookup`, etc.

Example:
```javascript
db.movies.aggregate([
  { $match: { year: { $gt: 2015 } } },
  { $group: { _id: "$director", avgRating: { $avg: "$rating" } } },
  { $sort: { avgRating: -1 } }
]);
```

#### 2) Filtering documents — `$match`
- Filters documents using standard query operators: `$eq`,`$ne`, `$gt`, `$lt`, `$gte`, `$lte`, `$in`, `$nin`, `$and`, `$or`, `$not`, `$exists`, `$regex`.

Examples:
```javascript
// $eq – equal to
{ $match: { status: { $eq: "Delayed" } } }

// $ne – not equal to
{ $match: { status: { $ne: "Cancelled" } } }

// $gt / $lt – greater/less than
{ $match: { price: { $gt: 100 } } }
{ $match: { price: { $lt: 50 } } }

// $gte / $lte – greater/less than or equal
{ $match: { rating: { $gte: 4.5 } } }
{ $match: { rating: { $lte: 2 } } }

// $in / $nin – value is (not) in array
{ $match: { airline: { $in: ["Delta", "United"] } } }
{ $match: { airline: { $nin: ["Spirit", "Frontier"] } } }

// $and – all conditions must match
{ $match: { $and: [ { status: "On Time" }, { price: { $lt: 300 } } ] } }

// $or – any condition may match
{ $match: { $or: [ { status: "On Time" }, { status: "Delayed" } ] } }

// $not – negate a condition (wraps another operator)
{ $match: { price: { $not: { $gt: 500 } } } } // price <= 500

// $exists – field presence (not value)
{ $match: { couponCode: { $exists: true } } }

// $regex – pattern match (use with options)
{ $match: { flightNumber: { $regex: "^UA", $options: "i" } } }
```

- Use early `$match` to reduce work for later stages.

Example:
```javascript
{ $match: { status: "Delayed" } }
```

#### 3) Projection — `$project`
- Selects, reshapes, or renames fields for downstream stages.
- You can include/exclude fields and compute expressions.

Example:
```javascript
{ $project: { _id: 0, title: 1, releaseYear: "$year" } }
```

#### 4) Computed / conditional fields — `$addFields`, `$cond`
- Use `$addFields` to add computed fields.
- `$cond` (or `$switch`) provides conditional values based on expressions.

Example:
```javascript
{ $addFields: { ratingCategory: { $cond: [ { $gte: ["$rating", 8] }, "Excellent", "Average" ] } } }
```

#### 5) Grouping and aggregation — `$group`
- Aggregate values by a key using `$group` with accumulators: `$sum`, `$avg`, `$min`, `$max`, `$push`,`$push`, `$count`, `$addToSet`.

Examples (accumulators):
```javascript
// $sum – count docs or sum a numeric field
{ $group: { _id: "$airline", totalFlights: { $sum: 1 } } }
{ $group: { _id: "$airline", totalPrice: { $sum: "$price" } } }

// $avg – average of numeric field
{ $group: { _id: "$airline", avgPrice: { $avg: "$price" } } }

// $min / $max – min/max value of a field
{ $group: { _id: "$airline", minPrice: { $min: "$price" }, maxPrice: { $max: "$price" } } }

// $push – collect values into an array (may contain duplicates)
{ $group: { _id: "$airline", flightIds: { $push: "$flightId" } } }

// $addToSet – collect unique values into a set (removes duplicates)
{ $group: { _id: "$airline", uniqueDestinations: { $addToSet: "$destination" } } }

// $count – available as its own stage; to count within $group use $sum: 1
{ $count: "totalFlights" }
{ $group: { _id: null, totalFlights: { $sum: 1 } } }
```

Example:
```javascript
{ $group: { _id: "$airline", totalFlights: { $sum: 1 }, avgPrice: { $avg: "$price" } } }
```

#### 6) Counting documents — `$count`
- `$count` returns a single document with the total count after prior stages.

Example:
```javascript
{ $count: "totalFlights" }
```

#### 7) Joins — `$lookup`
- `$lookup` performs a left outer join between collections.
- Useful to enrich documents with related arrays from other collections.

Example:
```javascript
{ $lookup: { from: "reviews", localField: "mid", foreignField: "movie_id", as: "movieReviews" } }
```

#### 8) Other useful aggregation stages
- `$sort`, `$limit`, `$skip` — control result order and pagination
- `$unwind` — deconstruct arrays into documents
- `$replaceRoot` / `$replaceWith` — replace the root document
- `$facet` — run multiple pipelines in parallel and collect results

Examples:
```javascript
// $sort – sort by fields (desc: -1, asc: 1)
{ $sort: { avgPrice: -1, airline: 1 } }

// $limit – keep first N documents
{ $limit: 10 }

// $skip – skip first N documents (use with $limit for pagination)
{ $skip: 20 }

// $addFields – add a computed field (aka your "$addToField")
{ $addFields: { totalCost: { $add: ["$price", "$fee"] } } }

// $lookup – join additional data from another collection
{ $lookup: { from: "reviews", localField: "mid", foreignField: "movie_id", as: "reviews" } }

// $unwind – explode an array into multiple documents
{ $unwind: "$reviews" }
```

#### 9) Short example pipeline (find average price by airline for on-time flights)
```javascript
db.flights.aggregate([
  { $match: { status: "On Time" } },
  { $group: { _id: "$airline", avgPrice: { $avg: "$price" }, count: { $sum: 1 } } },
  { $project: { airline: "$_id", avgPrice: 1, count: 1, _id: 0 } },
  { $sort: { avgPrice: -1 } }
]);
```