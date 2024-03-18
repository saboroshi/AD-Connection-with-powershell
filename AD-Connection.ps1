<#	
  .Synopsis
   Connection test to Active Directory server..

  .Description
   Used to test Active Directory authentication. The script checks that this user with the specified username and password exists in AD. 
   If the username and password pair exists, it returns true, otherwise it returns false. Installation of the RSAT client required for its operation:
   
  .Parameter Server
   The Active Directory server.

  .Parameter Domain
   Domain name.

  .Parameter Username
   Domain user name.

  .Parameter Password
   Domain user password.

  .Example
   AD-Connection -Server "example.domain.com" -Domain "domain.com" -Username "aduser" -Password "adpassword"
#>

function AD-Connection
{
    param(
        $Server = "",
        $Domain = "",
        $Username = "",
        $Password = ""
    )
    $Pass = ConvertTo-SecureString "$Password" -AsPlainText -Force
    $User = "$Domain\$Username"
    $Credential = New-Object System.Management.Automation.PSCredential ($User, $Pass)
    try
    {
        Get-ADUser -Filter {SamAccountName -eq $Username} -Credential $Credential -Server "$Server" | Out-Null
        return $true
    }
    catch
    {
        return $false
    }
}
