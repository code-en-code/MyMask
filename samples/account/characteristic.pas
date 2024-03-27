unit characteristic;

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
  TCharacteristicView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytGender: TLayout;
    lblGender: TLabel;
    lblGenderAlert: TLabel;
    rdbFemale: TRadioButton;
    rdbOther: TRadioButton;
    rdbMale: TRadioButton;
    lytBirthday: TLayout;
    lblBirthday: TLabel;
    lblBirthdayAlert: TLabel;
    lytHeight: TLayout;
    edtHeight: TEdit;
    lblHeight: TLabel;
    lblHeightAlert: TLabel;
    lytWeight: TLayout;
    edtWeight: TEdit;
    lblWeight: TLabel;
    lblWeightAlert: TLabel;
    edtBirthday: TEdit;
    lytHeaderControls: TLayout;
    btnBack: TButton;
    lblTitle: TLabel;
    lytHeaderProgress: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    rctBgHeader: TRectangle;
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtHeightEnter(Sender: TObject);
    procedure edtWeightEnter(Sender: TObject);
    procedure rdbFemaleExit(Sender: TObject);
    procedure rdbMaleExit(Sender: TObject);
    procedure rdbOtherExit(Sender: TObject);
    procedure edtHeightExit(Sender: TObject);
    procedure edtWeightExit(Sender: TObject);
    procedure rdbFemaleChange(Sender: TObject);
    procedure rdbMaleChange(Sender: TObject);
    procedure rdbOtherChange(Sender: TObject);
    procedure edtHeightTyping(Sender: TObject);
    procedure edtWeightTyping(Sender: TObject);
    procedure edtBirthdayTyping(Sender: TObject);
    procedure edtBirthdayEnter(Sender: TObject);
    procedure edtBirthdayExit(Sender: TObject);
    procedure edtHeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtBirthdayKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rdbFemaleKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rdbMaleKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rdbOtherKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtBirthdayChange(Sender: TObject);
    procedure edtHeightChange(Sender: TObject);
    procedure edtWeightChange(Sender: TObject);
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
    procedure ValidateGender(const AValue: TValid);
    procedure ValidateBirthday(const AValue: TValid);
    procedure ValidateHeight(const AValue: TValid);
    procedure ValidateWeight(const AValue: TValid);
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
  PAGE_INDEX = 3;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TCharacteristicView }

{$Region'Infra'}
constructor TCharacteristicView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCharacteristicView.Destroy;
begin

  inherited;
end;

procedure TCharacteristicView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.User.OnValidateGender := ValidateGender;
  FEntity.User.OnValidateBirthday := ValidateBirthday;
  FEntity.User.OnValidateHeight := ValidateHeight;
  FEntity.User.OnValidateWeight := ValidateWeight;
end;

procedure TCharacteristicView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TCharacteristicView.Shows(AContainer: TFmxObject);
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

procedure TCharacteristicView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TCharacteristicView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TCharacteristicView.DestroyPrevPage;
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

procedure TCharacteristicView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TCharacteristicView.EnabledControls;
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
      {$IFDEF MSWINDOWS}
        rdbFemale.SetFocus;
      {$ENDIF}
    end)
  end).Start;
end;

procedure TCharacteristicView.DefaultSettingsInControls;
begin
  {$IFDEF MSWINDOWS}
    btnNext.CanFocus := True;
    btnNext.TabStop := True;
    btnBack.CanFocus := True;
    btnBack.TabStop := True;
    lytGender.TabStop := True;
    lytGender.TabOrder := 0;
    lytBirthday.TabOrder := 1;
    lytHeight.TabOrder := 2;
    lytWeight.TabOrder := 3;
  {$ELSE}
    btnNext.CanFocus := False;
    btnNext.TabStop := False;
    btnBack.CanFocus := False;
    btnBack.TabStop := False;
    lytGender.TabStop := False;
    lytGender.TabOrder := -1;
    lytBirthday.TabOrder := 1;
    lytHeight.TabOrder := 2;
    lytWeight.TabOrder := 3;
  {$ENDIF}
end;

procedure TCharacteristicView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TCharacteristicView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TCharacteristicView.AdjustScroll(AControl: TControl);
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

