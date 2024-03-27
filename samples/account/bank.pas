unit bank;

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
  TBankView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytAccount: TLayout;
    edtAccount: TEdit;
    lblAccount: TLabel;
    lblAccountAlert: TLabel;
    lytAgency: TLayout;
    edtAgency: TEdit;
    lblAgency: TLabel;
    lblAgencyAlert: TLabel;
    lytBank: TLayout;
    edtBank: TEdit;
    lblBank: TLabel;
    lblBankAlert: TLabel;
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
    procedure edtAccountEnter(Sender: TObject);
    procedure edtAgencyEnter(Sender: TObject);
    procedure edtBankEnter(Sender: TObject);
    procedure edtCityEnter(Sender: TObject);
    procedure edtUfEnter(Sender: TObject);
    procedure edtAccountExit(Sender: TObject);
    procedure edtAgencyExit(Sender: TObject);
    procedure edtBankExit(Sender: TObject);
    procedure edtCityExit(Sender: TObject);
    procedure edtUfExit(Sender: TObject);
    procedure edtAccountTyping(Sender: TObject);
    procedure edtAgencyTyping(Sender: TObject);
    procedure edtBankTyping(Sender: TObject);
    procedure edtCityTyping(Sender: TObject);
    procedure edtUfTyping(Sender: TObject);
    procedure edtAccountKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtAgencyKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtBankKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtAccountChange(Sender: TObject);
    procedure edtAgencyChange(Sender: TObject);
    procedure edtBankChange(Sender: TObject);
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
    procedure ValidateAccount(const AValue: TValid);
    procedure ValidateAgency(const AValue: TValid);
    procedure ValidateBank(const AValue: TValid);
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
  PAGE_INDEX = 6;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TBankView }

{$Region'Infra'}
constructor TBankView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TBankView.Destroy;
begin

  inherited;
end;

procedure TBankView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.Bank.OnValidateAccount := ValidateAccount;
  FEntity.Bank.OnValidateAgency := ValidateAgency;
  FEntity.Bank.OnValidateBank := ValidateBank;
  FEntity.Bank.OnValidateCity := ValidateCity;
  FEntity.Bank.OnValidateUf := ValidateUf;
end;

procedure TBankView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TBankView.Shows(AContainer: TFmxObject);
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

procedure TBankView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TBankView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TBankView.DestroyPrevPage;
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

procedure TBankView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TBankView.EnabledControls;
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
      edtAccount.SetFocus;
    end)
  end).Start;
end;

procedure TBankView.DefaultSettingsInControls;
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

procedure TBankView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TBankView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TBankView.AdjustScroll(AControl: TControl);
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

function TBankView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TBankView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TBankView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TBankView.HideKeyboard;
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
procedure TBankView.LoadData;
begin
  edtAccount.Text := FEntity.Bank.Account;
  edtAgency.Text := FEntity.Bank.Agency;
  edtBank.Text := FEntity.Bank.Bank;
  edtCity.Text := FEntity.Bank.City;
  edtUf.Text := FEntity.Bank.UF;
end;
{$EndRegion}

{$Region'Validate'}
function TBankView.IsValid: Boolean;
var
  LValidAccount: Boolean;
  LValidAgency: Boolean;
  LValidBank: Boolean;
  LValidCity: Boolean;
  LValidUf: Boolean;
begin
  LValidAccount := FEntity.Bank.IsValidAccount;
  LValidAgency := FEntity.Bank.IsValidAgency;
  LValidBank := FEntity.Bank.IsValidBank;
  LValidCity := FEntity.Bank.IsValidCity;
  LValidUf := FEntity.Bank.IsValidUf;
  Result := LValidAccount and LValidAgency and LValidBank and
            LValidCity and LValidUf;
end;

procedure TBankView.ValidateAccount(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblAccountAlert.Text := AValue.Msg
  else
    lblAccountAlert.Text := '';
end;

procedure TBankView.ValidateAgency(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblAgencyAlert.Text := AValue.Msg
  else
    lblAgencyAlert.Text := '';
end;

procedure TBankView.ValidateBank(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblBankAlert.Text := AValue.Msg
  else
    lblBankAlert.Text := '';
end;

procedure TBankView.ValidateCity(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCityAlert.Text := AValue.Msg
  else
    lblCityAlert.Text := '';
end;

procedure TBankView.ValidateUf(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblUfAlert.Text := AValue.Msg
  else
    lblUfAlert.Text := '';
end;
{$Endregion}

{$Region'Change'}
procedure TBankView.edtAccountChange(Sender: TObject);
begin
  edtAccountTyping(Sender);
end;

procedure TBankView.edtAgencyChange(Sender: TObject);
begin
  edtAgencyTyping(Sender);
end;

procedure TBankView.edtBankChange(Sender: TObject);
begin
  edtBankTyping(Sender);
end;

procedure TBankView.edtCityChange(Sender: TObject);
begin
  edtCityTyping(Sender);
end;

procedure TBankView.edtUfChange(Sender: TObject);
begin
  edtUfTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TBankView.edtAccountEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TBankView.edtAgencyEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TBankView.edtBankEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TBankView.edtCityEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TBankView.edtUfEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TBankView.edtAccountExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Bank.IsValidAccount;
end;

procedure TBankView.edtAgencyExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Bank.IsValidAgency;
end;

procedure TBankView.edtBankExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Bank.IsValidBank;
end;

procedure TBankView.edtCityExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Bank.IsValidCity;
end;

procedure TBankView.edtUfExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Bank.IsValidUf;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TBankView.edtAccountKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtAgency), Key);
end;

procedure TBankView.edtAgencyKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtBank), Key);
end;

procedure TBankView.edtBankKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCity), Key);
end;

procedure TBankView.edtCityKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtUf), Key);
end;

procedure TBankView.edtUfKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TBankView.edtAccountTyping(Sender: TObject);
begin
  FEntity.Bank.SetAccount(edtAccount.Text.Trim);
end;

procedure TBankView.edtAgencyTyping(Sender: TObject);
begin
  FEntity.Bank.SetAgency(edtAgency.Text.Trim);
end;

procedure TBankView.edtBankTyping(Sender: TObject);
begin
  FEntity.Bank.SetBank(edtBank.Text.Trim);
end;

procedure TBankView.edtCityTyping(Sender: TObject);
begin
  FEntity.Bank.SetCity(edtCity.Text.Trim);
end;

procedure TBankView.edtUfTyping(Sender: TObject);
begin
  FEntity.Bank.SetUf(edtUf.Text.Trim);
end;
{$EndRegion}

{$Region'Button'}
procedure TBankView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TBankView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TBankView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TBankView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
