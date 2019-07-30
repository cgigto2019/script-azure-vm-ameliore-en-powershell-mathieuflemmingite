

#ssh-keygen -t rsa -b 2048 -f $HOME\.ssh\id_rsa 

$sshPublicKey = Get-Content "$HOME\.ssh\id_rsa.pub"

New-AzResourceGroup -Name 'testressources' -Location 'westeurope'

$nbVM = Read-Host "Combien de VM souhaitez-vous créer ? "

for ($i=1;$i -le $nbVM;$i++)
{

    $parameters = @{
      ResourceGroupName = 'testressources'
      Name =  "namVM-" + $i
      Location = 'westeurope'
      ImageName = 'UbuntuLTS'
      Credential = $credential
      KeyData = $sshPublicKey
      OpenPorts = 22
    }
    
    $newVM1 = New-AzVM @parameters

    $publicIp = Get-AsPublicIpAdress -Name "namVM-" + $i

    ssh $env:USERNAME@publicIP

    git clone git@vps706123.ovh.net:root/boite-a-outils.git

}



