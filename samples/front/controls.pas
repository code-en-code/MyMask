unit controls;

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
  FMX.ListBox,
  FMX.Ani,
  FMX.Objects,

  //codeencode
  mytype,
  mymask;

type
  TControlsView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lblTitle: TLabel;
    lytCnpj: TLayout;
    rdbCnpj: TRadioButton;
    lytCpf: TLayout;
    rdbCpf: TRadioButton;
    lytCpfCnpj: TLayout;
    rdbCpfCnpj: TRadioButton;
    lytIe: TLayout;
    rdbIe: TRadioButton;
    cmbUf: TComboBox;
    lytCep: TLayout;
    rdbCep: TRadioButton;
    lytTelephone: TLayout;
    rdbTelephone: TRadioButton;
    lytCellPhone: TLayout;
    rdbCellPhone: TRadioButton;
    lytTelephoneCellPhone: TLayout;
    rdbTelephoneCellPhone: TRadioButton;
    lytPis: TLayout;
    rdbPis: TRadioButton;
    lytCard: TLayout;
    rdbCard: TRadioButton;
    lytGtin: TLayout;
    lytRenavam: TLayout;
    lytCnh: TLayout;
    lytLicensePlate: TLayout;
    lytNcm: TLayout;
    lytCest: TLayout;
    lytDate: TLayout;
    lytInteger: TLayout;
    lytFloat: TLayout;
    lytCurrency: TLayout;
    lytCustom: TLayout;
    rdbGtin: TRadioButton;
    rdbRenavam: TRadioButton;
    rdbCnh: TRadioButton;
    rdbLicensePlate: TRadioButton;
    rdbNcm: TRadioButton;
    rdbCest: TRadioButton;
    rdbDate: TRadioButton;
    rdbInteger: TRadioButton;
    rdbFloat: TRadioButton;
    rdbCurrency: TRadioButton;
    rdbCustom: TRadioButton;
    edtCustom: TEdit;
    lytValidation: TLayout;
    lblValidation: TLabel;
    swtValidation: TSwitch;
    lytName: TLayout;
    edtName: TEdit;
    lblName: TLabel;
    lblNameAlert: TLabel;
    procedure edtNameExit(Sender: TObject);
    procedure edtNameTyping(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure lblNameClick(Sender: TObject);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure lblNameTap(Sender: TObject; const Point: TPointF);
    procedure edtNameChange(Sender: TObject);
    procedure rdbCnpjChange(Sender: TObject);
    procedure cmbUfMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure swtValidationSwitch(Sender: TObject);
    procedure edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rdbLicensePlateChange(Sender: TObject);
    procedure edtCustomEnter(Sender: TObject);
    procedure edtCustomExit(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
  private
    { Private declarations }
    FKeyBounds: TRect;
    FOnDestroyPrevPage: TNotifyEvent;

    procedure SetKeyBounds(const Value: TRect);
    procedure EmbedIn(AContainer: TFmxObject);
    procedure DestroyPrevPage;
    procedure DisableControls;
    procedure EnabledControls;
    procedure DefaultSettingsInControls;
    procedure ClearAnimations;
    procedure RunAnimations;
    procedure AdjustScroll(AControl: TControl);
    procedure FooterMarginKeyboard;
    procedure FooterMarginDefault;

    procedure DoCnpj;
    procedure DoCpf;
    procedure DoCpfOrCnpj;
    procedure DoIe;
    procedure DoCep;
    procedure DoTelephone;
    procedure DoCellPhone;
    procedure DoTelephoneOrCellPhone;
    procedure DoCard;
    procedure DoPis;
    procedure DoGtin;
    procedure DoRenavam;
    procedure DoCnh;
    procedure DoLicensePlate;
    procedure DoNcm;
    procedure DoCest;
    procedure DoDate;
    procedure DoInteger;
    procedure DoFloat;
    procedure DoCurrency;
    procedure DoCustom;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Shows(AContainer: TFmxObject);

    property KeyBounds: TRect read FKeyBounds write SetKeyBounds;
    property OnDestroyPrevPage: TNotifyEvent read FOnDestroyPrevPage write FOnDestroyPrevPage;
  end;

const
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TControlsView }

{$Region'Infra'}
constructor TControlsView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TControlsView.Destroy;
begin

  inherited;
end;

procedure TControlsView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TControlsView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  DefaultSettingsInControls;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
end;

procedure TControlsView.EmbedIn(AContainer: TFmxObject);
begin
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TControlsView.DestroyPrevPage;
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

procedure TControlsView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TControlsView.DefaultSettingsInControls;
begin
  {$IFDEF MSWINDOWS}
    btnNext.CanFocus := True;
    btnNext.TabStop := True;
  {$ELSE}
    btnNext.CanFocus := False;
    btnNext.TabStop := False;
  {$ENDIF}
  cmbUf.Visible := False;
  edtCustom.Visible := False;
end;

procedure TControlsView.EnabledControls;
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
    end)
  end).Start;
