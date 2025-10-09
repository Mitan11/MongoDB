A concrete example using a `movies` collection in the `mitan` database.

```javascript
use mitan;

// Optional: clean start when re-running the script
db.movie.drop();

// Create collection and insert sample documents
db.createCollection("movie");

db.movie.insertMany([
  { mid: 1, title: "3 Idiots",       director: "Rajkumar Hirani",   genre: ["Comedy", "Drama"],  rating: 8.4, year: 2009 },
  { mid: 2, title: "Dangal",         director: "Nitesh Tiwari",     genre: ["Drama", "Sports"],  rating: 8.3, year: 2016 },
  { mid: 3, title: "Lagaan",         director: "Ashutosh Gowariker",genre: ["Comedy", "Drama"],  rating: 8.1, year: 2001 },
  { mid: 4, title: "Gully Boy",      director: "Zoya Akhtar",       genre: ["Music",  "Drama"],  rating: 7.9, year: 2019 },
  { mid: 5, title: "Sholay",         director: "Ramesh Sippy",      genre: ["Action", "Drama"],  rating: 8.2, year: 1975 },
  { mid: 6, title: "Chak De! India", director: "Shimit Amin",       genre: ["Drama", "Sports"],  rating: 8.1, year: 2007 }
]);

// Rename collection
db.movie.renameCollection("movies");

// Sorting
db.movies.find().sort({ rating: 1 });   // ascending by rating
db.movies.find().sort({ rating: -1 });  // descending by rating

// Comparison operators
db.movies.find({ year: { $gt: 2010 } }); // $gt, $lt, $lte, $gte, $eq, $ne

// Logical operators
db.movies.find({ $or:  [{ title: "Lagaan" }, { rating: 8.2 }] });
db.movies.find({ $and: [{ title: "Lagaan" }, { rating: 8.1 }] });
db.movies.find({ year: { $not: { $lt: 2010 } } });

// Regular expression examples

db.movies.find({title : {$regex : "^L"}})

db.movies.find({title : {$regex : "A$"}})

db.movies.find({title : {$regex : "A$" , $options : 'i'}})

db.movies.find({title : {$regex : "an"}})

db.movies.find({title : {$regex : "^3.*s$"}})

db.movies.find({title : { $regex: "^.{8}$"}})

db.movies.find({ title : { $regex: "^S.{7}$"}})

db.movies.find({genre : "Drama"})

db.movies.find({director : "Rajkumar Hirani"},{_id: 0,title : 1, year : 1})

db.movies.find({$and : [{$or : [{ rating: {$gte : 8.2} }]} , {year : {$lt : 2010}}]})

db.movies.find({year : {$gt : 2000}}).sort({year : 1})

db.movies.find({} , {_id: 0,title : 1, genre : 1 , rating : 1})

db.movies.find().sort({director : 1})

db.movies.find().limit(2)

db.movies.find().limit(2).skip(1)

db.movies.find({$or : [{director : "Zoya Akhtar"} , {rating :{$lt: 8.0}}]})

db.movies.find({$and: [{ genre: "Drama" },{ genre: "Sports" }]})

db.movies.find({rating : {$ne : 8.1 }})

db.movies.find({$and: [{ year: {$gt : 2000} },{ year: {$lt : 2010} }]})

db.movies.find({title : {$regex : "^G"}})

db.movies.find({title : {$regex : "India$"}})

db.movies.find({title : {$regex : "Boy"}})

db.movies.find({
    title: { $regex: /^[^\s]+ [^\s]+$/ }
})

db.movies.aggregate([
    { $unwind: "$genre" },                   // split array into separate documents
    { $group: { _id: "$genre", total: { $sum: 1 } } } // count each genre
  ])

db.movies.aggregate([
    {$match: {year : {$gt : 2000}}},
    { $group:{ _id : null , avgRating: {$avg : "$rating"}} },
])

db.movies.aggregate([
    { $sort: { rating: -1 } },  // sort descending by rating
    { $limit: 1 }               // take the top movie
])

db.movies.aggregate([
    { $group:{ _id : "$director" , avgRating: {$avg : "$rating"}} },
])

db.movies.updateOne({title : "Gully Boy"} , {$set : {rating : 8.0}})

db.movies.updateMany(
  {},                     // empty filter → applies to all documents
  { $set: { language: "Hindi" } } // add new field
)

db.movies.updateMany(
  {},  // match all documents
  { $rename: { "rating": "imdb_rating" } } // rename field
)

db.movies.updateMany(
    { year: {$lt : 2010} },
    { $inc: { imdb_rating: 0.1 } }  // increment rating by 0.1
)

// db.movies.updateMany(
//   {},                 // match all documents
//   { $unset: { rating: "" } } // remove the rating field
// )

db.movies.deleteMany({year: {$lt : 1980}})

db.movies.deleteOne({title:"Lagaan"})

db.movies.deleteMany({rating: {$lt : 8.0}})

```

