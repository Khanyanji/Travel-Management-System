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

// Get the user_id from the URL
if (isset($_GET['user_id'])) {
    $user_id = $conn->real_escape_string($_GET['user_id']);
} else {
    die("User ID not provided.");
}

// Fetch user details
$sql = "SELECT name, email FROM Users WHERE user_id = $user_id";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $name = $row['name'];
    $email = $row['email'];
} else {
    die("User not found.");
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account - Salama Travel Management System</title>
    <link rel="stylesheet" href="Salama Travel Management System.css">
</head>
<body>
    <header>
        <h1>My Account</h1>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="about.html">About Us</a></li>
                <li><a href="plan.html">Plan Your Trip</a></li>
                <li><a href="services.html">Services</a></li>
                <li><a href="reviews.html">Reviews</a></li>
                <li><a href="partnerships.html">Partnerships</a></li>
                <li><a href="contact.html">Contact Us</a></li>
                <li><a href="login.html">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h2>Welcome, <?php echo $name; ?>!</h2>
        <p>Manage your account details and bookings below.</p>

        <section>
            <h3>Account Details</h3>
            <p><strong>Name:</strong> <?php echo $name; ?></p>
            <p><strong>Email:</strong> <?php echo $email; ?></p>
            <p><a href="edit-account.html">Edit Account Details</a></p>
        </section>

        <section>
            <h3>Flight Booking History</h3>
            <ul>
                <?php
                // Fetch flight booking history from the database
                $sql = "SELECT * FROM User_Flight_History WHERE user_id = $user_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<li>Flight: {$row['departure_city']} to {$row['destination_city']} on {$row['departure_time']} - Status: {$row['status']}</li>";
                    }
                } else {
                    echo "<li>No flight bookings found.</li>";
                }
                ?>
            </ul>
        </section>

        <section>
            <h3>Hotel Booking History</h3>
            <ul>
                <?php
                // Fetch hotel booking history from the database
                $sql = "SELECT 
                            hb.hotel_name, 
                            hb.branch, 
                            b.status, 
                            b.booking_date 
                        FROM Bookings b
                        JOIN Hotels h ON b.reference_id = h.hotel_id
                        JOIN HotelBranches hb ON h.branch_id = hb.branch_id
                        WHERE b.booking_type = 'Hotel' AND b.user_id = $user_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<li>Hotel: {$row['hotel_name']} ({$row['branch']}) - Booked on: {$row['booking_date']} - Status: {$row['status']}</li>";
                    }
                } else {
                    echo "<li>No hotel bookings found.</li>";
                }
                ?>
            </ul>
        </section>

        <section>
            <h3>Pickup Booking History</h3>
            <ul>
                <?php
                // Fetch pickup booking history from the database
                $sql = "SELECT * FROM User_Pickup_History WHERE user_id = $user_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<li>Pickup: {$row['airport']} ({$row['direction']}) - Date: {$row['date']} - Status: {$row['status']}</li>";
                    }
                } else {
                    echo "<li>No pickup bookings found.</li>";
                }
                ?>
            </ul>
        </section>

        <section>
            <h3>Account Actions</h3>
            <p><a href="change-password.html">Change Password</a></p>
            <p><a href="logout.html">Logout</a></p>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Salama Travel Management System. All rights reserved.</p>
    </footer>
</body>
</html>

<?php
// Close the database connection
$conn->close();
?>      <p>&copy; 2025 Salama Travel Management System. All rights reserved.</p>
    </footer>
</body>
</html>

<?php
// Close the database connection
$conn->close();
?>