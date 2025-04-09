<?php
include "config.php";
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!isset($_SESSION['user_id'])) {
        die("Please log in to leave a review.");
    }

    $user_id = $_SESSION['user_id'];
    $rating = intval($_POST['rating']);
    $review_text = htmlspecialchars($_POST['review-text'], ENT_QUOTES, 'UTF-8');

    $stmt = $conn->prepare("INSERT INTO reviews (user_id, rating, review_text) VALUES (?, ?, ?)");
    $stmt->bind_param("iis", $user_id, $rating, $review_text);

    if ($stmt->execute()) {
        echo "Review submitted! <a href='reviews.html'>Go Back</a>";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
}
?>