Exercise: Menu items collection

```javascript
use mitan;

db.createCollection("MenuItem");

db.MenuItem.insertMany([
  { MenuItemId: 1, ItemName: "Margherita Pizza", Cuisine: "Italian",  Price: 299 },
  { MenuItemId: 2, ItemName: "Paneer Tikka",     Cuisine: "Indian",   Price: 249 },
  { MenuItemId: 3, ItemName: "Sushi Roll",       Cuisine: "Japanese", Price: 499 },
  { MenuItemId: 4, ItemName: "Veg Manchurian",   Cuisine: "Chinese",  Price: 199 },
  { MenuItemId: 5, ItemName: "Tacos",            Cuisine: "Mexican",  Price: 149 }
]);

// Comparison operations
db.MenuItem.find({ Price: { $gt: 200 } });
db.MenuItem.find({ Price: { $gte: 199, $lte: 300 } });

// Logical operations
db.MenuItem.find({ $or: [ { Cuisine: "Indian" }, { Cuisine: "Italian" } ] });
db.MenuItem.find({ $and: [ { Price: { $gte: 200 } }, { Cuisine: { $ne: "Chinese" } } ] });

// Pattern matching ($regex)
db.MenuItem.find({ ItemName: { $regex: "^V" } });     // starts with V
db.MenuItem.find({ ItemName: { $regex: "a$" } });     // ends with a
db.MenuItem.find({ ItemName: { $regex: "chi", $options: "i" } }); // contains 'chi' (case-insensitive)

// Rename collection
db.MenuItem.renameCollection("MenuItems");
```

Exercise: Music collection

```javascript
// Switch to the 'entertainmentDB' database. Creates it if it doesn't exist.
use entertainmentDB

// Explicitly create the 'music' collection
db.createCollection("music")

// Insert multiple song documents into the 'music' collection
db.music.insertMany([
{song_id : 1, title : "Tum Hi Ho", artist:"Arjit Singh" , album : "Aashiqui 2" , genre : ["Romantic" , "Bollywood"], year : 2013 , streams : 5000000 },
{song_id : 2, title : "Senorita", artist:"Shawn Mendes" , album : "Single" , genre : ["Pop"], year : 2019 , streams : 7500000 },
{song_id : 3, title : "Apna Bana Le", artist:"Arjit Singh" , album : "Bhediya" , genre : ["Romantic" , "Bollywood"], year : 2022 , streams : 4200000 },
{song_id : 4, title : "Believer", artist:"Imagine Dragons" , album : "Evolve" , genre : ["Rock" , "Pop"], year : 2017 , streams : 1200000 },
{song_id : 5, title : "Kesariya", artist:"Arjit Singh" , album : "Brahmastra" , genre : ["Romantic" , "Bollywood"], year : 2022 , streams : 9500000 }
])

// Retrieve all documents from the 'music' collection
db.music.find()

// Create a descending index on the 'title' field of the 'movie' collection for faster sorting/searching
db.movie.createIndex({title: -1})

// List all indexes on the 'movie' collection
db.movie.getIndexes()

// Drop the specified index from the 'movie' collection
db.movie.dropIndex({title: 1})

// Limit the output to the first 2 documents
db.music.find().limit(2)

// Skip the first document and return the next 2 (for pagination)
db.music.find().limit(2).skip(1)

// Find songs where the album name starts with 'B'
db.music.find({ album: { $regex: "^B" } })

// Find songs released after the year 2019
db.music.find({year : {$gt : 2019}})

// Find songs where the artist's name starts with 'A' and ends with 'h'
db.music.find({artist: { $regex: "^A.*h$" }})

// Find songs where the title is exactly 8 characters long
db.music.find({title : { $regex: "^.{8}$"}})

// Find songs where the title starts with 'S' and is 8 characters long
db.music.find({ title : { $regex: "^S.{7}$"}})

// Find songs where the album name starts with 'b' (case-insensitive)
db.music.find({ album: { $regex: "^b" ,  $options: "i" } })

// Find songs where the artist's name starts with 'a' and ends with 'h' (case-insensitive)
db.music.find({artist: { $regex: "^a.*h$" ,  $options: "i" }})
```

Exercise: Shopping Cart collection

