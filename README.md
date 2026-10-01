# Customer Support Operations Analysis

## Overview

This project analyzes 4,000 customer support tickets to examine ticket volume, response times, reopen rates, and customer satisfaction.

I used **PostgreSQL in DBeaver** for the SQL analysis and **Tableau** to create an interactive dashboard.

## Questions Analyzed

* How many tickets are coming in, and through which channels?
* Which support queues handle the most tickets?
* How quickly are customers receiving their first response?
* Does priority affect response time?
* Which queues have the longest response times?
* How often are tickets reopened?
* Which queues or channels have the highest reopen rates?
* How does customer satisfaction vary by channel?
* Is there a relationship between response time and CSAT?
* Which areas of the operation appear to need attention?

## Key Findings

* **Technical** handled the most tickets, with 1,282 tickets.
* **Integrations** had the longest average response time at 171.37 minutes.
* **Billing** had the highest queue-level reopen rate at 8.65%.
* **In-app** had the lowest average CSAT at 3.89.
* The correlation between response time and CSAT was approximately **0.0215**, indicating very little linear relationship between the two variables in this dataset.

## Tools

* PostgreSQL
* DBeaver
* Tableau
* SQL

## Portfolio Dashboard

[View the interactive Tableau dashboard](https://public.tableau.com/app/profile/brittnie.chenier/viz/CustomerSupportOperationsDashboard/CustomerSupportOperationsDashboard)

## Project Files

* `support_tickets.csv` — dataset used for the analysis
* `sql/support_ticket_analysis.sql` — SQL queries used to answer the analysis questions
* Tableau — interactive dashboard linked above
