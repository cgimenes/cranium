unit frmNovoProdutoU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmNovoProdutoF = class(TForm)
    lbCodigo: TLabel;
    edtCodigo: TEdit;
    lbDescricao: TLabel;
    edtDescricao: TEdit;
    lbValorVenda: TLabel;
    edtValorVenda: TEdit;
    lbValorUnt: TLabel;
    edtValorUnt: TEdit;
    lbQuantidade: TLabel;
    edtQuantidade: TEdit;
    cbCategoria: TComboBox;
    cbFornecedor: TComboBox;
    cbUndMedida: TComboBox;
    btnGravar: TButton;
    btnAlterar: TButton;
    lbCategoria: TLabel;
    lbUndMedida: TLabel;
    lbFornecedor: TLabel;
    chBAtivo: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure edtValorUntExit(Sender: TObject);
    procedure edtValorVendaExit(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbCategoriaChange(Sender: TObject);
    procedure cbUndMedidaChange(Sender: TObject);
  private

  public

  end;

var
  frmNovoProdutoF: TfrmNovoProdutoF;
  j : integer;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
  external 'CraniumResources.dll';

function ShowCategoria : integer; stdcall;
  external 'CraniumResources.dll';

function ShowFornecedor : integer; stdcall;
  external 'CraniumResources.dll';

function ShowUndMedida : integer; stdcall;
  external 'CraniumResources.dll';

implementation

uses DataU;

{$R *.dfm}

procedure TfrmNovoProdutoF.btnAlterarClick(Sender: TObject);
var xAtivo, i : integer;
begin
  j := j + 1;
  if j = 1 then
  begin
    for i := 0 To ComponentCount -1 Do
    begin
      If (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TComboBox)Then
        TEdit(Components[i]).Enabled := TRUE;
    end;
    edtQuantidade.Enabled := FALSE;
    lbQuantidade.Enabled := FALSE;
    chbAtivo.Enabled := TRUE;
  end
  else if j >= 2 then
  begin
    xAtivo := 0;
    if chBAtivo.Checked then
      xAtivo := 1;

    ComandoSQL('UPDATE ESTOQUE SET ' +
               '  DESCRICAO = ' + QuotedStr(edtDescricao.Text) +
               ', VLRUNITARIO = ' + StringReplace(edtValorUnt.Text, ',', '.', [rfReplaceAll]) +
               ', QUANTIDADE = ' + edtQuantidade.Text +
               ', CATEGORIA = (SELECT CODIGO FROM CATEGORIA WHERE CATEGORIA.NOME = ' + QuotedStr(cbCategoria.Text) + ')' +
               ', FORNECEDOR = (SELECT CODIGO FROM PESSOA WHERE PESSOA.NOME = ' + QuotedStr(cbFornecedor.Text) + ')' +
               ', UNDMEDIDA = (SELECT CODIGO FROM UNDMEDIDA WHERE UNDMEDIDA.NOME = ' + QuotedStr(cbUndMedida.Text) + ')' +
               ', VLRVENDA = ' + StringReplace(edtValorVenda.Text, ',', '.', [rfReplaceAll]) +
               ', ATIVO = ' + QuotedStr(IntToStr(xAtivo)) +
               ' WHERE CODIGO = ' + edtCodigo.Text);

    Application.MessageBox('Alterado com sucesso!', 'Alterar Produto - Aviso do Sistema', mb_iconinformation+mb_ok);
  end;
end;

procedure TfrmNovoProdutoF.btnGravarClick(Sender: TObject);
var xAtivo : integer;
begin
  if edtQuantidade.Text = '' then
    edtQuantidade.Text := '0';
  if edtDescricao.Text = '' then
  begin
    Application.MessageBox('Digite uma descrição!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    edtDescricao.SetFocus;
    exit;
  end;
  edtValorUntExit(self);
  edtValorVendaExit(self);
  if edtValorUnt.Text = '' then
  begin
    Application.MessageBox('Digite um valor unitário!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    edtValorUnt.SetFocus;
    exit;
  end;
  if edtValorVenda.Text = '' then
  begin
    Application.MessageBox('Digite um valor de venda!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    edtValorVenda.SetFocus;
    exit;
  end;
  if StrToFloat(edtValorVenda.Text) < StrToFloat(edtValorUnt.Text) then
  begin
    Application.MessageBox('Digite um valor de venda maior que o valor unitário!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    edtValorVenda.SetFocus;
    exit;
  end;
  if StrToInt(edtQuantidade.Text) < 0 then
  begin
    Application.MessageBox('Digite uma quantidade positiva ou zero!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    edtQuantidade.SetFocus;
    exit;
  end;
  if cbCategoria.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione uma categoria!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    cbCategoria.SetFocus;
    exit;
  end;
  if cbUndMedida.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione uma unidade de medida!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    cbUndMedida.SetFocus;
    exit;
  end;
  if cbFornecedor.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um fornecedor!', 'Novo Produto - Erro do Sistema', mb_iconwarning+mb_ok);
    cbFornecedor.SetFocus;
    exit;
  end;

  xAtivo := 0;
  if chBAtivo.Checked then
    xAtivo := 1;

  ComandoSQL('INSERT INTO ESTOQUE ' +
             ' VALUES  ' +
             '    (' + edtCodigo.Text +
             '   , ' + QuotedStr(edtDescricao.Text) +
             '   , ' + StringReplace(edtValorUnt.Text, ',', '.', [rfReplaceAll]) +
             '   , ' + edtQuantidade.Text +
             '   , ' + ' (SELECT CODIGO FROM CATEGORIA WHERE CATEGORIA.NOME = ' + QuotedStr(cbCategoria.Text) + ')' +
             '   , ' + ' (SELECT CODIGO FROM PESSOA WHERE PESSOA.NOME = ' + QuotedStr(cbFornecedor.Text) + ')' +
             '   , ' + ' (SELECT CODIGO FROM UNDMEDIDA WHERE UNDMEDIDA.NOME = ' + QuotedStr(cbUndMedida.Text) + ')' +
             '   , ' + StringReplace(edtValorVenda.Text, ',', '.', [rfReplaceAll]) +
             '   , ' + QuotedStr(IntToStr(xAtivo)) +
             '   ) ');

  Application.MessageBox('Gravado com sucesso!', 'Novo Produto - Aviso do Sistema', mb_iconinformation+mb_ok);

  FormCreate(self);
  edtDescricao.Text := '';
  edtValorVenda.Text := '';
  edtValorUnt.Text := '';
  edtQuantidade.Text := '';
  cbCategoria.ItemIndex := -1;
  cbFornecedor.ItemIndex := -1;
  cbUndMedida.ItemIndex := -1;
end;

procedure TfrmNovoProdutoF.cbCategoriaChange(Sender: TObject);
begin
  if cbCategoria.ItemIndex = 0 then
  begin
    ShowCategoria;
    FormCreate(nil);
  end;
end;

procedure TfrmNovoProdutoF.cbUndMedidaChange(Sender: TObject);
begin
  if cbUndMedida.ItemIndex = 0 then
  begin
    ShowUndMedida;
    FormCreate(nil);
  end;
end;

procedure TfrmNovoProdutoF.edtValorUntExit(Sender: TObject);
begin
  if edtValorUnt.Text = '' then
    exit;
  edtValorUnt.Text := FormatFloat('##,##0.00', StrToFloat(edtValorUnt.Text));
end;

procedure TfrmNovoProdutoF.edtValorVendaExit(Sender: TObject);
begin
  if edtValorVenda.Text = '' then
    exit;
  edtValorVenda.Text := FormatFloat('##,##0.00', StrToFloat(edtValorVenda.Text));
end;

procedure TfrmNovoProdutoF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNovoProdutoF.FormCreate(Sender: TObject);
begin
  j := 0;
  cbCategoria.Items.Clear;
  cbCategoria.Items.Add('NOVA CATEGORIA');
  cbFornecedor.Items.Clear;
  cbUndMedida.Items.Clear;
  cbUndMedida.Items.Add('NOVA UNIDADE DE MEDIDA');
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM CATEGORIA WHERE ATIVO = 1');
    while not eof do
    begin
      cbCategoria.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;

    dbSelect('SELECT NOME FROM PESSOA WHERE TIPOFORNECEDOR = 1');
    while not eof do
    begin
      cbFornecedor.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;

    dbSelect('SELECT NOME FROM UNDMEDIDA WHERE ATIVO = 1');
    while not eof do
    begin
      cbUndMedida.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;

    dbSelect('SELECT MAX(CODIGO) MAXCODIGO FROM ESTOQUE');
    edtCodigo.Text := IntToStr(FieldByName('MAXCODIGO').AsInteger + 1);
  end;
end;

end.