```javascript
// Create the 'shoppingCart' collection
db.createCollection("shoppingCart")

// Insert multiple documents into the 'shoppingCart' collection
db.shoppingCart.insertMany([

{
	"cart_id" : 1 ,
	"customer" : "Aditi",
	"items" : ["Apples" , "Bananas"],
	"status" : "Pending",
	"total" : 200
},

{
	"cart_id" : 2 ,
	"customer" : "Rohan",
	"items" : ["Milk" , "Bread" , "Eggs"],
	"status" : "Pending",
	"total" : 150
},

{
	"cart_id" : 3 ,
	"customer" : "Priya",
	"items" : ["Rice" , "Dal"],
	"status" : "confirmed",
	"total" : 500
},

{
	"cart_id" : 4 ,
	"customer" : "Rakshit",
	"items" : ["PS5" , "Orange"],
	"status" : "confirmed",
	"total" : 51000
},

{
	"cart_id" : 5 ,
	"customer" : "Riddhi",
	"items" : ["Curd" , "Butter Milk" , "Panner"],
	"status" : "Pending",
	"total" : 100
}

])

// Retrieve all documents from the 'shoppingCart' collection
db.shoppingCart.find()

// Sort the results by customer name in ascending order
db.shoppingCart.find().sort("customer")

// Sort the results by total in descending order
db.shoppingCart.find().sort({"total" : -1})

// Find carts with "Pending" status and total greater than 180
db.shoppingCart.find({"status" : "Pending" , "total" : {"$gt" : 180}})

// Find carts belonging to either "Priya" or "Aditi"
db.shoppingCart.find({"customer": { "$in": ["Priya", "Aditi"] } })

// Find carts where the status is not "confirmed"
db.shoppingCart.find({ "status": { "$ne": "confirmed" } })

// Find carts with a total less than 200
db.shoppingCart.find({"total" : {"$lt" : 200}})

// Find carts with a total greater than or equal to 500
db.shoppingCart.find({"total" : {"$gte" : 500}})

// Find customers whose name starts with 'P'
db.shoppingCart.find({"customer" : {"$regex" : "^P"}})

// Find customers whose name ends with 'n'
db.shoppingCart.find({"customer" : {"$regex" : "n$"}})

// Find customers whose name is exactly 5 characters long
db.shoppingCart.find({"customer" : {"$regex" : "^.{5}$"}})

// Find customer "aditi" case-insensitively
db.shoppingCart.find({"customer" : {"$regex" : "aditi" , "$options" : "i"}})

// Limit the results to the first 2 documents
db.shoppingCart.find().limit(2)

// Delete the cart with cart_id 2
db.shoppingCart.deleteOne({"cart_id" : 2})

// Delete all carts with "Pending" status
db.shoppingCart.deleteMany({"status" : "Pending"})

// Skip the first 2 documents and return the next 1 (prints the 3rd cart)
// Useful when you want a single item from a specific offset
db.shoppingCart.find().limit(1).skip(2)

// Update the status of the cart with cart_id 1 to "Pending"
// updateOne(filter, update) modifies the first matching document
db.shoppingCart.updateOne({"cart_id": 1}, { $set: { "status": "Pending" } })

// Update all carts with status "Pending" to have status "In-Progress"
// Useful to change workflow state for multiple orders at once
db.shoppingCart.updateMany({"status" : "Pending"},{$set : {"status" : "In-Progress"}})
```

Exercise: New movies and reviews (insertions + example aggregation queries)

