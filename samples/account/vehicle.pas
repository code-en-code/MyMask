unit vehicle;

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
  mystring,

  //entities
  entities;

type
  TVehicleView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytBrand: TLayout;
    edtBrand: TEdit;
    lblBrand: TLabel;
    lblBrandAlert: TLabel;
    lytModel: TLayout;
    edtModel: TEdit;
    lblModel: TLabel;
    lblModelAlert: TLabel;
    lytYear: TLayout;
    edtYear: TEdit;
    lblYear: TLabel;
    lblYearAlert: TLabel;
    lytRenavam: TLayout;
    edtRenavam: TEdit;
    lblRenavam: TLabel;
    lblRenavamAlert: TLabel;
    lytLicensePlate: TLayout;
    edtLicensePlate: TEdit;
    lblLicensePlate: TLabel;
    lblLicensePlateAlert: TLabel;
    lytColor: TLayout;
    edtColor: TEdit;
    lblColor: TLabel;
    lblColorAlert: TLabel;
    lytHeaderControls: TLayout;
    btnBack: TButton;
    lblTitle: TLabel;
    lytHeaderProgress: TLayout;
    rctBgProgress: TRectangle;
    rctProgress: TRectangle;
    rctBgHeader: TRectangle;
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtBrandEnter(Sender: TObject);
    procedure edtModelEnter(Sender: TObject);
    procedure edtYearEnter(Sender: TObject);
    procedure edtRenavamEnter(Sender: TObject);
    procedure edtLicensePlateEnter(Sender: TObject);
    procedure edtColorEnter(Sender: TObject);
    procedure edtBrandExit(Sender: TObject);
    procedure edtModelExit(Sender: TObject);
    procedure edtYearExit(Sender: TObject);
    procedure edtRenavamExit(Sender: TObject);
    procedure edtLicensePlateExit(Sender: TObject);
    procedure edtColorExit(Sender: TObject);
    procedure edtBrandTyping(Sender: TObject);
    procedure edtModelTyping(Sender: TObject);
    procedure edtYearTyping(Sender: TObject);
    procedure edtRenavamTyping(Sender: TObject);
    procedure edtColorTyping(Sender: TObject);
    procedure edtLicensePlateTyping(Sender: TObject);
    procedure edtBrandKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtModelKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtYearKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtRenavamKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtLicensePlateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtColorKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtBrandChange(Sender: TObject);
    procedure edtModelChange(Sender: TObject);
    procedure edtYearChange(Sender: TObject);
    procedure edtRenavamChange(Sender: TObject);
    procedure edtLicensePlateChange(Sender: TObject);
    procedure edtColorChange(Sender: TObject);
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
    procedure ValidateBrand(const AValue: TValid);
    procedure ValidateModel(const AValue: TValid);
    procedure ValidateYear(const AValue: TValid);
    procedure ValidateRenavam(const AValue: TValid);
    procedure ValidateLicensePlate(const AValue: TValid);
    procedure ValidateColor(const AValue: TValid);
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
  PAGE_INDEX = 8;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TVehicleView }

{$Region'Infra'}
constructor TVehicleView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TVehicleView.Destroy;
begin

  inherited;
end;

procedure TVehicleView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.Vehicle.OnValidateBrand := ValidateBrand;
  FEntity.Vehicle.OnValidateModel := ValidateModel;
  FEntity.Vehicle.OnValidateYear := ValidateYear;
  FEntity.Vehicle.OnValidateRenavam := ValidateRenavam;
  FEntity.Vehicle.OnValidateLicensePlate := ValidateLicensePlate;
  FEntity.Vehicle.OnValidateColor := ValidateColor;
end;

procedure TVehicleView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TVehicleView.Shows(AContainer: TFmxObject);
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

procedure TVehicleView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TVehicleView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TVehicleView.DestroyPrevPage;
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

procedure TVehicleView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TVehicleView.EnabledControls;
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
      edtBrand.SetFocus;
    end)
  end).Start;
end;

procedure TVehicleView.DefaultSettingsInControls;
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

procedure TVehicleView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TVehicleView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TVehicleView.AdjustScroll(AControl: TControl);
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

function TVehicleView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TVehicleView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TVehicleView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TVehicleView.HideKeyboard;
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
procedure TVehicleView.LoadData;
begin
  edtBrand.Text := FEntity.Vehicle.Brand;
  edtModel.Text := FEntity.Vehicle.Model;
  edtYear.Text := FEntity.Vehicle.Year;
  edtRenavam.Text := FEntity.Vehicle.Renavam;
  TMyMask.ApplyMask(edtRenavam, TMyType.RenavamMask);
  edtLicensePlate.Text := FEntity.Vehicle.LicensePlate;
  TMyMask.ApplyMask(edtLicensePlate, TMyType.LicensePlateMask, True);
  edtColor.Text := FEntity.Vehicle.Color;
