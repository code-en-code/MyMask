unit company;

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
  TCompanyView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytName: TLayout;
    edtName: TEdit;
    lblName: TLabel;
    lblNameAlert: TLabel;
    lytAddress: TLayout;
    edtAddress: TEdit;
    lblAddress: TLabel;
    lblAddressAlert: TLabel;
    lytCity: TLayout;
    edtCity: TEdit;
    lblCity: TLabel;
    lblCityAlert: TLabel;
    lytUf: TLayout;
    edtUf: TEdit;
    lblUf: TLabel;
    lblUfAlert: TLabel;
    lytCnpj: TLayout;
    edtCnpj: TEdit;
    lblCnpj: TLabel;
    lblCnpjAlert: TLabel;
    lytIe: TLayout;
    edtIe: TEdit;
    lblIe: TLabel;
    lblIeAlert: TLabel;
    lytSuframa: TLayout;
    edtSuframa: TEdit;
    lblSuframa: TLabel;
    lblSuframaAlert: TLabel;
    lytPhone: TLayout;
    edtPhone: TEdit;
    lblPhone: TLabel;
    lblPhoneAlert: TLabel;
    lytHeaderControls: TLayout;
    btnBack: TButton;
    lblTitle: TLabel;
    lytHeaderProgress: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    rctBgHeader: TRectangle;
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
    procedure edtAddressEnter(Sender: TObject);
    procedure edtCityEnter(Sender: TObject);
    procedure edtUfEnter(Sender: TObject);
    procedure edtCnpjEnter(Sender: TObject);
    procedure edtIeEnter(Sender: TObject);
    procedure edtSuframaEnter(Sender: TObject);
    procedure edtPhoneEnter(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtAddressExit(Sender: TObject);
    procedure edtCityExit(Sender: TObject);
    procedure edtUfExit(Sender: TObject);
    procedure edtCnpjExit(Sender: TObject);
    procedure edtIeExit(Sender: TObject);
    procedure edtSuframaExit(Sender: TObject);
    procedure edtPhoneExit(Sender: TObject);
    procedure edtNameTyping(Sender: TObject);
    procedure edtAddressTyping(Sender: TObject);
    procedure edtCityTyping(Sender: TObject);
    procedure edtUfTyping(Sender: TObject);
    procedure edtCnpjTyping(Sender: TObject);
    procedure edtIeTyping(Sender: TObject);
    procedure edtSuframaTyping(Sender: TObject);
    procedure edtPhoneTyping(Sender: TObject);
    procedure edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtAddressKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPhoneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCnpjKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtIeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtSuframaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtNameChange(Sender: TObject);
    procedure edtAddressChange(Sender: TObject);
    procedure edtCityChange(Sender: TObject);
    procedure edtUfChange(Sender: TObject);
    procedure edtCnpjChange(Sender: TObject);
    procedure edtIeChange(Sender: TObject);
    procedure edtSuframaChange(Sender: TObject);
    procedure edtPhoneChange(Sender: TObject);
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
    procedure ValidateAddress(const AValue: TValid);
    procedure ValidateCity(const AValue: TValid);
    procedure ValidateUf(const AValue: TValid);
    procedure ValidateCnpj(const AValue: TValid);
    procedure ValidateIe(const AValue: TValid);
    procedure ValidateSuframa(const AValue: TValid);
    procedure ValidatePhone(const AValue: TValid);
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
  PAGE_INDEX = 5;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TCompanyView }

{$Region'Infra'}
constructor TCompanyView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCompanyView.Destroy;
begin

  inherited;
end;

procedure TCompanyView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.Company.OnValidateName := ValidateName;
  FEntity.Company.OnValidateAddress := ValidateAddress;
  FEntity.Company.OnValidateCity := ValidateCity;
  FEntity.Company.OnValidateUf := ValidateUf;
  FEntity.Company.OnValidateCnpj := ValidateCnpj;
  FEntity.Company.OnValidateIe := ValidateIe;
  FEntity.Company.OnValidateSuframa := ValidateSuframa;
  FEntity.Company.OnValidatePhone := ValidatePhone;
