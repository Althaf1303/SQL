create database Project
Use Project
create table Teams1 (TeamID INT, TeamName VARCHAR(50), LeagueID INT)
INSERT INTO Teams1 (TeamID, TeamName, LeagueID) VALUES
(1, 'Red Dragons', 1),(2, 'Blue Sharks', 1),(3, 'Golden Eagles', 1),(4, 'Silver Wolves', 1),(5, 'Black Panthers', 1),
(6, 'White Lions', 1),(7, 'Green Gators', 1),(8, 'Purple Pythons', 1),(9, 'Crimson Hawks', 1),(10, 'Amber Tigers', 1),
(11, 'Sapphire Falcons', 1),(12, 'Emerald Elephants', 1),(13, 'Ruby Rhinos', 1),(14, 'Topaz Turtles', 1),(15, 'Diamond Dolphins', 1),
(16, 'Bronze Bears', 1),(17, 'Maroon Mustangs', 1),(18, 'Teal Toucans', 1),(19, 'Scarlet Scorpions', 1),(20, 'Indigo Iguanas', 1);
select *from Teams1

Create table Players1 (PlayerID INT, PlayerName VARCHAR(50), TeamID INT)
INSERT INTO Players1 (PlayerID, PlayerName, TeamID) VALUES
(1, 'Alex Johnson', 1), (2, 'Michael Brown', 1), (3, 'Chris Smith', 2), (4, 'Jordan Lee', 2), (5, 'Taylor Green', 3), 
(6, 'Casey Clark', 3), (7, 'Morgan King', 4), (8, 'Jamie Turner', 4), (9, 'Riley Parker', 5), (10, 'Devon Mitchell', 5), 
(11, 'Quinn Rogers', 6), (12, 'Jesse Bennett', 6), (13, 'Avery Bailey', 7), (14, 'Casey Murphy', 7), (15, 'Dana Brooks', 8),
(16, 'Reese Robinson', 8), (17, 'Sidney Kelly', 9), (18, 'Frankie Edwards', 9), (19, 'Corey Scott', 10), (20, 'Drew Campbell', 10);
select *from Players1


CREATE TABLE Matches (MatchID INT, Team1ID INT, Team2ID INT, MatchDate DATE)
Insert into Matches (MatchID ,Team1ID,Team2ID,MatchDate) values 
(1, 1, 2, '2023-10-01'), (2, 1, 3, '2023-10-02'), (3, 2, 3, '2023-10-03'), (4, 2, 4, '2023-10-04'), (5, 3, 4, '2023-10-05'), (6, 3, 5, '2023-10-06'), 
(7, 4, 5, '2023-10-07'), (8, 4, 6, '2023-10-08'), (9, 5, 6, '2023-10-09'), (10, 5, 7, '2023-10-10'), (11, 6, 7, '2023-10-11'), (12, 6, 8, '2023-10-12'),
(13, 7, 8, '2023-10-13'), (14, 7, 9, '2023-10-14'), (15, 8, 9, '2023-10-15'), (16, 8, 10, '2023-10-16'), (17, 9, 10, '2023-10-17'), (18, 9, 1, '2023-10-18'), (19, 10, 1, '2023-10-19'), (20, 10, 2, '2023-10-20');
select *from Matches

create table Scores (ScoreID INT, MatchID INT, TeamID INT, Points INT)
Insert into Scores (ScoreID ,MatchID,TeamID,Points) values
(1, 1, 1, 4),(2, 1, 2, 5),(3, 2, 2, 6),(4, 2, 3, 7),(5, 3, 3, 8),
(6, 3, 4, 9),(7, 4, 4, 10),(8, 4, 5, 11),(9, 5, 5, 12),(10, 5, 6, 13),
(11, 6, 6, 14),(12, 6, 7, 15),(13, 7, 7, 16),(14, 7, 8, 17),(15, 8, 8, 18),
(16, 8, 9, 19),(17, 9, 9, 20),(18, 9, 10, 21),(19, 10, 10, 23),(20, 10, 1, 24); 
select *from Scores

create table Leagues(LeagueID INT, LeagueName VARCHAR(255))
Insert into Leagues (LeagueID,LeagueName) values
(1, 'Premier League'),(2, 'La Liga'),(3, 'Serie A'),(4, 'Bundesliga'),(5, 'Ligue 1'),
(6, 'Eredivisie'),(7, 'Primeira Liga'),(8, 'Scottish Premiership'),(9, 'Major League Soccer'),(10, 'Brasileirão'),
(11, 'Argentine Primera División'),(12, 'J1 League'),(13, 'K League 1'),(14, 'Süper Lig'),(15, 'Russian Premier League'),
(16, 'Chinese Super League'),(17, 'Saudi Professional League'),(18, 'Australian A-League'),(19, 'Indian Super League'),(20, 'Mexican Liga MX');
select *from Leagues

SELECT p.PlayerID, p.PlayerName, t.TeamName, COUNT(s.MatchID) AS MatchesPlayed, SUM(s.Points) AS TotalPoints 
FROM Players1 p 
JOIN Teams1 t ON p.TeamID = t.TeamID 
JOIN Scores s ON p.TeamID = s.TeamID 
GROUP BY p.PlayerID, p.PlayerName, t.TeamName;

SELECT m.MatchID, t1.TeamName AS Team1, t2.TeamName AS Team2, m.MatchDate, s1.Points AS Team1Points, s2.Points AS Team2Points 
FROM Matches m
JOIN Scores s1 ON m.MatchID = s1.MatchID AND m.Team1ID = s1.TeamID
JOIN Scores s2 ON m.MatchID = s2.MatchID AND m.Team2ID = s2.TeamID
JOIN Teams1 t1 ON m.Team1ID = t1.TeamID
JOIN Teams1 t2 ON m.Team2ID = t2.TeamID;

SELECT t.TeamID, t.TeamName, l.LeagueName, SUM(s.Points) AS TotalPoints 
FROM Teams1 t
JOIN Leagues l ON t.LeagueID = l.LeagueID
JOIN Scores s ON t.TeamID = s.TeamID 
GROUP BY t.TeamID, t.TeamName, l.LeagueName 
ORDER BY TotalPoints DESC;

DELIMITER && 
CREATE PROCEDURE Sports() 
BEGIN 
SELECT * FROM Teams1; 
SELECT * FROM Players1; 
SELECT * FROM Matches; 
SELECT * FROM Scores; 
SELECT * FROM Leagues; 
END && 
DELIMITER ;
CALL Sports;