end;
{$EndRegion}

{$Region'Validate'}
function TVehicleView.IsValid: Boolean;
var
  LValidBrand: Boolean;
  LValidModel: Boolean;
  LValidYear: Boolean;
  LValidRenavam: Boolean;
  LValidLicensePlate: Boolean;
  LValidColor: Boolean;
begin
  LValidBrand := FEntity.Vehicle.IsValidBrand;
  LValidModel := FEntity.Vehicle.IsValidModel;
  LValidYear := FEntity.Vehicle.IsValidYear(False);
  LValidRenavam := FEntity.Vehicle.IsValidRenavam(False);
  LValidLicensePlate := FEntity.Vehicle.IsValidLicensePlate(False);
  LValidColor := FEntity.Vehicle.IsValidColor;
  Result := LValidBrand and LValidModel and LValidYear and
            LValidRenavam and LValidLicensePlate and LValidColor;
end;

procedure TVehicleView.ValidateBrand(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblBrandAlert.Text := AValue.Msg
  else
    lblBrandAlert.Text := '';
end;

procedure TVehicleView.ValidateModel(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblModelAlert.Text := AValue.Msg
  else
    lblModelAlert.Text := '';
end;

procedure TVehicleView.ValidateYear(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblYearAlert.Text := AValue.Msg
  else
    lblYearAlert.Text := '';
end;

procedure TVehicleView.ValidateRenavam(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblRenavamAlert.Text := AValue.Msg
  else
    lblRenavamAlert.Text := '';
end;

procedure TVehicleView.ValidateLicensePlate(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblLicensePlateAlert.Text := AValue.Msg
  else
    lblLicensePlateAlert.Text := '';
end;

procedure TVehicleView.ValidateColor(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblColorAlert.Text := AValue.Msg
  else
    lblColorAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TVehicleView.edtBrandChange(Sender: TObject);
begin
  edtBrandTyping(Sender);
end;

procedure TVehicleView.edtModelChange(Sender: TObject);
begin
  edtModelTyping(Sender);
end;

procedure TVehicleView.edtYearChange(Sender: TObject);
begin
  edtYearTyping(Sender);
end;

procedure TVehicleView.edtRenavamChange(Sender: TObject);
begin
  edtRenavamTyping(Sender);
end;

procedure TVehicleView.edtLicensePlateChange(Sender: TObject);
begin
  edtLicensePlateTyping(Sender);
end;

procedure TVehicleView.edtColorChange(Sender: TObject);
begin
  edtColorTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TVehicleView.edtBrandEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TVehicleView.edtModelEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TVehicleView.edtYearEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TVehicleView.edtRenavamEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TVehicleView.edtLicensePlateEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TVehicleView.edtColorEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Enter'}
procedure TVehicleView.edtBrandExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidBrand;
end;

procedure TVehicleView.edtModelExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidModel;
end;

procedure TVehicleView.edtYearExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidYear(False);
end;

procedure TVehicleView.edtRenavamExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidRenavam(False);
end;

procedure TVehicleView.edtLicensePlateExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidLicensePlate(False);
end;

procedure TVehicleView.edtColorExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Vehicle.IsValidColor;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TVehicleView.edtBrandKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtModel), Key);
end;

procedure TVehicleView.edtModelKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtYear), Key);
end;

procedure TVehicleView.edtYearKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtRenavam), Key);
end;

procedure TVehicleView.edtRenavamKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtLicensePlate), Key);
end;

procedure TVehicleView.edtLicensePlateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtColor), Key);
end;

procedure TVehicleView.edtColorKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TVehicleView.edtBrandTyping(Sender: TObject);
begin
  FEntity.Vehicle.SetBrand(edtBrand.Text.Trim);
end;

procedure TVehicleView.edtModelTyping(Sender: TObject);
begin
  FEntity.Vehicle.SetModel(edtModel.Text.Trim);
end;

procedure TVehicleView.edtYearTyping(Sender: TObject);
begin
  FEntity.Vehicle.SetYear(edtYear.Text.Trim);
end;

procedure TVehicleView.edtRenavamTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtRenavam, TMyType.RenavamMask);
  FEntity.Vehicle.SetRenavam(TMyMask.RemoveMask(edtRenavam.Text.Trim));
end;

procedure TVehicleView.edtLicensePlateTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtLicensePlate, TMyType.LicensePlateMask, True);
  FEntity.Vehicle.SetLicensePlate(TMyMask.RemoveMask(edtLicensePlate.Text.Trim, True));
end;

procedure TVehicleView.edtColorTyping(Sender: TObject);
begin
  FEntity.Vehicle.SetColor(edtColor.Text.Trim);
end;
{$EndRegion}

{$Region'Button'}
procedure TVehicleView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TVehicleView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TVehicleView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TVehicleView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