end;

procedure TCompanyView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TCompanyView.Shows(AContainer: TFmxObject);
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

procedure TCompanyView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TCompanyView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TCompanyView.DestroyPrevPage;
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

procedure TCompanyView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TCompanyView.EnabledControls;
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

procedure TCompanyView.DefaultSettingsInControls;
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

procedure TCompanyView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TCompanyView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TCompanyView.AdjustScroll(AControl: TControl);
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

function TCompanyView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TCompanyView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TCompanyView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TCompanyView.HideKeyboard;
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
procedure TCompanyView.LoadData;
begin
  edtName.Text := FEntity.Company.Name;
  edtAddress.Text := FEntity.Company.Address;
  edtCity.Text := FEntity.Company.City;
  edtUf.Text := FEntity.Company.UF;
  edtCnpj.Text := FEntity.Company.CNPJ;
  TMyMask.ApplyMask(edtCnpj, TMyType.CnpjMask);
  edtIe.Text := FEntity.Company.IE;
  TMyMask.ApplyMask(edtIe, TMyType.IeMask(edtIe.Text, edtUf.Text, False));
  edtSuframa.Text := FEntity.Company.Suframa;
  edtPhone.Text := FEntity.Company.Phone;
  if FEntity.Company.Phone.Length <= 10 then
    TMyMask.ApplyMask(edtPhone, TMyType.TelephoneMask)
  else
    TMyMask.ApplyMask(edtPhone, TMyType.CellPhoneMask);
end;
{$EndRegion}

{$Region'Validate'}
function TCompanyView.IsValid: Boolean;
var
  LValidName: Boolean;
  LValidAddress: Boolean;
  LValidCity: Boolean;
  LValidUf: Boolean;
  LValidCnpj: Boolean;
  LValidIe: Boolean;
  LValidSuframa: Boolean;
  LValidPhone: Boolean;
begin
  LValidName := FEntity.Company.IsValidName;
  LValidAddress := FEntity.Company.IsValidAddress;
  LValidCity := FEntity.Company.IsValidCity;
  LValidUf := FEntity.Company.IsValidUf;
  LValidCnpj := FEntity.Company.IsValidCnpj(False);
  LValidIe := FEntity.Company.IsValidIe(False);
  LValidSuframa := FEntity.Company.IsValidSuframa(False);
  LValidPhone := FEntity.Company.IsValidPhone(False);
  Result := LValidName and LValidAddress and LValidCity and LValidUf and
            LValidCnpj and LValidIe and LValidSuframa and LValidPhone;
end;

