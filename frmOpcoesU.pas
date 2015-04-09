unit frmOpcoesU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, ComCtrls, ExtCtrls, StdCtrls;

type
  TfrmOpcoesF = class(TForm)
    tvOpcoes: TTreeView;
    pnlGeral: TPanel;
    chbAniversariante: TCheckBox;
    btnOK: TButton;
    btnCancelar: TButton;
    chbIniciaWindows: TCheckBox;
    procedure tvOpcoesClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var frmOpcoesF: TfrmOpcoesF;

implementation
uses IniciaComWindows;

{$R *.dfm}

procedure TfrmOpcoesF.btn1Click(Sender: TObject);
begin
  pnlGeral.BringToFront;
end;

procedure TfrmOpcoesF.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmOpcoesF.btnOKClick(Sender: TObject);
var Registro : TRegistry;
    Caminho : string;
begin
  Caminho := '"' + Application.ExeName + '"';

  RunOnStartup('Cranium', Caminho, chbIniciaWindows.Checked);

  Registro := TRegistry.Create;
  Registro.OpenKey('Cranium', TRUE);
  Registro.WriteBool('Aniversariante', chbAniversariante.Checked);
  Registro.CloseKey;
  Registro.Free;
  Self.Close;
end;

procedure TfrmOpcoesF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOpcoesF.FormShow(Sender: TObject);
var Registro : TRegistry;
begin
  Registro := TRegistry.Create;
  if Registro.OpenKey('Cranium',FALSE) then
  begin
    if Registro.ValueExists('Aniversariante') then
      chbAniversariante.Checked := Registro.ReadBool('Aniversariante');
  end;
  Registro.CloseKey;

  chbIniciaWindows.Checked := FALSE;
  Registro.RootKey := HKEY_LOCAL_MACHINE;
  Registro.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', FALSE);
  if Registro.ValueExists('Cranium') then
    chbIniciaWindows.Checked := TRUE;

  Registro.Free;
end;

procedure TfrmOpcoesF.tvOpcoesClick(Sender: TObject);
begin
  if tvOpcoes.Selected.Text = 'Geral' then
    pnlGeral.BringToFront;
end;
end.
