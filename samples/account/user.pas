unit user;

interface

uses
  //delphi
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  //fmx
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.Edit,
  FMX.VirtualKeyboard,
  FMX.Platform,
  FMX.Ani,
  FMX.Objects,

  //codeencode
  mytype,
  mymask,

  //entities
  entities;

type
  TUserView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    lytName: TLayout;
    edtName: TEdit;
    lblName: TLabel;
    lblNameAlert: TLabel;
    lytCpf: TLayout;
    edtCpf: TEdit;
    lblCpf: TLabel;
    lblCpfAlert: TLabel;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytCnh: TLayout;
    edtCnh: TEdit;
    lblCnh: TLabel;
    lblCnhAlert: TLabel;
    lblTitle: TLabel;
    btnBack: TButton;
    lytRg: TLayout;
    edtRg: TEdit;
    lblRg: TLabel;
    lblRgAlert: TLabel;
    lytPis: TLayout;
    edtPis: TEdit;
    lblPis: TLabel;
    lblPisAlert: TLabel;
    rctBgHeader: TRectangle;
    lytHeaderProgress: TLayout;
    lytHeaderControls: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    procedure edtCpfTyping(Sender: TObject);
    procedure edtPisTyping(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtNameTyping(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure edtPisExit(Sender: TObject);
    procedure edtCnhTyping(Sender: TObject);
    procedure edtCnhExit(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
    procedure edtCpfEnter(Sender: TObject);
    procedure edtPisEnter(Sender: TObject);
    procedure edtCnhEnter(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtRgEnter(Sender: TObject);
    procedure edtRgExit(Sender: TObject);
    procedure edtRgTyping(Sender: TObject);
    procedure edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCpfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtRgKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCnhKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPisKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtNameChange(Sender: TObject);
    procedure edtCpfChange(Sender: TObject);
    procedure edtRgChange(Sender: TObject);
    procedure edtCnhChange(Sender: TObject);
    procedure edtPisChange(Sender: TObject);
  private
    { Private declarations }
    FEntity: TEntity;
    FKeyBounds: TRect;
    FCurrentProgress: Single;
    FOnDestroyPrevPage: TNotifyEvent;
    FOnBack: TNotifyEvent;
    FOnNext: TNotifyEvent;

    procedure SetEntity(const Value: TEntity);
    procedure SetKeyBounds(const Value: TRect);
    procedure EmbedIn(AContainer: TFmxObject);
    procedure EntityExists;
    procedure DestroyPrevPage;
    procedure DisableControls;
    procedure EnabledControls;
    procedure DefaultSettingsInControls;
    procedure LoadData;
    procedure ClearAnimations;
    procedure RunAnimations;
    procedure AdjustScroll(AControl: TControl);
    function ShowsMoreThreeFields(AControl: TControl): Boolean;
    procedure FooterMarginKeyboard;
    procedure FooterMarginDefault;
    procedure HideKeyboard;

    function IsValid: Boolean;
    procedure ValidateName(const AValue: TValid);
    procedure ValidateCpf(const AValue: TValid);
    procedure ValidateCnh(const AValue: TValid);
    procedure ValidatePis(const AValue: TValid);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Shows(AContainer: TFmxObject);

    property Entity: TEntity read FEntity write SetEntity;
    property KeyBounds: TRect read FKeyBounds write SetKeyBounds;
    property CurrentProgress: Single read FCurrentProgress write FCurrentProgress;
    property OnDestroyPrevPage: TNotifyEvent read FOnDestroyPrevPage write FOnDestroyPrevPage;
    property OnBack: TNotifyEvent read FOnBack write FOnBack;
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
  end;

const
  TOTAL_PAGES = 9;
  PAGE_INDEX = 1;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TUserView }

{$Region'Infra'}
constructor TUserView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TUserView.Destroy;
begin

  inherited;
end;

procedure TUserView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.User.OnValidateName := ValidateName;
  FEntity.User.OnValidateCpf := ValidateCpf;
  FEntity.User.OnValidateCnh := ValidateCnh;
  FEntity.User.OnValidatePis := ValidatePis;
end;

procedure TUserView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TUserView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  DefaultSettingsInControls;
  LoadData;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
end;

procedure TUserView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TUserView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TUserView.DestroyPrevPage;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(1);
    TThread.Synchronize(nil,
    procedure
    begin
      if Assigned(FOnDestroyPrevPage) then
        FOnDestroyPrevPage(nil);
    end)
  end).Start;
end;

procedure TUserView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TUserView.EnabledControls;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(1000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lytHeader.Enabled := True;
      vsbBody.Enabled := True;
      lytFooter.Enabled := True;
      edtName.SetFocus;
    end)
  end).Start;
end;

procedure TUserView.DefaultSettingsInControls;
begin
  {$IFDEF MSWINDOWS}
    btnNext.CanFocus := True;
    btnNext.TabStop := True;
    btnBack.CanFocus := True;
    btnBack.TabStop := True;
  {$ELSE}
    btnNext.CanFocus := False;
    btnNext.TabStop := False;
    btnBack.CanFocus := False;
    btnBack.TabStop := False;
  {$ENDIF}
end;

procedure TUserView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TUserView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TUserView.AdjustScroll(AControl: TControl);
var
  LHeightOneField: Single;
begin
  FooterMarginKeyboard;
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  if ShowsMoreThreeFields(AControl) then //display >= 3 fields
    vsbBody.ViewportPosition := PointF(vsbBody.ViewportPosition.X, AControl.Position.Y - LHeightOneField)
  else //display < 3 fields
    vsbBody.ViewportPosition := PointF(vsbBody.ViewportPosition.X, AControl.Position.Y);
end;

function TUserView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TUserView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TUserView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TUserView.HideKeyboard;
var
  Keyboard: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, Keyboard) then
  begin
    if TVirtualKeyBoardState.Visible in Keyboard.GetVirtualKeyBoardState then
      Keyboard.HideVirtualKeyboard;
  end;
