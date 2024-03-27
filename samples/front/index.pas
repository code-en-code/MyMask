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
  FMX.Ani,
  FMX.Effects,
  FMX.Objects,
  FMX.Layouts,

  //view
  splash,
  controls;

type
  TIndexView = class(TForm)
    lytMain: TLayout;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
  private
    { Private declarations }
    FSplash: TSplashView;
    FControls: TControlsView;

    procedure CleanContainer;

    procedure ShowSplash(ADestroyPrevPage: TNotifyEvent);
    procedure NextSplash(Sender: TObject);
    procedure DestroySplash(Sender: TObject);

    procedure ShowControls(ADestroyPrevPage: TNotifyEvent);
  public
    { Public declarations }
  end;

var
  IndexView: TIndexView;

implementation

{$R *.fmx}

{$Region'Infra'}
procedure TIndexView.FormDestroy(Sender: TObject);
begin
  if Assigned(FSplash) then
    FreeAndNil(FSplash);
  if Assigned(FControls) then
    FreeAndNil(FControls);
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
  ShowSplash(nil);
end;

procedure TIndexView.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if Assigned(FControls) then
  begin
    FControls.KeyBounds := Bounds;
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
  ShowControls(DestroySplash);
end;

procedure TIndexView.DestroySplash(Sender: TObject);
begin
  if Assigned(FSplash) then
    FreeAndNil(FSplash);
end;
{$EndRegion}

{$Region'Controls'}
procedure TIndexView.ShowControls(ADestroyPrevPage: TNotifyEvent);
begin
  if Assigned(FControls) then
    FreeAndNil(FControls);
  FControls := TControlsView.Create(nil);
  FControls.OnDestroyPrevPage := ADestroyPrevPage;
  FControls.Shows(lytMain);
end;
{$EndRegion}

end.
