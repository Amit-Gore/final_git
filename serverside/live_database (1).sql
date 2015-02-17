-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2015 at 11:03 AM
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

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`healthse`@`localhost` FUNCTION `levenshteinE`( s1 VARCHAR(255), s2 VARCHAR(255) ) RETURNS int(11)
    DETERMINISTIC
BEGIN
DECLARE s1_len, s2_len, i, j, c, c_temp, cost INT;
DECLARE s1_char CHAR;
-- max strlen=255
DECLARE cv0, cv1 VARBINARY(256);
SET s1_len = CHAR_LENGTH(s1), s2_len = CHAR_LENGTH(s2), cv1 = 0x00, j = 1, i = 1, c = 0;
IF s1 = s2 THEN
RETURN 0;
ELSEIF s1_len = 0 THEN
RETURN s2_len;
ELSEIF s2_len = 0 THEN
RETURN s1_len;
ELSE
WHILE j <= s2_len DO
SET cv1 = CONCAT(cv1, UNHEX(HEX(j))), j = j + 1;
END WHILE;
WHILE i <= s1_len DO
SET s1_char = SUBSTRING(s1, i, 1), c = i, cv0 = UNHEX(HEX(i)), j = 1;
WHILE j <= s2_len DO
SET c = c + 1;
IF s1_char = SUBSTRING(s2, j, 1) THEN
SET cost = 0; ELSE SET cost = 1;
END IF;
SET c_temp = CONV(HEX(SUBSTRING(cv1, j, 1)), 16, 10) + cost;
IF c > c_temp THEN SET c = c_temp; END IF;
SET c_temp = CONV(HEX(SUBSTRING(cv1, j+1, 1)), 16, 10) + 1;
IF c > c_temp THEN
SET c = c_temp;
END IF;
SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;
END WHILE;
SET cv1 = cv0, i = i + 1;
END WHILE;
END IF;
RETURN c;
END$$

DELIMITER ;

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

-- --------------------------------------------------------

--
-- Table structure for table `contactcc`
--

CREATE TABLE IF NOT EXISTS `contactcc` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(1000) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `contactcc`
--

INSERT INTO `contactcc` (`ID`, `name`, `email`, `subject`, `message`) VALUES
(1, 'ksgfdas', 'prashant.panchal63@gmail.com', 'afsd', 'afaisadsas '),
(2, 'amit Gore ', 'amit.gore2009@gmail.com', 'tp', ' adiatusdaiodfadaid9ra8dcaodga9pd8atgdp8ap8dfd'),
(3, 'amit Gore ', 'amit.gore2009@gmail.com', 'tp', ' adiatusdaiodfadaid9ra8dcaodga9pd8atgdp8ap8jh');

-- --------------------------------------------------------

--
-- Table structure for table `day`
--

