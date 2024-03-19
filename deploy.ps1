foreach ($item in 1..1) {
    $start = get-date
    terraform fmt;terraform validate
    terraform apply --auto-approve
    $end =get-date
    Write-Output "Script started at $start and ended at $end"
}