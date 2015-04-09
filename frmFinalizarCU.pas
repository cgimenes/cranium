unit frmFinalizarCU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmFinalizarCF = class(TForm)
    cbTipoPagamento: TComboBox;
    lbTotal: TLabel;
    lbVlrTotal: TLabel;
    btnFinalizar: TButton;
    edtCodigo: TEdit;
    lbCodigo: TLabel;
    lbTipoPagamento: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    FvSalvou: Boolean;
    procedure SetvSalvou(const Value: Boolean);

  public
    property vSalvou : Boolean read FvSalvou write SetvSalvou;

  end;

var
  frmFinalizarCF: TfrmFinalizarCF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmFinalizarCF.btnFinalizarClick(Sender: TObject);
begin
  if cbTipoPagamento.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de pagamento!', 'Nova Compra - Erro do Sistema', mb_iconwarning+mb_ok);
    cbTipoPagamento.SetFocus;
    exit;
  end;
  Self.FvSalvou := TRUE;
  Self.Close;
end;

procedure TfrmFinalizarCF.FormShow(Sender: TObject);
begin
  FvSalvou := FALSE;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM TIPOPAGAMENTO WHERE ATIVO = 1');
    while not eof do
    begin
      cbTipoPagamento.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    dbSelect('SELECT MAX(CODIGO) MAXCODIGO FROM COMPRA');
    edtCodigo.Text := IntToStr(FieldByName('MAXCODIGO').AsInteger + 1);
  end;
end;

procedure TfrmFinalizarCF.SetvSalvou(const Value: Boolean);
begin
  FvSalvou := Value;
end;
end.
