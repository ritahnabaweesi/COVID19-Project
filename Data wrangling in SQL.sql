-- save the all sessions_data for contractor 89 under sessions_data table and the snow_jobs data under the snow_jobs table
-- View the data table that has been loaded under sessions_data
select * FROM [sessions_data]

-- View the output of splitting the Date_time_of_selecting_job into Day of week, time of day, and modified date
SELECT Date_time_of_selecting_job,
SUBSTRING(Date_time_of_selecting_job, 1,3) as day_of_week,
SUBSTRING(Date_time_of_selecting_job,12,8) as time_of_day
FROM [sessions_data]

--Update the table to include the Day of the week, time of day, hour and modified date
--Define the data types for the new columns being created
ALTER TABLE [sessions_data]
ADD Day_of_week Nvarchar(50),
	Time_of_day TIME,
	Hour_of_day NVARCHAR(255),
	Modified_date NVARCHAR(50)

-- Update the sessions_data table to have the new columns created
UPDATE [sessions_data]
SET Day_of_week = SUBSTRING(Date_time_of_selecting_job, 1, 3),
	Time_of_day = SUBSTRING(Date_time_of_selecting_job, 12, 8),
	Hour_of_day = SUBSTRING(Date_time_of_selecting_job,12,2),
	Modified_date = SUBSTRING(Date_time_of_selecting_job,5,6) + RIGHT(Date_time_of_selecting_job,5)

--Add a session ID column for each of the contractors
-- Adding a new column 'session_id' of type INT
ALTER TABLE sessions_data
ADD session_id INT;

-- Updating the session_id column with partitioned row numbers
WITH NumberedRows AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Contractor_ID ORDER BY Contractor_ID, Modified_date) AS rn
    FROM sessions_data
)

-- Updating the session_id column with the row numbers
UPDATE NumberedRows
SET session_id = rn;


--Select the columns of interest relating to jobs contractors selected

SELECT Contractor_ID,
	Job_ID_selected_job,
	Date_time_of_selecting_job,
	session_id,
	Modified_date,
	Day_of_week,
	Hour_of_day,
	[quadrant jobs_Opt 1] as os_quad_jobs
FROM [sessions_data]
ORDER BY Contractor_ID, session_id

-- View the job data table
SELECT JOB_ID,
	WORKER_ID,
	Neighborhood,
	Quadrant,
	JOB_TYPE,
	PRICE_JOB
FROM [snow_job_data]

--Create view for contractor 89 for the jobs picked with job information
-- This is to simply segregate the jobs that were selected from all else

Create View Contractor_89_jobs as
SELECT
	ses.Job_ID_selected_job as Job_ID, 
	ses.Date_time_of_selecting_job,
	ses.session_id,
	ses.Modified_date,
	ses.Day_of_week,
	ses.Hour_of_day,
	snw.Neighborhood,
	snw.Quadrant,
	snw.JOB_TYPE as Job_type,
	snw.PRICE_JOB as Price_job
FROM [sessions_data] ses
JOIN [snow_job_data] snw
	ON ses.Job_ID_selected_job = snw.JOB_ID
	AND ses.Contractor_ID = snw.WORKER_ID
--WHERE Contractor_ID = 89 --include this if the file has other contractor IDs otherwise it was commented out in this case


--Insert the view Contractor_89_jobs into a table for executed jobs
SELECT *
INTO Contractor_89_executed_jobs
FROM Contractor_89_jobs

--Consolidate all Contractor_ID 89 job IDs for all sessions into a long format
--The outstanding jobs in quadrant, neighborhood are associated to each job ID at the time of the session 
--Create view for Contractor_ID 89 job IDs with 
--If dealing with information with other contractor IDs, include the AND statement to filter based on contractor ID of interest

