# Giftogram-Chat-API

## Author
**Name:** Dana Gallo

---

## Time Spent
8-9 Hours

---

## Summary of Process

I started by reading through the requirements and breaking down what needed to be built, mainly focusing on creating a REST API that could handle users and messaging between them.
I set up a basic Node.js project using Express and installed the necessary packages. After that, I created a PostgreSQL database and built two tables: one for users and one for messages. The users table stores account information, and the messages table stores messages between users.
Next, I connected my application to the database. Once the connection was working, I implemented each endpoint one at a time. I started with user registration and used bcrypt to hash passwords.
After that, I built the messaging features and created an endpoint to list all users except the current user.
While building each endpoint, I returned JSON responses and followed the required error format when something went wrong.
Lastly, I tested each endpoint to make sure everything was working correctly and exported the database as a SQL file for submission.

---

## Issues with Endpoint Structure

Not an issue, but an area for improvement could be how how query parameters are used when retrieving messages and users. While this approach works, it might be clearer to use URL parameters instead (for example, /messages/:userId) so the endpoints better reflect what data is being requested.

---

## Suggested Improvements

### Security

One security improvement I would make is continuing to use prepared statements for all database interactions. In this project, I used placeholders like $1, $2, etc. when writing SQL queries. This makes sure that user input is handled safely and not directly interpreted as part of the query itself, which helps prevent unintended or malicious behavior.

Another improvement would be to move sensitive information, ex: database credentials, into environment variables instead of hardcoding them in the application. For example, I would store values like the database username and password that could be stored in a .env file and accessed in the code. 

### Usability

One usability improvement would be to add more input validation. For example, validating email formats, enforcing password requirements, and ensuring required fields are present for all endpoints. This would help prevent invalid data from being submitted and provide clearer feedback to users when input is incorrect.

### API Design

One improvement I would make is to include proper HTTP status codes in all responses. 
A better approach would be to return appropriate HTTP status codes along with the JSON response. For example, a successful request could return 200, while client errors such as invalid input or failed login attempts could return 400 or 401. Server errors could return 500. 

---
