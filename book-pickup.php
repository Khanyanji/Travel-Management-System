<?php
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection details
$host = 'localhost';
$dbname = 'salama_agency';
$username = 'root';
$password = '';

// Create connection
$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect and sanitize form data
    $name = $conn->real_escape_string($_POST['name']);
    $pickup_location = $conn->real_escape_string($_POST['pickup-location']);
    $dropoff_location = $conn->real_escape_string($_POST['dropoff-location']);
    $date = $conn->real_escape_string($_POST['date']);
    $time = $conn->real_escape_string($_POST['time']);
    $passengers = $conn->real_escape_string($_POST['passengers']);

    // Step 1: Find the user ID based on the name (assuming names are unique)
    $sql = "SELECT user_id FROM Users WHERE name = '$name'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $user_id = $row['user_id'];

        // Step 2: Find the pickup ID based on the pickup location
        $sql = "SELECT pickup_id FROM Pickups WHERE airport = '$pickup_location'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $pickup_id = $row['pickup_id'];

            // Step 3: Insert the booking into the Bookings table
            $sql = "INSERT INTO Bookings (user_id, booking_type, reference_id, status) 
                    VALUES ($user_id, 'Pickup', $pickup_id, 'Booked')";

            if ($conn->query($sql) === TRUE) {
                echo "Pickup booked successfully!";
            } else {
                echo "Error booking pickup: " . $conn->error;
            }
        } else {
            echo "No pickups found for the selected location.";
        }
    } else {
        echo "User not found.";
    }

    // Close the database connection
    $conn->close();
}
?>