unit index;

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
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Ani,
  FMX.Effects,
  FMX.Objects,

  //view
  splash,
  welcome,
  user,
  contact,
  characteristic,
  address,
  company,
  bank,
  payment,
  vehicle,
  product,
  send,
  success,

  //entities
  entities;

type
  TIndexView = class(TForm)
    lytMain: TLayout;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
  private
    { Private declarations }
    FSplash: TSplashView;
    FWelcome: TWelcomeView;
    FUser: TUserView;
    FContact: TContactView;
    FCharacteristic: TCharacteristicView;
    FAddress: TAddressView;
    FCompany: TCompanyView;
    FBank: TBankView;
    FPayment: TPaymentView;
    FVehicle: TVehicleView;
    FProduct: TProductView;
    FSend: TSendView;
    FSuccess: TSuccessView;
    FEntity: TEntity;

    procedure CleanContainer;

    procedure ShowSplash(ADestroyPrevPage: TNotifyEvent);
    procedure NextSplash(Sender: TObject);
    procedure DestroySplash(Sender: TObject);

    procedure ShowWelcome(ADestroyPrevPage: TNotifyEvent);
    procedure NextWelcome(Sender: TObject);
    procedure DestroyWelcome(Sender: TObject);

    procedure ShowUser(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackUser(Sender: TObject);
    procedure NextUser(Sender: TObject);
    procedure DestroyUser(Sender: TObject);

    procedure ShowContact(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackContact(Sender: TObject);
    procedure NextContact(Sender: TObject);
    procedure DestroyContact(Sender: TObject);

    procedure ShowCharacteristic(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackCharacteristic(Sender: TObject);
    procedure NextCharacteristic(Sender: TObject);
    procedure DestroyCharacteristic(Sender: TObject);

    procedure ShowAddress(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackAddress(Sender: TObject);
    procedure NextAddress(Sender: TObject);
    procedure DestroyAddress(Sender: TObject);

    procedure ShowCompany(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackCompany(Sender: TObject);
    procedure NextCompany(Sender: TObject);
    procedure DestroyCompany(Sender: TObject);

    procedure ShowBank(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackBank(Sender: TObject);
    procedure NextBank(Sender: TObject);
    procedure DestroyBank(Sender: TObject);

    procedure ShowPayment(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackPayment(Sender: TObject);
    procedure NextPayment(Sender: TObject);
    procedure DestroyPayment(Sender: TObject);

    procedure ShowVehicle(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackVehicle(Sender: TObject);
    procedure NextVehicle(Sender: TObject);
    procedure DestroyVehicle(Sender: TObject);

    procedure ShowProduct(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
    procedure BackProduct(Sender: TObject);
    procedure NextProduct(Sender: TObject);
    procedure DestroyProduct(Sender: TObject);

    procedure ShowSend;
    procedure NextSend(Sender: TObject);
    procedure DestroySend(Sender: TObject);

    procedure ShowSuccess;
    procedure NextSuccess(Sender: TObject);
    procedure DestroySuccess(Sender: TObject);
  public
    { Public declarations }
  end;

var
  IndexView: TIndexView;

implementation

{$R *.fmx}

{ TIndexView }

{$Region'Infra'}
procedure TIndexView.FormDestroy(Sender: TObject);
begin
  if Assigned(FEntity) then
    FreeAndNil(FEntity);
  if Assigned(FSplash) then
    FreeAndNil(FSplash);
  if Assigned(FWelcome) then
    FreeAndNil(FWelcome);
  if Assigned(FUser) then
    FreeAndNil(FUser);
  if Assigned(FContact) then
    FreeAndNil(FContact);
  if Assigned(FCharacteristic) then
    FreeAndNil(FCharacteristic);
  if Assigned(FAddress) then
    FreeAndNil(FAddress);
  if Assigned(FCompany) then
    FreeAndNil(FCompany);
  if Assigned(FBank) then
    FreeAndNil(FBank);
  if Assigned(FPayment) then
    FreeAndNil(FPayment);
  if Assigned(FVehicle) then
    FreeAndNil(FVehicle);
  if Assigned(FProduct) then
    FreeAndNil(FProduct);
  if Assigned(FSend) then
    FreeAndNil(FSend);
  if Assigned(FSuccess) then
    FreeAndNil(FSuccess);
end;

procedure TIndexView.CleanContainer;
var
  LIndex: Integer;
begin
  for LIndex := lytMain.ControlsCount - 1 downto 0 do
    lytMain.RemoveObject(lytMain.Controls[LIndex]);
end;

procedure TIndexView.FormShow(Sender: TObject);
begin
  FEntity := TEntity.Create;
  ShowSplash(nil);
end;

procedure TIndexView.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if Assigned(FUser) then
  begin
    FUser.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FContact) then
  begin
    FContact.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FCharacteristic) then
  begin
    FCharacteristic.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FAddress) then
  begin
    FAddress.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FCompany) then
  begin
    FCompany.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FBank) then
  begin
    FBank.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FPayment) then
  begin
    FPayment.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FVehicle) then
  begin
    FVehicle.KeyBounds := Bounds;
    Exit;
  end;

  if Assigned(FProduct) then
  begin
    FProduct.KeyBounds := Bounds;
    Exit;
  end;
end;
{$EndRegion}

{$Region'Splash'}
procedure TIndexView.ShowSplash(ADestroyPrevPage: TNotifyEvent);
begin
  if Assigned(FSplash) then
    FreeAndNil(FSplash);
  FSplash := TSplashView.Create(nil);
  FSplash.OnDestroyPrevPage := ADestroyPrevPage;
  FSplash.OnNext := NextSplash;
  FSplash.Shows(lytMain);
end;

procedure TIndexView.NextSplash(Sender: TObject);
begin
  CleanContainer;
  ShowWelcome(DestroySplash);
end;

procedure TIndexView.DestroySplash(Sender: TObject);
begin
  if Assigned(FSplash) then
    FreeAndNil(FSplash);
end;
{$EndRegion}

{$Region'Welcome'}
procedure TIndexView.ShowWelcome(ADestroyPrevPage: TNotifyEvent);
begin
  if Assigned(FWelcome) then
    FreeAndNil(FWelcome);
  FWelcome := TWelcomeView.Create(nil);
  FWelcome.OnDestroyPrevPage := ADestroyPrevPage;
  FWelcome.OnNext := NextWelcome;
  FWelcome.Shows(lytMain);
end;

procedure TIndexView.NextWelcome(Sender: TObject);
begin
  CleanContainer;
  ShowUser(DestroyWelcome, 0);
end;

procedure TIndexView.DestroyWelcome(Sender: TObject);
begin
  if Assigned(FWelcome) then
    FreeAndNil(FWelcome);
end;
{$EndRegion}

{$Region'User'}
procedure TIndexView.ShowUser(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FUser) then
    FreeAndNil(FUser);
  FUser := TUserView.Create(nil);
  FUser.Entity := FEntity;
  FUser.CurrentProgress := ACurrentProgress;
  FUser.OnDestroyPrevPage := ADestroyPrevPage;
  FUser.OnBack := BackUser;
  FUser.OnNext := NextUser;
  FUser.Shows(lytMain);
end;

procedure TIndexView.BackUser(Sender: TObject);
begin
  if Assigned(FEntity) then
    FreeAndNil(FEntity);
  FEntity := TEntity.Create;
  CleanContainer;
  ShowWelcome(DestroyUser);
end;

procedure TIndexView.NextUser(Sender: TObject);
begin
  CleanContainer;
  ShowContact(DestroyUser, FUser.CurrentProgress);
end;

procedure TIndexView.DestroyUser(Sender: TObject);
begin
  if Assigned(FUser) then
    FreeAndNil(FUser);
end;
{$EndRegion}

{$Region'Contact'}
procedure TIndexView.ShowContact(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FContact) then
    FreeAndNil(FContact);
  FContact := TContactView.Create(nil);
  FContact.Entity := FEntity;
  FContact.CurrentProgress := ACurrentProgress;
  FContact.OnDestroyPrevPage := ADestroyPrevPage;
  FContact.OnBack := BackContact;
  FContact.OnNext := NextContact;
  FContact.Shows(lytMain);
end;

procedure TIndexView.BackContact(Sender: TObject);
begin
  CleanContainer;
  ShowUser(DestroyContact, FContact.CurrentProgress);
end;

procedure TIndexView.NextContact(Sender: TObject);
begin
  CleanContainer;
  ShowCharacteristic(DestroyContact, FContact.CurrentProgress);
end;

procedure TIndexView.DestroyContact(Sender: TObject);
begin
  if Assigned(FContact) then
    FreeAndNil(FContact);
end;
{$EndRegion}

{$Region'Characteristic'}
procedure TIndexView.ShowCharacteristic(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FCharacteristic) then
    FreeAndNil(FCharacteristic);
  FCharacteristic := TCharacteristicView.Create(nil);
  FCharacteristic.Entity := FEntity;
  FCharacteristic.CurrentProgress := ACurrentProgress;
  FCharacteristic.OnDestroyPrevPage := ADestroyPrevPage;
  FCharacteristic.OnBack := BackCharacteristic;
  FCharacteristic.OnNext := NextCharacteristic;
  FCharacteristic.Shows(lytMain);
end;

procedure TIndexView.BackCharacteristic(Sender: TObject);
begin
  CleanContainer;
  ShowContact(DestroyCharacteristic, FCharacteristic.CurrentProgress);
end;

procedure TIndexView.NextCharacteristic(Sender: TObject);
begin
  CleanContainer;
  ShowAddress(DestroyCharacteristic, FCharacteristic.CurrentProgress);
end;

procedure TIndexView.DestroyCharacteristic(Sender: TObject);
begin
  if Assigned(FCharacteristic) then
    FreeAndNil(FCharacteristic);
end;
{$EndRegion}

{$Region'Address'}
procedure TIndexView.ShowAddress(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FAddress) then
    FreeAndNil(FAddress);
  FAddress := TAddressView.Create(nil);
  FAddress.Entity := FEntity;
  FAddress.CurrentProgress := ACurrentProgress;
  FAddress.OnDestroyPrevPage := ADestroyPrevPage;
  FAddress.OnBack := BackAddress;
  FAddress.OnNext := NextAddress;
  FAddress.Shows(lytMain);
end;

procedure TIndexView.BackAddress(Sender: TObject);
begin
  CleanContainer;
  ShowCharacteristic(DestroyAddress, FAddress.CurrentProgress);
end;

procedure TIndexView.NextAddress(Sender: TObject);
begin
  CleanContainer;
  ShowCompany(DestroyAddress, FAddress.CurrentProgress);
end;

procedure TIndexView.DestroyAddress(Sender: TObject);
begin
  if Assigned(FAddress) then
    FreeAndNil(FAddress);
end;
{$EndRegion}

{$Region'Company'}
procedure TIndexView.ShowCompany(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FCompany) then
    FreeAndNil(FCompany);
  FCompany := TCompanyView.Create(nil);
  FCompany.Entity := FEntity;
  FCompany.CurrentProgress := ACurrentProgress;
  FCompany.OnDestroyPrevPage := ADestroyPrevPage;
  FCompany.OnBack := BackCompany;
  FCompany.OnNext := NextCompany;
  FCompany.Shows(lytMain);
end;

procedure TIndexView.BackCompany(Sender: TObject);
begin
  CleanContainer;
  ShowAddress(DestroyCompany, FCompany.CurrentProgress);
end;

procedure TIndexView.NextCompany(Sender: TObject);
begin
  CleanContainer;
  ShowBank(DestroyCompany, FCompany.CurrentProgress);
end;

procedure TIndexView.DestroyCompany(Sender: TObject);
begin
  if Assigned(FCompany) then
    FreeAndNil(FCompany);
end;
{$EndRegion}

{$Region'Bank'}
procedure TIndexView.ShowBank(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FBank) then
    FreeAndNil(FBank);
  FBank := TBankView.Create(nil);
  FBank.Entity := FEntity;
  FBank.CurrentProgress := ACurrentProgress;
  FBank.OnDestroyPrevPage := ADestroyPrevPage;
  FBank.OnBack := BackBank;
  FBank.OnNext := NextBank;
  FBank.Shows(lytMain);
end;

procedure TIndexView.BackBank(Sender: TObject);
begin
  CleanContainer;
  ShowCompany(DestroyBank, FBank.CurrentProgress);
end;

procedure TIndexView.NextBank(Sender: TObject);
begin
  CleanContainer;
  ShowPayment(DestroyBank, FBank.CurrentProgress);
end;

procedure TIndexView.DestroyBank(Sender: TObject);
begin
  if Assigned(FBank) then
    FreeAndNil(FBank);
end;
{$EndRegion}

{$Region'Payment'}
procedure TIndexView.ShowPayment(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FPayment) then
    FreeAndNil(FPayment);
  FPayment := TPaymentView.Create(nil);
  FPayment.Entity := FEntity;
  FPayment.CurrentProgress := ACurrentProgress;
  FPayment.OnDestroyPrevPage := ADestroyPrevPage;
  FPayment.OnBack := BackPayment;
  FPayment.OnNext := NextPayment;
  FPayment.Shows(lytMain);
end;

procedure TIndexView.BackPayment(Sender: TObject);
begin
  CleanContainer;
  ShowBank(DestroyPayment, FPayment.CurrentProgress);
end;

procedure TIndexView.NextPayment(Sender: TObject);
begin
  CleanContainer;
  ShowVehicle(DestroyPayment, FPayment.CurrentProgress);
end;

procedure TIndexView.DestroyPayment(Sender: TObject);
begin
  if Assigned(FPayment) then
    FreeAndNil(FPayment);
end;
{$EndRegion}

{$Region'Vehicle'}
procedure TIndexView.ShowVehicle(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FVehicle) then
    FreeAndNil(FVehicle);
  FVehicle := TVehicleView.Create(nil);
  FVehicle.Entity := FEntity;
  FVehicle.CurrentProgress := ACurrentProgress;
  FVehicle.OnDestroyPrevPage := ADestroyPrevPage;
  FVehicle.OnBack := BackVehicle;
  FVehicle.OnNext := NextVehicle;
  FVehicle.Shows(lytMain);
end;

procedure TIndexView.BackVehicle(Sender: TObject);
begin
  CleanContainer;
  ShowPayment(DestroyVehicle, FVehicle.CurrentProgress);
end;

procedure TIndexView.NextVehicle(Sender: TObject);
begin
  CleanContainer;
  ShowProduct(DestroyVehicle, FVehicle.CurrentProgress);
end;

procedure TIndexView.DestroyVehicle(Sender: TObject);
begin
  if Assigned(FVehicle) then
    FreeAndNil(FVehicle);
end;
{$EndRegion}

{$Region'Product'}
procedure TIndexView.ShowProduct(ADestroyPrevPage: TNotifyEvent; ACurrentProgress: Single);
begin
  if Assigned(FProduct) then
    FreeAndNil(FProduct);
  FProduct := TProductView.Create(nil);
  FProduct.Entity := FEntity;
  FProduct.CurrentProgress := ACurrentProgress;
  FProduct.OnDestroyPrevPage := ADestroyPrevPage;
  FProduct.OnBack := BackProduct;
  FProduct.OnNext := NextProduct;
  FProduct.Shows(lytMain);
end;

procedure TIndexView.BackProduct(Sender: TObject);
begin
  CleanContainer;
  ShowVehicle(DestroyProduct, FProduct.CurrentProgress);
end;

procedure TIndexView.NextProduct(Sender: TObject);
begin
  CleanContainer;
  ShowSend;
end;

procedure TIndexView.DestroyProduct(Sender: TObject);
begin
  if Assigned(FProduct) then
    FreeAndNil(FProduct);
end;
{$EndRegion}

{$Region'Send'}
procedure TIndexView.ShowSend;
begin
  if Assigned(FSend) then
    FreeAndNil(FSend);
  FSend := TSendView.Create(nil);
  FSend.Entity := FEntity;
  FSend.OnDestroyPrevPage := DestroyUser;
  FSend.OnNext := NextSend;
  FSend.Shows(lytMain);
end;

procedure TIndexView.NextSend(Sender: TObject);
begin
  CleanContainer;
  ShowSuccess;
end;

procedure TIndexView.DestroySend(Sender: TObject);
begin
  if Assigned(FSend) then
    FreeAndNil(FSend);
end;
{$EndRegion}

{$Region'Success'}
procedure TIndexView.ShowSuccess;
begin
  if Assigned(FSuccess) then
    FreeAndNil(FSuccess);
  FSuccess := TSuccessView.Create(nil);
  FSuccess.OnDestroyPrevPage := DestroySend;
  FSuccess.OnNext := NextSuccess;
  FSuccess.Shows(lytMain);
end;

procedure TIndexView.NextSuccess(Sender: TObject);
begin
  if Assigned(FEntity) then
    FreeAndNil(FEntity);
  FEntity := TEntity.Create;
  CleanContainer;
  ShowWelcome(DestroySuccess);
end;

procedure TIndexView.DestroySuccess(Sender: TObject);
begin
  if Assigned(FSuccess) then
    FreeAndNil(FSuccess);
end;
{$EndRegion}

end.
