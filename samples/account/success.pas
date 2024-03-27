unit success;

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
  FMX.Objects,
  FMX.VirtualKeyboard,
  FMX.Platform;

type
  TSuccessView = class(TFrame)
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
    procedure ClearAnimations;
    procedure RunAnimations;
    procedure HideKeyboard;
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

{ TSuccessView }

constructor TSuccessView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TSuccessView.Destroy;
begin

  inherited;
end;

procedure TSuccessView.EmbedIn(AContainer: TFmxObject);
begin
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TSuccessView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
end;

procedure TSuccessView.DestroyPrevPage;
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

procedure TSuccessView.DisableControls;
begin
  lytMain.Enabled := False;
end;

procedure TSuccessView.EnabledControls;
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

procedure TSuccessView.ClearAnimations;
begin
  lytMain.Opacity := 0;
end;

procedure TSuccessView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytMain, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
end;

procedure TSuccessView.HideKeyboard;
var
  Keyboard: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, Keyboard) then
  begin
    if TVirtualKeyBoardState.Visible in Keyboard.GetVirtualKeyBoardState then
      Keyboard.HideVirtualKeyboard;
  end;
end;

procedure TSuccessView.btnNextClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    btnNextTap(Sender, TPointF.Create(0, 0));
  {$ENDIF}
end;

procedure TSuccessView.btnNextTap(Sender: TObject; const Point: TPointF);
begin
  HideKeyboard;
  if Assigned(FOnNext) then
    FOnNext(nil);
end;

end.