end;

procedure TControlsView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TControlsView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TControlsView.AdjustScroll(AControl: TControl);
begin
  vsbBody.ViewportPosition := PointF(vsbBody.ViewportPosition.X, AControl.Position.Y);
end;

procedure TControlsView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TControlsView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;
{$EndRegion}

{$Region'Do'}
procedure TControlsView.DoCnpj;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CnpjMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CnpjMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 14 then
      if not TMyType.IsCnpj(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoCpf;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CpfMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CpfMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 11 then
      if not TMyType.IsCpf(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoCpfOrCnpj;
begin
  if TMyMask.RemoveMask(edtName.Text).Length <= 11 then
    DoCpf
  else
    DoCnpj;
end;

procedure TControlsView.DoIe;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.IeMask(edtName.Text, cmbUf.Items[cmbUf.ItemIndex], False));
  TMyMask.ApplyMask(lblTitle, TMyType.IeMask(edtName.Text, cmbUf.Items[cmbUf.ItemIndex], False));
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length >= 8 then
      if not TMyType.IsIe(edtName.Text, cmbUf.Items[cmbUf.ItemIndex], LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoCep;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CepMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CepMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 8 then
      if not TMyType.IsCep(edtName.Text, LDescriptionErrors, '') then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoTelephone;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.TelephoneMask);
  TMyMask.ApplyMask(lblTitle, TMyType.TelephoneMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 10 then
      if not TMyType.IsTelephone(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoCellPhone;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CellPhoneMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CellPhoneMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 11 then
      if not TMyType.IsCellPhone(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoTelephoneOrCellPhone;
begin
  if TMyMask.RemoveMask(edtName.Text).Length <= 10 then
    DoTelephone
  else
    DoCellPhone;
end;

procedure TControlsView.DoCard;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CardMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CardMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 16 then
      if not TMyType.IsCard(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoPis;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.PisMask);
  TMyMask.ApplyMask(lblTitle, TMyType.PisMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 11 then
      if not TMyType.IsPis(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoGtin;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.GtinMask);
  TMyMask.ApplyMask(lblTitle, TMyType.GtinMask);
   lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length in [8, 12, 13, 14] then
      if not TMyType.IsGtin(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoRenavam;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.RenavamMask);
  TMyMask.ApplyMask(lblTitle, TMyType.RenavamMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 11 then
      if not TMyType.IsRenavam(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoCnh;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CnhMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CnhMask);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 11 then
      if not TMyType.IsCnh(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoLicensePlate;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text, True);
  TMyMask.ApplyMask(edtName, TMyType.LicensePlateMask, True);
  TMyMask.ApplyMask(lblTitle, TMyType.LicensePlateMask, True);
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 7 then
      if not TMyType.IsLicensePlate(edtName.Text, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoNcm;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.NcmMask);
  TMyMask.ApplyMask(lblTitle, TMyType.NcmMask);
end;

procedure TControlsView.DoCest;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.CestMask);
  TMyMask.ApplyMask(lblTitle, TMyType.CestMask);
end;

procedure TControlsView.DoDate;
var
  LDescriptionErrors: String;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, TMyType.ddmmyyyyMask('/'));
  TMyMask.ApplyMask(lblTitle, TMyType.ddmmyyyyMask('/'));
  lblNameAlert.Text := '';
  if swtValidation.IsChecked then
  begin
    if TMyMask.RemoveMask(edtName.Text).Length = 8 then
      if not TMyType.IsDate(edtName.Text, '/', TDateFormat.ddmmyyyy, LDescriptionErrors) then
        lblNameAlert.Text := LDescriptionErrors;
  end;
end;

procedure TControlsView.DoInteger;
begin
  lblTitle.Text := edtName.Text;
  TMyMask.ApplyInteger(edtName);
  TMyMask.ApplyInteger(lblTitle);
end;

procedure TControlsView.DoFloat;
begin
  lblTitle.Text := edtName.Text;
  TMyMask.ApplyFloat(edtName, 2);
  TMyMask.ApplyFloat(lblTitle, 2);
end;

procedure TControlsView.DoCurrency;
begin
  lblTitle.Text := edtName.Text;
  TMyMask.ApplyCurrency(edtName, 'R$', 2);
  TMyMask.ApplyCurrency(lblTitle, 'R$', 2);
end;

procedure TControlsView.DoCustom;
begin
  lblTitle.Text := TMyMask.RemoveMask(edtName.Text);
  TMyMask.ApplyMask(edtName, edtCustom.Text);
  TMyMask.ApplyMask(lblTitle, edtCustom.Text);
end;
{$EndRegion}

{$Region'Change'}
procedure TControlsView.swtValidationSwitch(Sender: TObject);
begin
  edtNameTyping(Sender);
end;

procedure TControlsView.edtNameChange(Sender: TObject);
begin
  edtNameTyping(Sender);
end;

procedure TControlsView.rdbCnpjChange(Sender: TObject);
begin
  edtName.Text := '';
  lblTitle.Text := 'MyMask';
  lblNameAlert.Text := '';
  edtName.KeyboardType := TVirtualKeyboardType.NumberPad;
  cmbUf.Visible := rdbIe.IsChecked;
  edtCustom.Visible := rdbCustom.IsChecked;
end;

procedure TControlsView.rdbLicensePlateChange(Sender: TObject);
begin
  rdbCnpjChange(Sender);
  edtName.KeyboardType := TVirtualKeyboardType.Default;
  cmbUf.Visible := rdbIe.IsChecked;
  edtCustom.Visible := rdbCustom.IsChecked;
end;
{$EndRegion}

{$Region'Click'}
procedure TControlsView.lblNameClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    lblNameTap(Sender, PointF(0,0));
  {$ENDIF}
end;
{$EndRegion}

{$Region'Enter'}
procedure TControlsView.edtNameEnter(Sender: TObject);
begin
  FooterMarginKeyboard;
end;

procedure TControlsView.edtCustomEnter(Sender: TObject);
begin
  FooterMarginKeyboard;
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TControlsView.edtNameExit(Sender: TObject);
begin
  FooterMarginDefault;
  edtNameTyping(Sender);
end;

procedure TControlsView.edtCustomExit(Sender: TObject);
begin
  FooterMarginDefault;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TControlsView.edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
end;
{$EndRegion}

{$Region'MouseWheel'}
procedure TControlsView.cmbUfMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  Abort;
end;
{$EndRegion}

{$Region'Typing'}
procedure TControlsView.edtNameTyping(Sender: TObject);
begin
  if rdbCnpj.IsChecked then
    DoCnpj
  else if rdbCpf.IsChecked then
    DoCpf
  else if rdbCpfCnpj.IsChecked then
    DoCpfOrCnpj
  else if rdbIe.IsChecked then
    DoIe
  else if rdbCep.IsChecked then
    DoCep
  else if rdbTelephone.IsChecked then
    DoTelephone
  else if rdbCellPhone.IsChecked then
    DoCellPhone
  else if rdbTelephoneCellPhone.IsChecked then
    DoTelephoneOrCellPhone
  else if rdbCard.IsChecked then
    DoCard
  else if rdbPis.IsChecked then
    DoPis
  else if rdbGtin.IsChecked then
    DoGtin
  else if rdbRenavam.IsChecked then
    DoRenavam
  else if rdbCnh.IsChecked then
    DoCnh
  else if rdbLicensePlate.IsChecked then
    DoLicensePlate
  else if rdbNcm.IsChecked then
    DoNcm
  else if rdbCest.IsChecked then
    DoCest
  else if rdbDate.IsChecked then
    DoDate
  else if rdbInteger.IsChecked then
    DoInteger
  else if rdbFloat.IsChecked then
    DoFloat
  else if rdbCurrency.IsChecked then
    DoCurrency
  else if rdbCustom.IsChecked then
    DoCustom;
end;
{$EndRegion}

{$Region'Tap'}
procedure TControlsView.lblNameTap(Sender: TObject; const Point: TPointF);
begin
  edtName.SetFocus;
end;
{$EndRegion}

{$Region'Button'}
procedure TControlsView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TControlsView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  edtNameTyping(Sender);
end;
{$EndRegion}

end.
