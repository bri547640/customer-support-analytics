---- Q01 How many tickets are coming in, and through which channels? ----
SELECT channel, 
	COUNT (*) AS ticket_count
FROM support_tickets
GROUP BY channel
ORDER BY ticket_count DESC;

---- Q02 Which support queues handle the most tickets? ----
SELECT queue, 
	COUNT (*) AS ticket_count
FROM support_tickets
GROUP BY queue
ORDER BY ticket_count DESC;

---- Q03 How quickly are customers receiving their first response? ----
SELECT 
	AVG(first_response_min) AS avg_response_min
FROM support_tickets;

SELECT 
	AVG(first_response_min) AS avg_response_min,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY first_response_min) AS median_response_min
FROM support_tickets; 

---- Q04 Does priority affect response time? ----
SELECT
	priority,
	COUNT(*) AS total_tickets,
	ROUND(AVG(first_response_min), 2) AS avg_response_min
FROM support_tickets
GROUP BY priority
ORDER BY avg_response_min DESC;

---- Q05 Which queues have the longest response times? ----
SELECT 
	queue,
	COUNT(*) AS total_tickets,
	count(*) * 100.0/ (SELECT count (*) FROM support_tickets) AS ticket_percentage,
	ROUND(AVG(first_response_min), 2) AS avg_response_min
FROM support_tickets
GROUP BY queue
ORDER BY avg_response_min DESC;

---- Q06 How often are tickets reopened? ----
SELECT 
	reopened,
	COUNT (*) AS total_tickets,
	ROUND(COUNT (*) * 100.0/ (SELECT COUNT (*) FROM support_tickets), 2) 
	AS reopened_percentage
FROM support_tickets
GROUP BY reopened;

---- Q07 Which queues or channels have the highest reopen rates? ----
SELECT
    queue,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (WHERE reopened = true) AS reopened_tickets,
    ROUND(
        COUNT(*) FILTER (WHERE reopened = true) * 100.0 / COUNT(*),
        2
    ) AS reopen_rate_percent
FROM support_tickets
GROUP BY queue
ORDER BY reopen_rate_percent DESC;

SELECT
    channel,
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (WHERE reopened = true) AS reopened_tickets,
    ROUND(
        COUNT(*) FILTER (WHERE reopened = true) * 100.0 / COUNT(*),
        2
    ) AS reopen_rate_percent
FROM support_tickets
GROUP BY channel
ORDER BY reopen_rate_percent DESC;

---- Q08 How does customer satisfaction vary by channel? ----
SELECT
	channel,
	ROUND(AVG(csat), 2
	) AS avg_csat
FROM support_tickets
GROUP BY channel
ORDER BY avg_csat DESC;

---- Q09 Is there a relationship between response time and CSAT? ----
SELECT
	first_response_min, csat 
FROM support_tickets
WHERE first_response_min IS NOT NULL
	AND csat IS NOT NULL; 

SELECT
	corr(first_response_min, csat) AS correlation
FROM support_tickets 
WHERE first_response_min IS NOT NULL 
	AND csat IS NOT NULL;

---- Q10 Which areas of the operation appear to need attention? ----
-- 1. Integrations had the longest average response time.
-- 2. Billing had the highest reopen rate.
-- 3. In-app had the lowest average CSAT.
-- 4. Response time and CSAT had very little linear correlation
--    (r = 0.0215), indicating very little linear relationship between 
--    response time and CSAT in this dataset.