CREATE TABLE IF NOT EXISTS `day` (
  `Day` varchar(15) NOT NULL,
  `DayId` varchar(15) NOT NULL,
  PRIMARY KEY (`Day`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `day`
--

INSERT INTO `day` (`Day`, `DayId`) VALUES
('Friday', 'FriSlots'),
('Monday', 'MonSlots'),
('Saturday', 'SatSlots'),
('Sunday', 'SunSlots'),
('Thursday', 'ThurSlots'),
('Tuesday', 'TuesSlots'),
('Wednesday', 'WedSlots');

-- --------------------------------------------------------

--
-- Table structure for table `docinfo_withschedule`
--

CREATE TABLE IF NOT EXISTS `docinfo_withschedule` (
  `doc_id` int(11) DEFAULT NULL,
  `FirstName` varchar(15) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `speciality` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `lat` float DEFAULT NULL,
  `lng` float DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `MonSlots` varchar(60) DEFAULT NULL,
  `TuesSlots` varchar(60) DEFAULT NULL,
  `WedSlots` varchar(60) DEFAULT NULL,
  `ThurSlots` varchar(60) DEFAULT NULL,
  `FriSlots` varchar(60) DEFAULT NULL,
  `SatSlots` varchar(60) DEFAULT NULL,
  `SunSlots` varchar(60) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_clinic`
--

CREATE TABLE IF NOT EXISTS `doctor_clinic` (
  `clinic_id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `clinic_name` varchar(30) NOT NULL,
  `clinic_address` varchar(100) NOT NULL,
  `clinic_contact` varchar(20) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  PRIMARY KEY (`clinic_id`),
  KEY `doctor_id` (`doctor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `doctor_clinic`
--

INSERT INTO `doctor_clinic` (`clinic_id`, `doctor_id`, `clinic_name`, `clinic_address`, `clinic_contact`, `lat`, `lng`) VALUES
(1, 7, 'Skin City', 'Parihar Chowk,opposite to JaiHind Store,\r\nAundh,Pune', '8945454512', 0, 0),
(2, 3, 'Jagtap Clinic and Research Cen', 'Jagtap Clinic and Research Center, 303, 3rd foor, Mangalmurti complex, Hirabag chowk, Tilak Road, Pu', '', 18.507041, 73.851449),
(3, 4, 'Kulkarni Hospital', 'Kulkarni Hospital, 125/B, Warje Naka, Warje, Pune - 411052', '', 18.486743, 73.791907),
(4, 14, 'Skin care and cure', 'Skin care and cure, Ground Floor, Triveni Housing Society, Behind Annapurna Wadewale, Opposite Domin', '', 18.477478, 73.823754);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_info`
--

CREATE TABLE IF NOT EXISTS `doctor_info` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `regnumber` varchar(15) NOT NULL,
  `MedicalCouncil` varchar(50) NOT NULL,
  `temp_password` varchar(10) NOT NULL DEFAULT '396969',
  `password` varchar(100) NOT NULL DEFAULT '$1$UmSSvHDx$3OpOFcrSlCOUIpx.ydXS01',
  `fee` int(11) NOT NULL,
  `schema_enumeration` text NOT NULL COMMENT 'SEO activity,according to schema.org',
  `schedule` text NOT NULL COMMENT 'doctor schedule is saved as json text',
  `speciality` varchar(30) NOT NULL,
  `FirstName` varchar(15) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `ss_name` varchar(100) NOT NULL COMMENT 'To solve the issue, ''varun joshi'',for temporary purpose we have included one more column',
  `DocImage` text,
  `DisplayName` varchar(40) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `gender` varchar(8) NOT NULL,
  `address` varchar(200) NOT NULL,
  `area` varchar(50) NOT NULL,
  `lat` float DEFAULT '19.0901' COMMENT 'lattitude',
  `lng` float DEFAULT '74.7386' COMMENT 'longitude',
  `enquired` int(11) NOT NULL COMMENT 'total appointment enquired',
  `booked` int(11) NOT NULL COMMENT 'total appointment booked',
  `cancelled` int(11) NOT NULL COMMENT 'total appointment cancelled',
  `rejected` int(11) NOT NULL COMMENT 'No.of appointments rejected by the doctor',
  `aboutdoctor` text NOT NULL,
  `degree` varchar(20) NOT NULL,
  `experience` int(11) NOT NULL,
  PRIMARY KEY (`doc_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `doctor_info`
--

INSERT INTO `doctor_info` (`doc_id`, `email`, `regnumber`, `MedicalCouncil`, `temp_password`, `password`, `fee`, `schema_enumeration`, `schedule`, `speciality`, `FirstName`, `LastName`, `ss_name`, `DocImage`, `DisplayName`, `contact`, `gender`, `address`, `area`, `lat`, `lng`, `enquired`, `booked`, `cancelled`, `rejected`, `aboutdoctor`, `degree`, `experience`) VALUES
(1, 'drsunilagarwal@gmail.com', '2469', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 300, 'Physician', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Addiction medicine', 'Sunil', 'Agrawal', '', 'ProfilePics/DoctorProfPic/dr_agarwal_profile.jpg', 'Sunil Agrawal', '', 'M', 'Hutatma Chowk, Bhosari-Alandi Road, Bhosari, Pune - 411039, Maharashtra', 'Bhosari', 18.63, 73.87, 0, 0, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho', 6),
(2, 'dr.chandrashekhar.raman@healthserve.in', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 300, 'Emergency', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Ambulatory care', 'Chandrashekhar', 'Raman', 'ChandrashekharRaman', 'ProfilePics/DoctorProfPic/Dr Raman.jpg', 'Chandrashekhar Raman', '9921491569', 'M', 'Noble Hospital, 153, Magarpatta City Road, Hadapsar, Pune - 411013', 'Hadapsar', 18.5, 73.93, 2, 0, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho', 10),
(3, 'sujitjagtap2001@yahoo.co.in', '2002/02/884', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Physician', '{"2015-02-11":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-12":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-13":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-14":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-16":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-18":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-19":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-20":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-23":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-25":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-26":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"singhagadaaaaaaaaaaaaaaaaaaaaaaaa","from_inMins":570,"to_inMins":765,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":19},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","from_inMins":870,"to_inMins":1020,"sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1],"TotalSlots":14},"numberofSuperSlots":2}}', 'Biomedical scientist', 'Sujit', 'Jagtap', '', 'ProfilePics/DoctorProfPic/4. SUJIT photo.jpg', 'Sujit Jagtap', '9822290200', 'M', 'Jagtap Clinic &amp; Research Centerter 303, 3rd Floor, Mangalmurti complex Hirabagh chowk, tilak roa', 'Tilak Road', 18.48, 74.8, 16, 2, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho', 4),
(4, 'kulshree1@rediffmail.com', '91020', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Physician', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Biomedicine', 'Shrirang', 'Kulkarni', '', 'ProfilePics/DoctorProfPic/Dr Shrirang.jpg', 'Shrirang Kulkarni', '7774002664', 'M', 'Kulkarni Hospital 125/B Warje Naka Warje, Pune 411052', 'warje', 18.48, 73.81, 1, 0, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho', 3),
(5, 'hscc.nagar@healthserve.in', 'MMC85430', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Cardiovascular', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Cardiopulmonary rehabilitation', 'Sinukumar', 'Bhaskaran', '', 'ProfilePics/DoctorProfPic/ShinuKumar.jpg', 'Sinukumar Bhaskaran', '9028051102', 'M', 'Columbia Asia Hospital, 22/A,Near Nyati Empire, Kharadi - Mundhwa Road, Kharadi, Pune-411014', 'Kharadi', 18.55, 73.94, 0, 0, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho', 9),
(6, 'thokalajit@gmail.com', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 100, 'Physician', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Correctional medicine', 'Ajit', 'Thokal', 'AjitThokal', 'ProfilePics/DoctorProfPic/Dr. Ajit Thokal.jpg', 'Ajit Thokal', '9220824726', 'M', 'Healthserve Community Clinic, 101 Kaware Heights, near Maharashtra Agro Agency Old Vasant Takies ', 'Koregaon Park', 19.09, 74.73, 0, 0, 0, 0, 'Brief Introduction about Doctor', 'D. Ortho, M.S. (Orth', 12),
(8, 'drsandeepkharb@gmail.com', 'DMC-37988', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Endocrine', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Endocrinology', 'Sandip', 'Kharab', '', NULL, 'Sandip Kharab', '9561070234', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Karve road', 19.0901, 74.7386, 7, 0, 0, 0, '', 'MD (Medeicine),  DNB', 6),
(9, 'dramoldiwan@yahoo.co.in', '2004020922', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'RespiratoryTherapy', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Pulmonary  Medicine', 'Amol', 'Diwan', 'AmolDiwan', NULL, 'Amol Diwan', '9552287638', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Kothrud', 19.0901, 74.7386, 0, 0, 0, 0, '', 'MBBS, MD (Pulmonary ', 6),
(10, 'dr.ganesh.mehatras@healthserve.in', 'MMC2002010134', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Renal', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Nephrology', 'Ganesh', 'Mehatras', 'GaneshMehatras', NULL, 'GaneshMehatras', '', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Aundh', 19.0901, 74.7386, 1, 0, 0, 0, '', 'MD, DNB (Nephrology)', 5),
(11, 'lalitshimpi@hotmail.com', '75990', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Gastroenterologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Medicine Gastroenterology', 'Lalit', 'Shimpi', 'LalitShimpi', NULL, 'Lalit Shimpi', '9850424112', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Hadapsar', 19.0901, 74.7386, 5, 0, 0, 0, '', 'MB, DNB (Medicine), ', 5),
(12, 'njpatil@gmail.com', '2812', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Physician', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Medicine', 'Nilesh', 'Patil', '', NULL, 'Nilesh Patil', '9004009101', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Baner', 19.0901, 74.7386, 0, 0, 0, 0, '', 'FCPS (Medicine)', 6),
(13, 'tuncus1@gmail.com', '34668', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Neurologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Neuro Surgeon', 'K', 'Tingre', 'K.N.Tingre', NULL, 'K.N.Tingre', '9850790640', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Hingewadi', 19.0901, 74.7386, 0, 0, 0, 0, '', 'MS, MCH (Neuro & Spi', 6),
(14, 'dryuvrajmore@yahoo.co.in', '2003/04/2008', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Dermatologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Skin', 'Yuvraj', 'More', '', NULL, 'Yuvraj More', '8149880318', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'sinhagad road', 19.0901, 74.7386, 1, 0, 0, 0, '', 'MD (Skin)', 5),
(15, 'twinklechildclinic@gmail.com', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Pediatric', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Pead. Cardiology', 'Santosh', 'Joshi', '', NULL, 'Santosh Joshi', '8605472281', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Koregaon Park', 19.0901, 74.7386, 1, 0, 0, 0, '', 'MD (Pead. Cardiology', 5),
(16, 'dr.dhara.patel@healthserve.in', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 0, 'Physician', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'General Practitioner ', 'Dhara', 'Patel', 'DharaPatel', NULL, 'Dhara Patel', '7507838487', 'F', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar - 4', 'Sinhagad road', 19.0901, 74.7386, 0, 0, 0, 0, '', 'M.B.B.S', 4),
(17, 'hscc.nagar@healthserve.in', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Endocrine', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Endocrinology', 'Varsha', 'Jagtap', '', NULL, 'Varsha Jagtap', '', 'F', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar', 'Aundh', 19.0901, 74.7386, 2, 0, 0, 0, '', 'DM(Endocrinology)', 5),
(18, 'hscc.nagar@healthserve.in', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Gynecologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Gynecologists', 'Deepti', 'Thokal', 'DeeptiThokal', NULL, 'Deepti Thokal', '', 'F', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar', 'Shivaji Nagar', 19.0901, 74.7386, 0, 0, 0, 0, '', 'MBBS , DGO(Gynecolog', 4),
(19, 'hscc.nagar@healthserve.in', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 350, 'Dermatologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Skin', 'Nachiket', 'Palaskar', '', NULL, 'NachiketPalaskar', '', 'M', '101 HealthServe Community Clinic, Kaware Heights, Old Vasant Talkies Chowk, Maliwada, Ahmednagar', 'Pune Camp ', 19.0901, 74.7386, 1, 0, 0, 0, '', 'MBBS, MD(Skin)', 5);
INSERT INTO `doctor_info` (`doc_id`, `email`, `regnumber`, `MedicalCouncil`, `temp_password`, `password`, `fee`, `schema_enumeration`, `schedule`, `speciality`, `FirstName`, `LastName`, `ss_name`, `DocImage`, `DisplayName`, `contact`, `gender`, `address`, `area`, `lat`, `lng`, `enquired`, `booked`, `cancelled`, `rejected`, `aboutdoctor`, `degree`, `experience`) VALUES
(27, 'amitgore2009@gmail.com', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 1, '', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Emergency Medicine', 'Varun', 'Joshi', 'VarunJoshi', 'ProfilePics/DoctorProfPic/VarunJoshida840950.jpg', 'Varun Joshi', '111', 'M', 'Sahil Parihar Chowk Aundh', 'Hingewadi', 18.5603, 73.8091, 7, 3, 3, 2, 'AYUSH', 'BAMS', 19),
(28, 'prashant.panchal63@gmail.com', '', '', '396969', '$1$J4EEMyG7$Q2EwX/zu3kZIj6oIecBfr/', 200, 'Gynecologic', '{"2015-02-15":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-17":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-21":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-22":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-24":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-27":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}},"2015-02-28":{"slot1":{"from":"09:30","to":"12:45","avgTimePerPatient":10,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},"slot2":{"from":"14:30","to":"17:00","avgTimePerPatient":15,"location":"Aundh","sequentialSlots":[1,1,1,1,1,1,1,1,1,1,1,1,1,1]}}}', 'Gynecologist', 'Prashant', 'Panchal', 'PrashantPanchal', 'ProfilePics/DoctorProfPic/PrashantPanchalAIbEiAIAAABDCIHwqPGX3avfOyILdmNhcmRfcGhvdG8qKDY2Y2VlMDY4ZjY4NzBiNDc2Mzc4YzhjNmJhNWViZjAxMDE5ZmVhMjYwAd1_1D1f-8ysH3MP30JZoxN-eRhz.jpg', 'Prashant Panchal', '8149426686', 'M', 'Navale Hospital Pune Maharashtra', 'Everywhere', 18.5806, 73.9814, 2, 2, 0, 0, 'I''m a passionate researcher', 'M.D.', 5);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_schedule`
--

CREATE TABLE IF NOT EXISTS `doctor_schedule` (
  `ScheduleID` int(11) NOT NULL AUTO_INCREMENT,
  `DoctorId` int(11) NOT NULL,
  `MonSlots` varchar(60) NOT NULL,
  `TuesSlots` varchar(60) NOT NULL,
  `WedSlots` varchar(60) NOT NULL,
  `ThurSlots` varchar(60) NOT NULL,
  `FriSlots` varchar(60) NOT NULL,
  `SatSlots` varchar(60) NOT NULL,
  `SunSlots` varchar(60) NOT NULL,
  `AppCount` int(11) NOT NULL DEFAULT '3' COMMENT 'Number of appointments per slot',
  PRIMARY KEY (`ScheduleID`),
  KEY `DoctorId` (`DoctorId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `doctor_schedule`
--

INSERT INTO `doctor_schedule` (`ScheduleID`, `DoctorId`, `MonSlots`, `TuesSlots`, `WedSlots`, `ThurSlots`, `FriSlots`, `SatSlots`, `SunSlots`, `AppCount`) VALUES
(1, 1, 'A,C,D,F', 'B,C,D,I,J,K,L', 'B,C,D,I,J', 'B,C,D,I,J,K,L', 'B,C,D,I,J,K,L', 'I,J,K,L', 'B,C,D,E', 3),
(2, 2, 'I,J,K,L', 'I,J,K,L', 'I,J,K,L', 'I,J,K,L', 'I,J,K,L', 'C,D,E,F', 'H,I', 3),
(3, 3, 'B,C,J,K,L', 'B,C,D,I,J', 'B,C,J,K,L', 'K,L', 'B,C,D,I,L', 'I,J,K,L', 'B,D,E', 3),
(4, 4, 'K,L', 'I,J', 'J,K,L', 'I,J,K', 'I,J,K,L', 'C,D', '', 3),
(5, 5, 'A,B,C,H,I,J', 'A,B,C,H,I,J', 'A,B,C,H,I,J', 'A,B,C,H,I,J', 'A,B,C,H,I,J', 'D,E', 'I,J', 3),
(6, 6, 'B,C', 'B,C', 'B,C', 'B,C', 'B,C', 'K,L', 'K,L', 3),
(8, 8, 'F,G,H,I,J', 'F,G,H,I,J', 'F,G,H,I,J', 'F,G,H,I,J', 'F,G,H,I,J', 'K,L', 'K,L', 3),
(9, 9, 'B,C,K,L', 'F,G,H,I,J', 'B,C,K,L', 'F,G,H,I,J', 'B,C,K,L', 'K,L', 'K,L', 3),
(10, 10, 'A,B,C,F,G,H,I,J', 'C,F,G,H,I,J,K,L', 'A,B,C,F,G,H,I,J', 'C,F,G,H,I,J,K,L', 'A,B,C,F,G,H,I,J', 'C,F,G,H,I,J,K,L', 'H,I,J', 3),
(11, 11, 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 3),
(12, 12, 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 'A,B,C,I,J,K,L', 3),
(13, 13, 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 3),
(14, 14, 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 'A,B,C,D,E,F,G', 3),
(15, 15, 'D,E,F,G', 'D,E,F,G', 'D,E,F,G', 'D,E,F,G', 'D,E,F,G', 'D,E,F,G', 'D,E,F,G', 3),
(16, 16, 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 3),
(17, 17, 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 'E,F,G,H,I,J', 3),
(18, 18, 'K,L', 'K,L', 'K,L', 'K,L', 'I,J,K,L', 'I,J,K,L', 'I,J,K,L', 3),
(19, 19, 'K,L', 'K,L', 'K,L', 'K,L', 'I,J,K,L', 'I,J,K,L', 'I,J,K,L', 3),
(22, 27, 'A,E,H,K,L', 'A,F,I', 'E,F,I,L', 'C,E,J,K', 'B,D,F,I,L', 'B,D,H,I', 'A,B,C,E,G,I,J,K,L', 3),
(23, 28, 'A,B,C,H,I,J,K,L', 'A,B,C,D,H,I,J,K,L', 'A,B,C,H,I,J,K,L', 'A,B,C,H,I,J,K,L', 'A,B,C,H,I,J,K,L', 'K,L', 'A,B,C,H,I,J,K,L', 5);

-- --------------------------------------------------------

--
-- Table structure for table `olddoctor_info`
--

CREATE TABLE IF NOT EXISTS `olddoctor_info` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_verified` tinyint(1) NOT NULL,
  `fee` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `pwd1` varchar(100) NOT NULL,
  `Rnumber` varchar(25) NOT NULL,
  `dor` date NOT NULL,
  `speciality` varchar(30) NOT NULL,
  `FirstName` varchar(15) NOT NULL,
  `LastName` varchar(15) NOT NULL,
  `email` varchar(20) NOT NULL,
  `gender` varchar(8) NOT NULL,
  `address` varchar(100) NOT NULL,
  `lat` float NOT NULL,
  `lng` float NOT NULL,
  `street` varchar(15) NOT NULL,
  `state` varchar(15) NOT NULL,
  `country` varchar(10) NOT NULL,
  `Mnumber` int(11) NOT NULL,
  `Lnumber` int(11) NOT NULL,
  `birthDate` date NOT NULL,
  PRIMARY KEY (`doc_id`),
  UNIQUE KEY `Rnumber` (`Rnumber`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `olddoctor_info`
--

INSERT INTO `olddoctor_info` (`doc_id`, `is_verified`, `fee`, `username`, `pwd1`, `Rnumber`, `dor`, `speciality`, `FirstName`, `LastName`, `email`, `gender`, `address`, `lat`, `lng`, `street`, `state`, `country`, `Mnumber`, `Lnumber`, `birthDate`) VALUES
(2, 0, 110, 'abhijeet', '$1$nc4.k55.$0HVTsFia2WBlD0L2eoZLF1', '2009010018', '2014-01-07', '', 'Abhijeet', 'G', 'amitgore2013@gmail.c', '', 'asd', 18.5603, 73.8092, 'asd', 'asd', 'asd', 2147483647, 2147483647, '1967-11-19'),
(3, 1, 90, 'kaveri', '$1$5U..oo1.$b5BSiPHA6o0DxnSkHIIOQ/', '2013020340', '2013-02-28', 'Allergy & Immunology', 'A', 'Kaveri', 'amitgore2013@gmail.c', 'F', 'sadashiv peth,pune', 18.5083, 73.8466, 'Tilak Road', 'Maharashtra', 'India', 2147483647, 2147483647, '1969-11-09'),
(4, 0, 400, 'reddy', '$1$bJ1.Iw2.$tq.FlOZ9LrKyPixOQ7qtP/', '2009010019', '2009-01-07', 'Gynecology', 'A', 'Reddy', 'amitgore2009@gmail.c', '', 'NCL colony,Pune', 18.5446, 73.811, 'mumbai bypass', 'Maharashtra', 'India', 2147483647, 2147483647, '1969-11-11'),
(5, 1, 50, 'amit_gore', '123abcDEF', '1', '2014-08-18', 'ENT', 'Amit', 'Gore', 'amitgore2009@gmail.c', 'M', 'Karve Nagar,\r\nOpp.Jai Hind Store', 18.4561, 73.8209, 'Karve Road', 'Maharashtra', 'India', 8988259, 246224, '1973-07-09'),
(6, 1, 450, 'amit_kataria', '123abcDEF', '2', '2014-08-03', 'Dentologist', 'Amit', 'Kataria', 'amitgore2009@gmail.c', 'M', 'Sinhagad Road,\r\nPL Park', 18.5362, 73.894, 'Sinhagad Road', 'Maharashtra', 'India', 1241415, 5124214, '1974-08-12'),
(7, 1, 150, 'amit_jain', '$1$Db/.Qx1.$E1KYR49fb0GhQDOcd9.C4.', '3', '2014-08-05', 'Gynecology', 'Amit', 'Jain', 'amitjain2009@gmail.c', '', 'Magarpatta City,Hadapsar,Pune', 18.5158, 73.9272, 'bipass road', 'Maharashtra', 'India', 1241241, 123123, '1967-11-19');

-- --------------------------------------------------------

--
-- Table structure for table `prelaunch_emails`
--

CREATE TABLE IF NOT EXISTS `prelaunch_emails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `prelaunch_emails`
--

INSERT INTO `prelaunch_emails` (`ID`, `email`) VALUES
(3, 'amitgore2009@gmail.com'),
(4, 'alsdfjalsdfj@asdf.com'),
(5, 'anurag@healthserve.in'),
(6, 'niteshbhele@gmail.com'),
(7, 'wavre_d3656@rediffmail.com'),
(8, 'varunjoshi17@gmail.com'),
(9, 'rajspeed.20@gmail.com'),
(10, 'vikash1056@gmail.com'),
(11, 'test@test.com'),
(12, 'prashant.panchal63@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `ref_appointment_info`
--

CREATE TABLE IF NOT EXISTS `ref_appointment_info` (
  `AppointmentId` int(11) NOT NULL AUTO_INCREMENT,
  `RefAppointmentId` int(11) DEFAULT NULL COMMENT 'this would be the id of appointment which got referred ',
  `DoctorId` int(11) NOT NULL,
  `PatientId` int(11) NOT NULL,
  `AppointmentDate` date NOT NULL,
  `AppointmentSlot` varchar(5) NOT NULL,
  `PatientName` varchar(30) NOT NULL,
  `Reason` text NOT NULL,
  `refbyDoctor` varchar(30) NOT NULL,
  `AppointmentStatus` varchar(25) NOT NULL,
  `Prescription` text NOT NULL,
  PRIMARY KEY (`AppointmentId`),
  KEY `RefAppointmentId` (`RefAppointmentId`,`DoctorId`,`PatientId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sheet1`
--

CREATE TABLE IF NOT EXISTS `sheet1` (
  `email` varchar(26) DEFAULT NULL,
  `regnumber` int(8) DEFAULT NULL,
  `fee` int(3) DEFAULT NULL,
  `speciality` varchar(8) DEFAULT NULL,
  `FirstName` varchar(8) DEFAULT NULL,
  `LastName` varchar(7) DEFAULT NULL,
  `contact` bigint(10) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `address` varchar(26) DEFAULT NULL,
  `aboutdoctor` varchar(11) DEFAULT NULL,
  `degree` varchar(7) DEFAULT NULL,
  `experience` int(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sheet1`
--

INSERT INTO `sheet1` (`email`, `regnumber`, `fee`, `speciality`, `FirstName`, `LastName`, `contact`, `gender`, `address`, `aboutdoctor`, `degree`, `experience`) VALUES
('prashant.panchal@gmail.com', 81034687, 200, 'Medicine', 'Prashant', 'Panchal', 8194426686, 'M', 'Navale Hospital,Narhe,Pune', 'asdasasdczx', 'M.B.B.S', 3);

-- --------------------------------------------------------

--
-- Table structure for table `userregistration`
--

CREATE TABLE IF NOT EXISTS `userregistration` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_provider` varchar(15) NOT NULL,
  `oauth_uid` varchar(50) DEFAULT NULL,
  `fb_access_token` varchar(256) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `user_email` varchar(30) DEFAULT NULL,
  `email_activation` varchar(50) NOT NULL COMMENT 'Activation link for email verification',
  `email_activation_status` tinyint(1) DEFAULT '0',
  `contactNumber` varchar(15) NOT NULL,
  `OTP` text NOT NULL COMMENT 'Storing OTP in database',
  `OTPverified` tinyint(1) DEFAULT '0' COMMENT 'check whether OTP is verified or not(the expiry time is 24hrs)',
  `gender` varchar(10) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `contactNumber` (`contactNumber`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `oauth_uid` (`oauth_uid`),
  UNIQUE KEY `fb_access_token` (`fb_access_token`),
  KEY `OTPverified` (`OTPverified`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=123 ;

--
-- Dumping data for table `userregistration`
--

INSERT INTO `userregistration` (`userID`, `oauth_provider`, `oauth_uid`, `fb_access_token`, `username`, `password`, `display_name`, `FirstName`, `LastName`, `user_email`, `email_activation`, `email_activation_status`, `contactNumber`, `OTP`, `OTPverified`, `gender`) VALUES
(32, 'healthserve', NULL, NULL, '9096119299', '$1$hmTyLrcY$Wdp.54FoZMG5MvE31jFvK.', 'Rahul Lamba', 'Rahul', 'Lamba', NULL, '', 0, '9096119299', '$1$YELQrO6f$vHtAIj9XRHxrqX/b.4ohc/', 0, 'male'),
(35, 'healthserve', NULL, NULL, '9823637675', '$1$hWRGwMVA$zLMSrG04N3PfUBvyVW1qt/', 'Kumar Singh Thakur', 'Kumar Singh', 'Thakur', NULL, '', 0, '9823637675', '$1$v1o6YE0Q$AGf11tn7v/AIZ50CWUsU41', 1, 'male'),
(38, 'healthserve', NULL, NULL, '8551812786', '$1$xCdf9L/u$CP7gOULcfXNpMAYUkoRuP/', 'Varun Joshi', 'Varun', 'joshi', '0', '', 0, '8551812786', '$1$vj/6Jd8H$Rz73yczJdNtXtwdYDnxEk.', 1, 'male'),
(40, 'healthserve', NULL, NULL, '9689046006', '$1$B/.vjhlM$7FDBzhvXJbYIZHYt/tB.T.', 'Anurag Kataria', 'anurag', 'kataria', NULL, '', 0, '9689046006', '$1$U1wOXOLw$Mgoq0mYkqp91SZmOOC4Ya/', 1, 'male'),
(58, 'healthserve', NULL, NULL, '9168214362', '$1$qcatXdjB$5322nzO56gX4LAtGilwCy1', 'Abhijiit Singh', 'Abhijit', 'Singh', NULL, '', 0, '9168214362', '$1$WE1chHGq$7ekYkNDSTO.I.JQdtUFFm0', 1, 'male'),
(61, 'healthserve', NULL, NULL, '9405402036', '$1$iVPN3Lov$xCI9GZubjyxudb.CE081X1', 'Kiran narang', 'kiran', 'narang', NULL, '', 0, '9405402036', '$1$DTE1Y0Gu$FI6Dr.mh5mGOr.kDgbJLx1', 1, 'female'),
(121, 'healthserve', NULL, NULL, '9975657960', '$1$XJ4.UJ..$xopLM.VPi0lRstOKH37cy.', NULL, 'Ashish', 'Singh', NULL, '', 0, '9975657960', '$1$RY0.GS..$RCnt.NSOWkpgXOJsFLbg5/', 1, 'male'),
(122, 'facebook', '10201700545310170', 'CAAEjuUZCMjK4BAFl1nUAW71KBTU80yCDOQVZCYCA9EL972ERRWke2zM1aTDT8fZAHy35fqUP30icn9PgvdUzdaO8HHgqsZA70nKMs7hv57jOTZBQGC43tufUMwRwk8qSmYLDCtxYv5XNRXHS1zIVmZBpesYXmcZAx4d9PxjZAmQ838HCnutQWgZCROlGeWZAWiKEMZD', '8149426686', '$1$Hy2.Ej3.$6e1KrUf42bx90FXTVyTa20', 'Amit Gore', 'Amit', 'Gore', 'amitgore2009@gmail.com', '', 1, '8149426686', '$1$Bj/.0m5.$4UQqwawrxyU0w15gTJLGq1', 1, 'male');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
