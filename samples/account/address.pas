unit address;

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
  TAddressView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytCep: TLayout;
    edtCep: TEdit;
    lblCep: TLabel;
    lblCepAlert: TLabel;
    lytAddress: TLayout;
    edtAddress: TEdit;
    lblAddress: TLabel;
    lblAddressAlert: TLabel;
    lytDistrict: TLayout;
    edtDistrict: TEdit;
    lblDistrict: TLabel;
    lblDistrictAlert: TLabel;
    lytNumber: TLayout;
    edtNumber: TEdit;
    lblNumber: TLabel;
    lblNumberAlert: TLabel;
    lytCity: TLayout;
    edtCity: TEdit;
    lblCity: TLabel;
    lblCityAlert: TLabel;
    lytUf: TLayout;
    edtUf: TEdit;
    lblUf: TLabel;
    lblUfAlert: TLabel;
    lytHeaderControls: TLayout;
    btnBack: TButton;
    lblTitle: TLabel;
    lytHeaderProgress: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    rctBgHeader: TRectangle;
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtCepEnter(Sender: TObject);
    procedure edtAddressEnter(Sender: TObject);
    procedure edtNumberEnter(Sender: TObject);
    procedure edtDistrictEnter(Sender: TObject);
    procedure edtCityEnter(Sender: TObject);
    procedure edtUfEnter(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure edtAddressExit(Sender: TObject);
    procedure edtNumberExit(Sender: TObject);
    procedure edtDistrictExit(Sender: TObject);
    procedure edtCityExit(Sender: TObject);
    procedure edtUfExit(Sender: TObject);
    procedure edtCepTyping(Sender: TObject);
    procedure edtAddressTyping(Sender: TObject);
    procedure edtNumberTyping(Sender: TObject);
    procedure edtDistrictTyping(Sender: TObject);
    procedure edtCityTyping(Sender: TObject);
    procedure edtUfTyping(Sender: TObject);
    procedure edtCepKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtAddressKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtNumberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtDistrictKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtCepChange(Sender: TObject);
    procedure edtAddressChange(Sender: TObject);
    procedure edtNumberChange(Sender: TObject);
    procedure edtDistrictChange(Sender: TObject);
    procedure edtCityChange(Sender: TObject);
    procedure edtUfChange(Sender: TObject);
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
    procedure ValidateCep(const AValue: TValid);
    procedure ValidateAddress(const AValue: TValid);
    procedure ValidateNumber(const AValue: TValid);
    procedure ValidateDistrict(const AValue: TValid);
    procedure ValidateCity(const AValue: TValid);
    procedure ValidateUf(const AValue: TValid);
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
  PAGE_INDEX = 4;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TAddressView }

{$Region'Infra'}
constructor TAddressView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAddressView.Destroy;
begin

  inherited;
end;

procedure TAddressView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.User.OnValidateCep := ValidateCep;
  FEntity.User.OnValidateAddress := ValidateAddress;
  FEntity.User.OnValidateNumber := ValidateNumber;
  FEntity.User.OnValidateDistrict := ValidateDistrict;
  FEntity.User.OnValidateCity := ValidateCity;
  FEntity.User.OnValidateUf := ValidateUf;
end;

procedure TAddressView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TAddressView.Shows(AContainer: TFmxObject);
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

procedure TAddressView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TAddressView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TAddressView.DestroyPrevPage;
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

procedure TAddressView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TAddressView.EnabledControls;
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
      edtCep.SetFocus;
    end)
  end).Start;
end;

procedure TAddressView.DefaultSettingsInControls;
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

procedure TAddressView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TAddressView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TAddressView.AdjustScroll(AControl: TControl);
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

function TAddressView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TAddressView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TAddressView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TAddressView.HideKeyboard;
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
procedure TAddressView.LoadData;
begin
  edtCep.Text := FEntity.User.CEP;
  TMyMask.ApplyMask(edtCep, TMyType.CepMask);
  edtAddress.Text := FEntity.User.Address;
  edtNumber.Text := FEntity.User.Number;
  edtDistrict.Text := FEntity.User.District;
  edtCity.Text := FEntity.User.City;
  edtUf.Text := FEntity.User.UF;
end;
{$EndRegion}

