unit contact;

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
  TContactView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytEmail: TLayout;
    edtEmail: TEdit;
    lblEmail: TLabel;
    lblEmailAlert: TLabel;
    lytWhatsapp: TLayout;
    edtWhatsapp: TEdit;
    lblWhatsapp: TLabel;
    lblWhatsappAlert: TLabel;
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
    procedure edtEmailEnter(Sender: TObject);
    procedure edtWhatsappEnter(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure edtWhatsappExit(Sender: TObject);
    procedure edtEmailTyping(Sender: TObject);
    procedure edtPhoneTyping(Sender: TObject);
    procedure edtPhoneEnter(Sender: TObject);
    procedure edtPhoneExit(Sender: TObject);
    procedure edtWhatsappTyping(Sender: TObject);
    procedure edtEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtWhatsappKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPhoneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtEmailChange(Sender: TObject);
    procedure edtWhatsappChange(Sender: TObject);
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
    procedure ValidateEmail(const AValue: TValid);
    procedure ValidateWhatsapp(const AValue: TValid);
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
  PAGE_INDEX = 2;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TContactView }

{$Region'Infra'}
constructor TContactView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TContactView.Destroy;
begin

  inherited;
end;

procedure TContactView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.User.OnValidateEmail := ValidateEmail;
  FEntity.User.OnValidateWhatsapp := ValidateWhatsapp;
  FEntity.User.OnValidatePhone := ValidatePhone;
end;

procedure TContactView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TContactView.Shows(AContainer: TFmxObject);
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

procedure TContactView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TContactView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TContactView.DestroyPrevPage;
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

procedure TContactView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TContactView.EnabledControls;
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
      edtEmail.SetFocus;
    end)
  end).Start;
end;

procedure TContactView.DefaultSettingsInControls;
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

procedure TContactView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TContactView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TContactView.AdjustScroll(AControl: TControl);
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

function TContactView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TContactView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TContactView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TContactView.HideKeyboard;
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
procedure TContactView.LoadData;
begin
  edtEmail.Text := FEntity.User.Email;
  edtWhatsapp.Text := FEntity.User.Whatsapp;
  TMyMask.ApplyMask(edtWhatsapp, TMyType.CellPhoneMask);
  edtPhone.Text := FEntity.User.Phone;
  if FEntity.User.Phone.Length <= 10 then
    TMyMask.ApplyMask(edtPhone, TMyType.TelephoneMask)
  else
    TMyMask.ApplyMask(edtPhone, TMyType.CellPhoneMask);
end;
{$EndRegion}

{$Region'Validate'}
function TContactView.IsValid: Boolean;
var
  LValidEmail: Boolean;
  LValidWhatsapp: Boolean;
  LValidPhone: Boolean;
begin
  LValidEmail := FEntity.User.IsValidEmail(False);
  LValidWhatsapp := FEntity.User.IsValidWhatsapp(False);
  LValidPhone := FEntity.User.IsValidPhone(False);
  Result := LValidEmail and LValidWhatsapp and LValidPhone;
end;

procedure TContactView.ValidateEmail(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblEmailAlert.Text := AValue.Msg
  else
    lblEmailAlert.Text := '';
end;

procedure TContactView.ValidateWhatsapp(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblWhatsappAlert.Text := AValue.Msg
  else
    lblWhatsappAlert.Text := '';
end;

procedure TContactView.ValidatePhone(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblPhoneAlert.Text := AValue.Msg
  else
    lblPhoneAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TContactView.edtEmailChange(Sender: TObject);
begin
  edtEmailTyping(Sender);
end;

procedure TContactView.edtWhatsappChange(Sender: TObject);
begin
  edtWhatsappTyping(Sender);
end;

procedure TContactView.edtPhoneChange(Sender: TObject);
begin
  edtPhoneTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TContactView.edtEmailEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TContactView.edtWhatsappEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TContactView.edtPhoneEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TContactView.edtEmailExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidEmail;
end;

procedure TContactView.edtWhatsappExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidWhatsapp;
end;

procedure TContactView.edtPhoneExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidPhone;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TContactView.edtEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtWhatsapp), Key);
end;

procedure TContactView.edtWhatsappKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtPhone), Key);
end;

procedure TContactView.edtPhoneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TContactView.edtEmailTyping(Sender: TObject);
begin
  FEntity.User.SetEmail(edtEmail.Text.Trim);
end;

procedure TContactView.edtWhatsappTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtWhatsapp, TMyType.CellPhoneMask);
  FEntity.User.SetWhatsapp(TMyMask.RemoveMask(edtWhatsapp.Text.Trim));
end;

procedure TContactView.edtPhoneTyping(Sender: TObject);
begin
  if TMyMask.RemoveMask(edtPhone.Text).Length <= 10 then
    TMyMask.ApplyMask(edtPhone, TMyType.TelephoneMask)
  else
    TMyMask.ApplyMask(edtPhone, TMyType.CellPhoneMask);
  edtPhone.MaxLength := 0;
  FEntity.User.SetPhone(TMyMask.RemoveMask(edtPhone.Text.Trim));
end;
{$EndRegion}

{$Region'Button'}
procedure TContactView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TContactView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TContactView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TContactView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
