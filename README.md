# How to RUN? Please don't ignore this. IMPORTANT!!!!!

Please run the folder SmartHealthPrediction as a Project Folder instead of the outside folder. Otherwise, errors may occur.

<img src="https://i.imgur.com/I7KtBAS.jpeg" alt="Run this folder as a Project Folder" style="max-width:100%;" >

First off, make sure to backup the database using SHPS.bak in your local machine in order to access it in the application.

For developers, you can run this program in your favourite IDE, specifically, the Main class. Note: Please make sure you already added the SQL JDBC JAR file in your Project Settings section. Otherwise, you won’t be able to connect to the database.
The default url to connect to the database is 
“jdbc:sqlserver://localhost;database=SHPS;integratedSecurity=true;”

The above url is supposed to find your default localhost name, default instance and default port of your local. If you have any problem while connecting the database, please make sure to adjust the url to fit your machine’s requirements. 

