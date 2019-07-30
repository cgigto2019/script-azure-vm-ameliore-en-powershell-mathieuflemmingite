

Param([int] $nbVM)

$numVM=1

#ssh-keygen -t rsa -b 2048 -f $HOME\.ssh\id_rsa 

$sshPublicKey = Get-Content "$HOME\.ssh\id_rsa.pub"

New-AzResourceGroup -Name 'testressources' -Location 'westeurope'

#$nbVM = Read-Host "Combien de VM souhaitez-vous créer ? "

#$credential = Get-Credential -Message "Veuillez saisir votre login et votre mot de passe pour vos VMs :"   // + Get-Random % 20

$user="Mathieu"
$keyMDP = ( Get-Random ) % 20
$password = "bibo"+$keyMDP
$password = ConvertTo-SecureString $password -AsPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential -ArgumentList ($user, $password)

for ($i=1;$i -le $nbVM;$i++)
{

    $parameters = @{
      ResourceGroupName = 'testressources'
      Name =  "namVM-" + $numVM
      Location = 'westeurope'
      ImageName = 'UbuntuLTS'
      Credential = $credential
      KeyData = $sshPublicKey
      OpenPorts = 22
    }
    
    $newVM1 = New-AzVM @parameters

    $publicIp = Get-AsPublicIpAdress -Name "namVM-" + $numVM

    ssh $env:USERNAME@publicIP

    git clone mat@vps706123.ovh.net:root/boite-a-outils.git

    $numVM++

}

