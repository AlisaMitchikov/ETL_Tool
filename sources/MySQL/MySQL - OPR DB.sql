-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2024 at 06:45 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `northwind - opr`
--
CREATE DATABASE IF NOT EXISTS `northwind - opr` DEFAULT CHARACTER SET hebrew COLLATE hebrew_general_ci;
USE `northwind - opr`;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(40) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `QuantityPerUnit` varchar(20) DEFAULT NULL,
  `UnitPrice` decimal(19,4) DEFAULT NULL,
  `UnitsInStock` smallint(6) DEFAULT NULL,
  `UnitsOnOrder` smallint(6) DEFAULT NULL,
  `ReorderLevel` smallint(6) DEFAULT NULL,
  `Discontinued` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_general_ci;

--
-- RELATIONSHIPS FOR TABLE `products`:
--

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `ProductName`, `SupplierID`, `CategoryID`, `QuantityPerUnit`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`, `ReorderLevel`, `Discontinued`) VALUES
(1, 'Chai', 1, 1, '10 boxes x 20 bags', 18.0000, 39, 0, 10, 0),
(2, 'Chang', 1, 1, '24 - 12 oz bottles', 19.0000, 17, 40, 25, 0),
(3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10.0000, 13, 70, 25, 0),
(4, 'Chef Anton\'s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22.0000, 53, 0, 0, 0),
(5, 'Chef Anton\'s Gumbo Mix', 2, 2, '36 boxes', 21.3500, 0, 0, 0, 1),
(6, 'Grandma\'s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25.0000, 120, 0, 25, 0),
(7, 'Uncle Bob\'s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30.0000, 15, 0, 10, 0),
(8, 'Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40.0000, 6, 0, 0, 0),
(9, 'Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97.0000, 29, 0, 0, 1),
(10, 'Ikura', 4, 8, '12 - 200 ml jars', 31.0000, 31, 0, 0, 0),
(11, 'Queso Cabrales', 5, 4, '1 kg pkg.', 21.0000, 22, 30, 30, 0),
(12, 'Queso Manchego La Pastora', 5, 4, '10 - 500 g pkgs.', 38.0000, 86, 0, 0, 0),
(13, 'Konbu', 6, 8, '2 kg box', 6.0000, 24, 0, 5, 0),
(14, 'Tofu', 6, 7, '40 - 100 g pkgs.', 23.2500, 35, 0, 0, 0),
(15, 'Genen Shouyu', 6, 2, '24 - 250 ml bottles', 15.5000, 39, 0, 5, 0),
(16, 'Pavlova', 7, 3, '32 - 500 g boxes', 17.4500, 29, 0, 10, 0),
(17, 'Alice Mutton', 7, 6, '20 - 1 kg tins', 39.0000, 0, 0, 0, 1),
(18, 'Carnarvon Tigers', 7, 8, '16 kg pkg.', 62.5000, 42, 0, 0, 0),
(19, 'Teatime Chocolate Biscuits', 8, 3, '10 boxes x 12 pieces', 9.2000, 25, 0, 5, 0),
(20, 'Sir Rodney\'s Marmalade', 8, 3, '30 gift boxes', 81.0000, 40, 0, 0, 0),
(21, 'Sir Rodney\'s Scones', 8, 3, '24 pkgs. x 4 pieces', 10.0000, 3, 40, 5, 0),
(22, 'Gustaf\'s Kn?ckebr?d', 9, 5, '24 - 500 g pkgs.', 21.0000, 104, 0, 25, 0),
(23, 'Tunnbr?d', 9, 5, '12 - 250 g pkgs.', 9.0000, 61, 0, 25, 0),
(24, 'Guaran? Fant?stica', 10, 1, '12 - 355 ml cans', 4.5000, 20, 0, 0, 1),
(25, 'NuNuCa Nu?-Nougat-Creme', 11, 3, '20 - 450 g glasses', 14.0000, 76, 0, 30, 0),
(26, 'Gumb?r Gummib?rchen', 11, 3, '100 - 250 g bags', 31.2300, 15, 0, 0, 0),
(27, 'Schoggi Schokolade', 11, 3, '100 - 100 g pieces', 43.9000, 49, 0, 30, 0),
(28, 'R?ssle Sauerkraut', 12, 7, '25 - 825 g cans', 45.6000, 26, 0, 0, 1),
(29, 'Th?ringer Rostbratwurst', 12, 6, '50 bags x 30 sausage', 123.7900, 0, 0, 0, 1),
(30, 'Nord-Ost Matjeshering', 13, 8, '10 - 200 g glasses', 25.8900, 10, 0, 15, 0),
(31, 'Gorgonzola Telino', 14, 4, '12 - 100 g pkgs', 12.5000, 0, 70, 20, 0),
(32, 'Mascarpone Fabioli', 14, 4, '24 - 200 g pkgs.', 32.0000, 9, 40, 25, 0),
(33, 'Geitost', 15, 4, '500 g', 2.5000, 112, 0, 20, 0),
(34, 'Sasquatch Ale', 16, 1, '24 - 12 oz bottles', 14.0000, 111, 0, 15, 0),
(35, 'Steeleye Stout', 16, 1, '24 - 12 oz bottles', 18.0000, 20, 0, 15, 0),
(36, 'Inlagd Sill', 17, 8, '24 - 250 g jars', 19.0000, 112, 0, 20, 0),
(37, 'Gravad lax', 17, 8, '12 - 500 g pkgs.', 26.0000, 11, 50, 25, 0),
(38, 'C?te de Blaye', 18, 1, '12 - 75 cl bottles', 263.5000, 17, 0, 15, 0),
(39, 'Chartreuse verte', 18, 1, '750 cc per bottle', 18.0000, 69, 0, 5, 0),
(40, 'Boston Crab Meat', 19, 8, '24 - 4 oz tins', 18.4000, 123, 0, 30, 0),
(41, 'Jack\'s New England Clam Chowder', 19, 8, '12 - 12 oz cans', 9.6500, 85, 0, 10, 0),
(42, 'Singaporean Hokkien Fried Mee', 20, 5, '32 - 1 kg pkgs.', 14.0000, 26, 0, 0, 1),
(43, 'Ipoh Coffee', 20, 1, '16 - 500 g tins', 46.0000, 17, 10, 25, 0),
(44, 'Gula Malacca', 20, 2, '20 - 2 kg bags', 19.4500, 27, 0, 15, 0),
(45, 'Rogede sild', 21, 8, '1k pkg.', 9.5000, 5, 70, 15, 0),
(46, 'Spegesild', 21, 8, '4 - 450 g glasses', 12.0000, 95, 0, 0, 0),
(47, 'Zaanse koeken', 22, 3, '10 - 4 oz boxes', 9.5000, 36, 0, 0, 0),
(48, 'Chocolade', 22, 3, '10 pkgs.', 12.7500, 15, 70, 25, 0),
(49, 'Maxilaku', 23, 3, '24 - 50 g pkgs.', 20.0000, 10, 60, 15, 0),
(50, 'Valkoinen suklaa', 23, 3, '12 - 100 g bars', 16.2500, 65, 0, 30, 0),
(51, 'Manjimup Dried Apples', 24, 7, '50 - 300 g pkgs.', 53.0000, 20, 0, 10, 0),
(52, 'Filo Mix', 24, 5, '16 - 2 kg boxes', 7.0000, 38, 0, 25, 0),
(53, 'Perth Pasties', 24, 6, '48 pieces', 32.8000, 0, 0, 0, 0),
(54, 'Tourti?re', 25, 6, '16 pies', 7.4500, 21, 0, 10, 0),
(55, 'P?t? chinois', 25, 6, '24 boxes x 2 pies', 24.0000, 115, 0, 20, 0),
(56, 'Gnocchi di nonna Alice', 26, 5, '24 - 250 g pkgs.', 38.0000, 21, 10, 30, 0),
(57, 'Ravioli Angelo', 26, 5, '24 - 250 g pkgs.', 19.5000, 36, 0, 20, 0),
(58, 'Escargots de Bourgogne', 27, 8, '24 pieces', 13.2500, 62, 0, 20, 0),
(59, 'Raclette Courdavault', 28, 4, '5 kg pkg.', 55.0000, 79, 0, 0, 0),
(60, 'Camembert Pierrot', 28, 4, '15 - 300 g rounds', 34.0000, 19, 0, 0, 0),
(61, 'Sirop d\'?rable', 29, 2, '24 - 500 ml bottles', 28.5000, 113, 0, 25, 0),
(62, 'Tarte au sucre', 29, 3, '48 pies', 49.3000, 17, 0, 0, 0),
(63, 'Vegie-spread', 7, 2, '15 - 625 g jars', 43.9000, 24, 0, 5, 0),
(64, 'Wimmers gute Semmelkn?del', 12, 5, '20 bags x 4 pieces', 33.2500, 22, 80, 30, 0),
(65, 'Louisiana Fiery Hot Pepper Sauce', 2, 2, '32 - 8 oz bottles', 21.0500, 76, 0, 0, 0),
(66, 'Louisiana Hot Spiced Okra', 2, 2, '24 - 8 oz jars', 17.0000, 4, 100, 20, 0),
(67, 'Laughing Lumberjack Lager', 16, 1, '24 - 12 oz bottles', 14.0000, 52, 0, 10, 0),
(68, 'Scottish Longbreads', 8, 3, '10 boxes x 8 pieces', 12.5000, 6, 10, 15, 0),
(69, 'Gudbrandsdalsost', 15, 4, '10 kg pkg.', 36.0000, 26, 0, 15, 0),
(70, 'Outback Lager', 7, 1, '24 - 355 ml bottles', 15.0000, 15, 10, 30, 0),
(71, 'Flotemysost', 15, 4, '10 - 500 g pkgs.', 21.5000, 26, 0, 0, 0),
(72, 'Mozzarella di Giovanni', 14, 4, '24 - 200 g pkgs.', 34.8000, 14, 0, 0, 0),
(73, 'R?d Kaviar', 17, 8, '24 - 150 g jars', 15.0000, 101, 0, 5, 0),
(74, 'Longlife Tofu', 4, 7, '5 - 1000 ml pouches', 10.0000, 4, 20, 5, 0),
(75, 'Rh?nbr?u Klosterbier', 12, 1, '24 - 0.5 l bottles', 7.7500, 125, 0, 25, 0),
(76, 'Lakkalik??ri', 23, 1, '500 ml', 18.0000, 57, 0, 20, 0),
(77, 'Original Frankfurter gr?ne So?e', 12, 2, '12 boxes', 13.0000, 32, 0, 15, 0);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) DEFAULT NULL,
  `ContactTitle` varchar(30) DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL,
  `HomePage` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_general_ci;

--
-- RELATIONSHIPS FOR TABLE `suppliers`:
--

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`, `HomePage`) VALUES
(1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222', NULL, NULL),
(2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', NULL, '#CAJUN.HTM#'),
(3, 'Grandma Kelly\'s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', NULL),
(4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011', NULL, NULL),
(5, 'Cooperativa de Quesos \'Las Cabras\'', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', NULL, NULL),
(6, 'Mayumi\'s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877', NULL, 'Mayumi\'s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'),
(7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', NULL),
(8, 'Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King\'s Way', 'Manchester', NULL, 'M14 GSD', 'UK', '(161) 555-4448', NULL, NULL),
(9, 'PB Kn?ckebr?d AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'G?teborg', NULL, 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', NULL),
(10, 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', NULL, '5442', 'Brazil', '(11) 555 4640', NULL, NULL),
(11, 'Heli S??waren GmbH & Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstra?e 5', 'Berlin', NULL, '10785', 'Germany', '(010) 9984510', NULL, NULL),
(12, 'Plutzer Lebensmittelgro?m?rkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', NULL, '60439', 'Germany', '(069) 992755', NULL, 'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'),
(13, 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', NULL, '27478', 'Germany', '(04721) 8713', '(04721) 8714', NULL),
(14, 'Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', NULL, '48100', 'Italy', '(0544) 60323', '(0544) 60603', '#FORMAGGI.HTM#'),
(15, 'Norske Meierier', 'Beate Vileid', 'Marketing Manager', 'Hatlevegen 5', 'Sandvika', NULL, '1320', 'Norway', '(0)2-953010', NULL, NULL),
(16, 'Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th Avenue Suite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931', NULL, NULL),
(17, 'Svensk Sj?f?da AB', 'Michael Bj?rn', 'Sales Representative', 'Brovallav?gen 231', 'Stockholm', NULL, 'S-123 45', 'Sweden', '08-123 45 67', NULL, NULL),
(18, 'Aux joyeux eccl?siastiques', 'Guyl?ne Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', NULL, '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62', NULL),
(19, 'New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '02134', 'USA', '(617) 555-3267', '(617) 555-3389', NULL),
(20, 'Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', NULL, '0512', 'Singapore', '555-8787', NULL, NULL),
(21, 'Lyngbysild', 'Niels Petersen', 'Sales Manager', 'Lyngbysild Fiskebakken 10', 'Lyngby', NULL, '2800', 'Denmark', '43844108', '43844115', NULL),
(22, 'Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'Verkoop Rijnweg 22', 'Zaandam', NULL, '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210', NULL),
(23, 'Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', NULL, '53120', 'Finland', '(953) 10956', NULL, NULL),
(24, 'G\'day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward Parade Hunter\'s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873', 'G\'day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'),
(25, 'Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montr?al', 'Qu?bec', 'H1J 1C3', 'Canada', '(514) 555-9022', NULL, NULL),
(26, 'Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', NULL, '84100', 'Italy', '(089) 6547665', '(089) 6547667', NULL),
(27, 'Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', NULL, '71300', 'France', '85.57.00.07', NULL, NULL),
(28, 'Gai p?turage', 'Eliane Noz', 'Sales Representative', 'Bat. B 3, rue des Alpes', 'Annecy', NULL, '74000', 'France', '38.76.98.06', '38.76.98.58', NULL),
(29, 'For?ts d\'?rables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Qu?bec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for table products
--

--
-- Metadata for table suppliers
--

--
-- Metadata for database northwind - opr
--
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
