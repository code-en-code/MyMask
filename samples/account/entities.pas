unit entities;

interface

uses
  //delphi
  System.SysUtils,

  //codeenconde
  mytype;

type
  TValid = class
  public
    IsValid: Boolean;
    Msg: String;
  end;

  TEventValid = procedure (const AValue: TValid) of Object;

  TGender = (gdNone, gdFemale, gdMale, gdOther);

  TUser = class
  strict private
    { private declarations }
    FName: String;
    FCPF: String;
    FRG: String;
    FCNH: String;
    FPIS: String;
    FEmail: String;
    FWhatsapp: String;
    FPhone: String;
    FGender: TGender;
    FBirthday: String;
    FHeight: Double;
    FWeight: Double;
    FCEP: String;
    FAddress: String;
    FNumber: String;
    FDistrict: String;
    FCity: String;
    FUF: String;

    FOnValidateName: TEventValid;
    FOnValidateCpf: TEventValid;
    FOnValidateCnh: TEventValid;
    FOnValidatePis: TEventValid;
    FOnValidateEmail: TEventValid;
    FOnValidateWhatsapp: TEventValid;
    FOnValidatePhone: TEventValid;
    FOnValidateGender: TEventValid;
    FOnValidateBirthday: TEventValid;
    FOnValidateHeight: TEventValid;
    FOnValidateWeight: TEventValid;
    FOnValidateCep: TEventValid;
    FOnValidateAddress: TEventValid;
    FOnValidateNumber: TEventValid;
    FOnValidateDistrict: TEventValid;
    FOnValidateCity: TEventValid;
    FOnValidateUf: TEventValid;

    function GetBirthdatDte: TDate;
  public
    { public declarations }
    procedure SetName(const AValue: String);
    procedure SetCpf(const AValue: String);
    procedure SetRg(const AValue: String);
    procedure SetCnh(const AValue: String);
    procedure SetPis(const AValue: String);
    procedure SetEmail(const AValue: String);
    procedure SetWhatsapp(const AValue: String);
    procedure SetPhone(const AValue: String);
    procedure SetGender(const AValue: TGender);
    procedure SetBirthday(const AValue: String);
    procedure SetHeight(const AValue: Double);
    procedure SetWeight(const AValue: Double);
    procedure SetCep(const AValue: String);
    procedure SetAddress(const AValue: String);
    procedure SetNumber(const AValue: String);
    procedure SetDistrict(const AValue: String);
    procedure SetCity(const AValue: String);
    procedure SetUf(const AValue: String);

    function IsValidName: Boolean;
    function IsValidCpf(const ALength: Boolean = False): Boolean;
    function IsValidCnh(const ALength: Boolean = False): Boolean;
    function IsValidPis(const ALength: Boolean = False): Boolean;
    function IsValidEmail(const ALength: Boolean = False): Boolean;
    function IsValidWhatsapp(const ALength: Boolean = False): Boolean;
    function IsValidPhone(const ALength: Boolean = False): Boolean;
    function IsValidGender: Boolean;
    function IsValidBirthday(const ALength: Boolean = False): Boolean;
    function IsValidHeight: Boolean;
    function IsValidWeight: Boolean;
    function IsValidCep(const ALength: Boolean = False): Boolean;
    function IsValidAddress: Boolean;
    function IsValidNumber: Boolean;
    function IsValidDistrict: Boolean;
    function IsValidCity: Boolean;
    function IsValidUf: Boolean;

    property Name: String read FName write FName;
    property CPF: String read FCPF write FCPF;
    property RG: String read FRG write FRG;
    property CNH: String read FCNH write FCNH;
    property PIS: String read FPIS write FPIS;
    property Email: String read FEmail write FEmail;
    property Whatsapp: String read FWhatsapp write FWhatsapp;
    property Phone: String read FPhone write FPhone;
    property Gender: TGender read FGender write FGender;
    property BirthdatDte: TDate read GetBirthdatDte;
    property BirthdayStr: String read FBirthday write FBirthday;
    property Height: Double read FHeight write FHeight;
    property Weight: Double read FWeight write FWeight;
    property CEP: String read FCEP write FCEP;
    property Address: String read FAddress write FAddress;
    property Number: String read FNumber write FNumber;
    property District: String read FDistrict write FDistrict;
    property City: String read FCity write FCity;
    property UF: String read FUF write FUF;

    property OnValidateName: TEventValid read FOnValidateName write FOnValidateName;
    property OnValidateCpf: TEventValid read FOnValidateCpf write FOnValidateCpf;
    property OnValidateCnh: TEventValid read FOnValidateCnh write FOnValidateCnh;
    property OnValidatePis: TEventValid read FOnValidatePis write FOnValidatePis;
    property OnValidateEmail: TEventValid read FOnValidateEmail write FOnValidateEmail;
    property OnValidateWhatsapp: TEventValid read FOnValidateWhatsapp write FOnValidateWhatsapp;
    property OnValidatePhone: TEventValid read FOnValidatePhone write FOnValidatePhone;
    property OnValidateGender: TEventValid read FOnValidateGender write FOnValidateGender;
    property OnValidateBirthday: TEventValid read FOnValidateBirthday write FOnValidateBirthday;
    property OnValidateHeight: TEventValid read FOnValidateHeight write FOnValidateHeight;
    property OnValidateWeight: TEventValid read FOnValidateWeight write FOnValidateWeight;
    property OnValidateCep: TEventValid read FOnValidateCep write FOnValidateCep;
    property OnValidateAddress: TEventValid read FOnValidateAddress write FOnValidateAddress;
    property OnValidateNumber: TEventValid read FOnValidateNumber write FOnValidateNumber;
    property OnValidateDistrict: TEventValid read FOnValidateDistrict write FOnValidateDistrict;
    property OnValidateCity: TEventValid read FOnValidateCity write FOnValidateCity;
    property OnValidateUf: TEventValid read FOnValidateUf write FOnValidateUf;
  end;

  TCompany = class
  strict private
    { private declarations }
    FName: String;
    FAddress: String;
    FCity: String;
    FUF: String;
    FCNPJ: String;
    FIE: String;
    FSuframa: String;
    FPhone: String;

    FOnValidateName: TEventValid;
    FOnValidateAddress: TEventValid;
    FOnValidateCity: TEventValid;
    FOnValidateUf: TEventValid;
    FOnValidateCnpj: TEventValid;
    FOnValidateIe: TEventValid;
    FOnValidateSuframa: TEventValid;
    FOnValidatePhone: TEventValid;
  public
    { public declarations }
    procedure SetName(const AValue: String);
    procedure SetAddress(const AValue: String);
    procedure SetCity(const AValue: String);
    procedure SetUf(const AValue: String);
    procedure SetCnpj(const AValue: String);
    procedure SetIe(const AValue: String);
    procedure SetSuframa(const AValue: String);
    procedure SetPhone(const AValue: String);

    function IsValidName: Boolean;
    function IsValidAddress: Boolean;
    function IsValidCity: Boolean;
    function IsValidUf: Boolean;
    function IsValidCnpj(const ALength: Boolean = False): Boolean;
    function IsValidIe(const ALength: Boolean = False): Boolean;
    function IsValidSuframa(const ALength: Boolean = False): Boolean;
    function IsValidPhone(const ALength: Boolean = False): Boolean;

    property Name: String read FName write FName;
    property Address: String read FAddress write FAddress;
    property City: String read FCity write FCity;
    property UF: String read FUF write FUF;
    property CNPJ: String read FCNPJ write FCNPJ;
    property IE: String read FIE write FIE;
    property Suframa: String read FSuframa write FSuframa;
    property Phone: String read FPhone write FPhone;

    property OnValidateName: TEventValid read FOnValidateName write FOnValidateName;
    property OnValidateAddress: TEventValid read FOnValidateAddress write FOnValidateAddress;
    property OnValidateCity: TEventValid read FOnValidateCity write FOnValidateCity;
    property OnValidateUf: TEventValid read FOnValidateUf write FOnValidateUf;
    property OnValidateCnpj: TEventValid read FOnValidateCnpj write FOnValidateCnpj;
    property OnValidateIe: TEventValid read FOnValidateIe write FOnValidateIe;
    property OnValidateSuframa: TEventValid read FOnValidateSuframa write FOnValidateSuframa;
    property OnValidatePhone: TEventValid read FOnValidatePhone write FOnValidatePhone;
  end;

  TBank = class
  strict private
    { private declarations }
    FAccount: String;
    FAgency: String;
    FBank: String;
    FCity: String;
    FUF: String;

    FOnValidateAccount: TEventValid;
    FOnValidateAgency: TEventValid;
    FOnValidateBank: TEventValid;
    FOnValidateCity: TEventValid;
    FOnValidateUf: TEventValid;
  public
    { public declarations }
    procedure SetAccount(const AValue: String);
    procedure SetAgency(const AValue: String);
    procedure SetBank(const AValue: String);
    procedure SetCity(const AValue: String);
    procedure SetUf(const AValue: String);

    function IsValidAccount: Boolean;
    function IsValidAgency: Boolean;
    function IsValidBank: Boolean;
    function IsValidCity: Boolean;
    function IsValidUf: Boolean;

    property Account: String read FAccount write FAccount;
    property Agency: String read FAgency write FAgency;
    property Bank: String read FBank write FBank;
    property City: String read FCity write FCity;
    property UF: String read FUF write FUF;

    property OnValidateAccount: TEventValid read FOnValidateAccount write FOnValidateAccount;
    property OnValidateAgency: TEventValid read FOnValidateAgency write FOnValidateAgency;
    property OnValidateBank: TEventValid read FOnValidateBank write FOnValidateBank;
    property OnValidateCity: TEventValid read FOnValidateCity write FOnValidateCity;
    property OnValidateUf: TEventValid read FOnValidateUf write FOnValidateUf;
  end;

  TPayment = class
  strict private
    { private declarations }
    FNumber: String;
    FMonth: String;
    FYear: String;
    FCode: String;
    FName: String;

    FOnValidateNumber: TEventValid;
    FOnValidateExpirationDate: TEventValid;
    FOnValidateCode: TEventValid;
    FOnValidateName: TEventValid;

    function IsValidMonth(out ADescriptionErrors: String): Boolean;
    function IsValidYear(out ADescriptionErrors: String): Boolean;

    function GetExpirationDate: String;
  public
    { public declarations }
    procedure SetNumber(const AValue: String);
    procedure SetExpirationDate(const AValue: String);
    procedure SetCode(const AValue: String);
    procedure SetName(const AValue: String);

    function IsValidNumber(const ALength: Boolean = False): Boolean;
    function IsValidExpirationDate(const ALength: Boolean = False): Boolean;
    function IsValidCode(const ALength: Boolean = False): Boolean;
    function IsValidName: Boolean;

    property Number: String read FNumber write FNumber;
    property ExpirationDate: String read GetExpirationDate;
    property Month: String read FMonth;
    property Year: String read FYear;
    property Code: String read FCode write FCode;
    property Name: String read FName write FName;

    property OnValidateNumber: TEventValid read FOnValidateNumber write FOnValidateNumber;
    property OnValidateExpirationDate: TEventValid read FOnValidateExpirationDate write FOnValidateExpirationDate;
    property OnValidateCode: TEventValid read FOnValidateCode write FOnValidateCode;
    property OnValidateName: TEventValid read FOnValidateName write FOnValidateName;
  end;

  TVehicle = class
  strict private
    { private declarations }
    FBrand: String;
    FModel: String;
    FYear: String;
    FRenavam: String;
    FLicensePlate: String;
    FColor: String;

    FOnValidateBrand: TEventValid;
    FOnValidateModel: TEventValid;
    FOnValidateYear: TEventValid;
    FOnValidateRenavam: TEventValid;
    FOnValidateLicensePlate: TEventValid;
    FOnValidateColor: TEventValid;
  public
    { public declarations }
    procedure SetBrand(const AValue: String);
    procedure SetModel(const AValue: String);
    procedure SetYear(const AValue: String);
    procedure SetRenavam(const AValue: String);
    procedure SetLicensePlate(const AValue: String);
    procedure SetColor(const AValue: String);

    function IsValidBrand: Boolean;
    function IsValidModel: Boolean;
    function IsValidYear(const ALength: Boolean = False): Boolean;
    function IsValidRenavam(const ALength: Boolean = False): Boolean;
    function IsValidLicensePlate(const ALength: Boolean = False): Boolean;
    function IsValidColor: Boolean;

    property Brand: String read FBrand write FBrand;
    property Model: String read FModel write FModel;
    property Year: String read FYear write FYear;
    property Renavam: String read FRenavam write FRenavam;
    property LicensePlate: String read FLicensePlate write FLicensePlate;
    property Color: String read FColor write FColor;

    property OnValidateBrand: TEventValid read FOnValidateBrand write FOnValidateBrand;
    property OnValidateModel: TEventValid read FOnValidateModel write FOnValidateModel;
    property OnValidateYear: TEventValid read FOnValidateYear write FOnValidateYear;
    property OnValidateRenavam: TEventValid read FOnValidateRenavam write FOnValidateRenavam;
    property OnValidateLicensePlate: TEventValid read FOnValidateLicensePlate write FOnValidateLicensePlate;
    property OnValidateColor: TEventValid read FOnValidateColor write FOnValidateColor;
  end;

  TProduct = class
  strict private
    { private declarations }
    FName: String;
    FGTIN: String;
    FPrice: Currency;
    FNCM: String;
    FCEST: String;
    FExpirationDate: String;
    FWidth: Double;
    FHeight: Double;
    FLength: Double;
    FGrossWeight: Double;
    FLiquidWeight: Double;
    FQuantityVolumes: Integer;

    FOnValidateName: TEventValid;
    FOnValidateGtin: TEventValid;
    FOnValidatePrice: TEventValid;
    FOnValidateNcm: TEventValid;
    FOnValidateCest: TEventValid;
    FOnValidateExpirationDate: TEventValid;
  private
    function GetExpirationDateDte: TDate;
  public
    { public declarations }
    procedure SetName(const AValue: String);
    procedure SetGtin(const AValue: String);
    procedure SetPrice(const AValue: Currency);
    procedure SetNcm(const AValue: String);
    procedure SetCest(const AValue: String);
    procedure SetExpirationDate(const AValue: String);
    procedure SetWidth(const AValue: Double);
    procedure SetHeight(const AValue: Double);
    procedure SetLength(const AValue: Double);
    procedure SetGrossWeight(const AValue: Double);
    procedure SetLiquidWeight(const AValue: Double);
    procedure SetQuantityVolumes(const AValue: Integer);

    function IsValidName: Boolean;
    function IsValidGtin(const ALength: Boolean = False): Boolean;
    function IsValidPrice: Boolean;
    function IsValidNcm(const ALength: Boolean = False): Boolean;
    function IsValidCest(const ALength: Boolean = False): Boolean;
    function IsValidExpirationDate(const ALength: Boolean = False): Boolean;

    property Name: String read FName write FName;
    property GTIN: String read FGTIN write FGTIN;
    property Price: Currency read FPrice write FPrice;
    property NCM: String read FNCM write FNCM;
    property CEST: String read FCEST write FCEST;
    property ExpirationDateDte: TDate read GetExpirationDateDte;
    property ExpirationDateStr: String read FExpirationDate write FExpirationDate;
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;
    property Length: Double read FLength write FLength;
    property GrossWeight: Double read FGrossWeight write FGrossWeight;
    property LiquidWeight: Double read FLiquidWeight write FLiquidWeight;
    property QuantityVolumes: Integer read FQuantityVolumes write FQuantityVolumes;

    property OnValidateName: TEventValid read FOnValidateName write FOnValidateName;
    property OnValidateGtin: TEventValid read FOnValidateGtin write FOnValidateGtin;
    property OnValidatePrice: TEventValid read FOnValidatePrice write FOnValidatePrice;
    property OnValidateNcm: TEventValid read FOnValidateNcm write FOnValidateNcm;
    property OnValidateCest: TEventValid read FOnValidateCest write FOnValidateCest;
    property OnValidateExpirationDate: TEventValid read FOnValidateExpirationDate write FOnValidateExpirationDate;
  end;

  TEntity = class
  strict private
    { private declarations }
    FUser: TUser;
    FCompany: TCompany;
    FBank: TBank;
    FPayment: TPayment;
    FVehicle: TVehicle;
    FProduct: TProduct;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property User: TUser read FUser write FUser;
    property Company: TCompany read FCompany write FCompany;
    property Bank: TBank read FBank write FBank;
    property Payment: TPayment read FPayment write FPayment;
    property Vehicle: TVehicle read FVehicle write FVehicle;
    property Product: TProduct read FProduct write FProduct;
  end;

  const
    DECIMAL_MEASURES = 2;
    DECIMAL_CURRENCY = 2;
    DECIMAL_WEIGHT = 3;
    NO_DECIMAL = 0;
    CURRENCY_SYMBOL = 'R$';

