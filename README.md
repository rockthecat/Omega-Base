# Omega-Base
Web based Knowledge Base

In case of doubts, troubles, email: bugs.blacktoolkit@gmail.com 


To install Omega Base you need a JSP server (supports Tomcat >= 7 or JBoss or 
Glassfish), and PostgreSQL at least 9.0.



1-) PostgreSQL Configuration.
You will need to create a database on PostgreSQL if you don't have one to.
If you have one, you can upgrade it will keeping your data. But I would say: 
make a backup first for your safety.

-Open Pgadmin3. Check the version you have of the db. You can see the version
checking in table "configuration" column "db_version". This table always have 
just one row.

-If your installation is new, run all the SQL files in next step. If it exists, 
but the column doesn´t exists, start with SQL file 1.

-With pgadmin3, open the SQL files (on sql/scripts) from the version you have of the db, 
run them from the (db_version+1) from you have, in numeric sequence.


2-) JSP Server Configuration.
As 1.1 Omega Base supports Tomcat (at minimum version 7), JBoss or Glassfish. Other
servers may work, but it was not tested.

-Deploy dist/omegabase.war accordly do your server. 
-The JNDI Connection´s name is java:/jdbc/Prisma.

3-) Login.
The new installation´s default user is "administrator" and the password "changeit".
You must change this for security.


