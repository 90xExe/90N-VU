CREATE DATABASE PRESENTATION;
USE PRESENTATION;


-- 1️⃣ USERS TABLE
CREATE TABLE Users (
    User_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Country VARCHAR(50),
    Subscription_Type VARCHAR(50),
    Join_Date DATE
);

-- 2️⃣ ARTIST TABLE
CREATE TABLE Artist (
    Artist_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100),
    Country VARCHAR(50),
    Genre VARCHAR(50),
    Followers_Count INT DEFAULT 0
);

-- 3️⃣ ALBUM TABLE
CREATE TABLE Album (
    Album_ID INT PRIMARY KEY NOT NULL,
    Artist_ID INT,
    Title VARCHAR(100),
    Release_Date DATE,
    Genre VARCHAR(50),
    FOREIGN KEY (Artist_ID) REFERENCES Artist(Artist_ID)
);

-- 4️⃣ SONG TABLE
CREATE TABLE Song (
    Song_ID INT PRIMARY KEY NOT NULL,
    Album_ID INT,
    Title VARCHAR(100),
    Duration TIME,
    Genre VARCHAR(50),
    Play_Count INT DEFAULT 0,
    FOREIGN KEY (Album_ID) REFERENCES Album(Album_ID)
);

-- 5️⃣ PLAYLIST TABLE
CREATE TABLE Playlist (
    Playlist_ID INT PRIMARY KEY NOT NULL,
    User_ID INT,
    Title VARCHAR(100),
    Description TEXT,
    Created_Date DATE,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 6️⃣ PLAYLIST_SONG TABLE (Many-to-Many)
CREATE TABLE Playlist_Song (
    PS_ID INT PRIMARY KEY NOT NULL,
    Playlist_ID INT,
    Song_ID INT,
    Added_Date DATE,
    FOREIGN KEY (Playlist_ID) REFERENCES Playlist(Playlist_ID),
    FOREIGN KEY (Song_ID) REFERENCES Song(Song_ID)
);

-- 7️⃣ SUBSCRIPTION TABLE
CREATE TABLE Subscription (
    Subscription_ID INT PRIMARY KEY NOT NULL,
    User_ID INT UNIQUE,
    Type VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    Payment_Method VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 8️⃣ LISTENING_HISTORY TABLE
CREATE TABLE Listening_History (
    History_ID INT PRIMARY KEY NOT NULL,
    User_ID INT,
    Song_ID INT,
    Play_Time DATETIME,
    Device VARCHAR(50),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Song_ID) REFERENCES Song(Song_ID)
);

-- 9️⃣ FOLLOW TABLE (User follows Artist)
CREATE TABLE Follow (
    Follow_ID INT PRIMARY KEY NOT NULL,
    Follower_ID INT,
    Followed_Artist_ID INT,
    Follow_Date DATE,
    FOREIGN KEY (Follower_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Followed_Artist_ID) REFERENCES Artist(Artist_ID)
);

-- 🔟 SYSTEM_LOG TABLE
CREATE TABLE System_Log (
    Log_ID INT PRIMARY KEY NOT NULL,
    User_ID INT,
    Activity VARCHAR(255),
    Timestamp DATETIME,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 11️⃣ DEVICE TABLE
CREATE TABLE Device (
    Device_ID INT PRIMARY KEY NOT NULL,
    User_ID INT,
    Device_Name VARCHAR(100),
    Device_Type VARCHAR(50),
    Register_Date DATE,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 12️⃣ PAYMENT TABLE
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY NOT NULL,
    User_ID INT,
    Amount DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    Payment_Date DATE,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 13️⃣ GENRE TABLE
CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY NOT NULL,
    Genre_Name VARCHAR(100),
    Description TEXT
);

-- 14️⃣ SONG_GENRE TABLE (Many-to-Many)
CREATE TABLE Song_Genre (
    SongGenre_ID INT PRIMARY KEY NOT NULL,
    Song_ID INT,
    Genre_ID INT,
    FOREIGN KEY (Song_ID) REFERENCES Song(Song_ID),
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);

-- 15️⃣ ADVERTISEMENT TABLE
CREATE TABLE Advertisement (
    Ad_ID INT PRIMARY KEY NOT NULL,
    Title VARCHAR(100),
    Company VARCHAR(100),
    Duration TIME,
    Target_Audience VARCHAR(100)
);

-- 16️⃣ AD_LOG TABLE (Track user ad views)
CREATE TABLE Ad_Log (
    AdLog_ID INT PRIMARY KEY NOT NULL,
    Ad_ID INT,
    User_ID INT,
    Watch_Time TIME,
    Date DATE,
    FOREIGN KEY (Ad_ID) REFERENCES Advertisement(Ad_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

-- 17️⃣ STAFF TABLE
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Department VARCHAR(50),
    Join_Date DATE
);

-- 18️⃣ TRAINING_SESSION TABLE (Linked to Staff)
CREATE TABLE Training_Session (
    Training_ID INT PRIMARY KEY NOT NULL,
    Staff_ID INT,
    Topic VARCHAR(100),
    Schedule DATE,
    Completion_Date DATE,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
