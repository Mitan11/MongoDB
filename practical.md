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
