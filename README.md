# Progpoepart1
# RaceDay - Event Management System

### Student: Sade Sazila
### Module: PROG6212 - Programming 2B
### Assessment: Portfolio of Evidence - Part 1
### Institution: The IIE
### Semester 2, 2026

---

## Project Overview

RaceDay is a full-stack web-based event management system designed
for the South African road running, walking, and cycling community.

---

## Part 1 - System Planning

Part 1 focuses on planning the system before writing application code.
All planning documents are committed to the `/docs` folder.

| Document | Location |
|----------|----------|
| ERD | docs/diagrams/ |
| API Endpoint Plan | docs/api-plan/ |
| SQL Script | docs/sql/RaceDay_DB.sql |

---

## Database Design

The RaceDay system uses 6 database tables:

- **Users** — stores both Organizers and Participants
- **UserProfiles** — extended profile info, one-to-one with Users
- **Events** — race events created by Organizers
- **Categories** — age/distance groupings per event
- **Enrollments** — links Participants to Events and Categories
- **Results** — finish times and positions after events

---

## How to Run the SQL Script

1. Open SQL Server Management Studio (SSMS)
2. Connect using Windows Authentication
3. Open `docs/sql/RaceDay_DB.sql`
4. Click Execute (or press F5)
5. The database `RaceDayDB` will be created automatically

---

## GitHub Actions CI/CD

A GitHub Actions workflow runs on every push to the `part1` branch
to validate that all required documentation files exist.

---

## References

Microsoft Corporation. 2024. *CREATE TABLE (Transact-SQL)*.
[Online]. Available at:
https://learn.microsoft.com/en-us/sql/t-sql/statements/create-table-transact-sql
[Accessed: 26 September 2026].
