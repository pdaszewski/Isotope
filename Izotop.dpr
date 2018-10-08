program Izotop;

uses
  Forms,
  OknoGl in 'OknoGl.pas' {AOknoGl};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Analiza Izotopów';
  Application.CreateForm(TAOknoGl, AOknoGl);
  Application.Run;
end.
