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
db.movies.find({ title: { $regex: "^L" } });     // starts with 'L'
db.movies.find({ title: { $regex: "i$" } });     // ends with 'i'
db.movies.find({ title: { $regex: "xyz" } });    // contains 'xyz'
db.movies.find({ title: { $regex: "^3.*s$" } }); // starts with '3' and ends with 's'
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
```
