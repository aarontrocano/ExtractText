$tsv = (Get-Content "C:\Users\atrocano\Documents\working_Set\scsv_file - Copy.txt").Replace(";", "`t")
$tsv | Set-Content -Path "C:\Users\atrocano\Documents\working_Set\tsv_file.txt"