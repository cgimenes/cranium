unit frmProdutoSelecionadoVU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmProdutoSelecionadoVF = class(TForm)
    edtCodigo: TEdit;
    lbCodigo: TLabel;
    lbDescricao: TLabel;
    edtDescricao: TEdit;
    lbValorUn: TLabel;
    edtValorUn: TEdit;
    lbQuantidade: TLabel;
    edtQuantidade: TEdit;
    lbTotal: TLabel;
    edtTotal: TEdit;
    btnOK: TButton;
    procedure edtValorUnExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FvSalvou: Boolean;
    procedure SetvSalvou(const Value: Boolean);

  public

    property vSalvou : Boolean read FvSalvou write SetvSalvou;
  end;

var
  frmProdutoSelecionadoVF: TfrmProdutoSelecionadoVF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmProdutoSelecionadoVF.btnOKClick(Sender: TObject);
begin
  if edtQuantidade.Text = '' then
    edtQuantidade.Text := '0';

  if StrToInt(edtQuantidade.Text) <= 0 then
  begin
    Application.MessageBox('Digite uma quantidade positiva!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
    exit;
  end;

  self.vSalvou := TRUE;
  self.Close;
end;

procedure TfrmProdutoSelecionadoVF.edtQuantidadeExit(Sender: TObject);
begin
  if (edtQuantidade.Text = '') or (StrToInt(edtQuantidade.Text) <= 0) then
  begin
    Application.MessageBox('Digite uma quantidade maior que zero!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
    exit;
  end;

  dbSelect('SELECT QUANTIDADE FROM ESTOQUE WHERE CODIGO = ' + edtCodigo.text);
  if StrToInt(edtQuantidade.Text) > DataF.dbQuery.FieldByName('QUANTIDADE').asInteger then
  begin
    Application.MessageBox('Quantidade maior que a do estoque!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
  end
  else
  begin
    edtTotal.Text := FormatFloat('##,##0.00', StrToFloat(edtQuantidade.text) * StrToFloat(edtValorUn.text));
  end;
end;

procedure TfrmProdutoSelecionadoVF.edtValorUnExit(Sender: TObject);
Begin
  dbSelect('SELECT VLRUNITARIO FROM ESTOQUE WHERE CODIGO = ' + edtCodigo.text);
  if StrtoFloat(edtValorUn.Text) < DataF.dbQuery.FieldByName('VLRUNITARIO').asFloat then
  begin
    Application.MessageBox('Valor menor que o de venda!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    edtValorUn.SetFocus;
  end;
end;

procedure TfrmProdutoSelecionadoVF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmProdutoSelecionadoVF.FormShow(Sender: TObject);
begin
  FvSalvou := FALSE;
end;

procedure TfrmProdutoSelecionadoVF.SetvSalvou(const Value: Boolean);
begin
  FvSalvou := Value;
end;
end.