{$Region'Validate'}
function TAddressView.IsValid: Boolean;
var
  LValidCep: Boolean;
  LValidAddress: Boolean;
  LValidNumber: Boolean;
  LValidDistrict: Boolean;
  LValidCity: Boolean;
  LValidUf: Boolean;
begin
  LValidCep := FEntity.User.IsValidCep(False);
  LValidAddress := FEntity.User.IsValidAddress;
  LValidNumber := FEntity.User.IsValidNumber;
  LValidDistrict := FEntity.User.IsValidDistrict;
  LValidCity := FEntity.User.IsValidCity;
  LValidUf := FEntity.User.IsValidUf;
  Result := LValidCep and LValidAddress and LValidNumber and
            LValidDistrict and LValidCity and LValidUf;
end;

procedure TAddressView.ValidateCep(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCepAlert.Text := AValue.Msg
  else
    lblCepAlert.Text := '';
end;

procedure TAddressView.ValidateAddress(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblAddressAlert.Text := AValue.Msg
  else
    lblAddressAlert.Text := '';
end;

procedure TAddressView.ValidateNumber(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNumberAlert.Text := AValue.Msg
  else
    lblNumberAlert.Text := '';
end;

procedure TAddressView.ValidateDistrict(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblDistrictAlert.Text := AValue.Msg
  else
    lblDistrictAlert.Text := '';
end;

procedure TAddressView.ValidateCity(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCityAlert.Text := AValue.Msg
  else
    lblCityAlert.Text := '';
end;

procedure TAddressView.ValidateUf(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblUfAlert.Text := AValue.Msg
  else
    lblUfAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TAddressView.edtCepChange(Sender: TObject);
begin
  edtCepTyping(Sender);
end;

procedure TAddressView.edtAddressChange(Sender: TObject);
begin
  edtAddressTyping(Sender);
end;

procedure TAddressView.edtNumberChange(Sender: TObject);
begin
  edtNumberTyping(Sender);
end;

procedure TAddressView.edtDistrictChange(Sender: TObject);
begin
  edtDistrictTyping(Sender);
end;

procedure TAddressView.edtCityChange(Sender: TObject);
begin
  edtCityTyping(Sender);
end;

procedure TAddressView.edtUfChange(Sender: TObject);
begin
  edtUfTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TAddressView.edtCepEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TAddressView.edtAddressEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TAddressView.edtNumberEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TAddressView.edtDistrictEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TAddressView.edtCityEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TAddressView.edtUfEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TAddressView.edtCepExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidCep;
end;

procedure TAddressView.edtAddressExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidAddress;
end;

procedure TAddressView.edtNumberExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidNumber;
end;

procedure TAddressView.edtDistrictExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidDistrict;
end;

procedure TAddressView.edtCityExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidCity;
end;

procedure TAddressView.edtUfExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidUf;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TAddressView.edtCepKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtAddress), Key);
end;

procedure TAddressView.edtAddressKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtNumber), Key);
end;

procedure TAddressView.edtNumberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtDistrict), Key);
end;

procedure TAddressView.edtDistrictKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCity), Key);
end;

procedure TAddressView.edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtUf), Key);
end;

procedure TAddressView.edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TAddressView.edtCepTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtCep, TMyType.CepMask);
  FEntity.User.SetCep(TMyMask.RemoveMask(edtCep.Text.Trim));
end;

procedure TAddressView.edtAddressTyping(Sender: TObject);
begin
  FEntity.User.SetAddress(edtAddress.Text.Trim);
end;

procedure TAddressView.edtNumberTyping(Sender: TObject);
begin
  FEntity.User.SetNumber(edtNumber.Text.Trim);
end;

procedure TAddressView.edtDistrictTyping(Sender: TObject);
begin
  FEntity.User.SetDistrict(edtDistrict.Text.Trim);
end;

procedure TAddressView.edtCityTyping(Sender: TObject);
begin
  FEntity.User.SetCity(edtCity.Text.Trim);
end;

procedure TAddressView.edtUfTyping(Sender: TObject);
begin
  FEntity.User.SetUf(edtUf.Text.Trim);
end;
{$EndRegion}

{$Region'Button'}
procedure TAddressView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TAddressView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TAddressView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TAddressView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
