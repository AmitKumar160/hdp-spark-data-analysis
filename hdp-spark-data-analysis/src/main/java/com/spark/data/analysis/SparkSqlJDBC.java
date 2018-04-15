package com.spark.data.analysis;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SQLContext;
import org.apache.spark.sql.SparkSession;

import java.util.Arrays;
import java.util.Properties;

/**
 * @author Amit kumar
 * date : 14/04/2018
 * Main Class: SparkSqlJDBC
 */
public class SparkSqlJDBC {

	public static void main(String[] args) {

		System.out.println("Input params:"+Arrays.toString(args));
		String user = args[0].trim();
		String password = args[1].trim();
		String hostName = args[2].trim();
		String port = args[3].trim();
		String instance = args[4].trim();

		SparkSession spark = SparkSession
				.builder()
				.appName("Spark SQL data analysis")
				.config("spark.hadoop.mapred.output.compress","false")
				.getOrCreate();

		runJdbcDataset(spark,hostName,port,instance,user,password);
		spark.stop();
	}

	private static void runJdbcDataset(SparkSession spark, String hostName, String port, String instance, String user, String password) {

		Properties connectionProp = new Properties();

		connectionProp.put("user", user);
		connectionProp.put("password", password);
		connectionProp.put("driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver");

		long startTime = System.currentTimeMillis();
		try {
			StringBuffer url = new StringBuffer();
			url.append("jdbc:sqlserver://");
			url.append(hostName+":"+port);
			url.append(";database="+instance);

			Dataset<Row> jdbcDF = spark.read().jdbc(url.toString(), "cus_sup_ord_join", connectionProp);
			SQLContext sq =jdbcDF.sqlContext();

			// Average revenue of country and its city
			// Which country and its city is producing more revenue.
			Dataset<Row> jdbcDF1 = sq.sql("select customer_cty,customer_city,avg(TotalAmount) as avg_price from cus_sup_ord_join group by customer_cty,customer_city order by avg_price");
			jdbcDF1.write().jdbc(url.toString(),"avg_revenue_cty", connectionProp);

			// number customers from each country and city
			Dataset<Row> jdbcDF2 = spark.read().jdbc(url.toString(), "Customer", connectionProp);
			SQLContext sqc =jdbcDF2.sqlContext();
			Dataset<Row> jdbcDF3 = sqc.sql("select city,country,count(1) as cus_count from customer group by city,country");
			jdbcDF3.write().jdbc(url.toString(),"num_cus_cty", connectionProp);

			// number suppliers from each country and city
			Dataset<Row> jdbcDF4 = spark.read().jdbc(url.toString(), "Supplier", connectionProp);
			SQLContext sqs =jdbcDF4.sqlContext();
			Dataset<Row> jdbcDF5 = sqs.sql("select city,country,count(1) as sup_count from Supplier group by city,country");
			jdbcDF5.write().jdbc(url.toString(),"num_sup_cty", connectionProp);
			
			// Products discontinued by customers
			Dataset<Row> jdbcDF6 = sq.sql("select distinct customerId,Customer_first_name,customer_last_name,productId,productName,supplierId,CompanyName,contactName,IsDiscontinued from cus_sup_ord_join where IsDiscontinued =1");
			jdbcDF6.write().jdbc(url.toString(),"prod_disCont_cty", connectionProp);

			// Below will get all product with orderdate and also reflect customers and product with no orders
			Dataset<Row> jdbcDF7 = sq.sql("select distinct customerId,Customer_first_name,customer_last_name,productId,productName,supplierId,CompanyName,contactName,IsDiscontinued from cus_sup_ord_join where IsDiscontinued =1");
			jdbcDF7.write().jdbc(url.toString(),"order_prd_id", connectionProp);
			
			long endTime = System.currentTimeMillis();
			System.out.println("Time Taken:" + (endTime - startTime) + "ms");
		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
	}
}
