unit frmItensMovU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TfrmItensMovF = class(TForm)
    sgItens: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frmItensMovF: TfrmItensMovF;

implementation

{$R *.dfm}

procedure TfrmItensMovF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmItensMovF.FormShow(Sender: TObject);
begin
  With sgItens do
  begin
    Cells[0,0] := 'Código';
    Cells[1,0] := 'Descrição do produto';
    Cells[2,0] := 'Quantidade';
    Cells[3,0] := 'Total';
  end;
end;

end.

