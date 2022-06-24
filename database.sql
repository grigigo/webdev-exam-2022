-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_1684_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('6b02d1bb305b');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genre`
--

DROP TABLE IF EXISTS `book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genre` (
  `book_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  KEY `fk_book_genre_book_id_books` (`book_id`),
  KEY `fk_book_genre_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_book_genre_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_book_genre_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genre`
--

LOCK TABLES `book_genre` WRITE;
/*!40000 ALTER TABLE `book_genre` DISABLE KEYS */;
INSERT INTO `book_genre` VALUES (13,8),(13,14),(13,9),(13,7),(13,6),(14,7),(14,8),(14,9),(15,4),(15,14),(16,9),(16,14),(18,10),(18,14),(19,8),(19,11),(19,15),(20,10),(20,14),(20,5),(20,4);
/*!40000 ALTER TABLE `book_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `desc` text NOT NULL,
  `year` int(11) NOT NULL,
  `pub_house` varchar(64) NOT NULL,
  `author` varchar(64) NOT NULL,
  `page_count` int(11) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (13,'Маленький принц','В одном из писем к матери Сент-Экзюпери признался: «Мне ненавистны люди, пишущие ради забавы, ищущие эффектов. Надо иметь что сказать». Ему, романтику неба, не чуравшемуся земных радостей, любившему, по свидетельству друзей, «писать, говорить, петь, играть, докапываться до сути вещей, есть, обращать на себя внимание, ухаживать за женщинами», человеку проницательного ума со своими достоинствами и недостатками, но всегда стоявшему на защите общечеловеческих ценностей, было «что сказать». И он написал самую известную во всем мире сказку «Маленький принц» о самом важном в этой жизни, жизни на планете Земля, все чаще такой неласковой, но любимой и единственной.',1943,'Галлимар','Антуан де Сент-Экзюпери',96,13,3),(14,'Вино из одуванчиков','Войдите в светлый мир двенадцатилетнего мальчика и проживите с ним одно лето, наполненное событиями радостными и печальными, загадочными и тревожными; лето, когда каждый день совершаются удивительные открытия, главное из которых – ты живой, ты дышишь, ты чувствуешь!',1957,'Эксмо','Рэй Брэдбери',250,9,2),(15,'Дюна','В далекой мультигалактической империи враждуют два великих дома – Атрейдесы и Харконнены. Последним удается склонить Императора на свою сторону, и юного наследника дома Атрейдесов – Пола – вместе с семьей высылают на далекую и пустынную планету Арракис, называемую также Дюной. Ужасные бури, гигантские черви, жестокие фанатики, фримены, и единственный во всей Вселенной источник Пряности, важнейшей субстанции в Империи, – таков новый дом Пола.',1965,'Издательство АСТ','Фрэнк Герберт',1610,7,3),(16,'451 градус по Фаренгейту','451° по Фаренгейту – температура, при которой воспламеняется и горит бумага. Философская антиутопия Брэдбери рисует беспросветную картину развития постиндустриального общества: это мир будущего, в котором все письменные издания безжалостно уничтожаются специальным отрядом пожарных, а хранение книг преследуется по закону, интерактивное телевидение успешно служит всеобщему оболваниванию, карательная психиатрия решительно разбирается с редкими инакомыслящими, а на охоту за неисправимыми диссидентами выходит электрический пес… Роман, принесший своему творцу мировую известность.',1951,'Эксмо','Рэй Брэдбери',200,11,3),(17,'1984','Одна из самых знаменитых антиутопий XX века – роман «1984» английского писателя Джорджа Оруэлла (1903–1950) был написан в 1948 году и продолжает тему «преданной революции», раскрытую в «Скотном дворе». По Оруэллу, нет и не может быть ничего ужаснее тотальной несвободы. Тоталитаризм уничтожает в человеке все духовные потребности, мысли, чувства и сам разум, оставляя лишь постоянный страх и единственный выбор – между молчанием и смертью, и если Старший Брат смотрит на тебя и заявляет, что «дважды два – пять», значит, так и есть',1949,'ФТМ','Джордж Оруэлл',320,6,2),(18,'Билли Саммерс','Билли – наемный убийца, который подумывает отойти от дел. Однако знакомый мафиози предлагает Саммерсу последнее дело, которое обеспечит киллеру более чем достойную старость. Убрать нужно другого профессионального стрелка, беспринципного и алчного Джоэла Аллена, который готов лишить жизни кого угодно. Что ж, придется сделать еще один выстрел перед тем, как уйти в закат. Откуда Саммерсу было знать, что этот заказ обойдется ему слишком дорого?',2021,'Издательство АСТ','Стивен Кинг',560,1,2),(19,'Занимательное программирование. Базы данных','Если у вас голова идёт кругом, когда речь заходит о базах данных, или же вы просто заплутали в лабиринте чисел и данных, которые, как вам кажется, неподвластны контролю, присоединяйтесь к Руруне и Кейну.',2005,'ДМК Пресс','Мана Такахаси',238,9,2),(20,'Позже','Джейми Конклин, живущий с матерью в Нью-Йорке, хочет быть всего лишь обычным подростком… но у него есть весьма необычный дар. Дар, который его мама настоятельно просит скрывать от других.',2021,'Издательство АСТ','Стивен Кинг',240,9,3);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (13,'Биография'),(10,'Детективы'),(8,'Детские'),(14,'Для взрослых'),(1,'Драма'),(12,'Исторические'),(9,'Классика'),(3,'Комедия'),(11,'Манга'),(15,'Обучение'),(7,'Приключения'),(6,'Сказка'),(2,'Трагедия'),(5,'Ужасы'),(4,'Фентези');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(128) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `md5_hash` varchar(256) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `object_type` varchar(100) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_images_md5_hash` (`md5_hash`),
  KEY `fk_images_book_id_books` (`book_id`),
  CONSTRAINT `fk_images_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (6,'9815607-antuan-de-sent-ekzuperi-malenkiy-princ-9815607.jpg','image/jpeg','ad454e5187a1adb957c4412f8fa662bc',13,NULL,NULL,0),(7,'43195024-rey-bredberi-vino-iz-oduvanchikov.jpg','image/jpeg','8be1c7b52e2301513ba87497adbfb466',14,NULL,NULL,0),(8,'25440524-frenk-gerbert-duna-pervaya-trilogiya.jpg','image/jpeg','f72e9af5a7b3a34c3ca68c44d1782ad4',15,NULL,NULL,0),(9,'39507162--.jpg','image/jpeg','51b5a12b73cb5fbfd3144e40cc430f98',16,NULL,NULL,0),(10,'129098--.jpg','image/jpeg','8596acf8946081abc39b1ed1082094fc',17,NULL,NULL,0),(11,'67303161-stiven-king-billi-sammers.jpg','image/jpeg','2ef3d90cf3a24f25b98c349657f6bfe8',18,NULL,NULL,0),(12,'44336455-mana-takahasi-zanimatelnoe-programmirovanie-bazy-dannyh-44336455.jpg','image/jpeg','add8ff58b79abec99e18d39286f513b3',19,NULL,NULL,0),(13,'66079668-stiven-king-pozzhe.jpg','image/jpeg','131fc7fc8962ef6e251f3a77ffb2eee4',20,NULL,NULL,0);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `review_rating` int(11) NOT NULL,
  `text_review` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_reviews_status_id_status` (`status_id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_status_id_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (4,13,3,5,'Очень нравится!!!','2022-06-24 15:45:39',2),(5,20,3,3,'Не очень-то и страшно)))','2022-06-24 15:46:32',2),(6,18,3,0,'Фу, не понравилось совсем','2022-06-24 15:46:53',3),(7,19,3,4,'Занимательно. Самое то для детей','2022-06-24 15:47:26',2),(8,15,3,4,'Очень длинное произведение, что начинаешь скучать','2022-06-24 15:48:00',2),(9,14,3,4,'Да','2022-06-24 15:48:17',1),(10,17,3,5,'Большой брат следит за тобой!!!','2022-06-24 15:48:38',2),(11,16,3,5,'Антиутопия','2022-06-24 15:48:56',1),(12,18,7,1,'Полный бред','2022-06-24 15:49:22',3),(13,20,7,1,'Сижу ночью и читаю. Не влияет','2022-06-24 15:49:43',2),(14,15,7,1,'Слишком длинное. Задолбался читать','2022-06-24 15:50:43',1),(15,16,7,1,'Я также с вашими книгами сделаю','2022-06-24 15:51:04',1),(16,17,7,1,'Я так и знал!','2022-06-24 15:51:28',1),(17,19,6,5,'Нашему сыночку понравилось!','2022-06-24 15:52:01',2),(18,14,6,5,'Нашему сыночку понравилось!','2022-06-24 15:52:44',2),(19,13,6,5,'Нашему сыночку понравилось!','2022-06-24 15:53:02',2),(20,13,5,3,'Я работаю','2022-06-24 15:54:30',1),(21,15,5,2,'Некогда столько читать','2022-06-24 15:54:47',1),(22,20,5,5,'-Испугались?\r\n-*** 0_0','2022-06-24 15:55:30',3),(23,16,5,5,'Когда поддерживаешь такое','2022-06-24 15:55:53',1);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','Всемогущий'),(2,'Модератор','Царь'),(3,'Пользователь','Холоп');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'на рассмотрении'),(2,'одобрено'),(3,'отклонено');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(32) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `first_name` varchar(16) NOT NULL,
  `middle_name` varchar(16) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','pbkdf2:sha256:260000$m2dcghKUh0IKwPS8$a40a19c4ef0dc3638ca4eb35d76ed50533f5607de6d0b93182fa83bf899b024a','Евсеев','Григорий',NULL,1),(2,'moder','pbkdf2:sha256:260000$qxz4c95yArYZt89p$876a19e8548605639229c791be2ee7e8273c43a6d0904b954daeb30833b5e021','Женин','Мишка',NULL,2),(3,'user1','pbkdf2:sha256:260000$DTd64GN58BjwBlnQ$bda5bf967227e959d81aa1d855143d77f1148dbfb64b831975060343802729e7','Щип','Тим',NULL,3),(4,'user2','pbkdf2:sha256:260000$J5702AMzM71pnUwO$6367ca7e57b6f721db8289090480686a168b35a2ae9bcdbd98a2d65967f12d05','Моторо','Иван',NULL,3),(5,'user3','pbkdf2:sha256:260000$SYmj0PJ4NSWsTCMq$199bc10bc5351d9bb88398c2a5e22d233fbc27188a12b58ed3bd952d5ea38784','Беседин','Бездельник',NULL,3),(6,'user4','pbkdf2:sha256:260000$TaihscYW1JlyOH8b$3766fb144f554dbd089e14ee0f32ba8c5cb520c94798fbba2606dee6af2fee93','Родители','Детей',NULL,3),(7,'user5','pbkdf2:sha256:260000$SkuUW2l1t9yuJlcF$dba3a008b0edb1e7dc09bb2dc250b3d604920e3ffcf1c3f8582a63f0229f4d2e','Крутой','Пользователь',NULL,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-24 16:02:08
