unit frmProdutoSelecionadoCU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmProdutoSelecionadoCF = class(TForm)
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
  frmProdutoSelecionadoCF: TfrmProdutoSelecionadoCF;

implementation

{$R *.dfm}

procedure TfrmProdutoSelecionadoCF.btnOKClick(Sender: TObject);
begin
  if edtQuantidade.Text = '' then
    edtQuantidade.Text := '0';

  if StrToInt(edtQuantidade.Text) <= 0 then
  begin
    Application.MessageBox('Digite uma quantidade positiva!', 'Nova Compra - Erro do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
    exit;
  end;

  self.vSalvou := TRUE;
  self.Close;
end;

procedure TfrmProdutoSelecionadoCF.edtQuantidadeExit(Sender: TObject);
begin
  if (edtQuantidade.Text = '') or (StrToInt(edtQuantidade.Text) <= 0) then
  begin
    Application.MessageBox('Digite uma quantidade maior que zero!', 'Nova Venda - Erro do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
    exit;
  end;

  edtTotal.Text := FormatFloat('##,##0.00', StrToFloat(edtQuantidade.text) * StrToFloat(edtValorUn.text));
end;

procedure TfrmProdutoSelecionadoCF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmProdutoSelecionadoCF.FormShow(Sender: TObject);
begin
  FvSalvou := FALSE;
end;

procedure TfrmProdutoSelecionadoCF.SetvSalvou(const Value: Boolean);
begin
  FvSalvou := Value;
end;
end.

