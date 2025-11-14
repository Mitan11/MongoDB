# Node Student CRUD Example

This folder contains a minimal Node.js script demonstrating basic MongoDB CRUD operations using the official driver.

## Files
- `package.json` – project metadata and dependency on `mongodb` driver.
- `index.js` – connects to MongoDB, performs insert, find, update, delete, and shows final state.

## Prerequisites
- Node.js installed (v16+ recommended).
- A running MongoDB instance on `mongodb://127.0.0.1:27017` (default local server).

## Install Dependencies
```powershell
cd "c:\Users\MITAN TANK\Desktop\Programs\MongoDB\node-student-crud"
npm install
```

## Run Script
```powershell
node index.js
```

## What It Does
1. Connects to MongoDB.
2. Inserts three student documents.
3. Reads and prints them.
4. Updates Aman’s course and age.
5. Deletes Riya.
6. Reads and prints final list.
7. Closes the connection.

## Notes
- Adjust `url` in `index.js` if your MongoDB is remote or requires authentication.
- The original sample attempted to update a student named `Aryan` who wasn't inserted. Script now targets `Aman` to ensure an update occurs.
- For production, wrap database logic in separate modules and add error handling / retry logic.

## Next Steps (Optional)
- Add schema validation using MongoDB JSON Schema.
- Implement indexing (e.g., `collection.createIndex({ name: 1 })`).
- Convert to async route handlers in an Express server.