implementation

{ TEntity }

constructor TEntity.Create;
begin
  FUser := TUser.Create;
  FUser.Gender := TGender.gdNone;
  FCompany := TCompany.Create;
  FBank := TBank.Create;
  FPayment := TPayment.Create;
  FVehicle := TVehicle.Create;
  FProduct := TProduct.Create;
end;

destructor TEntity.Destroy;
begin
  FreeAndNil(FUser);
  FreeAndNil(FCompany);
  FreeAndNil(FBank);
  FreeAndNil(FPayment);
  FreeAndNil(FVehicle);
  FreeAndNil(FProduct);
  inherited;
end;

{$Region'User'}

{ TUser }

function TUser.GetBirthdatDte: TDate;
begin
  if IsValidBirthday(False) then
    Result := StrToDate(FBirthday)
  else
    Result := TDate(0);
end;

{$Region'Sets'}
procedure TUser.SetName(const AValue: String);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  IsValidName;
end;

procedure TUser.SetCpf(const AValue: String);
begin
  if FCPF = AValue then
    Exit;
  FCPF := AValue;
  IsValidCpf(True);
end;

procedure TUser.SetRg(const AValue: String);
begin
  if FRG = AValue then
    Exit;
  FRG := AValue;
end;

procedure TUser.SetCnh(const AValue: String);
begin
  if FCNH = AValue then
    Exit;
  FCNH := AValue;
  IsValidCnh(True);
