[String]$dbname    = "WingtipToys";
[String]$ipaddress = "52.183.249.9";
[String]$userid    = "sa";
[String]$pwd       = "Yukon9000000";

# ADO.NET connection
$con = New-Object Data.SqlClient.SqlConnection;
$con.ConnectionString = "Data Source=$ipaddress;Initial Catalog=master;User Id=$userid;Password=$pwd";
$con.Open()

$sql = "CREATE DATABASE [$dbname];"
$cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
$cmd.ExecuteNonQuery();

$cmd.Dispose();
$con.Close();
$con.Dispose();
