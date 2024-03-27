unit welcome;

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
  FMX.Ani,
  FMX.Objects;

type
  TWelcomeView = class(TFrame)
    lytMain: TLayout;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    btnNext: TButton;
    procedure btnNextClick(Sender: TObject);
    procedure btnNextTap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
    FOnDestroyPrevPage: TNotifyEvent;
    FOnNext: TNotifyEvent;

    procedure EmbedIn(AContainer: TFmxObject);
    procedure DestroyPrevPage;
    procedure DisableControls;
    procedure EnabledControls;
    procedure DefaultSettingsInControls;
    procedure ClearAnimations;
    procedure RunAnimations;
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

{ TWelcomeView }

constructor TWelcomeView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TWelcomeView.Destroy;
begin

  inherited;
end;

procedure TWelcomeView.EmbedIn(AContainer: TFmxObject);
begin
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TWelcomeView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  DefaultSettingsInControls;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
end;

procedure TWelcomeView.DestroyPrevPage;
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

procedure TWelcomeView.DisableControls;
begin
  lytMain.Enabled := False;
end;

procedure TWelcomeView.EnabledControls;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(1000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lytMain.Enabled := True;
      {$IFDEF MSWINDOWS}
        btnNext.SetFocus;
      {$ENDIF}
    end)
  end).Start;
end;

procedure TWelcomeView.DefaultSettingsInControls;
begin
  {$IFDEF MSWINDOWS}
    btnNext.CanFocus := True;
    btnNext.TabStop := True;
  {$ELSE}
    btnNext.CanFocus := False;
    btnNext.TabStop := False;
  {$ENDIF}
end;

procedure TWelcomeView.ClearAnimations;
begin
  lytMain.Opacity := 0;
end;

procedure TWelcomeView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytMain, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TWelcomeView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TWelcomeView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  if Assigned(FOnNext) then
    FOnNext(nil);
end;

end.
