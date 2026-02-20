const express = require("express");
const { Pool } = require("pg");
const bcrypt = require("bcrypt");

const app = express();
app.use(express.json());

const pool = new Pool({
    user: "danagallo",
    host: "localhost",
    database: "chat_app",
    password: "",
    port: 5432,
});

app.get("/", (req, res) => {
    res.json({ message: "API is running" });
});

// REGISTER
app.post("/register", async (req, res) => {
    const { email, password, first_name, last_name } = req.body;

    if (!email || !password) {
        return res.json({
            error_code: 100,
            error_title: "Missing Fields",
            error_message: "Email and password are required",
        });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);

        const result = await pool.query(
            `INSERT INTO users 
                (email, password, first_name, last_name)
             VALUES ($1, $2, $3, $4)
             RETURNING user_id, email, first_name, last_name`,
            [email, hashedPassword, first_name, last_name]
        );

        res.json(result.rows[0]);
    } catch (err) {
        res.json({
            error_code: 101,
            error_title: "Registration Failed",
            error_message: "Email may already exist",
        });
    }
});

// LOGIN
app.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        const result = await pool.query(
            `SELECT * FROM users WHERE email = $1`,
            [email]
        );

        if (result.rows.length === 0) throw new Error();

        const user = result.rows[0];
        const match = await bcrypt.compare(password, user.password);

        if (!match) throw new Error();

        res.json({
            user_id: user.user_id,
            email: user.email,
            first_name: user.first_name,
            last_name: user.last_name,
        });
    } catch {
        res.json({
            error_code: 102,
            error_title: "Login Failure",
            error_message: "Email or Password was Invalid!",
        });
    }
});

// SEND MESSAGE
app.post("/send_message", async (req, res) => {
    const { sender_user_id, receiver_user_id, message } = req.body;
    const timestamp = Math.floor(Date.now() / 1000);

    try {
        await pool.query(
            `INSERT INTO messages (sender_user_id, receiver_user_id, message, timestamp)
       VALUES ($1, $2, $3, $4)`,
            [sender_user_id, receiver_user_id, message, timestamp]
        );

        res.json({
            success_code: 200,
            success_title: "Message Sent",
            success_message: "Message was sent successfully",
        });
    } catch {
        res.json({
            error_code: 103,
            error_title: "Message Failed",
            error_message: "Could not send message",
        });
    }
});

// VIEW MESSAGES
app.get("/view_messages", async (req, res) => {
    const { user_id_a, user_id_b } = req.query;

    try {
        const result = await pool.query(
            `SELECT message_id, sender_user_id, message, timestamp
       FROM messages
       WHERE (sender_user_id = $1 AND receiver_user_id = $2)
          OR (sender_user_id = $2 AND receiver_user_id = $1)
       ORDER BY timestamp ASC`,
            [user_id_a, user_id_b]
        );

        res.json({ messages: result.rows });
    } catch {
        res.json({
            error_code: 104,
            error_title: "Fetch Failed",
            error_message: "Could not retrieve messages",
        });
    }
});

// LIST USERS
app.get("/list_all_users", async (req, res) => {
    const { requester_user_id } = req.query;

    try {
        const result = await pool.query(
            `SELECT user_id, email, first_name, last_name
       FROM users
       WHERE user_id != $1`,
            [requester_user_id]
        );

        res.json({ users: result.rows });
    } catch {
        res.json({
            error_code: 105,
            error_title: "Fetch Failed",
            error_message: "Could not retrieve users",
        });
    }
});

app.listen(3000, () => {
    console.log("Server running on http://localhost:3000");
});
