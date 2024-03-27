unit splash;

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
  FMX.Objects;

type
  TSplashView = class(TFrame)
    rctBg: TRectangle;
    imgSplash: TImage;
    aniIndicator: TAniIndicator;
    lytMain: TLayout;
    lblSubTitle: TLabel;
  private
    { Private declarations }
    FOnDestroyPrevPage: TNotifyEvent;
    FOnNext: TNotifyEvent;

    procedure EmbedIn(AContainer: TFmxObject);
    procedure DestroyPrevPage;
    procedure DisableControls;
    procedure EnabledControls;
    procedure ClearAnimations;
    procedure RunAnimations;
    procedure RunProcesses;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Shows(AContainer: TFmxObject);

    property OnDestroyPrevPage: TNotifyEvent read FOnDestroyPrevPage write FOnDestroyPrevPage;
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
  end;

implementation

{$R *.fmx}

{ TSplashView }

constructor TSplashView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TSplashView.Destroy;
begin

  inherited;
end;

procedure TSplashView.EmbedIn(AContainer: TFmxObject);
begin
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TSplashView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
  RunProcesses;
end;

procedure TSplashView.DestroyPrevPage;
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

procedure TSplashView.DisableControls;
begin

end;

procedure TSplashView.EnabledControls;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(1000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lytMain.Enabled := True;
    end)
  end).Start;
end;

procedure TSplashView.ClearAnimations;
begin

end;

procedure TSplashView.RunAnimations;
begin
  aniIndicator.Enabled := True;
end;

procedure TSplashView.RunProcesses;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(5000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      aniIndicator.Enabled := False;
      if Assigned(FOnNext) then
        FOnNext(nil);
    end)
  end).Start;
end;

end.
