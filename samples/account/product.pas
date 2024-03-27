unit product;

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
  TProductView = class(TFrame)
    lytHeader: TLayout;
    lytFooter: TLayout;
    btnNext: TButton;
    vsbBody: TVertScrollBox;
    lytName: TLayout;
    edtName: TEdit;
    lblName: TLabel;
    lblNameAlert: TLabel;
    lytGtin: TLayout;
    edtGtin: TEdit;
    lblGtin: TLabel;
    lblGtinAlert: TLabel;
    lytPrice: TLayout;
    edtPrice: TEdit;
    lblPrice: TLabel;
    lblPriceAlert: TLabel;
    lytExpirationDate: TLayout;
    lblExpirationDate: TLabel;
    lblExpirationDateAlert: TLabel;
    edtExpirationDate: TEdit;
    lytNcm: TLayout;
    edtNcm: TEdit;
    lblNcm: TLabel;
    lblNcmAlert: TLabel;
    lytCest: TLayout;
    edtCest: TEdit;
    lblCest: TLabel;
    lblCestAlert: TLabel;
    lytWidth: TLayout;
    lblWidth: TLabel;
    lblWidthAlert: TLabel;
    edtWidth: TEdit;
    lytHeight: TLayout;
    lblHeight: TLabel;
    lblHeightAlert: TLabel;
    edtHeight: TEdit;
    lytLength: TLayout;
    lblLength: TLabel;
    lblLengthAlert: TLabel;
    edtLength: TEdit;
    lytGrossWeight: TLayout;
    lblGrossWeight: TLabel;
    lblGrossWeightAlert: TLabel;
    edtGrossWeight: TEdit;
    lytLiquidWeight: TLayout;
    lblLiquidWeight: TLabel;
    lblLiquidWeightAlert: TLabel;
    edtLiquidWeight: TEdit;
    lytQuantityVolumes: TLayout;
    lblQuantityVolumes: TLabel;
    lblQuantityVolumesAlert: TLabel;
    edtQuantityVolumes: TEdit;
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
    procedure edtGtinEnter(Sender: TObject);
    procedure edtPriceEnter(Sender: TObject);
    procedure edtNcmEnter(Sender: TObject);
    procedure edtCestEnter(Sender: TObject);
    procedure edtExpirationDateEnter(Sender: TObject);
    procedure edtWidthEnter(Sender: TObject);
    procedure edtHeightEnter(Sender: TObject);
    procedure edtLengthEnter(Sender: TObject);
    procedure edtGrossWeightEnter(Sender: TObject);
    procedure edtLiquidWeightEnter(Sender: TObject);
    procedure edtQuantityVolumesEnter(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtGtinExit(Sender: TObject);
    procedure edtPriceExit(Sender: TObject);
    procedure edtNcmExit(Sender: TObject);
    procedure edtCestExit(Sender: TObject);
    procedure edtExpirationDateExit(Sender: TObject);
    procedure edtWidthExit(Sender: TObject);
    procedure edtHeightExit(Sender: TObject);
    procedure edtLengthExit(Sender: TObject);
    procedure edtGrossWeightExit(Sender: TObject);
    procedure edtLiquidWeightExit(Sender: TObject);
    procedure edtQuantityVolumesExit(Sender: TObject);
    procedure edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtGtinKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPriceKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtNcmKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCestKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtExpirationDateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtWidthKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtHeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtLengthKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtGrossWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtLiquidWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtQuantityVolumesKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtNameTyping(Sender: TObject);
    procedure edtGtinTyping(Sender: TObject);
    procedure edtPriceTyping(Sender: TObject);
    procedure edtNcmTyping(Sender: TObject);
    procedure edtCestTyping(Sender: TObject);
    procedure edtExpirationDateTyping(Sender: TObject);
    procedure edtWidthTyping(Sender: TObject);
    procedure edtHeightTyping(Sender: TObject);
    procedure edtLengthTyping(Sender: TObject);
    procedure edtGrossWeightTyping(Sender: TObject);
    procedure edtLiquidWeightTyping(Sender: TObject);
    procedure edtQuantityVolumesTyping(Sender: TObject);
    procedure btnBackTap(Sender: TObject; const Point: TPointF);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
    procedure edtNameChange(Sender: TObject);
    procedure edtGtinChange(Sender: TObject);
    procedure edtPriceChange(Sender: TObject);
    procedure edtNcmChange(Sender: TObject);
    procedure edtCestChange(Sender: TObject);
    procedure edtExpirationDateChange(Sender: TObject);
    procedure edtWidthChange(Sender: TObject);
    procedure edtHeightChange(Sender: TObject);
    procedure edtLengthChange(Sender: TObject);
    procedure edtGrossWeightChange(Sender: TObject);
    procedure edtLiquidWeightChange(Sender: TObject);
    procedure edtQuantityVolumesChange(Sender: TObject);
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
    procedure ValidateGtin(const AValue: TValid);
    procedure ValidatePrice(const AValue: TValid);
    procedure ValidateNcm(const AValue: TValid);
    procedure ValidateCest(const AValue: TValid);
    procedure ValidateExpirationDate(const AValue: TValid);
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
  PAGE_INDEX = 9;
  MARGIN_BOTTOM = 20;

implementation

{$R *.fmx}

{ TProductView }

{$Region'Infra'}
constructor TProductView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TProductView.Destroy;
begin

  inherited;
end;

procedure TProductView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
  FEntity.Product.OnValidateName := ValidateName;
  FEntity.Product.OnValidateGtin := ValidateGtin;
  FEntity.Product.OnValidatePrice := ValidatePrice;
  FEntity.Product.OnValidateNcm := ValidateNcm;
  FEntity.Product.OnValidateCest := ValidateCest;
  FEntity.Product.OnValidateExpirationDate := ValidateExpirationDate;
end;

procedure TProductView.SetKeyBounds(const Value: TRect);
begin
  FKeyBounds := Value;
  FooterMarginKeyboard;
end;

procedure TProductView.Shows(AContainer: TFmxObject);
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

procedure TProductView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TProductView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TProductView.DestroyPrevPage;
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

procedure TProductView.DisableControls;
begin
  lytHeader.Enabled := False;
  vsbBody.Enabled := False;
  lytFooter.Enabled := False;
end;

procedure TProductView.EnabledControls;
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

procedure TProductView.DefaultSettingsInControls;
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

procedure TProductView.ClearAnimations;
begin
  lytHeader.Opacity := 0;
  vsbBody.Opacity := 0;
  lytFooter.Opacity := 0;
end;

procedure TProductView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytHeader, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(vsbBody, 'Opacity', 1, 0.7, 0.5, TAnimationType.In, TInterpolationType.Linear);
  TAnimator.AnimateFloatDelay(lytFooter, 'Opacity', 1, 0.7, 0.7, TAnimationType.In, TInterpolationType.Linear);
  rctProgress.Width := FCurrentProgress;
  FCurrentProgress := (rctBgProgress.Width / TOTAL_PAGES) * PAGE_INDEX;
  TAnimator.AnimateFloatDelay(rctProgress, 'width', FCurrentProgress, 0.3, 0.7, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TProductView.AdjustScroll(AControl: TControl);
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

function TProductView.ShowsMoreThreeFields(AControl: TControl): Boolean;
var
  LHeightOneField: Single;
  LHeightThreeFields: Single;
begin
  LHeightOneField := (AControl.Height + AControl.Margins.Bottom);
  LHeightThreeFields := LHeightOneField * 3;
  Result := LHeightThreeFields <= vsbBody.Height
end;

procedure TProductView.FooterMarginKeyboard;
begin
  {$IFDEF ANDROID}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
  {$IFDEF IOS}
    lytFooter.Margins.Bottom := FKeyBounds.Height;
  {$ENDIF}
end;

procedure TProductView.FooterMarginDefault;
begin
  lytFooter.Margins.Bottom := MARGIN_BOTTOM;
end;

procedure TProductView.HideKeyboard;
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
procedure TProductView.LoadData;
begin
  edtName.Text := FEntity.Product.Name;
  edtGtin.Text := FEntity.Product.GTIN;
  TMyMask.ApplyMask(edtGtin, TMyType.GtinMask);
  edtPrice.Text := FEntity.Product.Price.ToString;
  TMyMask.ApplyCurrency(edtPrice, CURRENCY_SYMBOL, DECIMAL_CURRENCY);
  edtNcm.Text := FEntity.Product.NCM;
  TMyMask.ApplyMask(edtNcm, TMyType.NcmMask);
  edtCest.Text := FEntity.Product.CEST;
  TMyMask.ApplyMask(edtCest, TMyType.CestMask);
  edtExpirationDate.Text := FEntity.Product.ExpirationDateStr;
  TMyMask.ApplyMask(edtExpirationDate, TMyType.ddmmyyyyMask('/'));
  edtWidth.Text := FEntity.Product.Width.ToString;
  TMyMask.ApplyFloat(edtWidth, DECIMAL_MEASURES);
  edtHeight.Text := FEntity.Product.Height.ToString;
  TMyMask.ApplyFloat(edtHeight, DECIMAL_MEASURES);
  edtLength.Text := FEntity.Product.Length.ToString;
  TMyMask.ApplyFloat(edtLength, DECIMAL_MEASURES);
  edtGrossWeight.Text := FEntity.Product.GrossWeight.ToString;
  TMyMask.ApplyFloat(edtGrossWeight, DECIMAL_WEIGHT);
  edtLiquidWeight.Text := FEntity.Product.LiquidWeight.ToString;
  TMyMask.ApplyFloat(edtLiquidWeight, DECIMAL_WEIGHT);
  edtQuantityVolumes.Text := FEntity.Product.QuantityVolumes.ToString;
  TMyMask.ApplyFloat(edtQuantityVolumes, NO_DECIMAL);
end;
{$EndRegion}

{$Region'Validate'}
function TProductView.IsValid: Boolean;
var
  LValidName: Boolean;
  LValidGtin: Boolean;
  LValidPrice: Boolean;
  LValidNcm: Boolean;
  LValidCest: Boolean;
  LValidExpirationDate: Boolean;
begin
  LValidName := FEntity.Product.IsValidName;
  LValidGtin := FEntity.Product.IsValidGtin(False);
  LValidPrice := FEntity.Product.IsValidPrice;
  LValidNcm := FEntity.Product.IsValidNcm(False);
  LValidCest := FEntity.Product.IsValidCest(False);
  LValidExpirationDate := FEntity.Product.IsValidExpirationDate(False);
  Result := LValidName and LValidGtin and LValidPrice and
            LValidNcm and LValidCest and LValidExpirationDate;
end;

procedure TProductView.ValidateName(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNameAlert.Text := AValue.Msg
  else
    lblNameAlert.Text := '';
end;

procedure TProductView.ValidateGtin(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblGtinAlert.Text := AValue.Msg
  else
    lblGtinAlert.Text := '';
end;

procedure TProductView.ValidatePrice(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblPriceAlert.Text := AValue.Msg
  else
    lblPriceAlert.Text := '';
end;

procedure TProductView.ValidateNcm(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblNcmAlert.Text := AValue.Msg
  else
    lblNcmAlert.Text := '';
end;

procedure TProductView.ValidateCest(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblCestAlert.Text := AValue.Msg
  else
    lblCestAlert.Text := '';
end;

procedure TProductView.ValidateExpirationDate(const AValue: TValid);
begin
  if not AValue.IsValid then
    lblExpirationDateAlert.Text := AValue.Msg
  else
    lblExpirationDateAlert.Text := '';
end;
{$EndRegion}

{$Region'Change'}
procedure TProductView.edtNameChange(Sender: TObject);
begin
  edtNameTyping(Sender);
end;

procedure TProductView.edtGtinChange(Sender: TObject);
begin
  edtGtinTyping(Sender);
end;

procedure TProductView.edtPriceChange(Sender: TObject);
begin
  edtPriceTyping(Sender);
end;

procedure TProductView.edtNcmChange(Sender: TObject);
begin
  edtNcmTyping(Sender);
end;

procedure TProductView.edtCestChange(Sender: TObject);
begin
  edtCestTyping(Sender);
end;

procedure TProductView.edtExpirationDateChange(Sender: TObject);
begin
  edtExpirationDateTyping(Sender);
end;

procedure TProductView.edtWidthChange(Sender: TObject);
begin
  edtWidthTyping(Sender);
end;

procedure TProductView.edtHeightChange(Sender: TObject);
begin
  edtHeightTyping(Sender);
end;

procedure TProductView.edtLengthChange(Sender: TObject);
begin
  edtLengthTyping(Sender);
end;

procedure TProductView.edtGrossWeightChange(Sender: TObject);
begin
  edtGrossWeightTyping(Sender);
end;

procedure TProductView.edtLiquidWeightChange(Sender: TObject);
begin
  edtLiquidWeightTyping(Sender);
end;

procedure TProductView.edtQuantityVolumesChange(Sender: TObject);
begin
  edtQuantityVolumesTyping(Sender);
end;
{$EndRegion}

{$Region'Enter'}
procedure TProductView.edtNameEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtGtinEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtPriceEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtNcmEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtCestEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtExpirationDateEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtWidthEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtHeightEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtLengthEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtGrossWeightEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtLiquidWeightEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;

procedure TProductView.edtQuantityVolumesEnter(Sender: TObject);
begin
  AdjustScroll(TControl(TEdit(Sender).Parent));
end;
{$EndRegion}

{$Region'Exit'}
procedure TProductView.edtNameExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidName;
end;

procedure TProductView.edtGtinExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidGtin(False);
end;

procedure TProductView.edtPriceExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidPrice;
end;

procedure TProductView.edtNcmExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidNcm(False);
end;

procedure TProductView.edtCestExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidCest(False);
end;

procedure TProductView.edtExpirationDateExit(Sender: TObject);
begin
  FooterMarginDefault;
  FEntity.Product.IsValidExpirationDate(False);
end;

procedure TProductView.edtWidthExit(Sender: TObject);
begin
  FooterMarginDefault;
end;

procedure TProductView.edtHeightExit(Sender: TObject);
begin
  FooterMarginDefault;
end;

procedure TProductView.edtLengthExit(Sender: TObject);
begin
  FooterMarginDefault;
end;
procedure TProductView.edtGrossWeightExit(Sender: TObject);
begin
  FooterMarginDefault;
end;

procedure TProductView.edtLiquidWeightExit(Sender: TObject);
begin
  FooterMarginDefault;
end;

procedure TProductView.edtQuantityVolumesExit(Sender: TObject);
begin
  FooterMarginDefault;
end;
{$EndRegion}

{$Region'KeyDown'}
procedure TProductView.edtNameKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtGtin), Key);
end;

procedure TProductView.edtGtinKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtPrice), Key);
end;

procedure TProductView.edtPriceKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtNcm), Key);
end;

procedure TProductView.edtNcmKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtCest), Key);
end;

