<?php
// register.php

// Step 1: Database connection details
$host = 'localhost'; // or your host
$dbname = 'salama_agency'; // your database name
$username = 'root'; // default username for localhost
$password = ''; // default password for localhost

// Step 2: Create a connection to the database
$conn = new mysqli($host, $username, $password, $dbname);

// Step 3: Check if the connection was successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Step 4: Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Step 5: Collect form data
    $name = $conn->real_escape_string($_POST['name']); // Sanitize input
    $email = $conn->real_escape_string($_POST['email']); // Sanitize input
    $password = $conn->real_escape_string($_POST['password']); // Sanitize input
    $confirm_password = $conn->real_escape_string($_POST['confirm_password']); // Sanitize input

    // Step 6: Validate passwords match
    if ($password !== $confirm_password) {
        die("Passwords do not match.");
    }

    // Step 7: Insert data into the database
    $sql = "INSERT INTO Users (name, email, upassword) VALUES ('$name', '$email', '$password')";

    if ($conn->query($sql) === TRUE) {
       header("Location: login.html"); // Redirect to login page
exit(); // Stop further execution
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Step 8: Close the database connection
    $conn->close();
}
?>
