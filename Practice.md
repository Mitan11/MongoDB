## Practice Script (Commands with Explanations)

All tasks are commented. Run sequentially in `mongosh`. Missing inserts for collections used in queries (e.g., `employees`, `marks`) have been added. Field name inconsistencies (`Skill` vs `skills`) are normalized where possible.

```javascript
// 1. Switch (create if absent) to SchoolDB
use SchoolDB

// 2. Switch to EcommerceDB (later commands will operate across both DBs as you switch)
use EcommerceDB

// 3. Show all databases
show dbs

// 4. Drop current database (EcommerceDB at this moment)
db.dropDatabase()

// 5. Create base collections in EcommerceDB
db.createCollection("students")
db.createCollection("products")
db.createCollection("users")
db.createCollection("orders")

// 6. Show collections in current DB
show collections

// 7. Rename students -> learners
db.students.renameCollection("learners")

// 8. Create and drop a temporary collection 'logs'
db.createCollection("logs")
db.logs.drop()

// 9. (Recreate students collection after rename for clarity) Ensure we have 'students'
db.createCollection("students")

// 10. Insert single student (basic fields)
db.students.insertOne({ name: "Mitan", age: 21, gender: "Male" })

// 11. Insert multiple students
db.students.insertMany([
	{ name: "Pranay", age: 21, gender: "Male" },
	{ name: "Yash", age: 20, gender: "Male" },
	{ name: "Umang", age: 22, gender: "Male" }
])

// 12. Insert a student with skills array (note consistent lowercase 'skills')
db.students.insertOne({ name: "Jay", age: 21, gender: "Male", skills: ["C", "C++"] })

// 13. Insert student with embedded address document
db.students.insertOne({
	name: "Riddhi", age: 16, gender: "Female",
	address: { city: "Ahmedabad", pin: 380001 }
})

// 14. Insert sample products
db.products.insertMany([
	{ title: "Shoes", price: 1200, category: "Fashion" },
	{ title: "Laptop", price: 55000, category: "Electronics" },
	{ title: "Watch", price: 1500, category: "Accessories" },
	{ title: "Bag", price: 900, category: "Fashion" },
	{ title: "Keyboard", price: 1200, category: "Electronics" }
])

// 15. Insert one order with nested items array & computed total
db.orders.insertOne({
	order_id: 101,
	customer: "Milan",
	items: [
		{ product: "Laptop", qty: 1, price: 55000 },
		{ product: "Mouse", qty: 2, price: 500 }
	],
	total: 56000
})

// 16. Create Library collection & seed (for copy queries later)
db.createCollection("Library")
db.Library.insertMany([
	{ title: "Book1", author: "Author1", copies: 5 },
	{ title: "Book2", author: "Author2", copies: 7 },
	{ title: "Book3", author: "Author3", copies: 3 },
	{ title: "Book4", author: "Author4", copies: 6 },
	{ title: "Book5", author: "Author5", copies: 9 },
	{ title: "Book6", author: "Author6", copies: 2 },
	{ title: "Book7", author: "Author7", copies: 4 },
	{ title: "Book8", author: "Author8", copies: 8 },
	{ title: "Book9", author: "Author9", copies: 1 },
	{ title: "Book10", author: "Author10", copies: 10 }
])

// 17. Add students with date of birth for date queries
db.students.insertMany([
	{ name: "Arjun", dob: ISODate("2004-05-12") },
	{ name: "Sneha", dob: ISODate("2003-10-30") },
	{ name: "Rakesh", dob: ISODate("2005-01-22") }
])

// 18. Add roll numbers (needed for $lookup with marks later)
db.students.updateOne({ name: "Mitan" }, { $set: { roll: 1 } })
db.students.updateOne({ name: "Pranay" }, { $set: { roll: 2 } })
db.students.updateOne({ name: "Yash" }, { $set: { roll: 3 } })
db.students.updateOne({ name: "Umang" }, { $set: { roll: 4 } })
db.students.updateOne({ name: "Jay" }, { $set: { roll: 5 } })
db.students.updateOne({ name: "Riddhi" }, { $set: { roll: 6 } })
db.students.updateOne({ name: "Arjun" }, { $set: { roll: 7 } })
db.students.updateOne({ name: "Sneha" }, { $set: { roll: 8 } })
db.students.updateOne({ name: "Rakesh" }, { $set: { roll: 9 } })

// 19. Create marks collection for $lookup demonstration
db.createCollection("marks")
db.marks.insertMany([
	{ roll: 1, subject: "Math", score: 88 },
	{ roll: 2, subject: "Math", score: 76 },
	{ roll: 2, subject: "Science", score: 81 },
	{ roll: 3, subject: "Math", score: 69 },
	{ roll: 5, subject: "Science", score: 90 },
	{ roll: 6, subject: "Math", score: 72 },
	{ roll: 7, subject: "Science", score: 78 }
])

// 20. Create employees collection (missing earlier) for employees queries
db.createCollection("employees")
db.employees.insertMany([
	{ name: "Dev", department: "IT", age: 26, salary: 52000, joinDate: ISODate("2021-04-01") },
	{ name: "Eva", department: "HR", age: 31, salary: 47000, joinDate: ISODate("2020-09-15") },
	{ name: "Farhan", department: "IT", age: 29, salary: 61000, joinDate: ISODate("2022-02-20") },
	{ name: "Gita", department: "Finance", age: 34, salary: 75000, joinDate: ISODate("2019-12-10") }
])

// 21. Add tags to products for tag queries
db.products.updateMany({ title: { $in: ["Shoes", "Laptop"] } }, { $set: { tags: ["New", "Featured"] } })
db.products.updateMany({ title: { $in: ["Watch", "Bag"] } }, { $set: { tags: ["Sale"] } })

// ---------------- UPDATE OPERATIONS ----------------
// Update student 'Mitan' (skills array)
db.students.updateOne({ name: "Mitan" }, { $set: { skills: ["C", "Python", "React"] } })

// Add department IT to all Male students
db.students.updateMany({ gender: "Male" }, { $set: { department: "IT" } })

// Set status active for all students
db.students.updateMany({}, { $set: { status: "active" } })

// Remove dob field (will remove from newly inserted dob docs) – followed by rename example
db.students.updateMany({}, { $unset: { dob: "" } })

// Rename dob to dateOfBirth (noop if dob already removed)
db.students.updateMany({}, { $rename: { dob: "dateOfBirth" } })

// Increment age by 1 for Female students
db.students.updateMany({ gender: "Female" }, { $inc: { age: 1 } })

// Push single skill
db.students.updateOne({ name: "Mitan" }, { $push: { skills: "MongoDB" } })

// Push multiple skills using $each
db.students.updateOne({ name: "Mitan" }, { $push: { skills: { $each: ["MySql", "Node.js"] } } })

// Push multiple skills into all students
db.students.updateMany({}, { $push: { skills: { $each: ["MySql", "Node.js"] } } })

// Pull one skill from all students
db.students.updateMany({}, { $pull: { skills: "Node.js" } })

// PullAll example (fields named 'skills'; if some have 'Skill' mismatch they are skipped)
db.students.updateMany({}, { $pullAll: { skills: ["C++", "Node"] } })

// ---------------- DELETE OPERATIONS ----------------
db.students.deleteOne({ name: "Mitan" }) // delete a single student
db.users.deleteMany({ status: "inactive" }) // bulk delete by status
db.products.deleteMany({ price: { $lt: 100 } }) // delete cheap products (none maybe)
// Example delete by _id (placeholder ObjectId will likely not match)
// db.students.deleteOne({ _id: ObjectId("65bfa21c9f1f4c23d8e6a001") })

// ---------------- BASIC FINDS ----------------
db.students.find() // all students
db.students.find({ age: { $gt: 18 } }) // age greater than 18
db.students.find({ department: "IT" }) // department IT
db.students.find({ name: "Alice" }) // returns none (Alice not inserted) – intentional test
db.students.find().limit(5) // first 5 docs
db.students.find().skip(10).limit(5) // pagination example
db.products.find({ category: "Electronics" }) // electronics products
db.orders.find({ _id: 10 }) // likely empty (sample _id mismatch) – demonstrates filter

// Counts
db.students.find().count()
db.products.find({ price: { $gt: 500 } }).count()
db.students.find({ age: { $gt: 30 } }) // maybe none yet
db.employees.find({ salary: { $lt: 50000 } }) // employees below threshold

// Library copy range & category exclusion
db.Library.find({ copies: { $gt: 5, $lt: 10 } })
db.Library.find({ category: { $ne: "Clothing" } }) // category field not present → all docs returned

// Logical operators
db.students.find({ $or: [ { age: { $lt: 18 } }, { gender: "Male" } ] })
db.students.find({ $and: [ { status: "active" }, { age: { $gt: 20 } } ] })

// More filters
db.products.find({ price: { $lt: 500 } }) // cheap products (maybe none)
db.products.find({ price: { $not: { $gt: 500 } } }) // price <= 500
db.employees.find({ age: { $gt: 25 }, salary: { $gt: 40000 } })

// Regex examples
db.students.find({ name: { $regex: "^A" } }) // starts with A
db.students.find({ name: { $regex: "n$" } }) // ends with n
db.products.find({ title: { $regex: "Pro" } }) // substring Pro (none unless product names contain)
db.students.find({ name: { $regex: "^mitan$", $options: "i" } }) // case-insensitive exact match Mitan
db.students.find({ name: { $regex: "^user", $options: "i" } }) // prefix user (none)
db.products.find({ title: { $regex: "^.{8}$" } }) // exact length 8
db.products.find({ title: { $regex: "^S.{7}$" } }) // starts with S length 8 total

// Projection examples
db.students.find({}, { name: 1, age: 1 })
db.students.find({}, { _id: 0 }) // only _id suppression → returns empty docs? (projection returns nothing)

// Sorting
db.students.find().sort({ age: 1 }) // ascending age
db.students.find().sort({ name: -1 }) // descending name
db.products.find().sort({ age: 1, name: 1 }) // age field not in products; will sort by name fallback
db.Library.find().sort({ copies: -1, title: 1 }) // high copies first, then title

// Array queries
db.students.find({ skills: "MySql" }) // any doc having MySql in skills
db.students.find({ skills: { $all: ["Java", "Python"] } }) // requires both (unlikely unless updated manually)
db.products.find({ tags: { $in: ["New", "Featured"] } }) // products with those tags

// Index management
db.students.createIndex({ name: 1 })
db.students.getIndexes()
db.students.dropIndex({ name: 1 })

// Aggregations: group students by department counting documents
db.students.aggregate([
	{ $group: { _id: "$department", totalStudent: { $sum: 1 } } }
])

// Aggregation: sum price by product category
db.products.aggregate([
	{ $group: { _id: "$category", sum: { $sum: "$price" } } }
])

// Aggregation: average student age (global)
db.students.aggregate([
	{ $group: { _id: null, avgAgeOfStudent: { $avg: "$age" } } }
])

// Aggregation: max salary per department (employees)
db.employees.aggregate([
	{ $group: { _id: "$department", maxSalary: { $max: "$salary" } } }
])

// Aggregation: total copies per author (Library)
db.Library.aggregate([
	{ $group: { _id: "$author", totalCopies: { $sum: "$copies" } } }
])

// Aggregation: match expensive products (>1000)
db.products.aggregate([
	{ $match: { price: { $gt: 1000 } } }
])

// Aggregation: match active students (status lowercase 'active')
db.students.aggregate([
	{ $match: { status: "active" } }
])

// Aggregation: match employees joined after 2020-01-01
db.employees.aggregate([
	{ $match: { joinDate: { $gt: ISODate("2020-01-01") } } }
])

// Aggregation: simple projection rename (fullName = name)
db.students.aggregate([
	{ $project: { fullName: "$name", _id: 0 } }
])

// Aggregation: $lookup students with marks by roll
db.students.aggregate([
	{ $lookup: { from: "marks", localField: "roll", foreignField: "roll", as: "studentMarks" } }
])

// Aggregation: unwind joined marks to row-per-mark
db.students.aggregate([
	{ $lookup: { from: "marks", localField: "roll", foreignField: "roll", as: "studentMarks" } },
	{ $unwind: "$studentMarks" }
])
```

