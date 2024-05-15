$YC_TOKEN = $(yc iam create-token)
$CLOUD_ID = $(yc config get cloud-id)
$FOLDER_ID = $(yc config get folder-id)
$SUBNET_ID = $(yc vpc subnet get default-ru-central1-a | Select-Object -first 1).split(' ')[1]

Write-Output "cloud_secrets = {
    YC_TOKEN = ""$YC_TOKEN""
    CLOUD_ID = ""$CLOUD_ID""
    FOLDER_ID = ""$FOLDER_ID""
    SUBNET_ID = ""$SUBNET_ID""
}" `
> yandex.auto.tfvars