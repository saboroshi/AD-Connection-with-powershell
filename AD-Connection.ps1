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
