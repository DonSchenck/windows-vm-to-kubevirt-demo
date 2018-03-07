# Import web admin module
Import-Module WebAdministration

# Set application pool for web site
Set-ItemProperty -path 'IIS:\Sites\Default Web Site\WingtipToys' -Name applicationPool -Value DefaultAppPool