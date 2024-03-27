program front;

uses
  System.StartUpCopy,
  FMX.Forms,
  index in 'index.pas' {IndexView},
  splash in 'splash.pas' {SplashView: TFrame},
  controls in 'controls.pas' {ControlsView: TFrame},
  mymask in '..\..\src\mymask.pas',
  mytype in '..\..\modules\mytype\src\mytype.pas',
  mystring in '..\..\modules\mystring\src\mystring.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TIndexView, IndexView);
  Application.Run;
end.