end;

procedure TUser.SetPis(const AValue: String);
begin
  if FPIS = AValue then
    Exit;
  FPIS := AValue;
  IsValidPis(True);
end;

procedure TUser.SetEmail(const AValue: String);
begin
  if FEmail = AValue then
    Exit;
  FEmail := AValue;
  IsValidEmail(True);
end;

procedure TUser.SetWhatsapp(const AValue: String);
begin
  if FWhatsapp = AValue then
    Exit;
  FWhatsapp := AValue;
  IsValidWhatsapp(True);
end;

procedure TUser.SetPhone(const AValue: String);
begin
  if FPhone = AValue then
    Exit;
  FPhone := AValue;
  IsValidPhone(True);
end;

procedure TUser.SetGender(const AValue: TGender);
begin
  if FGender = AValue then
    Exit;
  FGender := AValue;
  IsValidGender;
end;

procedure TUser.SetBirthday(const AValue: String);
begin
  if FBirthday = AValue then
    Exit;
  FBirthday := AValue;
  IsValidBirthday(True);
end;

procedure TUser.SetHeight(const AValue: Double);
begin
  if FHeight = AValue then
    Exit;
  FHeight := AValue;
  IsValidHeight;
end;

procedure TUser.SetWeight(const AValue: Double);
begin
  if FWeight = AValue then
    Exit;
  FWeight := AValue;
  IsValidWeight;
