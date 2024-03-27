unit payment;

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
  TPaymentView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytNumber: TLayout;
    edtNumber: TEdit;
    lblNumber: TLabel;
    lblNumberAlert: TLabel;
    lytExpirationDate: TLayout;
    edtExpirationDate: TEdit;
    lblExpirationDate: TLabel;
    lblExpirationDateAlert: TLabel;
    lytCode: TLayout;
    edtCode: TEdit;
    lblCode: TLabel;
    lblCodeAlert: TLabel;
    lytName: TLayout;
    edtName: TEdit;
    lblName: TLabel;
    lblNameAlert: TLabel;
    lytHeaderControls: TLayout;
    btnBack: TButton;
    lblTitle: TLabel;
    lytHeaderProgress: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    rctBgHeader: TRectangle;
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtNumberEnter(Sender: TObject);
    procedure edtExpirationDateEnter(Sender: TObject);
    procedure edtCodeEnter(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
    procedure edtNumberExit(Sender: TObject);
    procedure edtExpirationDateExit(Sender: TObject);
    procedure edtCodeExit(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtNumberTyping(Sender: TObject);
    procedure edtExpirationDateTyping(Sender: TObject);
    procedure edtCodeTyping(Sender: TObject);
    procedure edtNameTyping(Sender: TObject);
    procedure edtNumberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtExpirationDateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCodeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtNumberChange(Sender: TObject);
    procedure edtExpirationDateChange(Sender: TObject);
    procedure edtCodeChange(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
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
    procedure ValidateNumber(const AValue: TValid);
    procedure ValidateExpirationDate(const AValue: TValid);
    procedure ValidateCode(const AValue: TValid);
    procedure ValidateName(const AValue: TValid);
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
  PAGE_INDEX = 7;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TPaymentView }

{$Region'Infra'}
constructor TPaymentView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPaymentView.Destroy;
begin

  inherited;
end;

procedure TPaymentView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.Payment.OnValidateNumber := ValidateNumber;
  FEntity.Payment.OnValidateExpirationDate := ValidateExpirationDate;
  FEntity.Payment.OnValidateCode := ValidateCode;
  FEntity.Payment.OnValidateName := ValidateName;
end;

procedure TPaymentView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TPaymentView.Shows(AContainer: TFmxObject);
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

procedure TPaymentView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TPaymentView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TPaymentView.DestroyPrevPage;
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

procedure TPaymentView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TPaymentView.EnabledControls;
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
      edtNumber.SetFocus;
    end)
  end).Start;
end;

procedure TPaymentView.DefaultSettingsInControls;
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

procedure TPaymentView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TPaymentView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TPaymentView.AdjustScroll(AControl: TControl);
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

function TPaymentView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TPaymentView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TPaymentView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TPaymentView.HideKeyboard;
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
procedure TPaymentView.LoadData;
begin
  edtNumber.Text := FEntity.Payment.Number;
  TMyMask.ApplyMask(edtNumber, TMyType.CardMask);
  edtExpirationDate.Text := FEntity.Payment.ExpirationDate;
  edtCode.Text := FEntity.Payment.Code;
  edtName.Text := FEntity.Payment.Name;
end;
{$EndRegion}

{$Region'Validate'}
function TPaymentView.IsValid: Boolean;
var
  LValidNumber: Boolean;
  LValidExpirationDate: Boolean;
  LValidCode: Boolean;
  LValidName: Boolean;
begin
  LValidNumber := FEntity.Payment.IsValidNumber(False);
  LValidExpirationDate := FEntity.Payment.IsValidExpirationDate(False);
  LValidCode := FEntity.Payment.IsValidCode;
  LValidName := FEntity.Payment.IsValidName;
  Result := LValidNumber and LValidExpirationDate and LValidCode and LValidName;
end;

procedure TPaymentView.ValidateNumber(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNumberAlert.Text := AValue.Msg
  else
    lblNumberAlert.Text := '';
end;

procedure TPaymentView.ValidateExpirationDate(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblExpirationDateAlert.Text := AValue.Msg
  else
    lblExpirationDateAlert.Text := '';
end;

procedure TPaymentView.ValidateCode(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCodeAlert.Text := AValue.Msg
  else
    lblCodeAlert.Text := '';
end;

procedure TPaymentView.ValidateName(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNameAlert.Text := AValue.Msg
  else
    lblNameAlert.Text := '';
end;
{$Endregion}

{$Region'Change'}
procedure TPaymentView.edtNumberChange(Sender: TObject);
begin
  edtNumberTyping(Sender);
end;

procedure TPaymentView.edtExpirationDateChange(Sender: TObject);
begin
  edtExpirationDateTyping(Sender);
end;

procedure TPaymentView.edtCodeChange(Sender: TObject);
begin
  edtCodeTyping(Sender);
end;

procedure TPaymentView.edtNameChange(Sender: TObject);
begin
  edtNameTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TPaymentView.edtNumberEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TPaymentView.edtExpirationDateEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TPaymentView.edtCodeEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TPaymentView.edtNameEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TPaymentView.edtNumberExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Payment.IsValidNumber(False);
end;

procedure TPaymentView.edtExpirationDateExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Payment.IsValidExpirationDate(False);
end;

procedure TPaymentView.edtCodeExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Payment.IsValidCode;
end;

procedure TPaymentView.edtNameExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Payment.IsValidName;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TPaymentView.edtNumberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtExpirationDate), Key);
end;

procedure TPaymentView.edtExpirationDateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCode), Key);
end;

procedure TPaymentView.edtCodeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtName), Key);
end;

procedure TPaymentView.edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TPaymentView.edtNumberTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtNumber, TMyType.CardMask);
  FEntity.Payment.SetNumber(TMyMask.RemoveMask(edtNumber.Text.Trim));
end;

procedure TPaymentView.edtExpirationDateTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtExpirationDate, '##/##');
  FEntity.Payment.SetExpirationDate(TMyMask.RemoveMask(edtExpirationDate.Text.Trim));
end;

procedure TPaymentView.edtCodeTyping(Sender: TObject);
begin
  FEntity.Payment.SetCode(edtCode.Text.Trim);
end;

procedure TPaymentView.edtNameTyping(Sender: TObject);
begin
  FEntity.Payment.SetName(edtName.Text.Trim);
end;
{$EndRegion}

{$Region'Button'}
procedure TPaymentView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TPaymentView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TPaymentView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TPaymentView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
