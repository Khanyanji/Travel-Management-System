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
    $hotel = $conn->real_escape_string($_POST['hotel']);
    $checkin = $conn->real_escape_string($_POST['checkin']);
    $checkout = $conn->real_escape_string($_POST['checkout']);
    $guests = $conn->real_escape_string($_POST['guests']);

    // Step 1: Find the user ID based on the name (assuming names are unique)
    $sql = "SELECT user_id FROM Users WHERE name = '$name'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $user_id = $row['user_id'];

        // Step 2: Find the hotel ID based on the hotel name
        $sql = "SELECT hotel_id FROM Hotels 
                JOIN HotelBranches hb ON Hotels.branch_id = hb.branch_id 
                WHERE hb.hotel_name = '$hotel'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $hotel_id = $row['hotel_id'];

            // Step 3: Insert the booking into the Bookings table
            $sql = "INSERT INTO Bookings (user_id, booking_type, reference_id, status) 
                    VALUES ($user_id, 'Hotel', $hotel_id, 'Booked')";

            if ($conn->query($sql) === TRUE) {
                echo "Hotel booked successfully!";
            } else {
                echo "Error booking hotel: " . $conn->error;
            }
        } else {
            echo "No hotels found with the selected name.";
        }
    } else {
        echo "User not found.";
    }

    // Close the database connection
    $conn->close();
}
?>