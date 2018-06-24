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

Before running job please create DDL for below output tables according to select query in insight queries:
1.avg_revenue_cty
2.num_cus_cty
3.num_sup_cty
4.prod_disCont_cty
5.order_prd_id


Operation on Spark Environment:

./spark-client/bin/spark-submit --master yarn --deploy-mode cluster --class com.spark.data.analysis.SparkSqlJDBC --driver-memory 2G --num-executors 4 --executor-cores 2 --executor-memory 2G /{directory}/hdp-spark-data-analysis 0.0.1-SNAPSHOT user password hostName port db_instance db_type(mysql/postgresql/mssqlserver)

