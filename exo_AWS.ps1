

#ssh-keygen -t rsa -b 2048 -f $HOME\.ssh\id_rsa 

$sshPublicKey = Get-Content "$HOME\.ssh\id_rsa.pub"

New-AzResourceGroup -Name 'testressources' -Location 'westeurope'

for ($i=0;$i -le 2;$i++)
{

    
    $nameVM = Read-Host "Donnez un nom à votre VM : "

    $parameters = @{
      ResourceGroupName = 'testressources'
      Name = $nameVM
      Location = 'westeurope'
      ImageName = 'UbuntuLTS'
      Credential = $credential
      KeyData = $sshPublicKey
      OpenPorts = 22
    }
    
    $newVM1 = New-AzVM @parameters

    $publicIp = Get-AsPublicIpAdress -Name $nameVM

    ssh $env:USERNAME@publicIP

    git clone git@vps706123.ovh.net:root/boite-a-outils.git

}

