-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 01, 2020 at 07:39 AM
-- Server version: 10.4.15-MariaDB-log
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_balll`
--

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` int(11) NOT NULL,
  `make` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `make`, `model`, `year`, `price`) VALUES
(1, 'Honda', 'Civic', 2015, 20000),
(2, 'Honda', 'Civic', 2015, 20000),
(3, 'Honda', 'Accord', 2015, 25000),
(4, 'Subaru', 'Impreza', 2018, 25000),
(9, 'Toyota', 'Camry', 2016, 20000),
(11, 'H', 'e', 1099, 1123),
(12, 'Honda', 'Civic', 2012, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `fName` varchar(255) NOT NULL,
  `lName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `fName`, `lName`) VALUES
(1, 'Lucas', 'Ball'),
(2, 'Lucas', 'Ball'),
(3, 'Matthew', 'Wong'),
(4, 'Jeff', 'Goldman'),
(5, 'Joe', 'Average');

-- --------------------------------------------------------

--
-- Table structure for table `customer_dealerships`
--

CREATE TABLE `customer_dealerships` (
  `cuid` int(11) NOT NULL,
  `did` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_dealerships`
--

INSERT INTO `customer_dealerships` (`cuid`, `did`) VALUES
(4, 3),
(4, 3),
(4, 4),
(3, 2),
(2, 1),
(2, 1),
(1, 4),
(5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `customer_transactions`
--

CREATE TABLE `customer_transactions` (
  `cuid` int(11) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_transactions`
--

INSERT INTO `customer_transactions` (`cuid`, `tid`) VALUES
(4, 2),
(4, 2),
(2, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `dealerships`
--

CREATE TABLE `dealerships` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phoneNum` varchar(10) NOT NULL,
  `carStock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dealerships`
--

INSERT INTO `dealerships` (`id`, `name`, `phoneNum`, `carStock`) VALUES
(1, 'University Honda', '5417522150', 20),
(2, 'University Honda', '5417522150', 20),
(3, 'Toyota of Corvallis', '5417541515', 15),
(4, 'Wilson Motors', '5417524201', 25);

-- --------------------------------------------------------

--
-- Table structure for table `dealership_cars`
--

CREATE TABLE `dealership_cars` (
  `cid` int(11) NOT NULL,
  `did` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dealership_cars`
--

INSERT INTO `dealership_cars` (`cid`, `did`) VALUES
(1, 2),
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic`
--

CREATE TABLE `diagnostic` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `diagnostic`
--

INSERT INTO `diagnostic` (`id`, `text`) VALUES
(1, 'MySQL is Working!');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `fName` varchar(255) NOT NULL,
  `lName` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `dealership_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `fName`, `lName`, `type`, `dealership_ID`) VALUES
(1, 'Joseph', 'Johnson', 'Sales', 2),
(2, 'Joe', 'Johnson', 'Sales', 1),
(3, 'Sarah', 'Smith', 'Sales', 2),
(4, 'Lewis', 'Weaton', 'Manager', 3),
(5, 'Jeff', 'Cordley', 'Manager', 2),
(6, 'Mary', 'Jackson', 'Sales', 3),
(7, 'Jamie', 'Avery', 'Sales', 4),
(8, 'Jamie', 'Avery', 'Sales', 4),
(18, 'Adam', 'Nelson', 'Manager', 2);

-- --------------------------------------------------------

--
-- Table structure for table `employee_transactions`
--

CREATE TABLE `employee_transactions` (
  `eid` int(11) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee_transactions`
--

INSERT INTO `employee_transactions` (`eid`, `tid`) VALUES
(5, 2),
(5, 2),
(5, 3),
(4, 4),
(5, 2),
(5, 3),
(4, 4),
(4, 3),
(5, 2),
(5, 3),
(4, 4),
(4, 3),
(3, 2),
(1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `dealership_ID` int(11) NOT NULL,
  `date` date NOT NULL,
  `car_ID` int(11) NOT NULL,
  `customer_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `dealership_ID`, `date`, `car_ID`, `customer_ID`) VALUES
(2, 3, '2020-11-16', 1, 1),
(3, 2, '2020-11-16', 2, 2),
(4, 1, '2020-11-16', 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_dealerships`
--
ALTER TABLE `customer_dealerships`
  ADD KEY `customer_dealerships_ibfk_1` (`cuid`),
  ADD KEY `customer_dealerships_ibfk_2` (`did`);

--
-- Indexes for table `customer_transactions`
--
ALTER TABLE `customer_transactions`
  ADD KEY `cuid` (`cuid`),
  ADD KEY `tid` (`tid`);

--
-- Indexes for table `dealerships`
--
ALTER TABLE `dealerships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealership_cars`
--
ALTER TABLE `dealership_cars`
  ADD KEY `dealership_cars_ibfk_1` (`did`),
  ADD KEY `dealership_cars_ibfk_2` (`cid`);

--
-- Indexes for table `diagnostic`
--
ALTER TABLE `diagnostic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employees_ibfk_1` (`dealership_ID`);

--
-- Indexes for table `employee_transactions`
--
ALTER TABLE `employee_transactions`
  ADD KEY `employee_transactions_ibfk_1` (`tid`),
  ADD KEY `employee_transactions_ibfk_2` (`eid`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dealership_ID` (`dealership_ID`),
  ADD KEY `car_ID` (`car_ID`),
  ADD KEY `customer_ID` (`customer_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dealerships`
--
ALTER TABLE `dealerships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dealership_cars`
--
ALTER TABLE `dealership_cars`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `diagnostic`
--
ALTER TABLE `diagnostic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_dealerships`
--
ALTER TABLE `customer_dealerships`
  ADD CONSTRAINT `customer_dealerships_ibfk_1` FOREIGN KEY (`cuid`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_dealerships_ibfk_2` FOREIGN KEY (`did`) REFERENCES `dealerships` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_transactions`
--
ALTER TABLE `customer_transactions`
  ADD CONSTRAINT `customer_transactions_ibfk_1` FOREIGN KEY (`cuid`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `customer_transactions_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `dealership_cars`
--
ALTER TABLE `dealership_cars`
  ADD CONSTRAINT `dealership_cars_ibfk_1` FOREIGN KEY (`did`) REFERENCES `dealerships` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dealership_cars_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `cars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`dealership_ID`) REFERENCES `dealerships` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_transactions`
--
ALTER TABLE `employee_transactions`
  ADD CONSTRAINT `employee_transactions_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_transactions_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`dealership_ID`) REFERENCES `dealerships` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`car_ID`) REFERENCES `cars` (`id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`customer_ID`) REFERENCES `customers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
