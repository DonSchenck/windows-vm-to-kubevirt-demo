#
# dbupdate.ps1
#
# Establish variable values
[String]$database = 'wingtiptoys'
[String]$userid = 'sa'
[String]$password = 'EncryptThis2'
[String]$serverIP = '52.183.249.9'

# Create SQL Connection


Write-Verbose "Beginning database update..."

$con = new-object "System.data.sqlclient.SQLconnection"

#Set Connection String
$con.ConnectionString =("Server=$serverIP;Database=$database;User ID=$userid;Password=$password;")
$con.open()

Write-Verbose "...Deleting existing records..."

$sqlcmd = new-object "System.data.sqlclient.sqlcommand"
$sqlcmd.connection = $con
$sqlcmd.CommandTimeout = 600000
$sqlcmd.CommandText = “DELETE FROM Products WHERE ProductID < 20000;”
$rowsAffected = $sqlcmd.ExecuteNonQuery()

Write-Verbose "...Writing new records..."

$table = 'dbo.Products'

Import-Csv products.csv | ForEach {Invoke-Sqlcmd `
        -Username $userid `
        -Password $password `
	-Database $database -ServerInstance $serverIP `
	-Query "insert into $table (ProductName,Description,ImagePath,UnitPrice,CategoryID) VALUES ('$($_.productname)','$($_.description)','$($_.imagepath)','$($_.unitprice)','$($_.categoryid)')"
}

Write-Verbose "Finished."