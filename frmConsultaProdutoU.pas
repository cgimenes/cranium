unit frmConsultaProdutoU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TfrmConsultaProdutoF = class(TForm)
    cbConsultas: TComboBox;
    edtConsultas: TEdit;
    btnConsultas: TButton;
    lbConsultas: TLabel;
    sgConsultas: TStringGrid;
    cbCategoria: TComboBox;
    lbTipo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConsultasClick(Sender: TObject);
    procedure cbConsultasClick(Sender: TObject);
    procedure sgConsultasDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frmConsultaProdutoF: TfrmConsultaProdutoF;

implementation
uses DataU, frmNovoProdutoU;
{$R *.dfm}

procedure TfrmConsultaProdutoF.btnConsultasClick(Sender: TObject);
begin
  if cbConsultas.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de consulta!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
    cbConsultas.SetFocus;
    exit;
  end;
  if (cbConsultas.Text <> 'CATEGORIA') and (edtConsultas.Text = '') then
  begin
    Application.MessageBox('Digite algo para consultar!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
    edtConsultas.SetFocus;
    exit;
  end;
  if (cbConsultas.Text = 'CATEGORIA') and (cbCategoria.ItemIndex = -1) then
  begin
    Application.MessageBox('Selecione uma categoria!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
    cbCategoria.SetFocus;
    exit;
  end;

  if cbConsultas.Text = 'DESCRIÇÃO' then
  begin
    dbSelect('SELECT  CODIGO,    '
          + '    DESCRICAO, '
          + '    VLRVENDA,  '
          + '    QUANTIDADE '
          + 'FROM ESTOQUE WHERE DESCRICAO LIKE '
          + QuotedStr('%' + edtConsultas.Text + '%'));
  end
  else if cbConsultas.Text = 'CÓDIGO' then
  begin
    dbSelect('SELECT  CODIGO,    '
          + '    DESCRICAO, '
          + '    VLRVENDA,  '
          + '    QUANTIDADE '
          + 'FROM ESTOQUE WHERE CODIGO = '
          + edtConsultas.Text);
  end
  else if cbConsultas.Text = 'CATEGORIA' then
  begin
    if cbCategoria.ItemIndex = -1 then
    begin
      Application.MessageBox('Selecione uma categoria!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
      exit;
    end;
    dbSelect('SELECT  CODIGO, '
          + '    DESCRICAO, '
          + '    VLRVENDA, '
          + '    QUANTIDADE '
          + 'FROM ESTOQUE WHERE CATEGORIA = (SELECT CODIGO FROM CATEGORIA WHERE CATEGORIA.NOME = '
          + QuotedStr(cbCategoria.Text)
          + ')');
  end;

  With sgConsultas do
  begin
    RowCount := 2;
    Rows[1].Clear;
    While not DataF.dbQuery.EOF do
    begin
      Cells[0,RowCount - 1] := DataF.dbQuery.FieldByName('CODIGO').AsString;
      Cells[1,RowCount - 1] := DataF.dbQuery.FieldByName('DESCRICAO').AsString;
      Cells[2,RowCount - 1] := FormatFloat('##,##0.00',DataF.dbQuery.FieldByName('VLRVENDA').AsFloat);
      Cells[3,RowCount - 1] := DataF.dbQuery.FieldByName('QUANTIDADE').AsString;
      DataF.dbQuery.Next;
      if not DataF.dbQuery.Eof then
        RowCount := RowCount + 1;
    end;
  end;
end;

procedure TfrmConsultaProdutoF.cbConsultasClick(Sender: TObject);
begin
  if cbConsultas.Text = 'CATEGORIA' then
  begin
    cbCategoria.Visible := TRUE;
    edtConsultas.Visible := FALSE;
    cbCategoria.Enabled := TRUE;
  end
  else
  begin
    cbCategoria.Visible := FALSE;
    edtConsultas.Visible := TRUE;
    cbCategoria.Enabled := FALSE;
  end;
end;

procedure TfrmConsultaProdutoF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConsultaProdutoF.FormShow(Sender: TObject);
begin
  With sgConsultas do
  begin
    Cells[0,0] := 'Código';
    Cells[1,0] := 'Descrição';
    Cells[2,0] := 'Valor Un.';
    Cells[3,0] := 'Quantidade';
  end;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM CATEGORIA WHERE ATIVO = 1');
    while not eof do
    begin
      cbCategoria.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
  end;
end;

procedure TfrmConsultaProdutoF.sgConsultasDblClick(Sender: TObject);
var i : integer;
begin
  if sgConsultas.Cells[0,1] = '' then
    exit;

  frmNovoProdutoF := TfrmNovoProdutoF.Create(nil);

  dbSelect('SELECT ESTOQUE.CODIGO, '
          +'       ESTOQUE.DESCRICAO, '
          +'       ESTOQUE.VLRUNITARIO, '
          +'       ESTOQUE.QUANTIDADE, '
          +'       CATEGORIA.NOME AS CATEGORIA,'
          +'       PESSOA.NOME AS FORNECEDOR,'
          +'       UNDMEDIDA.NOME AS UNDMEDIDA, '
          +'       ESTOQUE.VLRVENDA, '
          +'       ESTOQUE.ATIVO '
          +'FROM   ESTOQUE, '
          +'       CATEGORIA, '
          +'       PESSOA, '
          +'       UNDMEDIDA '
          +'WHERE  ESTOQUE.CODIGO = ' + sgConsultas.Cells[0, sgConsultas.Row]
          +'       AND CATEGORIA.CODIGO = ESTOQUE.CATEGORIA '
          +'       AND PESSOA.CODIGO = ESTOQUE.FORNECEDOR '
          +'       AND UNDMEDIDA.CODIGO = ESTOQUE.UNDMEDIDA ');

  With frmNovoProdutoF do
  begin
    for I := 0 To ComponentCount -1 Do
      If (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TComboBox)Then
        TEdit(Components[i]).Enabled := FALSE;

    btnGravar.Visible := FALSE;
    btnAlterar.Visible := TRUE;
    btnAlterar.Enabled := TRUE;
    btnAlterar.Default := TRUE;
  end;

  With DataF.dbQuery do
  begin
    frmNovoProdutoF.edtCodigo.Text := FieldByName('CODIGO').AsString;
    frmNovoProdutoF.edtDescricao.Text := FieldByName('DESCRICAO').AsString;
    frmNovoProdutoF.edtValorUnt.Text := FormatFloat('##,##0.00',FieldByName('VLRUNITARIO').AsFloat);
    frmNovoProdutoF.edtQuantidade.Text := FieldByName('QUANTIDADE').AsString;
    frmNovoProdutoF.cbCategoria.ItemIndex := frmNovoProdutoF.cbCategoria.Items.IndexOf(FieldByName('CATEGORIA').AsString);
    frmNovoProdutoF.cbFornecedor.ItemIndex := frmNovoProdutoF.cbFornecedor.Items.IndexOf(FieldByName('FORNECEDOR').AsString);
    frmNovoProdutoF.cbUndMedida.ItemIndex := frmNovoProdutoF.cbUndMedida.Items.IndexOf(FieldByName('UNDMEDIDA').AsString);
    frmNovoProdutoF.edtValorVenda.Text := FormatFloat('##,##0.00',FieldByName('VLRVENDA').AsFloat);
    if FieldByName('ATIVO').AsInteger = 1 then
      frmNovoProdutoF.chbAtivo.Checked := TRUE
    else
      frmNovoProdutoF.chbAtivo.Checked := FALSE;
  end;

  frmNovoProdutoF.ShowModal;
end;

end.

