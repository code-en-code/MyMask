program account;

uses
  System.StartUpCopy,
  FMX.Forms,
  index in 'index.pas' {IndexView},
  welcome in 'welcome.pas' {WelcomeView: TFrame},
  user in 'user.pas' {UserView: TFrame},
  entities in 'entities.pas',
  send in 'send.pas' {SendView: TFrame},
  success in 'success.pas' {SuccessView: TFrame},
  contact in 'contact.pas' {ContactView: TFrame},
  characteristic in 'characteristic.pas' {CharacteristicView: TFrame},
  company in 'company.pas' {CompanyView: TFrame},
  address in 'address.pas' {AddressView: TFrame},
  bank in 'bank.pas' {BankView: TFrame},
  payment in 'payment.pas' {PaymentView: TFrame},
  vehicle in 'vehicle.pas' {VehicleView: TFrame},
  product in 'product.pas' {ProductView: TFrame},
  mytype in '..\..\modules\mytype\src\mytype.pas',
  mystring in '..\..\modules\mystring\src\mystring.pas',
  mymask in '..\..\src\mymask.pas',
  splash in 'splash.pas' {SplashView: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TIndexView, IndexView);
  Application.Run;
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
end.
