$WORK_DIR = "C:\Users\s07a1\Documents\work"
$WORK_FILE = "sample.txt"

$workFile = Join-Path -Path $WORK_DIR -ChildPath $WORK_FILE
$tmpFile = $workFile -replace ".txt", "_tmp.txt"

#変換前のファイルをコピー
Copy-Item $workFile $tmpFile

#ファイルを読み込んで、"カンマ,ダブルクォーテーション、改行(複数回)"を"カンマ,ダブルクォーテーション"に置換する
$file_contents = [System.IO.File]::ReadAllText($tmpFile) -replace ",""`n+",","""

#コンソール出力
Write-Output $file_contents

# UTF-8 LF(BOM無し)でファイル出力する
$FILE_OUTPUT_UTF8ariBOM_CRLF = "after.txt"
$file_contents -join "`n" |
ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } |
Set-Content -Encoding Byte -LiteralPath (Join-Path -Path $WORK_DIR -ChildPath $FILE_OUTPUT_UTF8ariBOM_CRLF)
