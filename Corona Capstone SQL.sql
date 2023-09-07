-- 1. Find the number of corona patients who faced shortness of breath.

SELECT COUNT(*) FROM covid19 WHERE Corona = 'Positive' AND Shortness_of_breath = 'true';

-- 2. Find the number of negative corona patients who have fever and sore_throat. 

Select Count(*) FROM covid19 WHERE corona= 'negative' AND fever = 'TRUE' AND sore_throat = 'TRUE';

-- 3. Group the data by month and rank the number of positive cases.

SELECT MONTH(Test_date) AS months, sum(corona='positive') AS total_positive_cases,
RANK() OVER (ORDER BY SUM(Corona='positive') DESC) AS Ranks FROM covid19 
WHERE corona='positive' GROUP BY months ORDER BY months;

-- 4. Find the female negative corona patients who faced cough and headache.

SELECT Count(*) FROM covid19 WHERE corona = 'negative' AND Sex='female' AND Ind_ID IN (
SELECT Ind_ID FROM covid19 WHERE Cough_symptoms = 'True' AND headache = 'True');

-- 5. How many elderly corona patients have faced breathing problems?

SELECT count(*) FROM covid19 WHERE Age_60_above='yes' AND Corona='positive' AND Shortness_of_breath='true';

-- 6. Which three symptoms were more common among COVID positive patients?

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Fever = 'TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Headache = 'TRUE'
) AS xyz
GROUP BY symptom ORDER BY total_count DESC LIMIT 3;

-- 7. Which symptom was less common among COVID negative people?

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'negative' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'negative' AND Fever = 'TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'negative' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'negative' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'negative' AND Headache = 'TRUE'
) AS xyz
GROUP BY symptom ORDER BY total_count ASC LIMIT 1;

-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Fever = 'TRUE' And Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Sore_throat = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM covid19 WHERE Corona = 'positive' AND Headache = 'TRUE' And Sex='Male' AND Known_contact ='abroad'
) AS xyz
GROUP BY symptom ORDER BY total_count DESC LIMIT 1;