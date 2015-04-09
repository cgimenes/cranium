program Cranium;

uses
  Forms,
  frmPrincipalU in 'frmPrincipalU.pas' {frmPrincipalF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gestor Cranium 0.2 BETA';
  Application.CreateForm(TfrmPrincipalF, frmPrincipalF);
  Application.Run;
end.
