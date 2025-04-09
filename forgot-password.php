<?php
// forgot-password.php

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
    $email = $conn->real_escape_string($_POST['email']); // Sanitize input

    // Step 6: Query the database to check if the email exists
    $sql = "SELECT * FROM Users WHERE email = '$email'";
    $result = $conn->query($sql);

    // Step 7: Check if the query returned a row
    if ($result->num_rows > 0) {
        // Email exists in the database
        echo "A password reset link has been sent to your email."; // Simulate sending an email
    } else {
        // Email does not exist in the database
        echo "No account found with that email address.";
    }

    // Step 8: Close the database connection
    $conn->close();
}
?>