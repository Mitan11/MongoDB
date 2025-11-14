## Employee Collection Exercises

This section creates an `Employee` collection, inserts sample documents, and demonstrates 20 common MongoDB queries / aggregations plus a MapReduce example (with an improved version). Each example includes an explanation of what it does and why you'd use it.

### Seed Data
```javascript
// Create the collection
db.createCollection("Employee")

// Insert sample employee documents
db.Employee.insertMany([
	{
		_id: 1,
		name: "Aarav",
		department: "IT",
		age: 28,
		salary: 60000,
		skills: ["MongoDB", "Node.js"],
		projects: [ { name: "Alpha", duration: 6 }, { name: "Beta", duration: 4 } ],
		joiningDate: ISODate("2022-01-10")
	},
	{
		_id: 2,
		name: "Diya",
		department: "HR",
		age: 32,
		salary: 55000,
		skills: ["Recruitment", "Communication"],
		projects: [ { name: "PeopleConnect", duration: 8 } ],
		joiningDate: ISODate("2021-03-15")
	},
	{
		_id: 3,
		name: "Karan",
		department: "IT",
		age: 26,
		salary: 48000,
		skills: ["Python", "MongoDB"],
		projects: [ { name: "Gamma", duration: 5 } ],
		joiningDate: ISODate("2023-02-05")
	},
	{
		_id: 4,
		name: "Isha",
		department: "Finance",
		age: 35,
		salary: 75000,
		skills: ["Excel", "SAP"],
		projects: [ { name: "AccountsRevamp", duration: 7 } ],
		joiningDate: ISODate("2020-10-22")
	},
	{
		_id: 5,
		name: "Manav",
		department: "IT",
		age: 30,
		salary: 68000,
		skills: ["Java", "Spring"],
		projects: [ { name: "Delta", duration: 6 }, { name: "Epsilon", duration: 3 } ],
		joiningDate: ISODate("2022-07-01")
	},
	{
		_id: 6,
		name: "Sara",
		department: "Marketing",
		age: 29,
		salary: 59000,
		skills: ["SEO", "Content Writing"],
		projects: [ { name: "BrandBoost", duration: 5 } ],
		joiningDate: ISODate("2021-08-09")
	}
])
```

---
### 1. IT employees with salary > 55000
Find employees in IT earning above 55K.
```javascript
db.Employee.find({ $and: [ { department: "IT" }, { salary: { $gt: 55000 } } ] })
```
Use case: Filter by multiple conditions (department + compensation threshold).

### 2. Employees in HR or Finance
Match any of the listed departments using `$in`.
```javascript
db.Employee.find({ department: { $in: ["HR", "Finance"] } })
```

### 3. Employees NOT in Marketing
Exclude departments with `$nin`.
```javascript
db.Employee.find({ department: { $nin: ["Marketing"] } })
```

### 4. Names starting with 'M'
Prefix match with regex anchor `^`.
```javascript
db.Employee.find({ name: { $regex: "^M" } })
```

### 5. Age > 28 using `$match`
Aggregation pipeline initial filter.
```javascript
db.Employee.aggregate([
	{ $match: { age: { $gt: 28 } } }
])
```
Benefit: Early `$match` reduces documents for later stages.

### 6. Total salary per department
Group by `department`, sum `salary`.
```javascript
db.Employee.aggregate([
	{ $group: { _id: "$department", totalSalary: { $sum: "$salary" } } }
])
```

### 7. Average age per department
```javascript
db.Employee.aggregate([
	{ $group: { _id: "$department", avgAge: { $avg: "$age" } } }
])
```

### 8. Global min/max salary
Single document output with min/max.
```javascript
db.Employee.aggregate([
	{ $group: { _id: null, maxSalary: { $max: "$salary" }, minSalary: { $min: "$salary" } } }
])
```
Note: Original example used `_id: "department"` which produces a literal string key; using `null` is conventional for global aggregations.

### 9. Project selected fields
Include only name, department, salary.
```javascript
db.Employee.aggregate([
	{ $project: { name: 1, department: 1, salary: 1, _id: 0 } }
])
```
`_id: 0` removes the default `_id` field.

### 10. Sort by salary descending
```javascript
db.Employee.find().sort({ salary: -1 })
```

### 11. Add static field `status = "Active"`
Adds the field in pipeline output (does not persist unless used with `$merge`/`$out`).
```javascript
db.Employee.aggregate([
	{ $addFields: { status: "Active" } }
])
```

### 12. Unwind `projects` array
One document per project (duplicates employee fields across rows).
```javascript
db.Employee.aggregate([
	{ $unwind: "$projects" }
])
```
Use this before grouping by project attributes.

### 13. Salary not equal to 60000
```javascript
db.Employee.find({ salary: { $ne: 60000 } })
```

### 14. Age >= 30
```javascript
db.Employee.find({ age: { $gte: 30 } })
```

### 15. Department in [IT, HR]
```javascript
db.Employee.find({ department: { $in: ["IT", "HR"] } })
```

### 16. Department not in [IT, HR]
```javascript
db.Employee.find({ department: { $nin: ["IT", "HR"] } })
```

### 17. Push new skill "Leadership" for Diya
```javascript
db.Employee.updateOne({ name: "Diya" }, { $push: { skills: "Leadership" } })
```
Atomic array append.

### 18. Pull skill "MongoDB" from Karan
```javascript
db.Employee.updateOne({ name: "Karan" }, { $pull: { skills: "MongoDB" } })
```
Removes matching element(s) from array.

### 19. First and last employee alphabetically
Use `$sort` then `$group` with `$first` / `$last`.
```javascript
db.Employee.aggregate([
	{ $sort: { name: 1 } },
	{ $group: { _id: null, firstEmployee: { $first: "$name" }, lastEmployee: { $last: "$name" } } }
])
```

### 20. MapReduce: Total project duration per employee (ORIGINAL)
Original map only emits the first project's duration, ignoring additional projects.
```javascript
var mapFunction = function() {
	emit(this.name, this.projects[0].duration);
};

var reduceFunction = function(name, durations) {
	return Array.sum(durations);
};

db.Employee.mapReduce(
	mapFunction,
	reduceFunction,
	{ out: "total_duration" }
)

db.total_duration.find()
```
Limitation: Employees with multiple projects are under-counted (e.g., Aarav has 6+4 but emits only 6).

### Improved MapReduce (emit all project durations)
```javascript
var mapAllProjects = function() {
	this.projects.forEach(p => emit(this.name, p.duration));
};

var reduceAllProjects = function(name, durations) {
	return Array.sum(durations);
};

db.Employee.mapReduce(
	mapAllProjects,
	reduceAllProjects,
	{ out: "total_duration_all" }
)

db.total_duration_all.find()
```
Now totals reflect all durations per employee.

### Aggregation Pipeline Equivalent (preferred)
Simpler and faster for this use case.
```javascript
db.Employee.aggregate([
	{ $unwind: "$projects" },
	{ $group: { _id: "$name", totalDuration: { $sum: "$projects.duration" } } },
	{ $project: { name: "$_id", totalDuration: 1, _id: 0 } },
	{ $sort: { totalDuration: -1 } }
])
```
Advantages: Runs in a single optimized pipeline, no custom JS, supports indexing.

---
