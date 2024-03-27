unit send;

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

  //entities
  entities;

type
  TSendView = class(TFrame)
    lytMain: TLayout;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    aniIndicator: TAniIndicator;
  private
    { Private declarations }
    FEntity: TEntity;
    FOnDestroyPrevPage: TNotifyEvent;
    FOnNext: TNotifyEvent;

    procedure SetEntity(const Value: TEntity);
    procedure EmbedIn(AContainer: TFmxObject);
    procedure EntityExists;
    procedure DestroyPrevPage;
    procedure DisableControls;
    procedure EnabledControls;
    procedure ClearAnimations;
    procedure RunAnimations;
    procedure SendData;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Shows(AContainer: TFmxObject);

    property Entity: TEntity read FEntity write SetEntity;
    property OnDestroyPrevPage: TNotifyEvent read FOnDestroyPrevPage write FOnDestroyPrevPage;
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
  end;

implementation

{$R *.fmx}

{ TSendView }

constructor TSendView.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TSendView.Destroy;
begin

  inherited;
end;

procedure TSendView.SetEntity(const Value: TEntity);
begin
  FEntity := Value;
end;

procedure TSendView.EmbedIn(AContainer: TFmxObject);
begin
  EntityExists;
  while Self.ChildrenCount > 0 do
    Self.Children[0].Parent := AContainer;
  FParent := AContainer;
end;

procedure TSendView.EntityExists;
begin
  if not Assigned(FEntity) then
    raise Exception.Create('Impossible to show, there is no entity.');
end;

procedure TSendView.Shows(AContainer: TFmxObject);
begin
  EmbedIn(AContainer);
  DestroyPrevPage;
  DisableControls;
  ClearAnimations;
  RunAnimations;
  EnabledControls;
  SendData;
end;

procedure TSendView.DestroyPrevPage;
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

procedure TSendView.DisableControls;
begin
  lytMain.Enabled := False;
end;

procedure TSendView.EnabledControls;
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

procedure TSendView.ClearAnimations;
begin
  lytMain.Opacity := 0;
end;

procedure TSendView.RunAnimations;
begin
  TAnimator.AnimateFloatDelay(lytMain, 'Opacity', 1, 0.7, 0.3, TAnimationType.In, TInterpolationType.Linear);
  aniIndicator.Enabled := True;
end;

procedure TSendView.SendData;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(5000);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      if Assigned(FOnNext) then
        FOnNext(nil);
    end)
  end).Start;
end;

end.
