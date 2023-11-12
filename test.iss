
#define MyAppExeName "WinFormsApp1.exe"
#define MyAppVersion "5.0.20.11191"
#define AppName "testAddIis"
#define MyAppPackPath SourcePath + "\..\images"
#define MyAppIcoName "inxdrive32.ico"
#define MyAppIcoName1 "inxdrive.bmp"
#define MyAppIcoName2 "isdonate.bmp"
;建立 
[Setup] 
;AppId={{EF909D9F-7C2F-46E8-9BBF-C65D3323A436}
AppPublisher=pppppp
AppName={#AppName}
AppVersion={#MyAppVersion}
AppVerName={#AppName}
DefaultDirName={pf}\Test\AddIis01
DefaultGroupName=testAddIis
OutputDir=Setup
OutputBaseFilename=testAddIis
SetupMutex=MySetupsMutexName,Global\MySetupsMutexName
SetupIconFile={#MyAppPackPath}\{#MyAppIcoName}
DisableWelcomePage=no
WizardImageFile={#MyAppPackPath}\{#MyAppIcoName1}
WizardSmallImageFile={#MyAppPackPath}\{#MyAppIcoName1}
UninstallDisplayIcon={#MyAppPackPath}\{#MyAppIcoName2}
VersionInfoCompany=HTTP://www.Hkiss.COM
VersionInfoDescription=ISsample 汉化增强版
VersionInfoVersion=1.0.0.0
VersionInfoCopyright=Copyright (C) 2007-2008 Hkiss
; yes 可以使文件更小
SolidCompression=yes
SetupLogging=yes
; default
CloseApplications=yes
; check all files
CloseApplicationsFilter=*.xlsx
;[Languages]
;Name: "english"; MessagesFile: "compiler:Default.isl"
;Name: "chinesetraditional"; MessagesFile: "compiler:Languages\ChineseTraditional.isl"
;AppMutex=MyProgMutex
;目錄
;建立應用程式目錄之外的其它目錄
ArchitecturesInstallIn64BitMode=x64 
[Dirs]
Name: {app}\bin;Permissions: everyone-full
[Tasks]
//[Tasks]-定义安装程序在执行安装期间所有由用户定制的任务。这些任务以选项框和单选项形式在附加任务向导页面中出现。
//创建桌面图标
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";
Name: "runoncommonstartup"; Description: "所有使用者"; GroupDescription: "啟動時自動執行"; Flags: exclusive unchecked
[Components]

Name: main; Description:"主程序(必选)";Types:full compact custom;Flags: fixed
Name: "main\english"; Description: "English"; Types: full compact custom
Name: "main\dutch"; Description: "Dutch"; Types: full compact custom
;Name: data; Description:"数据文件";Types:full

;Name: help;Description:"帮助文件";Types:full
;檔案
;安裝程式需要複製資料到使用者的系統之檔案
;Source來源，DestDir目的地 
[Files]
Source: ..\dotnet-runtime-7.0.10-win-x64.exe; DestDir: "{app}\bin\";Components:main
;Check:test
;AfterInstall:UpdateProgress
;Source: .\dotnet-runtime-7.0.10-win-x64.exe; DestDir: "{app}\bin\";Components:main;AfterInstall:UpdateProgress
;AddProgress('pp')
;Flags: deleteafterinstall
[Icons]
Name: "{autodesktop}\{#AppName}"; Filename: "{#MyAppPackPath}\{#MyAppExeName}";IconFilename: "{#MyAppPackPath}\{#MyAppIcoName}"; Tasks: desktopicon
;Name: "{group}"; Filename: "{#MyAppPackPath}\{#MyAppExeName}"; Tasks: quicklaunchicon; WorkingDir: {app};
Name: "{commonstartup}\{#AppName}"; Filename: "{#MyAppPackPath}\{#MyAppExeName}"; Tasks: runoncommonstartup
;執行
[Run]
Filename: "C:\test\2022\inno\ConsoleApp1\bin\Debug\net7.0\ConsoleApp1.exe"; Parameters:/install /quiet /norestart;Flags: waituntilterminated runhidden; Description: "InnoDriveSys"
;AfterInstall:UpdateProgress
;Filename: "C:\test\2022\inno\ConsoleApp1\bin\Debug\net7.0\ConsoleApp1.exe";Parameters:/install /quiet /norestart;Flags: waituntilterminated runhidden; Description: "InnoDriveSys";AfterInstall:AddProgress('00000')
;Filename: "C:\test\2022\inno\WinFormsApp1\bin\Debug\net7.0-windows\WinFormsApp1.exe";Flags: nowait postinstall skipifsilent;AfterInstall: UpdateProgress
;SetProgress(10)
;執行程式IISSetUp.exe ;不等待 ;輸入參數=安裝程式安裝路徑{app} 
;Filename: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Parameters: "/install /quiet /norestart"; StatusMsg: "Installing 32-bit Windows Universal runtime..."; Flags: waituntilterminated
;Filename: "{app}\bin\dotnet-runtime-7.0.10-win-x64.exe"; WorkingDir: {app}; Flags: skipifdoesntexist; StatusMsg: "Install .Net Framework ..."; Check: IsDotNet6Installed
[UninstallRun]
;Filename: {sys}\taskkill.exe; Parameters: "/f /im MyProcess.exe"; Flags: skipifdoesntexist runhidden
;Filename: "C:\test\2022\inno\WinFormsApp1\bin\Debug\net7.0-windows\WinFormsApp1.exe";Flags: nowait skipifdoesntexist;
;Filename: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Parameters: "/uninstall /quiet /norestart";WorkingDir: {app};Flags: waituntilterminated skipifdoesntexist;
;卸載刪除
[UninstallDelete]
;Name: {app}\bin\IISSetUp.exe; Type: filesandordirs;
;Name: {app}\bin\dotnet-runtime-7.0.10-win-x64.exe; Type: filesandordirs;
[CustomMessages]
authentication_form_Caption=SQL Server Database Setup
authentication_form_Description=Choose SQL Server database you will be using (ask your administrator about its parameters)
authentication_form_Label1_Caption0=Server Name:
authentication_form_Label2_Caption0=Enter Path to SQL Server (e.g. .\SQLEXPRESS; DEVSERVER)
authentication_form_Label3_Caption0=User name:
authentication_form_Label4_Caption0=Password:
authentication_form_ServerNameEdit_Text0=
authentication_form_WindowsRadioButton_Caption0=Use Windows Authentication
authentication_form_SqlRadioButton_Caption0=Use SQL Authentication
authentication_form_UserEdit_Text0=
authentication_form_PasswordEdit_Text0=
[Code]
function authentication_form_NextButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
  
end;
var
  Label1: TLabel;
  Label2: TLabel;
  Label3: TLabel;
  Label4: TLabel;
  ServerNameEdit: TEdit;
  WindowsRadioButton: TRadioButton;
  SqlRadioButton: TRadioButton;
  UserEdit: TEdit;
  PasswordEdit: TEdit;
function authentication_form_CreatePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(
    PreviousPageId,
    ExpandConstant('{cm:authentication_form_Caption}'),
    ExpandConstant('{cm:authentication_form_Description}')
  );

  Label1 := TLabel.Create(Page);
  with Label1 do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:authentication_form_Label1_Caption0}');
    Left := ScaleX(16);
    Top := ScaleY(0);
    Width := ScaleX(84);
    Height := ScaleY(17);
  end;
  

  with Page do
  begin
    OnNextButtonClick := @authentication_form_NextButtonClick;
  end;

  Result := Page.ID;
end;

procedure RegisterExtraCloseApplicationsResources;
begin
	RegisterExtraCloseApplicationsResource(true, 'C:\Program Files\Microsoft Office\root\Office16' + '\excel.exe');
end;

procedure CurStepChanged(CurStep: TSetupStep); 
var logfilepathname, logfilename, newfilepathname: string; 
begin logfilepathname := ExpandConstant('{log}'); 
logfilename := ExtractFileName(logfilepathname); 
newfilepathname := ExpandConstant('{app}\') + logfilename; 
if CurStep = ssDone then 
begin FileCopy(logfilepathname, newfilepathname, false); 
end; 
end;

function IsWindowsVersionOrNewer(Major, Minor: Integer): Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result :=
    (Version.Major > Major) or
    ((Version.Major = Major) and (Version.Minor >= Minor));
end;
function IsWindows10OrNewer: Boolean;
begin
  Result := IsWindowsVersionOrNewer(10, 0);
end;
function IsWindows11OrNewer: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result := IsWindows10OrNewer and (Version.Build >= 22000);
end;
const
  GWL_WNDPROC = -4;
  SB_VERT = 1;
  SB_BOTTOM = 7;
  WM_VSCROLL = $0115;
  WM_ERASEBKGND = $0014;

type
  WPARAM = UINT_PTR;
  LPARAM = LongInt;
  LRESULT = LongInt;

var
  OldStatusLabelWndProc: LongInt;
  OldFilenameLabelWndProc: LongInt;
  OldProgressListBoxWndProc: LongInt;
  ProgressListBox: TNewListBox;
  PrevStatus: string;
  PrevFileName: string;
function CallWindowProc(
  lpPrevWndFunc: LongInt; hWnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; external 'CallWindowProcW@user32.dll stdcall';  
function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: LongInt): LongInt;
  external 'SetWindowLongW@user32.dll stdcall';

procedure AddProgress(S: string);
begin
  if S <> '' then
  begin
   // Sleep(10000);
    ProgressListBox.Items.Add(S);
    ProgressListBox.ItemIndex := ProgressListBox.Items.Count;
    SendMessage(ProgressListBox.Handle, WM_VSCROLL, SB_BOTTOM, 0);

//MsgBox('pppppp', mbInformation, MB_OK);
  end;
end;

function StatusLabelWndProc(
  hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := CallWindowProc(OldStatusLabelWndProc, hwnd, uMsg, wParam, lParam);
  if PrevStatus <> WizardForm.StatusLabel.Caption then
  begin
    AddProgress(WizardForm.StatusLabel.Caption);
    PrevStatus := WizardForm.StatusLabel.Caption;
  end;
end;

function FilenameLabelWndProc(
  hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := CallWindowProc(OldFilenameLabelWndProc, hwnd, uMsg, wParam, lParam);
  if PrevFileName <> WizardForm.FilenameLabel.Caption then
  begin
    AddProgress(WizardForm.FilenameLabel.Caption);
    PrevFileName := WizardForm.FilenameLabel.Caption;
  end;
end;

function ProgressListBoxWndProc(
  hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  // reduce flicker
  if uMsg = WM_ERASEBKGND then
  begin
    Result := 1;
  end
    else
  begin
    Result :=
      CallWindowProc(OldProgressListBoxWndProc, hwnd, uMsg, wParam, lParam);
  end;
end;

function BufferToAnsi(const Buffer: string): AnsiString;
var
  W: Word;
  I: Integer;
begin
  SetLength(Result, Length(Buffer) * 2);
  for I := 1 to Length(Buffer) do
  begin
    W := Ord(Buffer[I]);
    Result[(I * 2)] := Chr(W shr 8); // high byte
    Result[(I * 2) - 1] := Chr(Byte(W)); // low byte
  end;
end;
var
  ProgressFileName: string;
procedure UpdateProgress;
var
  S: AnsiString;
  I, L, Max: Integer;
  Buffer: string;
  Stream: TFileStream;
  Lines: TStringList;
begin
ProgressFileName:='C:\test\2022\inno\ConsoleApp1\bin\Debug\net7.0\Redirect.txt';
 //MsgBox(ProgressFileName, mbInformation, MB_OK);
  Log(Format('ooooooooooooooooooooooooooooo', [ProgressFileName]));
  if not FileExists(ProgressFileName) then
  begin
MsgBox('9', mbInformation, MB_OK);
    Log(Format('Progress file %s does not exist', [ProgressFileName]));
  end
    else
  begin
    try
MsgBox('1', mbInformation, MB_OK);
      // Need shared read as the output file is locked for writing,
      // so we cannot use LoadStringFromFile
      Stream :=
        TFileStream.Create(ProgressFileName, fmOpenRead or fmShareDenyNone);
      try
        L := Stream.Size;
        Max := 100*2014;
        if L > Max then
        begin
          Stream.Position := L - Max;
          L := Max;
        end;
        SetLength(Buffer, (L div 2) + (L mod 2));
        Stream.ReadBuffer(Buffer, L);
        S := BufferToAnsi(Buffer);
      finally
        Stream.Free;
      end;
    except
      Log(Format('Failed to read progress from file %s - %s', [
                 ProgressFileName, GetExceptionMessage]));
    end;
  end;

  if S <> '' then
  begin
    Log('Progress len = ' + IntToStr(Length(S)));
    Lines := TStringList.Create();
    Lines.Text := S;
    for I := 0 to Lines.Count - 1 do
    begin
    //  MsgBox(Lines[I], mbInformation, MB_OK);
      if I < ProgressListBox.Items.Count then
      begin
        ProgressListBox.Items.Add(Lines[I]);
        //ProgressListBox.Items[I] := Lines[I];
      end
        else
      begin
        ProgressListBox.Items.Add(Lines[I]);
      end
    end;
    ProgressListBox.ItemIndex := ProgressListBox.Items.Count - 1;
    ProgressListBox.Selected[ProgressListBox.ItemIndex] := False;
    Lines.Free;
  end;

  // Just to pump a Windows message queue (maybe not be needed)
  //ProgressPage.SetProgress(0, 1);
end;



procedure InitializeWizard();
begin
if Is64BitInstallMode then
  begin 
 MsgBox(
      'Is64BitInstallMode.',
      mbCriticalError, MB_OK);
        end; 
  authentication_form_CreatePage(wpReady);
  if  IsWindows11OrNewer then
  begin 

    
    MsgBox(
      'This program was not tested on Windows XP and older, proceed with caution.',
      mbCriticalError, MB_OK);
  end;  
  OldStatusLabelWndProc :=
    SetWindowLong(WizardForm.StatusLabel.Handle, GWL_WNDPROC,
      CreateCallback(@StatusLabelWndProc));
  OldFilenameLabelWndProc :=
    SetWindowLong(WizardForm.FilenameLabel.Handle, GWL_WNDPROC,
      CreateCallback(@FilenameLabelWndProc));

  WizardForm.ProgressGauge.Top := WizardForm.FilenameLabel.Top;

  ProgressListBox := TNewListBox.Create(WizardForm);
  ProgressListBox.Parent := WizardForm.ProgressGauge.Parent;
  ProgressListBox.Top :=
    WizardForm.ProgressGauge.Top + WizardForm.ProgressGauge.Height + ScaleY(8);
  ProgressListBox.Width := WizardForm.FilenameLabel.Width;
  ProgressListBox.Height :=
    ProgressListBox.Parent.ClientHeight - ProgressListBox.Top - ScaleY(16);
  ProgressListBox.Anchors := [akLeft, akTop, akRight, akBottom];
  OldProgressListBoxWndProc :=
    SetWindowLong(ProgressListBox.Handle, GWL_WNDPROC,
      CreateCallback(@ProgressListBoxWndProc));
  // Lame way to shrink width of labels to client width of the list box,
  // so that particularly when the file paths in FilenameLabel are shortened
  // to fit to the label, they actually fit even to the list box.
  WizardForm.StatusLabel.Width := WizardForm.StatusLabel.Width - ScaleY(24);
  WizardForm.FilenameLabel.Width := WizardForm.FilenameLabel.Width - ScaleY(24);

end;

 

procedure SetMarqueeProgress(Marquee: Boolean);
begin
  if Marquee then
  begin
    WizardForm.ProgressGauge.Style := npbstMarquee;
  end
    else
  begin
    WizardForm.ProgressGauge.Style := npbstNormal;
  end;
end;
procedure SetProgress(Position: Integer);
begin
  WizardForm.ProgressGauge.Position :=
    Position * WizardForm.ProgressGauge.Max div 100;
end;
function IsDotNet6Installed: Boolean;
var
  regVersion: Cardinal;
begin
  Result := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v7.0', 'Version', regVersion);
end;


procedure KillTasks(const ExePath,ExeName:String);
var
  WbemLocator : Variant;
  WMIService   : Variant;
  WbemObjectSet: Variant;
  WbemObject   : Variant;
  i:Integer;
begin;
  WbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  WMIService := WbemLocator.ConnectServer('localhost', 'root\CIMV2');
  WbemObjectSet := WMIService.ExecQuery(Format('SELECT * FROM Win32_Process Where Name="%s"',[ExeName]));
  if not VarIsNull(WbemObjectSet) and (WbemObjectSet.Count > 0) then
  begin
    for i := 0 to WbemObjectSet.Count-1 do
    begin
      WbemObject := WbemObjectSet.ItemIndex(i);
      if WbemObject.ExecutablePath=ExpandConstant(ExePath+'\'+ExeName) then;
      begin
        if not VarIsNull(WbemObject) then
        begin
          WbemObject.Terminate();
          WbemObject := Unassigned;
        end;
      end;
    end;
  end;
end;
function IsProcessRunning(const AppName: string): Boolean;
var
  WMIService: Variant;
  WbemLocator: Variant;
  WbemObjectSet: Variant;
  Query: string;
begin
  WbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  WMIService := WbemLocator.ConnectServer('localhost', 'root\CIMV2');
  Query := 'SELECT * FROM Win32_Process Where Name="' + AppName + '"';
  WbemObjectSet := WMIService.ExecQuery(Query);
  Result := not VarIsNull(WbemObjectSet) and (WbemObjectSet.Count > 0);
end;
 

function IsAppRunning(const FileName: string): Boolean;
var
  FWMIService: Variant;
  FSWbemLocator: Variant;
  FWbemObjectSet: Variant;
begin
  Result := false;
  FSWbemLocator := CreateOleObject('WBEMScripting.SWBEMLocator');
  FWMIService := FSWbemLocator.ConnectServer('', 'root\CIMV2', '', '');
  FWbemObjectSet := FWMIService.ExecQuery(Format('SELECT Name FROM Win32_Process Where Name="%s"',[FileName]));
  Result := (FWbemObjectSet.Count > 0);
  FWbemObjectSet := Unassigned;
  FWMIService := Unassigned;
  FSWbemLocator := Unassigned;
end;
function InitializeSetup(): Boolean;  
var  
  ResultStr: String;  
  ResultCode: Integer;  
begin     
  result := IsAppRunning('{#MyAppExeName}');
  if result then
   // begin
   //   MsgBox('检测到{#MyAppExeName}正在运行，请先关闭程序后重试! ', mbError, MB_OK); 
   //   result:=false;
   // end
  //else 
    begin  
    if  MsgBox('是否卸载已安装的{#AppName}', mbConfirmation, MB_YESNO) = IDYES then
      begin  
      KillTasks('C:\test\2022\inno\WinFormsApp1\bin\Debug\net7.0-windows','{#MyAppExeName}');
        //安装前卸载流程
        //Exec(ResultStr, '/silent', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode);  
        //ShellExec('runas', ResultStr, '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ResultCode); 
      end;
    result:=true;
    end
  else
    begin
        result:=true; 
    end;
end;
procedure TaskKillProcessByName(AppName: String);
var
  WbemLocator : Variant;
  WMIService   : Variant;
  WbemObjectSet: Variant;
  WbemObject   : Variant;
begin;
  WbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  WMIService := WbemLocator.ConnectServer('localhost', 'root\CIMV2');
  WbemObjectSet := WMIService.ExecQuery('SELECT * FROM Win32_Process Where Name="' + AppName + '"');
  if not VarIsNull(WbemObjectSet) and (WbemObjectSet.Count > 0) then
  begin
    WbemObject := WbemObjectSet.ItemIndex(0);
    if not VarIsNull(WbemObject) then
    begin
      WbemObject.Terminate();
      WbemObject := Unassigned;
    end;
  end;
end;
function InitializeUninstall(): Boolean;
begin
    Result:=  IsAppRunning('{#MyAppExeName}');
    if  Result then
    begin
      if MsgBox('卸载程序检测到 {#AppName} 正在运行！'#13''#13'单击“是”按钮关闭程序并继续卸载；'#13''#13'单击“否”按钮退出卸载！', mbConfirmation, MB_YESNO) = IDYES then
      begin
        TaskKillProcessByName('{#MyAppExeName}');
    //    TaskKillProcessByName('{#MyAppExeName}');
      //    KillTasks('C:\test\2022\inno\WinFormsApp1\bin\Debug\net7.0-windows','{#MyAppExeName}');
        Result:= true;
      end
      else
        Result:= false;
    end
     else
        Result:= true;
    
end;
procedure DeinitializeSetup();
begin
  // In case you are using VCL styles or similar, this needs to be done before
  // you unload the style.
  SetWindowLong(
    WizardForm.StatusLabel.Handle, GWL_WNDPROC, OldStatusLabelWndProc);
  SetWindowLong(
    WizardForm.FilenameLabel.Handle, GWL_WNDPROC, OldFilenameLabelWndProc);
  SetWindowLong(
    ProgressListBox.Handle, GWL_WNDPROC, OldProgressListBoxWndProc);
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  WasVisible: Boolean;
begin
  // store the original visibility state
  WasVisible := WizardForm.PreparingLabel.Visible;
  try
    // show the PreparingLabel
    WizardForm.PreparingLabel.Visible := True;
    // set a label caption
    WizardForm.PreparingLabel.Caption := 'InstallingDotNetMsg';
    // do your installation here      
    Result:='ppppppppp'#13''#13' ooop';
  finally
    // restore the original visibility state
    WizardForm.PreparingLabel.Visible := WasVisible;
  end;
end;
function test(): Boolean;
  
var
  WinHttpReq: Variant;
begin
  Result := False;
  Log('Checking installation online...');
  try
    WinHttpReq := CreateOleObject('WinHttp.WinHttpRequest.5.1');
    WinHttpReq.Open('GET', 'https://www.example.com/install_check.php', false);
    WinHttpReq.Send();
    if WinHttpReq.Status = 200 then
    begin
      Log('Installation was allowed...');
      Result := True;
    end
      else
    begin
      Log(Format('Installation was not allowed with %d: %s...', [
        WinHttpReq.Status, WinHttpReq.StatusText]));
      MsgBox('Installation is not allowed.', mbError, MB_OK);      
    end;
  except
    Log(Format('Installation check failed: %s', [GetExceptionMessage]));
    MsgBox('Error checking if the installation is allowed.', mbError, MB_OK)
 end;
end;