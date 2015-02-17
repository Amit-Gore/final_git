-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2015 at 11:02 AM
-- Server version: 5.5.36
-- PHP Version: 5.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `live_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment_info`
--

CREATE TABLE IF NOT EXISTS `appointment_info` (
  `AppointmentId` int(11) NOT NULL AUTO_INCREMENT,
  `DoctorId` int(11) NOT NULL,
  `PatientId` int(11) NOT NULL,
  `AppointmentDate` date NOT NULL,
  `AppointmentSlot` varchar(20) NOT NULL,
  `slotID` varchar(100) NOT NULL COMMENT 'slot''s unique id generated at the time of schedule set',
  `PatientName` varchar(30) NOT NULL,
  `Reason` text NOT NULL,
  `AppointmentStatus` varchar(25) NOT NULL,
  PRIMARY KEY (`AppointmentId`),
  KEY `DoctorId` (`DoctorId`),
  KEY `PatientId` (`PatientId`),
  KEY `DoctorId_2` (`DoctorId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=132 ;

--
-- Dumping data for table `appointment_info`
--

INSERT INTO `appointment_info` (`AppointmentId`, `DoctorId`, `PatientId`, `AppointmentDate`, `AppointmentSlot`, `slotID`, `PatientName`, `Reason`, `AppointmentStatus`) VALUES
(89, 11, 27, '2014-12-02', 'A', '', 'Anurag', 'back pain', '1'),
(90, 10, 27, '2014-12-02', 'I', '', 'Abhijit', 'tooth ache', '1'),
(91, 2, 23, '2014-12-06', 'E', '', 'asha kataria', 'son', '1'),
(92, 7, 23, '2014-12-04', 'L', '', 'Anurag Kataria', 'asd', '2'),
(93, 3, 23, '2014-12-06', 'I', '', 'Prashant Panchal', 'Backpain', '2'),
(94, 11, 23, '2014-12-05', 'A', '', 'Varun', 'knee pain', '1'),
(95, 14, 31, '2014-12-06', 'G', '', 'Abhishek Jain', 'Hair loss', '1'),
(96, 7, 35, '2014-12-11', 'H', '', 'Kumar Singh', 'Skin Rashes', '1'),
(106, 11, 34, '2014-12-13', 'A', '', 'Prashant Panchal', 'Diarhoea', '4'),
(107, 3, 34, '2014-12-12', 'I', '', 'Anurag Kataria', 'Diarhoea', '4'),
(108, 17, 34, '2014-12-12', 'J', '', 'Prashant Panchal', 'asd', '4'),
(109, 4, 35, '2014-12-13', 'C', '', 'Kumar Singh', 'Skin rashes', '1'),
(110, 3, 34, '2014-12-14', 'D', '', 'Prashant Panchal', 'back pain', '4'),
(111, 17, 34, '2014-12-13', 'H', '', 'Prashant Panchal', 'Diarhoea', '4'),
(112, 3, 36, '2015-02-13', 'J', '', 'Amit Gore ', 'Headche', '2'),
(113, 24, 38, '2015-01-05', 'B', '', 'Varun', 'issue', '4'),
(114, 3, 39, '2015-02-16', 'J', '', 'amit gore ', 'headche', '1'),
(115, 27, 40, '2015-01-22', 'L', '', 'Maximus', 'peeing', '3'),
(116, 27, 41, '2015-01-22', 'E', '', 'Amit Gore', 'Depression', '4'),
(117, 27, 41, '2015-01-22', 'I', '', 'Amit Gore', 'Extra Happiness', '4'),
(118, 27, 41, '2015-01-22', 'F', '', 'Amit Gore', 'Frustration', '4'),
(119, 27, 54, '2015-01-22', 'E', '', 'Amit Gore', 'Patience Overloaded', '3'),
(120, 27, 54, '2015-01-22', 'E', '', 'Prashant Panchal', 'Happiness Overloaded', '2'),
(121, 27, 54, '2015-01-22', 'C', '', 'Amit Gore', 'Cannot disclose', '4'),
(122, 19, 58, '2015-01-08', 'K', '', 'Abhijit', 'Rashes', '1'),
(123, 28, 58, '2015-01-08', 'I', '', 'Abhijirt', 'dgdgdgdf', '2'),
(124, 28, 59, '2015-01-09', 'L', '', 'amit Gore', 'Diarhoea', '2'),
(125, 8, 62, '2015-01-12', 'H', '', 'test', 'test', '1'),
(126, 8, 104, '2015-01-16', 'J', '', 'Amit Gore', 'Fever', '1'),
(130, 3, 122, '2015-02-17', '9:50-10:00', 'slot1:2', 'Prashant Panchal', 'Hagwan', '1'),
(131, 3, 122, '2015-02-17', '12:10-12:20', 'slot1:16', 'Prashant Panchal', 'fever', '1');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