```javascript
new mocies db.movies.insertMany([
  {
    mid: 1,
    title: "Rocky Reborn",
    genre: ["Sport", "Drama"],
    rating: 8.5,
    year: 2018,
    director: "Alex Stone",
    boxOffice: 95000000
  },
  {
    mid: 2,
    title: "Laugh Out Loud",
    genre: ["Comedy"],
    rating: 7.2,
    year: 2016,
    director: "Amy Johnson",
    boxOffice: 60000000
  },
  {
    mid: 3,
    title: "Code of Honor",
    genre: ["Action", "Thriller"],
    rating: 9.0,
    year: 2021,
    director: "Arjun Mehta",
    boxOffice: 120000000
  },
  {
    mid: 4,
    title: "Soul of Music",
    genre: ["Drama", "Musical"],
    rating: 8.0,
    year: 2019,
    director: "Ariana Blake",
    boxOffice: 87000000
  },
  {
    mid: 5,
    title: "The Last Laugh",
    genre: ["Comedy", "Drama"],
    rating: 6.8,
    year: 2014,
    director: "Brian Carter",
    boxOffice: 45000000
  },
  {
    mid: 6,
    title: "Champions League",
    genre: ["Sport"],
    rating: 8.9,
    year: 2020,
    director: "Ankit Sharma",
    boxOffice: 130000000
  },
  {
    mid: 7,
    title: "Into the Shadows",
    genre: ["Thriller", "Horror"],
    rating: 7.5,
    year: 2017,
    director: "Chris Nolan",
    boxOffice: 75000000
  },
  {
    mid: 8,
    title: "Smiles of Spring",
    genre: ["Romance", "Comedy"],
    rating: 7.8,
    year: 2022,
    director: "Aarav Patel",
    boxOffice: 56000000
  }
])

db.reviews.insertMany([
  { movie_id: 1, reviewer: "Alice", comment: "Loved the drama and sport blend!", stars: 5 },
  { movie_id: 1, reviewer: "Bob", comment: "Strong story and acting.", stars: 4 },
  { movie_id: 2, reviewer: "Charlie", comment: "Hilarious and light-hearted.", stars: 4 },
  { movie_id: 3, reviewer: "David", comment: "Intense and thrilling!", stars: 5 },
  { movie_id: 4, reviewer: "Eve", comment: "Beautiful music and visuals.", stars: 4 },
  { movie_id: 5, reviewer: "Frank", comment: "Could be funnier.", stars: 3 },
  { movie_id: 6, reviewer: "Grace", comment: "Best sports movie ever!", stars: 5 },
  { movie_id: 7, reviewer: "Henry", comment: "Dark and interesting plot.", stars: 4 },
  { movie_id: 8, reviewer: "Isla", comment: "Feel-good romantic comedy.", stars: 5 }
])

db.movies.aggregate([{
    "$match" : {"year" : {"$gt" : 2015}}
}])


db.movies.aggregate([{
    "$match" : {"genre" : {"$in" : ["Sport" , "Comedy"]}}
}])


db.movies.aggregate([{
    "$match" : {"genre" : {"$nin" : ["Sports" , "Comedy"]}}
}])


db.movies.aggregate([{
    "$match" : {"$and" : [{"rating" : {"$lt" : 8}} , {"year" : {"$lt" : 2020 }}] }
}])


db.movies.aggregate([{
    "$match" : {"$or" : [{"rating" : {"$lt" : 8}} , {"year" : {"$gt" : 2020 }}] }
}])


db.movies.aggregate([
    {
        "$match" :  {"year" : {"$not" : {"$gt" : 2014}}}
    }
])


db.movies.aggregate([
    {
        "$match" :  {"name" :{ "$exists" : "true"}}
    }
])


db.movies.aggregate([
    {
        "$match" :  {"director" :{ "$regex" : "^A"}}
    }
])


db.movies.aggregate([
    {
        "$project" :  {_id : 0 , title:1 , genre : 1 , releaseYear: "$year"}
    }
])


db.movies.aggregate([
    {
        $addFields : {ratingCatagory : {$cond : {if : {$gte : ["$rating" , 8]} , then : "Excellent" , else : "Average"}}}
    }
])


// Join movies with their reviews using $lookup (placed here in the New movies section)
// Adds a new field 'movieReviews' containing an array of matching review documents
db.movies.aggregate([
  {
    $lookup: {
      from: "reviews",
      localField: "mid",
      foreignField: "movie_id",
      as: "movieReviews"
    }
  }
])
```

Exercise: NEW STUDENTS

```javascript
NEW STUDENTS db.student.insertMany([
  {
    name: 'Raj',
    score: 85,
    result: 'Pass',
    department: 'fcait',
    gender: 'male',
    dob: '2004-01-07'
  },
  {
    name: 'Mitan',
    score: 74,
    result: 'Pass',
    department: 'fcait',
    gender: 'male',
    dob: '2004-02-09'
  },
  {
    name: 'Shaily',
    score: 92,
    result: 'Pass',
    department: 'fcait',
    gender: 'female',
    dob: '2004-06-22'
  },
  {
    name: 'Aastha',
    score: 58,
    result: 'Pass',
    department: 'imca',
    gender: 'female',
    dob: '2004-08-08'
  },
  {
    name: 'John',
    score: 32,
    result: 'Fail',
    department: 'bca',
    gender: 'male',
    dob: '2004-03-15'
  }
])



db.student.aggregate([
  {
    "$group": {
      "_id": "$department",           
      "studentCount": { "$sum": 1 }
   	}
  }
])


db.student.aggregate([
  {
    $group: {
      _id: null,
      totalScore: { $sum: "$score" }
    }
  }
])


db.student.aggregate([
  {
    $group: {
      _id: null,
      averageScore: { $avg: "$score" }
    }
  }
])


db.student.aggregate([
  {
    $group: {
      _id: null,
      minScore: { $min: "$score" }
    }
  }
])


db.student.aggregate([
  {
    $group: {
      _id: null,
      maxScore: { $max: "$score" }
    }
  }
])
db.student.aggregate([
  {
    $count: "totalStudents"
  }
])



db.student.aggregate([
  {
    $group: {
      _id: null,
      totalScore: { $sum: "$score" },
      averageScore : {$avg : "$score"},
      studentCount : {$sum : 1}
    }
  }
])


db.student.aggregate([
  {
    $group: {
      _id: "$department",
      totalScore: { $sum: "$score" },
      averageScore : {$avg : "$score"},
      studentCount : {$sum : 1}
    }
  }
])
```
