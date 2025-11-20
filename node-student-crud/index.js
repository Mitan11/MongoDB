const { MongoClient } = require("mongodb");

const url = "mongodb://127.0.0.1:27017";
const client = new MongoClient(url);

async function main() {
    try {
        
        await client.connect();
        console.log("Connected successfully to MongoDB");

        const db = client.db("studentDatabase");
        const collection = db.collection("studentInfo");

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
