Spark SQL DATA ANALYSIS:


check out project from github



import project to eclipse IDE as existing maven project.



check dependencies in pom.xml



microsoft sql server 
dependencies
<!-- https://mvnrepository.com/artifact/com.microsoft.sqlserver/sqljdbc41 -->

		<dependency>
	
  			<groupId>com.microsoft.sqlserver</groupId>

			<artifactId>sqljdbc41</artifactId>

			<version>4.0.2206.100</version>

		</dependency>


above dependency is mostly not available in maven private mode so first download driver jar from micrsoft 
website
link: https://www.microsoft.com/en-in/download/details.aspx?id=11774


then go to {directory}\Microsoft JDBC Driver 6.0 for SQL Server\sqljdbc_6.0\enu\jre7 
and register this jar to your maven repository

Command:
mvn install:install-file -Dfile=sqljdbc41.jar -Dpackaging=jar -DgroupId=com.microsoft.sqlserver -DartifactId=sqljdbc41 -Dversion=4.0.2206.100



then update project in IDE.
Build project:

		    mvn clean
			
		    mvn install


Operation on Spark Environment:



./bin/spark-submit --master spark://Hadoop04:7077 --class com.spark.data.analysis.SparkSqlJDBC /{directory}/sparksql-1.0-SNAPSHOT.jar

