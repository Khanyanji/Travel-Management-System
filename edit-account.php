<?php
// edit-account.php

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
    // Step 5: Collect and sanitize form data
    $name = $conn->real_escape_string($_POST['name']);
    $email = $conn->real_escape_string($_POST['email']);
    $currentPassword = $conn->real_escape_string($_POST['current-password']);
    $newPassword = $conn->real_escape_string($_POST['new-password']);
    $confirmPassword = $conn->real_escape_string($_POST['confirm-password']);

    // Step 6: Validate current password (if changing password)
    if (!empty($newPassword) {
        // Check if current password is correct
        $sql = "SELECT * FROM Users WHERE email = '$email' AND upassword = '$currentPassword'";
        $result = $conn->query($sql);

        if ($result->num_rows === 0) {
            die("Current password is incorrect.");
        }

        // Check if new password and confirm password match
        if ($newPassword !== $confirmPassword) {
            die("New password and confirm password do not match.");
        }

        // Update password
        $updateSql = "UPDATE Users SET name = '$name', upassword = '$newPassword' WHERE email = '$email'";
    } else {
        // Update only name and email (no password change)
        $updateSql = "UPDATE Users SET name = '$name' WHERE email = '$email'";
    }

    // Step 7: Execute the update query
    if ($conn->query($updateSql) === TRUE) {
        echo "Account updated successfully!";
    } else {
        echo "Error updating account: " . $conn->error;
    }

    // Step 8: Close the database connection
    $conn->close();
}
?>