procedure TProductView.edtCestKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtExpirationDate), Key);
end;

procedure TProductView.edtExpirationDateKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtWidth), Key);
end;

procedure TProductView.edtWidthKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtHeight), Key);
end;

procedure TProductView.edtHeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtLength), Key);
end;

procedure TProductView.edtLengthKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtGrossWeight), Key);
end;

procedure TProductView.edtGrossWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtLiquidWeight), Key);
end;

procedure TProductView.edtLiquidWeightKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), TEdit(edtQuantityVolumes), Key);
end;

procedure TProductView.edtQuantityVolumesKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TMyMask.MyKeyDown := Key;
  TMyMask.EditKeyDownNextFocus(TEdit(Sender), btnNext, Key);
end;
{$EndRegion}

{$Region'Typing'}
procedure TProductView.edtNameTyping(Sender: TObject);
begin
  FEntity.Product.SetName(edtName.Text.Trim);
end;

procedure TProductView.edtGtinTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtGtin, TMyType.GtinMask);
  FEntity.Product.SetGtin(TMyMask.RemoveMask(edtGtin.Text.Trim));
end;

procedure TProductView.edtPriceTyping(Sender: TObject);
begin
  TMyMask.ApplyCurrency(edtPrice, CURRENCY_SYMBOL, DECIMAL_CURRENCY);
  FEntity.Product.SetPrice(TMyMask.ControlToCurrency(edtPrice, CURRENCY_SYMBOL));
