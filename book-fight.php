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
    $from = $conn->real_escape_string($_POST['from']);
    $to = $conn->real_escape_string($_POST['to']);
    $date = $conn->real_escape_string($_POST['date']);
    $passengers = $conn->real_escape_string($_POST['passengers']);

    // Step 1: Find the user ID based on the name (assuming names are unique)
    $sql = "SELECT user_id FROM Users WHERE name = '$name'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $user_id = $row['user_id'];

        // Step 2: Find the flight ID based on departure and destination cities
        $sql = "SELECT flight_id FROM Flights 
                JOIN Airports a1 ON Flights.departure_airport_id = a1.airport_id 
                JOIN Airports a2 ON Flights.destination_airport_id = a2.airport_id 
                WHERE a1.city = '$from' AND a2.city = '$to'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $flight_id = $row['flight_id'];

            // Step 3: Insert the booking into the Bookings table
            $sql = "INSERT INTO Bookings (user_id, booking_type, reference_id, status) 
                    VALUES ($user_id, 'Flight', $flight_id, 'Booked')";

            if ($conn->query($sql) === TRUE) {
                echo "Flight booked successfully!";
            } else {
                echo "Error booking flight: " . $conn->error;
            }
        } else {
            echo "No flights found for the selected route.";
        }
    } else {
        echo "User  not found.";
    }

    // Close the database connection
    $conn->close();
}
?>