Create view Viewed_jobs_contractor_89 as
SELECT [job ID_Opt 1] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 1] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 1] <> 0 
UNION 
SELECT [job ID_Opt 2] AS Combined_Job_IDs,Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 2] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 2] <> 0  
UNION 
SELECT [job ID_Opt 3] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id,[quadrant jobs_Opt 3] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 3] <> 0 
UNION 
SELECT [job ID_Opt 4] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id,[quadrant jobs_Opt 4] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 4] <> 0 
UNION 
SELECT [job ID_Opt 5] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id,[quadrant jobs_Opt 5] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 5] <> 0 
UNION 
SELECT [job ID_Opt 6] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 6] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 6] <> 0 
UNION 
SELECT [job ID_Opt 7] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 7] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 7] <> 0 
UNION 
SELECT [job ID_Opt 8] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 8] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 8] <> 0 
UNION
SELECT [job ID_Opt 9] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 9] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 9] <> 0 
UNION 
SELECT [job ID_Opt 10] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 10] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 10] <> 0 
UNION 
SELECT [job ID_Opt 11] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 11] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 11] <> 0 
UNION 
SELECT [job ID_Opt 12] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 12] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 12] <> 0 
UNION 
SELECT [job ID_Opt 13] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 13] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 13] <> 0 
UNION 
SELECT [job ID_Opt 14] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 14] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 14] <> 0 
UNION 
SELECT [job ID_Opt 15] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 15] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 15] <> 0 
UNION 
SELECT [job ID_Opt 16] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 16] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 16] <> 0 
UNION 
SELECT [job ID_Opt 17] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 17] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 17] <> 0 
UNION 
SELECT [job ID_Opt 18] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 18] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 18] <> 0 
UNION 
SELECT [job ID_Opt 19] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 19] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 19] <> 0 
UNION 
SELECT [job ID_Opt 20] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 20] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 20] <> 0 
UNION 
SELECT [job ID_Opt 21] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 21] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 21] <> 0 
UNION 
SELECT [job ID_Opt 22] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 22] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 22] <> 0 
UNION 
SELECT [job ID_Opt 23] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 23] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 23] <> 0 
UNION 
SELECT [job ID_Opt 24] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 24] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 24] <> 0 
UNION 
SELECT [job ID_Opt 25] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 25] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 25] <> 0 
UNION 
SELECT [job ID_Opt 26] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 26] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 26] <> 0 
UNION 
SELECT [job ID_Opt 27] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 27] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 27] <> 0 
UNION 
SELECT [job ID_Opt 28] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 28] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 28] <> 0 
UNION 
SELECT [job ID_Opt 29] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 29] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 29] <> 0 
UNION 
SELECT [job ID_Opt 30] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 30] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 30] <> 0 
UNION 
SELECT [job ID_Opt 31] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 31] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 31] <> 0 
UNION 
SELECT [job ID_Opt 32] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 32] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 32] <> 0 
UNION 
SELECT [job ID_Opt 33] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 33] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 33] <> 0 
UNION 
SELECT [job ID_Opt 34] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 34] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 34] <> 0 
UNION 
SELECT [job ID_Opt 35] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 35] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 35] <> 0 
UNION 
SELECT [job ID_Opt 36] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 36] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 36] <> 0 
UNION 
SELECT [job ID_Opt 37] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 37] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 37] <> 0 
UNION 
SELECT [job ID_Opt 38] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 38] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 38] <> 0 
UNION 
SELECT [job ID_Opt 39] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 39] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 39] <> 0 
UNION 
SELECT [job ID_Opt 40] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 40] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 40] <> 0 
UNION 
SELECT [job ID_Opt 41] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 41] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 41] <> 0 
UNION 
SELECT [job ID_Opt 42] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 42] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 42] <> 0 
UNION 
SELECT [job ID_Opt 43] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 43] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 43] <> 0 
UNION 
SELECT [job ID_Opt 44] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 44] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 44] <> 0 
UNION 
SELECT [job ID_Opt 45] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 45] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 45] <> 0 
UNION 
SELECT [job ID_Opt 46] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 46] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 46] <> 0 
UNION 
SELECT [job ID_Opt 47] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 47] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 47] <> 0 
UNION 
SELECT [job ID_Opt 48] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 48] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 48] <> 0 
UNION 
SELECT [job ID_Opt 49] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 49] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 49] <> 0 
UNION 
SELECT [job ID_Opt 50] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 50] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 50] <> 0 
UNION 
SELECT [job ID_Opt 51] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 51] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 51] <> 0 
UNION 
SELECT [job ID_Opt 52] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 52] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 52] <> 0 
UNION 
SELECT [job ID_Opt 53] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 53] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 53] <> 0 
UNION 
SELECT [job ID_Opt 54] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 54] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 54] <> 0 
UNION 
SELECT [job ID_Opt 55] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 55] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 55] <> 0 
UNION 
SELECT [job ID_Opt 56] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 56] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 56] <> 0 
UNION 
SELECT [job ID_Opt 57] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 57] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 57] <> 0 
UNION 
SELECT [job ID_Opt 58] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 58] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 58] <> 0 
UNION 
SELECT [job ID_Opt 59] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 59] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 59] <> 0 
UNION 
SELECT [job ID_Opt 60] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 60] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 60] <> 0 
UNION 
SELECT [job ID_Opt 61] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 61] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 61] <> 0 
UNION 
SELECT [job ID_Opt 62] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 62] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 62] <> 0 
UNION 
SELECT [job ID_Opt 63] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 63] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 63] <> 0 
UNION 
SELECT [job ID_Opt 64] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 64] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 64] <> 0 
UNION 
SELECT [job ID_Opt 65] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 65] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 65] <> 0 
UNION 
SELECT [job ID_Opt 66] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 66] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 66] <> 0 
UNION 
SELECT [job ID_Opt 67] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 67] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 67] <> 0 
UNION 
SELECT [job ID_Opt 68] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 68] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 68] <> 0 
UNION 
SELECT [job ID_Opt 69] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 69] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 69] <> 0 
UNION 
SELECT [job ID_Opt 70] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 70] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 70] <> 0 
UNION 
SELECT [job ID_Opt 71] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 71] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 71] <> 0 
UNION 
SELECT [job ID_Opt 72] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 72] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 72] <> 0 
UNION 
SELECT [job ID_Opt 73] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 73] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 73] <> 0 
UNION 
SELECT [job ID_Opt 74] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 74] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 74] <> 0 
UNION 
SELECT [job ID_Opt 75] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 75] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 75] <> 0 
UNION 
SELECT [job ID_Opt 76] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 76] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 76] <> 0 
UNION 
SELECT [job ID_Opt 77] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 77] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 77] <> 0 
UNION 
SELECT [job ID_Opt 78] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 78] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 78] <> 0 
UNION 
SELECT [job ID_Opt 79] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 79] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 79] <> 0 
UNION 
SELECT [job ID_Opt 80] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 80] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 80] <> 0 
UNION 
SELECT [job ID_Opt 81] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 81] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 81] <> 0 
UNION 
SELECT [job ID_Opt 82] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 82] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 82] <> 0 
UNION 
SELECT [job ID_Opt 83] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 83] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 83] <> 0 
UNION 
SELECT [job ID_Opt 84] AS Combined_Job_IDs, Date_time_of_selecting_job,session_id, [quadrant jobs_Opt 83] as os_quad_jobs FROM sessions_data WHERE [job ID_Opt 84] <> 0 


