#
# dbupdate.ps1
#
#Create SQL Connection

Write-Verbose "Beginning database update..."

$con = new-object "System.data.sqlclient.SQLconnection"

#Set Connection String
$con.ConnectionString =("Server=localhost;Database=wingtiptoys;Trusted_Connection=True;")
$con.open()

Write-Verbose "...Deleting existing records..."

$sqlcmd = new-object "System.data.sqlclient.sqlcommand"
$sqlcmd.connection = $con
$sqlcmd.CommandTimeout = 600000
$sqlcmd.CommandText = “DELETE FROM Products WHERE ProductID < 20000;”
$rowsAffected = $sqlcmd.ExecuteNonQuery()

Write-Verbose "...Writing new records..."

$database = 'wingtiptoys'
$server = '.'
$table = 'dbo.Products'

Import-Csv products.csv | ForEach {Invoke-Sqlcmd `
	-Database $database -ServerInstance $server `
	-Query "insert into $table (ProductName,Description,ImagePath,UnitPrice,CategoryID) VALUES ('$($_.productname)','$($_.description)','$($_.imagepath)','$($_.unitprice)','$($_.categoryid)')"
}

Write-Verbose "Finished."