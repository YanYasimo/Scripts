# Defina a política de execução para Unrestricted temporariamente
#Set-ExecutionPolicy Unrestricted -Force
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force


Write-Host "Instalando o módulo PSWindowsUpdate..."
# Instala o módulo PSWindowsUpdate, se ainda não estiver instalado
Install-PackageProvider NuGet -Force;
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name PSWindowsUpdate -Repository PSGallery

Write-Host "PSWindowsUpdate Instalado com sucesso"

# Importa o módulo PSWindowsUpdate
Import-Module PSWindowsUpdate

# Obtém a lista de atualizações pendentes
$updates = Get-WUList


# Verificar se há atualizações pendentes
if ($updates.Count -gt 0) {
    # string formatada para armazenar as informações das atualizações
    $updateInfo = $updates | ForEach-Object {
        "ID: $($_.KBArticleID)"
        "Título: $($_.Title)"
        "Descrição: $($_.Description)"
        "Data de Publicação: $($_.Date)"
        "-----"
    }

    # -join para unir as linhas em uma única string, separadas por quebras de linha
    $updateInfoString = $updateInfo -join "`r`n"

    # Exibe todas as informações em um único Write-Host
    Write-Host $updateInfoString

    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot

    # Exibe uma mensagem de confirmação
} else {
    Write-Host "Não há atualizações pendentes."
}

# Restaura a política de execução para Restrict
Set-ExecutionPolicy Restricted -Force

# Força reinicialização
Restart-Computer -Force