$WORK_DIR = "C:\Users\s07a1\Documents\work"
$WORK_FILE = "sample.txt"

$workFile = Join-Path -Path $WORK_DIR -ChildPath $WORK_FILE
$tmpFile = $workFile -replace ".txt", "_tmp.txt"

#�ϊ��O�̃t�@�C�����R�s�[
Copy-Item $workFile $tmpFile

#�t�@�C����ǂݍ���ŁA"�J���},�_�u���N�H�[�e�[�V�����A���s(������)"��"�J���},�_�u���N�H�[�e�[�V����"�ɒu������
$file_contents = [System.IO.File]::ReadAllText($tmpFile) -replace ",""`n+",","""

#�R���\�[���o��
Write-Output $file_contents

# UTF-8 LF(BOM����)�Ńt�@�C���o�͂���
$FILE_OUTPUT_UTF8ariBOM_CRLF = "after.txt"
$file_contents -join "`n" |
ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } |
Set-Content -Encoding Byte -LiteralPath (Join-Path -Path $WORK_DIR -ChildPath $FILE_OUTPUT_UTF8ariBOM_CRLF)