SELECT * FROM Viewed_jobs_contractor_89

--Copy the data in the Viewed_jobs_contractor_89 into a table

SELECT * 
INTO Contractor_89_viewed_jobs_v2
FROM Viewed_jobs_contractor_89

--Modify the table; Date time column into Modified date, Hour of day, and day of week
ALTER TABLE Contractor_89_viewed_jobs_v2
ADD Modified_date NVARCHAR(50),
	Day_of_week NVARCHAR(50),
	Hour_of_day INT

UPDATE Contractor_89_viewed_jobs_v2
SET Modified_date = SUBSTRING(Date_time_of_selecting_job,5,6) + RIGHT(Date_time_of_selecting_job,5),
	Day_of_week = SUBSTRING(Date_time_of_selecting_job, 1, 3),
	Hour_of_day = SUBSTRING(Date_time_of_selecting_job,12,2)

SELECT * FROM Contractor_89_viewed_jobs_v2

--Add job characteristics to all the jobs viewed by the contractor
--Save the output in a table

SELECT cvj.Combined_Job_IDs as Job_ID,
	cvj.Date_time_of_selecting_job,
	cvj.session_id,
	cvj.Modified_date,
	cvj.Day_of_week,
	cvj.Hour_of_day,
	cvj.os_quad_jobs,
	snw.Neighborhood,
	snw.Quadrant,
	snw.JOB_TYPE as Job_type,
	snw.JOB_DESC1 as Job_desc1,
	snw.JOB_SIZE as Job_size,
	snw.PRICE_JOB as Price_job
INTO consolidated_contractor_89_jobs_v2
FROM Contractor_89_viewed_jobs_v2 cvj
JOIN snow_job_data snw
	ON cvj.Combined_Job_IDs = snw.JOB_ID

--Modify table consolidated_Contractor_89_jobs to include status of job
--If Job ID was selected by contractor, status 1 will be assigned otherwise 0
--The comparison is between the Contractor_89_executed_jobs table and the consolidated_contractor_89_jobs_v2 table

ALTER TABLE consolidated_contractor_89_jobs_v2
ADD Status INT

UPDATE consolidated_contractor_89_jobs_v2
SET Status = CASE WHEN EXISTS (SELECT 1 FROM Contractor_89_executed_jobs WHERE Job_ID = consolidated_contractor_89_jobs_v2.Job_ID) THEN 1
	ELSE 0
END;

SELECT * FROM consolidated_contractor_89_jobs_v2
ORDER BY session_id

--Add Time_category column to the consolidated_contractor_89_jobs_v2 table
--This classifies the Hour as either Night, Morning, Afternoon or evening
--consolidated_contractor_89_jobs_v2 is the final merged data table that will be read in python


ALTER TABLE consolidated_contractor_89_jobs_v2
ADD Time_category NVARCHAR(50)

UPDATE consolidated_contractor_89_jobs_v2
SET Time_category = CASE 
						WHEN Hour_of_day >= 0 AND Hour_of_day < 6 THEN 'Night'
						WHEN Hour_of_day >= 6 AND Hour_of_day < 12 THEN 'Morning'
						WHEN Hour_of_day >= 12 AND Hour_of_day < 18 THEN 'Afternoon'
						ELSE 'Evening' -- Hour_of_day is from 18 to 23
					END
-- Run this statement to check that the table meets your specifications
SELECT *
FROM consolidated_contractor_89_jobs_v2;