end;
{$EndRegion}

{$Region'LoadData'}
procedure TUserView.LoadData;
begin
  edtName.Text := FEntity.User.Name;
  edtCpf.Text := FEntity.User.CPF;
  TMyMask.ApplyMask(edtCpf, TMyType.CpfMask);
  edtRg.Text := FEntity.User.RG;
  edtCnh.Text := FEntity.User.CNH;
  TMyMask.ApplyMask(edtCnh, TMyType.CnhMask);
  edtPis.Text := FEntity.User.PIS;
  TMyMask.ApplyMask(edtPis, TMyType.PisMask);
end;
{$EndRegion}

{$Region'Validate'}
function TUserView.IsValid: Boolean;
var
  LValidName: Boolean;
  LValidCpf: Boolean;
  LValidCnh: Boolean;
  LValidPis: Boolean;
begin
  LValidName := FEntity.User.IsValidName;
  LValidCpf := FEntity.User.IsValidCpf(False);
  LValidCnh := FEntity.User.IsValidCnh(False);
  LValidPis := FEntity.User.IsValidPis(False);
  Result := LValidName and LValidCpf and LValidCnh and LValidPis;
end;

procedure TUserView.ValidateName(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNameAlert.Text := AValue.Msg
  else
    lblNameAlert.Text := '';
end;

procedure TUserView.ValidateCpf(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCpfAlert.Text := AValue.Msg
  else
    lblCpfAlert.Text := '';
end;

procedure TUserView.ValidateCnh(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCnhAlert.Text := AValue.Msg
  else
    lblCnhAlert.Text := '';
end;

procedure TUserView.ValidatePis(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblPisAlert.Text := AValue.Msg
  else
    lblPisAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TUserView.edtNameChange(Sender: TObject);
begin
  edtNameTyping(Sender);
end;

procedure TUserView.edtCpfChange(Sender: TObject);
begin
  edtCpfTyping(Sender);
end;

procedure TUserView.edtRgChange(Sender: TObject);
begin
  edtRgTyping(Sender);
end;

procedure TUserView.edtCnhChange(Sender: TObject);
begin
  edtCnhTyping(Sender);
end;

procedure TUserView.edtPisChange(Sender: TObject);
begin
  edtPisTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TUserView.edtNameEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TUserView.edtCpfEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TUserView.edtRgEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TUserView.edtCnhEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TUserView.edtPisEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TUserView.edtNameExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidName;
end;

procedure TUserView.edtCpfExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidCpf(False);
end;

procedure TUserView.edtRgExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.SetRg(edtRg.Text.Trim);
end;

procedure TUserView.edtCnhExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidCnh(False);
end;

procedure TUserView.edtPisExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidPis(False);
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TUserView.edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCpf), Key);
end;

procedure TUserView.edtCpfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtRg), Key);
end;

procedure TUserView.edtRgKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCnh), Key);
end;

procedure TUserView.edtCnhKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtPis), Key);
end;

procedure TUserView.edtPisKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TUserView.edtNameTyping(Sender: TObject);
begin
  FEntity.User.SetName(edtName.Text.Trim);
end;

procedure TUserView.edtCpfTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtCpf, TMyType.CpfMask);
  FEntity.User.SetCpf(TMyMask.RemoveMask(edtCpf.Text.Trim));
end;

procedure TUserView.edtRgTyping(Sender: TObject);
begin
  FEntity.User.SetRg(edtRg.Text.Trim);
end;

procedure TUserView.edtCnhTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtCnh, TMyType.CnhMask);
  FEntity.User.SetCnh(TMyMask.RemoveMask(edtCnh.Text.Trim));
end;

procedure TUserView.edtPisTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtPis, TMyType.PisMask);
  FEntity.User.SetPis(TMyMask.RemoveMask(edtPis.Text.Trim));
end;
{$EndRegion}

{$Region'Button'}
procedure TUserView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TUserView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TUserView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TUserView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
