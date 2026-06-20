# git fetch --prune; git branch -vv | Select-String '\[.*: gone\]' | % { git branch -d (($_ -replace '^\*?\s*([^\s]+).*','$1')) }
git fetch --prune
git branch -vv | Select-String '\[.*: gone\]' | ForEach-Object { 
    $name = ($_ -replace '^\*?\s*([^\s]+).*','$1')
    git branch -d $name
}