end;

procedure TProductView.edtNcmTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtNcm, TMyType.NcmMask);
  FEntity.Product.SetNcm(TMyMask.RemoveMask(edtNcm.Text.Trim));
end;

procedure TProductView.edtCestTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtCest, TMyType.CestMask);
  FEntity.Product.SetCest(TMyMask.RemoveMask(edtCest.Text.Trim));
end;

procedure TProductView.edtExpirationDateTyping(Sender: TObject);
begin
  TMyMask.ApplyMask(edtExpirationDate, TMyType.ddmmyyyyMask('/'));
  FEntity.Product.SetExpirationDate(edtExpirationDate.Text.Trim);
end;

procedure TProductView.edtWidthTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtWidth, DECIMAL_MEASURES);
  FEntity.Product.SetWidth(TMyMask.ControlToFloat(edtWidth));
end;

procedure TProductView.edtHeightTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtHeight, DECIMAL_MEASURES);
  FEntity.Product.SetHeight(TMyMask.ControlToFloat(edtHeight));
end;

procedure TProductView.edtLengthTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtLength, DECIMAL_MEASURES);
  FEntity.Product.SetLength(TMyMask.ControlToFloat(edtLength));
end;

procedure TProductView.edtGrossWeightTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtGrossWeight, DECIMAL_WEIGHT);
  FEntity.Product.SetGrossWeight(TMyMask.ControlToFloat(edtGrossWeight));
end;

procedure TProductView.edtLiquidWeightTyping(Sender: TObject);
begin
  TMyMask.ApplyFloat(edtLiquidWeight, DECIMAL_WEIGHT);
  FEntity.Product.SetLiquidWeight(TMyMask.ControlToFloat(edtLiquidWeight));
end;

procedure TProductView.edtQuantityVolumesTyping(Sender: TObject);
begin
  TMyMask.ApplyInteger(edtQuantityVolumes);
  FEntity.Product.SetQuantityVolumes(TMyMask.ControlToInteger(edtQuantityVolumes));
end;
{$EndRegion}

{$Region'Button'}
procedure TProductView.btnBackClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnBackTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TProductView.btnBackTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if Assigned(FOnBack) then
    FOnBack(nil);
end;

procedure TProductView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TProductView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  FooterMarginDefault;
  if IsValid then
    if Assigned(FOnNext) then
      FOnNext(nil);
end;
{$EndRegion}

end.