procedure TCompanyView.ValidateName(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNameAlert.Text := AValue.Msg
  else
    lblNameAlert.Text := '';
end;

procedure TCompanyView.ValidateAddress(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblAddressAlert.Text := AValue.Msg
  else
    lblAddressAlert.Text := '';
end;

procedure TCompanyView.ValidateCity(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCityAlert.Text := AValue.Msg
  else
    lblCityAlert.Text := '';
end;

procedure TCompanyView.ValidateUf(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblUfAlert.Text := AValue.Msg
  else
    lblUfAlert.Text := '';
end;

procedure TCompanyView.ValidateCnpj(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCnpjAlert.Text := AValue.Msg
  else
    lblCnpjAlert.Text := '';
end;

procedure TCompanyView.ValidateIe(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblIeAlert.Text := AValue.Msg
  else
    lblIeAlert.Text := '';
end;

procedure TCompanyView.ValidateSuframa(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblSuframaAlert.Text := AValue.Msg
  else
    lblSuframaAlert.Text := '';
end;

procedure TCompanyView.ValidatePhone(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblPhoneAlert.Text := AValue.Msg
  else
    lblPhoneAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TCompanyView.edtNameChange(Sender: TObject);
begin
  edtNameTyping(Sender);
end;

procedure TCompanyView.edtAddressChange(Sender: TObject);
begin
  edtAddressTyping(Sender);
end;

procedure TCompanyView.edtCityChange(Sender: TObject);
begin
  edtCityTyping(Sender);
end;

procedure TCompanyView.edtUfChange(Sender: TObject);
begin
  edtUfTyping(Sender);
end;

procedure TCompanyView.edtCnpjChange(Sender: TObject);
begin
  edtCnpjTyping(Sender);
end;

procedure TCompanyView.edtIeChange(Sender: TObject);
begin
  edtIeTyping(Sender);
end;

procedure TCompanyView.edtSuframaChange(Sender: TObject);
begin
  edtSuframaTyping(Sender);
end;

procedure TCompanyView.edtPhoneChange(Sender: TObject);
begin
  edtPhoneTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TCompanyView.edtNameEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtAddressEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtCityEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtUfEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtCnpjEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtIeEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtSuframaEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCompanyView.edtPhoneEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TCompanyView.edtNameExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidName;
end;

procedure TCompanyView.edtAddressExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidAddress;
end;

procedure TCompanyView.edtCityExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidCity;
end;

procedure TCompanyView.edtUfExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidUf;
end;

procedure TCompanyView.edtCnpjExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidCnpj;
end;

procedure TCompanyView.edtIeExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidIe;
end;

procedure TCompanyView.edtSuframaExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidSuframa;
end;

procedure TCompanyView.edtPhoneExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Company.IsValidPhone;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TCompanyView.edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtAddress), Key);
end;

procedure TCompanyView.edtAddressKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCity), Key);
end;

procedure TCompanyView.edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtUf), Key);
end;

procedure TCompanyView.edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCnpj), Key);
end;

procedure TCompanyView.edtCnpjKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtIe), Key);
end;

procedure TCompanyView.edtIeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtSuframa), Key);
end;

procedure TCompanyView.edtSuframaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtPhone), Key);
end;

procedure TCompanyView.edtPhoneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TCompanyView.edtNameTyping(Sender: TObject);
begin
  FEntity.Company.SetName(edtName.Text.Trim);
end;

procedure TCompanyView.edtAddressTyping(Sender: TObject);
begin
  FEntity.Company.SetAddress(edtAddress.Text.Trim);
end;

procedure TCompanyView.edtCityTyping(Sender: TObject);
begin
  FEntity.Company.SetCity(edtCity.Text.Trim);
end;

procedure TCompanyView.edtUfTyping(Sender: TObject);
begin
  FEntity.Company.SetUf(edtUf.Text.Trim);
end;

procedure TCompanyView.edtCnpjTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtCnpj, TMyType.CnpjMask);
  FEntity.Company.SetCnpj(TMyMask.RemoveMask(edtCnpj.Text.Trim));
end;

procedure TCompanyView.edtIeTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtIe, TMyType.IeMask(edtIe.Text, edtUf.Text, False));
  FEntity.Company.SetIe(TMyMask.RemoveMask(edtIe.Text.Trim));
end;

procedure TCompanyView.edtSuframaTyping(Sender: TObject);
begin
  FEntity.Company.SetSuframa(TMyMask.RemoveMask(edtSuframa.Text.Trim));
end;

procedure TCompanyView.edtPhoneTyping(Sender: TObject);
begin
  if TMyMask.RemoveMask(edtPhone.Text).Length <= 10 then
    TMyMask.ApplyMask(edtPhone, TMyType.TelephoneMask)
  else
    TMyMask.ApplyMask(edtPhone, TMyType.CellPhoneMask);
  edtPhone.MaxLength := 0;
  FEntity.Company.SetPhone(TMyMask.RemoveMask(edtPhone.Text.Trim));
end;
{$EndRegion}

{$Region'Button'}
procedure TCompanyView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TCompanyView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TCompanyView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TCompanyView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
