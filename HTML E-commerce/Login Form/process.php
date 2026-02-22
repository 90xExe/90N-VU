<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Sanitize inputs safely
    $name   = htmlspecialchars(trim($_POST['name']));
    $email  = htmlspecialchars(trim($_POST['email']));
    $gender = $_POST['gender'] ?? '';
    $dob    = $_POST['dob'] ?? '';
    $phone  = htmlspecialchars(trim($_POST['phone']));
    $password = $_POST['password'] ?? '';

    // Basic validation
    if (empty($name) || empty($email) || empty($password) || empty($gender) || empty($dob) || empty($phone)) {
        die("All fields are required.");
    }

    // Email validation
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("Invalid email format.");
    }

    // Password hashing
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Create user data array
    $userData = [
        "name" => $name,
        "email" => $email,
        "gender" => $gender,
        "dob" => $dob,
        "phone" => $phone,
        "password_hash" => $hashedPassword,
        "default_password" => $password, // store the original password as well
        "registered_at" => date("Y-m-d H:i:s")
    ];

    $file = "users.json";

    // If file exists, get old data
    if (file_exists($file)) {
        $existingData = json_decode(file_get_contents($file), true);
        if (!is_array($existingData)) {
            $existingData = [];
        }
    } else {
        $existingData = [];
    }

    // Add new user
    $existingData[] = $userData;

    // Save back to JSON file
    if (file_put_contents($file, json_encode($existingData, JSON_PRETTY_PRINT))) {
        header("Location: success.php");
        exit();
    } else {
        die("Error saving data.");
    }
}
?>