end;

procedure TUser.SetCep(const AValue: String);
begin
  if FCEP = AValue then
    Exit;
  FCEP := AValue;
  IsValidCep(True);
end;

procedure TUser.SetAddress(const AValue: String);
begin
  if FAddress = AValue then
    Exit;
  FAddress := AValue;
  IsValidAddress;
end;

procedure TUser.SetNumber(const AValue: String);
begin
  if FNumber = AValue then
    Exit;
  FNumber := AValue;
  IsValidNumber;
end;

procedure TUser.SetDistrict(const AValue: String);
begin
  if FDistrict = AValue then
    Exit;
  FDistrict := AValue;
  IsValidDistrict;
end;

procedure TUser.SetCity(const AValue: String);
begin
  if FCity = AValue then
    Exit;
  FCity := AValue;
  IsValidCity;
end;

procedure TUser.SetUf(const AValue: String);
begin
  if FUF = AValue then
    Exit;
  FUF := AValue;
  IsValidUf;
end;
{$EndRegion}

{$Region'Valid'}
function TUser.IsValidName: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FName.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome não pode ser vazio.';
  end
  else if FName.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateName) then
    FOnValidateName(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidCpf(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsCpf(FCPF, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FCPF.Length = 11 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateCpf) then
    FOnValidateCpf(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidCnh(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FCNH.IsEmpty then
    if not TMyType.IsCnh(FCNH, LDescriptionError) then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FCNH.Length = 11 then
          LValid.Msg := LDescriptionError;
      end
      else
        LValid.Msg := LDescriptionError;
    end;

  if Assigned(FOnValidateCnh) then
    FOnValidateCnh(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidPis(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FPIS.IsEmpty then
    if not TMyType.IsPis(FPIS, LDescriptionError) then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FPIS.Length = 11 then
          LValid.Msg := LDescriptionError;
      end
      else
        LValid.Msg := LDescriptionError;
    end;

  if Assigned(FOnValidatePis) then
    FOnValidatePis(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidEmail(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsEmail(FEmail, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FEmail.Length >= 8 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateEmail) then
    FOnValidateEmail(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidWhatsapp(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsCellPhone(FWhatsapp, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FWhatsapp.Length = 11 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateWhatsapp) then
    FOnValidateWhatsapp(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidPhone(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FPhone.IsEmpty then
  begin
    if FPhone.Length <= 10 then
    begin
      if not TMyType.IsTelephone(FPhone, LDescriptionError) then
      begin
        Result := False;
        LValid.IsValid := False;
        if ALength then
        begin
          if FPhone.Length = 10 then
            LValid.Msg := LDescriptionError;
        end
        else
          LValid.Msg := LDescriptionError;
      end;
    end
    else
    begin
      if not TMyType.IsCellPhone(FPhone, LDescriptionError) then
      begin
        Result := False;
        LValid.IsValid := False;
        if ALength then
        begin
          if FPhone.Length = 11 then
            LValid.Msg := LDescriptionError;
        end
        else
          LValid.Msg := LDescriptionError;
      end;
    end;
  end;

  if Assigned(FOnValidatePhone) then
    FOnValidatePhone(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidGender: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FGender = TGender.gdNone then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Selecione uma das opções.';
  end;

  if Assigned(FOnValidateGender) then
    FOnValidateGender(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidBirthday(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FBirthday.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Informe a data de nascimento.';
  end
  else if not TMyType.IsDate(FBirthday, '/', TDateFormat.ddmmyyyy, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FBirthday.Length = 10 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateBirthday) then
    FOnValidateBirthday(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidHeight: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FHeight <= 0 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Informe sua altura.';
  end;

  if Assigned(FOnValidateHeight) then
    FOnValidateHeight(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidWeight: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FWeight <= 0 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Informe seu peso.';
  end;

  if Assigned(FOnValidateWeight) then
    FOnValidateWeight(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidCep(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsCep(FCEP, LDescriptionError, '') then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FCEP.Length = 8 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateCep) then
    FOnValidateCep(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidAddress: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FAddress.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Endereço não pode ser vazio.';
  end
  else if FAddress.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Endereço deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateAddress) then
    FOnValidateAddress(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidNumber: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FNumber.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Número não pode ser vazio.';
  end;

  if Assigned(FOnValidateNumber) then
    FOnValidateNumber(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidDistrict: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FDistrict.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Bairro não pode ser vazio.';
  end
  else if FDistrict.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Bairro deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateDistrict) then
    FOnValidateDistrict(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidCity: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FCity.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade não pode ser vazio.';
  end
  else if FCity.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateCity) then
    FOnValidateCity(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TUser.IsValidUf: Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsUf(FUF, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateUf) then
    FOnValidateUf(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

{$Region'Company'}

{ TCompany }

{$Region'Sets'}
procedure TCompany.SetName(const AValue: String);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  IsValidName;
end;

procedure TCompany.SetAddress(const AValue: String);
begin
  if FAddress = AValue then
    Exit;
  FAddress := AValue;
  IsValidAddress;
end;

procedure TCompany.SetCity(const AValue: String);
begin
  if FCity = AValue then
    Exit;
  FCity := AValue;
  IsValidCity;
end;

procedure TCompany.SetUf(const AValue: String);
begin
  if FUF = AValue then
    Exit;
  FUF := AValue;
  IsValidUf;
end;

procedure TCompany.SetCnpj(const AValue: String);
begin
  if FCNPJ = AValue then
    Exit;
  FCNPJ := AValue;
  IsValidCnpj(True);
end;

procedure TCompany.SetIe(const AValue: String);
begin
  if FIE = AValue then
    Exit;
  FIE := AValue;
  IsValidIe(True);
end;

procedure TCompany.SetSuframa(const AValue: String);
begin
  if FSuframa = AValue then
    Exit;
  FSuframa := AValue;
  IsValidSuframa(True);
end;

procedure TCompany.SetPhone(const AValue: String);
begin
  if FPhone = AValue then
    Exit;
  FPhone := AValue;
  IsValidPhone(True);
end;
{$EndRegion}

{$Region'Valid'}
function TCompany.IsValidName: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FName.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome não pode ser vazio.';
  end
  else if FName.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateName) then
    FOnValidateName(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidAddress: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FAddress.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Endereço não pode ser vazio.';
  end
  else if FAddress.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Endereço deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateAddress) then
    FOnValidateAddress(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidCity: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FCity.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade não pode ser vazio.';
  end
  else if FCity.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateCity) then
    FOnValidateCity(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidUf: Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsUf(FUF, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateUf) then
    FOnValidateUf(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidCnpj(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsCnpj(FCNPJ, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FCNPJ.Length = 14 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateCnpj) then
    FOnValidateCnpj(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidIe(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsIe(FIE, FUF, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FIE.Length >= 8 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateIe) then
    FOnValidateIe(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidSuframa(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FSuframa.IsEmpty then
  begin
    if not TMyType.IsSuframa(FSuframa, LDescriptionError) then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FSuframa.Length >= 9 then
          LValid.Msg := LDescriptionError;
      end
      else
        LValid.Msg := LDescriptionError;
    end;
  end;

  if Assigned(FOnValidateSuframa) then
    FOnValidateSuframa(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TCompany.IsValidPhone(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FPhone.IsEmpty then
  begin
    if FPhone.Length <= 10 then
    begin
      if not TMyType.IsTelephone(FPhone, LDescriptionError) then
      begin
        Result := False;
        LValid.IsValid := False;
        if ALength then
        begin
          if FPhone.Length = 10 then
            LValid.Msg := LDescriptionError;
        end
        else
          LValid.Msg := LDescriptionError;
      end;
    end
    else
    begin
      if not TMyType.IsCellPhone(FPhone, LDescriptionError) then
      begin
        Result := False;
        LValid.IsValid := False;
        if ALength then
        begin
          if FPhone.Length = 11 then
            LValid.Msg := LDescriptionError;
        end
        else
          LValid.Msg := LDescriptionError;
      end;
    end;
  end;

  if Assigned(FOnValidatePhone) then
    FOnValidatePhone(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

{$Region'Bank'}

{ TBank }

{$Region'Sets'}
procedure TBank.SetAccount(const AValue: String);
begin
  if FAccount = AValue then
    Exit;
  FAccount := AValue;
  IsValidAccount;
end;

procedure TBank.SetAgency(const AValue: String);
begin
  if FAgency = AValue then
    Exit;
  FAgency := AValue;
  IsValidAgency;
end;

procedure TBank.SetBank(const AValue: String);
begin
  if FBank = AValue then
    Exit;
  FBank := AValue;
  IsValidBank;
end;

procedure TBank.SetCity(const AValue: String);
begin
  if FCity = AValue then
    Exit;
  FCity := AValue;
  IsValidCity;
end;

procedure TBank.SetUf(const AValue: String);
begin
  if FUF = AValue then
    Exit;
  FUF := AValue;
  IsValidUf;
end;
{$EndRegion}

{$Region'Valid'}
function TBank.IsValidAccount: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FAccount.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Conta não pode ser vazia.';
  end;

  if Assigned(FOnValidateAccount) then
    FOnValidateAccount(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TBank.IsValidAgency: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FAgency.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Agência não pode ser vazio.';
  end
  else if (FAgency.Length < 4) and (FAgency.Length > 5) then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Agência deve possuir entre 4 a 5 caracteres.';
  end;

  if Assigned(FOnValidateAgency) then
    FOnValidateAgency(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TBank.IsValidBank: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FBank.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Banco não pode ser vazio.';
  end
  else if FBank.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Banco deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateBank) then
    FOnValidateBank(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TBank.IsValidCity: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FCity.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade não pode ser vazio.';
  end
  else if FCity.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cidade deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateCity) then
    FOnValidateCity(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TBank.IsValidUf: Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsUf(FUF, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateUf) then
    FOnValidateUf(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

{$Region'Payment'}

{ TPayment }

function TPayment.GetExpirationDate: String;
begin
  if (FMonth.IsEmpty) or (FYear.IsEmpty) then
    Result := ''
  else
    Result := FMonth.PadLeft(2) + '/' + FYear.PadLeft(2);
end;

{$Region'Sets'}
procedure TPayment.SetNumber(const AValue: String);
begin
  if FNumber = AValue then
    Exit;
  FNumber := AValue;
  IsValidNumber(True);
end;

procedure TPayment.SetExpirationDate(const AValue: String);
begin
  FMonth := Copy(AValue, 1, 2);
  FYear := Copy(AValue, 3, 2);
  IsValidExpirationDate(True);
end;

procedure TPayment.SetCode(const AValue: String);
begin
  if FCode = AValue then
    Exit;
  FCode := AValue;
  IsValidCode(True);
end;

procedure TPayment.SetName(const AValue: String);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  IsValidName;
end;
{$EndRegion}

{$Region'Valid'}
function TPayment.IsValidNumber(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsCard(FNumber, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FNumber.Length = 16 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateNumber) then
    FOnValidateNumber(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TPayment.IsValidExpirationDate(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not IsValidMonth(LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if (FMonth.Length + FYear.Length) = 4 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end
  else if not IsValidYear(LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if (FMonth.Length + FYear.Length) = 4 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateExpirationDate) then
    FOnValidateExpirationDate(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TPayment.IsValidMonth(out ADescriptionErrors: String): Boolean;
begin
  Result := True;
  if FMonth.Length < 2 then
  begin
    Result := False;
    ADescriptionErrors := 'Mês com formato inválido.';
  end
  else if (StrToIntDef(FMonth, 0) < 1) or (StrToIntDef(FMonth, 0) > 12) then
  begin
    Result := False;
    ADescriptionErrors := 'Mês inválido.';
  end;
end;

function TPayment.IsValidYear(out ADescriptionErrors: String): Boolean;
var
  LDecade: Word;
  LYear: Word;
begin
  Result := True;
  if FYear.Length < 2 then
  begin
    Result := False;
    ADescriptionErrors := 'Ano com formato inválido.';
    Exit;
  end;

  LDecade := (StrToInt(Copy(DateToStr(Now), 7, 2)))*100;
  LYear := LDecade + StrToIntDef(FYear, 0);

  if (LYear < 1899) then
  begin
    Result := False;
    ADescriptionErrors := 'Ano inválido.';
    Exit;
  end;
end;

function TPayment.IsValidCode(const ALength: Boolean = False): Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FCode.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Código não pode ser vazio.';
  end
  else if (FCode.Length < 3) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FCode.Length = 3 then
        LValid.Msg := 'Código deve possuir 3 caracteres.';
    end
    else
      LValid.Msg := 'Código deve possuir 3 caracteres.';
  end;

  if Assigned(FOnValidateCode) then
    FOnValidateCode(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TPayment.IsValidName: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FName.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome não pode ser vazio.';
  end
  else if FName.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateName) then
    FOnValidateName(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

{$Region'TVehicle'}

{ TVehicle }

{$Region'Sets'}
procedure TVehicle.SetBrand(const AValue: String);
begin
  if FBrand = AValue then
    Exit;
  FBrand := AValue;
  IsValidBrand;
end;

procedure TVehicle.SetModel(const AValue: String);
begin
  if FModel = AValue then
    Exit;
  FModel := AValue;
  IsValidModel;
end;

procedure TVehicle.SetYear(const AValue: String);
begin
  if FYear = AValue then
    Exit;
  FYear := AValue;
  IsValidYear;
end;

procedure TVehicle.SetRenavam(const AValue: String);
begin
  if FRenavam = AValue then
    Exit;
  FRenavam := AValue;
  IsValidRenavam(True);
end;

procedure TVehicle.SetLicensePlate(const AValue: String);
begin
  if FLicensePlate = AValue then
    Exit;
  FLicensePlate := AValue;
  IsValidLicensePlate(True);
end;

procedure TVehicle.SetColor(const AValue: String);
begin
  if FColor = AValue then
    Exit;
  FColor := AValue;
  IsValidColor;
end;
{$EndRegion}

{$Region'Valid'}
function TVehicle.IsValidBrand: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FBrand.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Marca não pode ser vazio.';
  end
  else if FBrand.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Marca deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateBrand) then
    FOnValidateBrand(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TVehicle.IsValidModel: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FModel.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Modelo não pode ser vazio.';
  end
  else if FModel.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Modelo deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateModel) then
    FOnValidateModel(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TVehicle.IsValidYear(const ALength: Boolean): Boolean;
var
  LValid: TValid;
  LYear: Word;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FYear.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Ano não pode ser vazio.';
  end
  else if (FYear.Length < 4) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FYear.Length = 4 then
        LValid.Msg := 'Ano com formato inválido.';
    end
    else
      LValid.Msg := 'Ano com formato inválido.';
  end;

  LYear := StrToIntDef(FYear, 0);
  if (LYear < 1899) then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Ano inválido.';
  end;

  if Assigned(FOnValidateYear) then
    FOnValidateYear(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TVehicle.IsValidRenavam(const ALength: Boolean): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsRenavam(FRenavam, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FRenavam.Length = 11 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateRenavam) then
    FOnValidateRenavam(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TVehicle.IsValidLicensePlate(const ALength: Boolean): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsLicensePlate(FLicensePlate, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if FLicensePlate.Length = 7 then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateLicensePlate) then
    FOnValidateLicensePlate(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TVehicle.IsValidColor: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FColor.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cor não pode ser vazio.';
  end
  else if FColor.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Cor deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateColor) then
    FOnValidateColor(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

{$Region'TProduct'}

{ TProduct }

function TProduct.GetExpirationDateDte: TDate;
begin
  if IsValidExpirationDate(False) then
    Result := StrToDate(FExpirationDate)
  else
    Result := TDate(0);
end;

{$Region'Sets'}
procedure TProduct.SetName(const AValue: String);
begin
  if FName = AValue then
    Exit;
  FName := AValue;
  IsValidName;
end;

procedure TProduct.SetGtin(const AValue: String);
begin
  if FGTIN = AValue then
    Exit;
  FGTIN := AValue;
  IsValidGtin(True);
end;

procedure TProduct.SetPrice(const AValue: Currency);
begin
  if FPrice = AValue then
    Exit;
  FPrice := AValue;
  IsValidPrice;
end;

procedure TProduct.SetNcm(const AValue: String);
begin
  if FNCM = AValue then
    Exit;
  FNCM := AValue;
  IsValidNcm(True);
end;

procedure TProduct.SetCest(const AValue: String);
begin
  if FCEST = AValue then
    Exit;
  FCEST := AValue;
  IsValidCest(True);
end;

procedure TProduct.SetExpirationDate(const AValue: String);
begin
  if FExpirationDate = AValue then
    Exit;
  FExpirationDate := AValue;
  IsValidExpirationDate(True);
end;

procedure TProduct.SetWidth(const AValue: Double);
begin
  if FWidth = AValue then
    Exit;
  FWidth := AValue;
end;

procedure TProduct.SetHeight(const AValue: Double);
begin
  if FHeight = AValue then
    Exit;
  FHeight := AValue;
end;

procedure TProduct.SetLength(const AValue: Double);
begin
  if FLength = AValue then
    Exit;
  FLength := AValue;
end;

procedure TProduct.SetGrossWeight(const AValue: Double);
begin
  if FGrossWeight = AValue then
    Exit;
  FGrossWeight := AValue;
end;

procedure TProduct.SetLiquidWeight(const AValue: Double);
begin
  if FLiquidWeight = AValue then
    Exit;
  FLiquidWeight := AValue;
end;

procedure TProduct.SetQuantityVolumes(const AValue: Integer);
begin
  if FQuantityVolumes = AValue then
    Exit;
  FQuantityVolumes := AValue;
end;
{$EndRegion}

{$Region'Valid'}
function TProduct.IsValidName: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FName.IsEmpty then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome não pode ser vazio.';
  end
  else if FName.Length <= 2 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Nome deve possuir mais de 2 caracteres.';
  end;

  if Assigned(FOnValidateName) then
    FOnValidateName(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TProduct.IsValidGtin(const ALength: Boolean): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not TMyType.IsGtin(FGTIN, LDescriptionError) then
  begin
    Result := False;
    LValid.IsValid := False;
    if ALength then
    begin
      if (FGTIN.Length in [8, 12, 13, 14]) then
        LValid.Msg := LDescriptionError;
    end
    else
      LValid.Msg := LDescriptionError;
  end;

  if Assigned(FOnValidateGtin) then
    FOnValidateGtin(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TProduct.IsValidPrice: Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if FPrice <= 0 then
  begin
    Result := False;
    LValid.IsValid := False;
    LValid.Msg := 'Informe o preço.';
  end;

  if Assigned(FOnValidatePrice) then
    FOnValidatePrice(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TProduct.IsValidNcm(const ALength: Boolean): Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FNCM.IsEmpty then
    if FNCM.Length <> 8 then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FNCM.Length = 8 then
          LValid.Msg := 'NCM deve possuir 8 caracteres.';
      end
      else
        LValid.Msg := 'NCM deve possuir 8 caracteres.';
    end;

  if Assigned(FOnValidateNcm) then
    FOnValidateNcm(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TProduct.IsValidCest(const ALength: Boolean): Boolean;
var
  LValid: TValid;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FCEST.IsEmpty then
    if FCEST.Length <> 7 then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FCEST.Length = 7 then
          LValid.Msg := 'CEST deve possuir 7 caracteres.';
      end
      else
        LValid.Msg := 'CEST deve possuir 7 caracteres.';
    end;

  if Assigned(FOnValidateCest) then
    FOnValidateCest(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;

function TProduct.IsValidExpirationDate(const ALength: Boolean): Boolean;
var
  LValid: TValid;
  LDescriptionError: String;
begin
  LValid := TValid.Create;
  LValid.IsValid := True;
  Result := True;

  if not FExpirationDate.IsEmpty then
    if not TMyType.IsDate(FExpirationDate, '/', TDateFormat.ddmmyyyy, LDescriptionError) then
    begin
      Result := False;
      LValid.IsValid := False;
      if ALength then
      begin
        if FExpirationDate.Length = 10 then
          LValid.Msg := LDescriptionError;
      end
      else
        LValid.Msg := LDescriptionError;
    end;

  if Assigned(FOnValidateExpirationDate) then
    FOnValidateExpirationDate(LValid);
  if Assigned(LValid) then
    FreeAndNil(LValid);
end;
{$EndRegion}
{$EndRegion}

end.