function TCharacteristicView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TCharacteristicView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TCharacteristicView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TCharacteristicView.HideKeyboard;
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
procedure TCharacteristicView.LoadData;
begin
  case FEntity.User.Gender of
    gdNone:
      begin
        rdbFemale.IsChecked := False;
        rdbMale.IsChecked := False;
        rdbOther.IsChecked := False;
      end;
    gdFemale: rdbFemale.IsChecked := True;
    gdMale: rdbMale.IsChecked := True;
    gdOther: rdbOther.IsChecked := True;
  end;

  edtBirthday.Text := FEntity.User.BirthdayStr;
  TMyMask.ApplyMask(edtBirthday, TMyType.ddmmyyyyMask('/'));
  edtHeight.Text := FEntity.User.Height.ToString;
  TMyMask.ApplyFloat(edtHeight, DECIMAL_MEASURES);
  edtWeight.Text := FEntity.User.Weight.ToString;
  TMyMask.ApplyFloat(edtWeight, DECIMAL_WEIGHT);
end;
{$EndRegion}

{$Region'Validate'}
function TCharacteristicView.IsValid: Boolean;
var
  LValidGender: Boolean;
  LValidBirthday: Boolean;
  LValidHeight: Boolean;
  LValidWeight: Boolean;
begin
  LValidGender := FEntity.User.IsValidGender;
  LValidBirthday := FEntity.User.IsValidBirthday;
  LValidHeight := FEntity.User.IsValidHeight;
  LValidWeight := FEntity.User.IsValidWeight;
  Result := LValidGender and LValidBirthday and LValidHeight and LValidWeight;
end;

procedure TCharacteristicView.ValidateGender(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblGenderAlert.Text := AValue.Msg
  else
    lblGenderAlert.Text := '';
end;

procedure TCharacteristicView.ValidateBirthday(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblBirthdayAlert.Text := AValue.Msg
  else
    lblBirthdayAlert.Text := '';
end;

procedure TCharacteristicView.ValidateHeight(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblHeightAlert.Text := AValue.Msg
  else
    lblHeightAlert.Text := '';
end;

procedure TCharacteristicView.ValidateWeight(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblWeightAlert.Text := AValue.Msg
  else
    lblWeightAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TCharacteristicView.rdbFemaleChange(Sender: TObject);
begin
  FEntity.User.SetGender(TGender.gdFemale);
end;

procedure TCharacteristicView.rdbMaleChange(Sender: TObject);
begin
  FEntity.User.SetGender(TGender.gdMale);
end;

procedure TCharacteristicView.rdbOtherChange(Sender: TObject);
begin
  FEntity.User.SetGender(TGender.gdOther);
end;

procedure TCharacteristicView.edtBirthdayChange(Sender: TObject);
begin
  edtBirthdayTyping(Sender);
end;

procedure TCharacteristicView.edtHeightChange(Sender: TObject);
begin
  edtHeightTyping(Sender);
end;

procedure TCharacteristicView.edtWeightChange(Sender: TObject);
begin
  edtWeightTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TCharacteristicView.edtBirthdayEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCharacteristicView.edtHeightEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TCharacteristicView.edtWeightEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TCharacteristicView.rdbFemaleExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidGender;
end;

procedure TCharacteristicView.rdbMaleExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidGender;
end;

procedure TCharacteristicView.rdbOtherExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidGender;
end;

procedure TCharacteristicView.edtBirthdayExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidBirthday;
end;

procedure TCharacteristicView.edtHeightExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidHeight;
end;

procedure TCharacteristicView.edtWeightExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.User.IsValidWeight;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TCharacteristicView.rdbFemaleKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key in [vkReturn, vkTab] then
    rdbMale.SetFocus;
end;

procedure TCharacteristicView.rdbMaleKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key in [vkReturn, vkTab] then
    rdbOther.SetFocus;
end;

procedure TCharacteristicView.rdbOtherKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key in [vkReturn, vkTab] then
    edtBirthday.SetFocus;
end;

procedure TCharacteristicView.edtBirthdayKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtHeight), Key);
end;

procedure TCharacteristicView.edtHeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtWeight), Key);
end;

procedure TCharacteristicView.edtWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TCharacteristicView.edtBirthdayTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtBirthday, TMyType.ddmmyyyyMask('/'));
  FEntity.User.SetBirthday(edtBirthday.Text.Trim);
end;

procedure TCharacteristicView.edtHeightTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtHeight, DECIMAL_MEASURES);
  FEntity.User.SetHeight(TMyMask.ControlToFloat(edtHeight));
end;

procedure TCharacteristicView.edtWeightTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtWeight, DECIMAL_WEIGHT);
  FEntity.User.SetWeight(TMyMask.ControlToFloat(edtWeight));
end;
{$EndRegion}

{$Region'Button'}
procedure TCharacteristicView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TCharacteristicView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TCharacteristicView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TCharacteristicView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