Notes:
- Some original queries referenced non-existent data; placeholders retained to illustrate usage (e.g., searching for Alice).
- Mixed field naming Skill/skills standardized to `skills` going forward.
- Avoid using `$unset` + `$rename` on the same field sequentially unless intentional; included to mirror original commands.
- `$not` usage demonstrates negation of an operator expression (price > 500 negated). For inequality prefer `$lte`.

---
## Additional Dummy Data: marks (expanded dataset)

The earlier `marks` collection had limited subjects. Below is an expanded dataset including multiple subjects and exam types per student (roll). This enriches `$lookup` joins and enables aggregation examples like per-student average, per-subject toppers.

```javascript
// Recreate or ensure marks collection exists (drop if you want a clean slate)
// db.marks.drop()
db.createCollection("marks")

db.marks.insertMany([
	// roll 1 (Mitan) – multiple subjects
	{ roll: 1, subject: "Math",     exam: "Midterm", score: 88 },
	{ roll: 1, subject: "Math",     exam: "Final",   score: 92 },
	{ roll: 1, subject: "Physics",  exam: "Final",   score: 81 },
	{ roll: 1, subject: "English",  exam: "Midterm", score: 85 },

	// roll 2 (Pranay)
	{ roll: 2, subject: "Math",     exam: "Final",   score: 76 },
	{ roll: 2, subject: "Science",  exam: "Midterm", score: 81 },
	{ roll: 2, subject: "Science",  exam: "Final",   score: 84 },

	// roll 3 (Yash)
	{ roll: 3, subject: "Math",     exam: "Midterm", score: 69 },
	{ roll: 3, subject: "Chemistry",exam: "Final",   score: 74 },

	// roll 4 (Umang)
	{ roll: 4, subject: "Math",     exam: "Final",   score: 90 },
	{ roll: 4, subject: "Physics",  exam: "Midterm", score: 82 },
	{ roll: 4, subject: "Physics",  exam: "Final",   score: 86 },

	// roll 5 (Jay)
	{ roll: 5, subject: "Science",  exam: "Final",   score: 90 },
	{ roll: 5, subject: "English",  exam: "Final",   score: 88 },

	// roll 6 (Riddhi)
	{ roll: 6, subject: "Math",     exam: "Midterm", score: 72 },
	{ roll: 6, subject: "English",  exam: "Midterm", score: 79 },
	{ roll: 6, subject: "English",  exam: "Final",   score: 83 },

	// roll 7 (Arjun)
	{ roll: 7, subject: "Science",  exam: "Midterm", score: 78 },
	{ roll: 7, subject: "Science",  exam: "Final",   score: 80 },
	{ roll: 7, subject: "Chemistry",exam: "Final",   score: 77 },

	// roll 8 (Sneha)
	{ roll: 8, subject: "Math",     exam: "Final",   score: 86 },
	{ roll: 8, subject: "Physics",  exam: "Final",   score: 88 },
	{ roll: 8, subject: "English",  exam: "Final",   score: 91 },

	// roll 9 (Rakesh)
	{ roll: 9, subject: "Math",     exam: "Midterm", score: 63 },
	{ roll: 9, subject: "Chemistry",exam: "Final",   score: 68 },
	{ roll: 9, subject: "English",  exam: "Final",   score: 72 }
])

// Example aggregations you can run after inserting:
// 1) Average score per student
db.marks.aggregate([
	{ $group: { _id: "$roll", avgScore: { $avg: "$score" }, exams: { $sum: 1 } } },
	{ $sort: { avgScore: -1 } }
])

// 2) Top score per subject
db.marks.aggregate([
	{ $sort: { score: -1 } },
	{ $group: { _id: "$subject", topScore: { $first: "$score" }, roll: { $first: "$roll" } } },
	{ $sort: { _id: 1 } }
])

// 3) Join with students for student + marks summary (avg per student with name)
db.marks.aggregate([
	{ $group: { _id: "$roll", avgScore: { $avg: "$score" } } },
	{ $lookup: { from: "students", localField: "_id", foreignField: "roll", as: "student" } },
	{ $unwind: "$student" },
	{ $project: { _id: 0, roll: "$_id", name: "$student.name", avgScore: 1 } },
	{ $sort: { avgScore: -1 } }
])
```


