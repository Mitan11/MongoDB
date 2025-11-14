const { MongoClient } = require("mongodb");

// Connection URL (adjust if your MongoDB runs elsewhere)
const url = "mongodb://127.0.0.1:27017";
const client = new MongoClient(url);

// Database and collection names
const dbName = "studentDatabase";
const collectionName = "studentInfo";

async function main() {
    try {
        // Connect to MongoDB
        await client.connect();
        console.log("Connected successfully to MongoDB");

        // Access database and collection
        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        // --- CREATE --- Insert sample students
        const insertResult = await collection.insertMany([
            { name: "Shiv", age: 22, course: "MSc IT" },
            { name: "Aman", age: 23, course: "BCA" },
            { name: "Riya", age: 21, course: "BSc CS" }
        ]);
        console.log("Data Inserted:", insertResult.insertedCount, "documents");

        // --- READ --- Fetch all students
        const students = await collection.find().toArray();
        console.log("All Students:", students);

        // --- UPDATE --- Update Aman (fixing original example's non-existent Aryan)
        const updateResult = await collection.updateOne(
            { name: "Aman" },
            { $set: { course: "MSc IT", age: 24 } }
        );
        console.log("Documents Updated:", updateResult.modifiedCount);

        // --- DELETE --- Remove Riya
        const deleteResult = await collection.deleteOne({ name: "Riya" });
        console.log("Documents Deleted:", deleteResult.deletedCount);

        // --- FINAL READ --- Show remaining students
        const finalStudents = await collection.find().toArray();
        console.log("Final Students List:", finalStudents);
    } catch (err) {
        console.error("Error:", err);
    } finally {
        await client.close();
        console.log("Connection closed");
    }
}

// Run the main function
main();
