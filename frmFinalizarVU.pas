unit frmFinalizarVU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmFinalizarVF = class(TForm)
    cbCliente: TComboBox;
    cbVendedor: TComboBox;
    cbTipoPagamento: TComboBox;
    lbTotal: TLabel;
    lbVlrTotal: TLabel;
    btnFinalizar: TButton;
    edtCodigo: TEdit;
    lbCodigo: TLabel;
    lbTipoPagamento: TLabel;
    lbVendedor: TLabel;
    lbCliente: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    FvSalvou: Boolean;
    procedure SetvSalvou(const Value: Boolean);

  public
    property vSalvou : Boolean read FvSalvou write SetvSalvou;

  end;

var
  frmFinalizarVF: TfrmFinalizarVF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmFinalizarVF.btnFinalizarClick(Sender: TObject);
begin
  if cbCliente.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um cliente!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    cbCliente.SetFocus;
    exit;
  end;
  if cbVendedor.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um vendedor!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    cbVendedor.SetFocus;
    exit;
  end;
  if cbTipoPagamento.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de pagamento!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    cbTipoPagamento.SetFocus;
    exit;
  end;

  Self.FvSalvou := TRUE;
  Self.Close;
end;

procedure TfrmFinalizarVF.FormShow(Sender: TObject);
begin
  FvSalvou := FALSE;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM PESSOA WHERE TIPOCLIENTE = 1 AND ATIVO = 1');
    while not eof do
    begin
      cbCliente.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    dbSelect('SELECT NOME FROM PESSOA WHERE TIPOCOLABORADOR = 1 AND ATIVO = 1');
    while not eof do
    begin
      cbVendedor.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    dbSelect('SELECT NOME FROM TIPOPAGAMENTO WHERE ATIVO = 1');
    while not eof do
    begin
      cbTipoPagamento.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    dbSelect('SELECT MAX(CODIGO) MAXCODIGO FROM VENDA');
    edtCodigo.Text := IntToStr(FieldByName('MAXCODIGO').AsInteger + 1);
  end;
end;

procedure TfrmFinalizarVF.SetvSalvou(const Value: Boolean);
begin
  FvSalvou := Value;
end;
end.
