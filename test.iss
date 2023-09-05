;建立 
[Setup] 
AppName=testAddIis
AppVerName=testAddIis 5.0.20.11191
DefaultDirName={pf}\Test\AddIis01
DefaultGroupName=testAddIis
OutputBaseFilename=testAddIis_202011191

;目錄
;建立應用程式目錄之外的其它目錄
[Dirs]
Name: {app}\bin

;檔案
;安裝程式需要複製資料到使用者的系統之檔案
;Source來源，DestDir目的地 
[Files]
Source: .\dotnet-runtime-7.0.10-win-x64.exe; DestDir: {app}\bin\
;Flags: deleteafterinstall

;執行
[Run]
;執行程式IISSetUp.exe ;不等待 ;輸入參數=安裝程式安裝路徑{app} 
Filename: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Parameters: "/install /quiet /norestart"; StatusMsg: "Installing 32-bit Windows Universal runtime..."; Flags: waituntilterminated
;Filename: "{app}\bin\dotnet-runtime-7.0.10-win-x64.exe"; WorkingDir: {app}; Flags: skipifdoesntexist; StatusMsg: "Install .Net Framework ..."; Check: IsDotNet6Installed
[UninstallRun]
Filename: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Parameters: "/uninstall /quiet /norestart";WorkingDir: {app};Flags: waituntilterminated skipifdoesntexist;
;卸載刪除
[UninstallDelete]
;Name: {app}\bin\IISSetUp.exe; Type: filesandordirs;
Name: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Type: filesandordirs;

[Code]
function IsDotNet6Installed: Boolean;
var
  regVersion: Cardinal;
begin
  Result := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v7.0', 'Version', regVersion);
end;