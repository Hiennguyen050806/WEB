The project consists of 2 standard Maven WebApp projects:

BaiTap1_ServletJDBC: Pure MVC exercise with Servlet, JDBC, Remember Me Cookie, Session, Register, and Category CRUD based on PDF 06_MVC & PDF 14_HD.

BaiTap2_JPA: CRUD exercise with JPA 3.0 & Jakarta EE (Hibernate 7.x/6.x), adding advanced features:

Account activation via OTP code sent by email (and displayed in the Console).

Login with SHA-256 hashed passwords, plus Logout functionality.

Forgot password sending an OTP verification code via email and resetting to a new password.

Full Videos table CRUD using JPA technology.

Display the 10 latest videos on the home page /home.

Display all videos paginated at 6 items/page at the URL /video.

View details and play videos directly when clicking a video title on /home or /video.

File upload using Servlet Multipart (@MultipartConfig).

1. DATABASE CONFIGURATION
A. For Assignment 1 (BaiTap1_ServletJDBC)
Database Name: ShoppingServiceMVC

Script file: BaiTap1_ServletJDBC/src/main/resources/database.sql

Supports SQL Server (localhost:1433) and MySQL (localhost:3306).

Default password in DBConnection.java: 1234567@a$ (or 1234@a$). You can update it to match your local SQL password in vn.iotstar.connection.DBConnection.

B. For Assignment 2 (BaiTap2_JPA)
Database Name: webst2

Script file: BaiTap2_JPA/src/main/resources/database.sql

In persistence.xml, Hibernate is configured to automatically generate/update tables:

XML
<property name="hibernate.hbm2ddl.auto" value="update" />
So you only need to create an empty database CREATE DATABASE webst2; on SQL Server, and JPA will automatically create the users, categories, and videos tables.

DB configuration file: BaiTap2_JPA/src/main/resources/META-INF/persistence.xml (update the sa user and password if different).

2. HOW TO RUN THE PROJECT ON ECLIPSE / INTELLIJ IDEA AND TOMCAT
Option 1: Run with IntelliJ IDEA
Open the D:\web folder or open each folder (BaiTap1_ServletJDBC, BaiTap2_JPA) individually.

Wait for Maven to download and sync dependencies.

Run the test file that generates JPA sample data:

Right-click BaiTap2_JPA/src/main/java/vn/iotstar/config/Test.java -> select Run 'Test.main()'.

Configure Tomcat:

Go to Run -> Edit Configurations... -> click + -> select Tomcat Server -> Local.

Deployment tab: Click + -> Select Artifact -> choose BaiTap2_JPA:war exploded (set Application context to /BaiTap2_JPA or /).

Click Apply and Run.

Option 2: Run with Eclipse
Open Eclipse -> File -> Import... -> Existing Maven Projects -> Select the BaiTap1_ServletJDBC or BaiTap2_JPA folder.

Right-click the project -> Run As -> Run on Server (choose Tomcat 10+).

3. FUNCTIONALITY TEST URLS
A. Assignment 2 (BaiTap2_JPA)
Home page (10 latest videos): http://localhost:8080/BaiTap2_JPA/home

All videos (paginated at 6 items/page): http://localhost:8080/BaiTap2_JPA/video

Video details & playback: Click any video title on the home page or /video page.

Account registration & OTP: http://localhost:8080/BaiTap2_JPA/register (The OTP code is sent and printed directly to the Server Console so you can copy and enter it right away).

Login: http://localhost:8080/BaiTap2_JPA/login

Forgot password via OTP: http://localhost:8080/BaiTap2_JPA/forgot-password

Category management (Category JPA): http://localhost:8080/BaiTap2_JPA/admin/categories

Video management (Video JPA CRUD): http://localhost:8080/BaiTap2_JPA/admin/videos

File upload demo (Multipart): `
