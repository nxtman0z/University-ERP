# UniCore ERP

## Overview
This project is a Java Servlet and JSP based ERP skeleton for a university system.
The codebase has been cleaned to remove demo credentials, hardcoded sample records, and fake successful persistence behavior.

## Current State
- UI forms are available for admin, faculty, and student workflows.
- Dashboard tables render from request attributes and show empty states when no data is supplied.
- Authentication and write operations are JDBC-pending.
- No in-memory demo dataset is used.

## Tech Stack
- Java Servlets
- JSP
- Apache Tomcat 9+
- Plain CSS and JavaScript

## Project Structure
- src/com/project/model: domain model classes
- src/com/project/servlet: controllers for login and module actions
- src/com/project/util: data access placeholder service for JDBC integration
- webapp: JSP views, CSS, JavaScript, and web.xml

## Important Behavior Before JDBC Integration
- Login servlets now reject authentication until JDBC verification is implemented.
- Create/update servlets validate input and return a database-not-configured response instead of fake success.
- DataManager contains JDBC TODO stubs and does not persist sample data.

## JDBC Integration Plan
1. Configure JDBC datasource/connection settings.
2. Implement credential verification in login servlets.
3. Implement INSERT/SELECT logic in DataManager or DAO layer.
4. Populate request attributes from database queries before rendering dashboards.
5. Add proper success and error messaging after real DB operations.

## Local Run
1. Compile Java source into WEB-INF/classes.
2. Deploy the project under Tomcat webapps as UniversityERP.
3. Start Tomcat and open:
   - http://localhost:8080/UniversityERP
   - or http://localhost:9090/UniversityERP if 8080 is occupied

## Notes
- This repository is prepared for backend implementation, not final production deployment.
- Add database-backed authentication and persistence before using it as a real ERP.
