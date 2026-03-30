-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 30, 2026 at 04:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `daro_albertojr`
--

-- --------------------------------------------------------

--
-- Table structure for table `Appointments`
--

CREATE TABLE `Appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_name` varchar(100) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Appointments`
--

INSERT INTO `Appointments` (`appointment_id`, `patient_id`, `doctor_name`, `appointment_date`, `status`) VALUES
(201, 101, 'Dr. Garcia', '2025-03-10', 'Completed'),
(202, 102, 'Dr. Ramos', '2025-03-11', 'Scheduled'),
(203, 101, 'Dr. Cruz', '2025-03-15', 'Scheduled'),
(204, 103, 'Dr. Garcia', '2025-03-18', 'Cancelled'),
(205, 106, 'Dr. Ramos', '2025-03-20', 'Scheduled');

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `membership_level` varchar(20) DEFAULT NULL,
  `join_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`customer_id`, `customer_name`, `city`, `membership_level`, `join_date`) VALUES
(1, 'Alice', 'Cebu', 'Gold', '2025-01-10'),
(2, 'Bob', 'Bohol', 'Silver', '2025-01-15'),
(3, 'Charlie', 'Cebu', 'Bronze', '2025-02-10'),
(4, 'Diana', 'Tagbilaran', 'Gold', '2025-02-12'),
(5, 'Ethan', 'Bohol', 'Silver', '2025-03-01'),
(6, 'Fiona', 'Cebu', 'Gold', '2025-03-05'),
(7, 'George', 'Tagbilaran', 'Bronze', '2025-03-08'),
(8, 'Hannah', 'Cebu', 'Silver', '2025-04-01'),
(9, 'Ian', 'Bohol', 'Gold', '2025-04-10'),
(10, 'Julia', 'Cebu', 'Bronze', '2025-04-15');

-- --------------------------------------------------------

--
-- Table structure for table `Patients`
--

CREATE TABLE `Patients` (
  `patient_id` int(11) NOT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Patients`
--

INSERT INTO `Patients` (`patient_id`, `patient_name`, `city`, `contact_number`) VALUES
(101, 'Maria Santos', 'Cebu', '09123456781'),
(102, 'Juan Dela Cruz', 'Bohol', '09123456782'),
(103, 'Ana Reyes', 'Cebu', '09123456783'),
(104, 'Mark Lopez', 'Dumaguete', '09123456784'),
(105, 'Carla Gomez', 'Bohol', '09123456785');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Appointments`
--
ALTER TABLE `Appointments`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `Patients`
--
ALTER TABLE `Patients`
  ADD PRIMARY KEY (`patient_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- STEP 2: SQL FILTERING QUERIES (Customers) [cite: 56]
-- 1. Customers from Cebu
SELECT * FROM Customers WHERE city = 'Cebu'; [cite: 59]
-- 2. Gold membership customers
SELECT * FROM Customers WHERE membership_level = 'Gold'; [cite: 60]
-- 3. Names starting with A or D
SELECT * FROM Customers WHERE customer_name LIKE 'A%' OR customer_name LIKE 'D%'; [cite: 61]
-- 4. Cebu with Silver or Gold membership
SELECT * FROM Customers WHERE city = 'Cebu' AND membership_level IN ('Silver', 'Gold'); [cite: 62]
-- 5. Joined between 2025-02-01 and 2025-03-31
SELECT * FROM Customers WHERE join_date BETWEEN '2025-02-01' AND '2025-03-31'; [cite: 63]
-- 6. Bohol or Tagbilaran with Bronze membership
SELECT * FROM Customers WHERE city IN ('Bohol', 'Tagbilaran') AND membership_level = 'Bronze'; [cite: 64]
-- 7. Names containing "a"
SELECT * FROM Customers WHERE customer_name LIKE '%a%'; [cite: 65]
-- 8. Cebu, Gold, before March 2025
SELECT * FROM Customers WHERE city = 'Cebu' AND membership_level = 'Gold' AND join_date < '2025-03-01'; [cite: 66]
-- 9. Bohol/Tagbilaran, Silver/Bronze, on or before Feb 2025
SELECT * FROM Customers WHERE city IN ('Bohol', 'Tagbilaran') AND join_date <= '2025-02-28' AND membership_level IN ('Silver', 'Bronze'); [cite: 67]
-- 10. ID not 1, 4, 6 and joined after Feb 2025
SELECT * FROM Customers WHERE customer_id NOT IN (1, 4, 6) AND join_date > '2025-02-28'; [cite: 68]

-- STEP 3: JOIN OPERATIONS [cite: 69]
-- Part A: Patient name and doctor name for all appointments
SELECT p.patient_name, a.doctor_name FROM Patients p JOIN Appointments a ON p.patient_id = a.patient_id; [cite: 81]
-- Part B: Patients from Cebu and their appointments
SELECT p.patient_name, p.city, a.doctor_name FROM Patients p JOIN Appointments a ON p.patient_id = a.patient_id WHERE p.city = 'Cebu'; [cite: 83]
-- Part B: Appointments handled by Dr. Garcia
SELECT a.doctor_name, p.patient_name FROM Appointments a JOIN Patients p ON a.patient_id = p.patient_id WHERE a.doctor_name = 'Dr. Garcia'; [cite: 84]
-- Part C: All patients and their appointments (including those without)
SELECT p.patient_name, a.appointment_id FROM Patients p LEFT JOIN Appointments a ON p.patient_id = a.patient_id; [cite: 86]
-- Part C: All appointments even if patient info doesn't exist
SELECT a.appointment_id, a.doctor_name, p.patient_name FROM Appointments a LEFT JOIN Patients p ON a.patient_id = p.patient_id; [cite: 87]
