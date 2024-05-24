USE Fitness
GO

--1. What are the distinct UserIDs present in the dataset?
SELECT DISTINCT UserID FROM dbo.Ft;

--2. How many steps were taken by each user on a specific date (e.g., '4/25/2016')?
SELECT UserID, SUM(Steps) AS TotalSteps FROM dbo.Ft
WHERE Date = '4/25/2016' 
GROUP BY UserID;

--3. What is the total distance covered by each user on a specific date (e.g., '2023-01-01')?
SELECT UserID, SUM(Total_Distance) AS TotalDistance FROM dbo.Ft
WHERE Date = '4/25/2016'
GROUP BY UserID;

--4. What is the average sedentary time (in minutes) for all users across all dates?
SELECT AVG(Sedentary_Minutes) AS AvgSedentaryTime FROM dbo.Ft;

--5. Which users have logged activities manually and what is the total distance covered through logged activities for each user?
SELECT UserID, SUM(Logged_Activities_Distance) AS TotalLoggedDistance FROM dbo.Ft
WHERE Logged_Activities_Distance > 0
GROUP BY UserID;

--6. Which users have the highest average steps per day? Display the top 5 users.
SELECT TOP 5 UserID, AVG(Steps) AS AvgStepsPerDay FROM dbo.Ft
GROUP BY UserID
ORDER BY AvgStepsPerDay DESC;

--7. What is the total distance covered by all users on weekends (Saturday and Sunday)?
SELECT SUM(Total_Distance) AS TotalDistanceWeekends
FROM dbo.Ft
WHERE DATEPART(WEEKDAY, Date) IN (1, 7);

--8. Which users have spent more time in sedentary behavior than in light activity on average?
SELECT UserID
FROM (SELECT UserID, AVG(Sedentary_Minutes) AS AvgSedentaryMinutes, AVG(Lightly_Active_Minutes) AS AvgLightActiveMinutes
FROM dbo.Ft GROUP BY UserID) AS UserActivity
WHERE AvgSedentaryMinutes > AvgLightActiveMinutes;

--9. Which users have burned more than 1000 calories on average per day? Display their average daily calorie burn.
SELECT UserID, AVG(Calories_Burned) AS AvgCaloriesBurnedPerDay FROM dbo.Ft
GROUP BY UserID
HAVING AVG(Calories_Burned) > 1000;

--10. Which users have the highest ratio of very active minutes to total active minutes (very active + fairly active + lightly active) on average?
SELECT UserID, AVG(Very_Active_Minutes) / (AVG(Very_Active_Minutes) + AVG(Fairly_Active_Minutes) + AVG(Lightly_Active_Minutes)) AS VeryActiveRatio
FROM dbo.Ft
GROUP BY UserID
ORDER BY VeryActiveRatio DESC;

--11. Which users have logged activities for every day in the dataset?
SELECT UserID
FROM (SELECT UserID, COUNT(DISTINCT Date) AS UniqueDates
FROM dbo.Ft GROUP BY UserID
) AS UserActivity
WHERE UniqueDates = (SELECT COUNT(DISTINCT Date) FROM Fitness_Dataset);

--12. What is the average steps taken by users on weekdays (Monday to Friday) vs. weekends (Saturday and Sunday)?
SELECT CASE
WHEN DATEPART(WEEKDAY, Date) IN (1, 7) THEN 'Weekend'
ELSE 'Weekday'
END AS DayType,
AVG(Steps) AS AvgSteps
FROM dbo.Ft
GROUP BY CASE
WHEN DATEPART(WEEKDAY, Date) IN (1, 7) THEN 'Weekend'
ELSE 'Weekday'
END

--13. Which users have the highest total distance covered through very active activities? Display the top 3 users.
SELECT TOP 3 UserID, SUM(Very_Active_Distance) AS TotalVeryActiveDistance
FROM dbo.Ft
GROUP BY UserID
ORDER BY TotalVeryActiveDistance DESC;

--14. What is the total sedentary time for each user in minutes, sorted in descending order?
SELECT UserID, SUM(Sedentary_Minutes) AS TotalSedentaryTime
FROM Fitness_Dataset
GROUP BY UserID
ORDER BY TotalSedentaryTime DESC;

--15. Which users have the highest average fairly active minutes per day? Display the top 5 users.
SELECT TOP 5 UserID, AVG(Fairly_Active_Minutes) AS AvgFairlyActiveMinutes
FROM dbo.ft
GROUP BY UserID
ORDER BY AvgFairlyActiveMinutes DESC;