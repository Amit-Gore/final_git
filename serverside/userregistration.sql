-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2015 at 08:07 AM
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
