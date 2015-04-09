unit frmNovaCompraU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, CheckLst, Buttons;

type
  TfrmNovaCompraF = class(TForm)
    cbFornecedor: TComboBox;
    btnFinalizar: TButton;
    gbFornecedor: TGroupBox;
    gbAdicionados: TGroupBox;
    sgProdutos: TStringGrid;
    sgVenda: TStringGrid;
    lbTotal: TLabel;
    lbVlrTotal: TLabel;
    lbFornecedor: TLabel;
    btnTroca: TButton;
    procedure FormShow(Sender: TObject);
    procedure cbFornecedorClick(Sender: TObject);
    procedure sgProdutosDblClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure sgVendaDblClick(Sender: TObject);
    procedure btnTrocaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimpaProdutos(Grid : TStringGrid; Valor : String);
    procedure Total;
    procedure ApagaProduto(Grid: TStringGrid; ARow: Integer);
    procedure ProdutoSelecionado;

  public

  end;

var
  frmNovaCompraF: TfrmNovaCompraF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU, frmProdutoSelecionadoCU, frmFinalizarCU;
{$R *.dfm}

procedure TfrmNovaCompraF.btnFinalizarClick(Sender: TObject);
var i : integer;
begin
  if lbVlrTotal.Caption = 'R$ 0,00' then
  begin
    Application.MessageBox('Sem produtos!', 'Nova Venda - Aviso do Sistema', mb_iconinformation+mb_ok);
    Exit;
  end;

  frmFinalizarCF := TfrmFinalizarCF.Create(nil);
  frmFinalizarCF.lbVlrTotal.Caption := lbVlrTotal.Caption;
  frmFinalizarCF.ShowModal;

  if frmFinalizarCF.vSalvou then
  begin
    ComandoSQL('INSERT INTO COMPRA ' +
               ' VALUES  ' +
               '    (' + frmFinalizarCF.edtCodigo.Text +
               '   , ' + ' (SELECT CODIGO FROM PESSOA WHERE NOME = ' + QuotedStr(cbFornecedor.Text) + ')' +
               '   , ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) +
               '   , ' + ' (SELECT CODIGO FROM TIPOPAGAMENTO WHERE NOME = ' + QuotedStr(frmFinalizarCF.cbTipoPagamento.Text) + ')' +
               '   ) ');

    for i := 1 to sgVenda.RowCount - 1 do
    begin
      ComandoSQL('INSERT INTO ITENSCOMPRA ' +
                 ' VALUES ' +
                 '      ( ' + frmFinalizarCF.edtCodigo.Text +
                 '      , ' + sgVenda.Cells[0,i] +
                 '      , ' + sgVenda.Cells[2,i] +
                 '      , ' + StringReplace(FormatFloat('##,##0.00',StrToFloat(StringReplace(sgVenda.Cells[3,i], '.', '', [rfReplaceAll])) / StrToFloat(sgVenda.Cells[2,i])), ',', '.', [rfReplaceAll]) +
                 '   )    ');

      ComandoSQL(' UPDATE ESTOQUE SET ' +
                 ' QUANTIDADE = (SELECT QUANTIDADE FROM ESTOQUE WHERE CODIGO = ' + sgVenda.Cells[0,i] + ') + ' + sgVenda.Cells[2,i] +
                 ' WHERE CODIGO = ' + sgVenda.Cells[0,i]);
    end;

    Application.MessageBox('Gravado com sucesso!', 'Nova Venda - Aviso do Sistema', mb_iconinformation+mb_ok);
    LimpaProdutos(sgProdutos, 'Valor Un.');
    LimpaProdutos(sgVenda, 'Total');
    cbFornecedor.ItemIndex := -1;
    lbFornecedor.Enabled := TRUE;
    cbFornecedor.Enabled := TRUE;
    Total;
  end;
  FreeAndNil(frmFinalizarCF);
end;

procedure TfrmNovaCompraF.btnTrocaClick(Sender: TObject);
begin
  if Application.MessageBox('Já existem produtos adicionados ao pedido,' +
    #13#10 + 'ao trocar o fornecedor, todo o pedido será apagado!' +
    #13#10 + 'Deseja realmente trocar de fornecedor?',
    'Atenção', MB_YESNO + MB_ICONWARNING) = IDYES then
  begin
    LimpaProdutos(sgProdutos, 'Valor Un.');
    LimpaProdutos(sgVenda, 'Total');
    lbFornecedor.Enabled := TRUE;
    cbFornecedor.Enabled := TRUE;
    cbFornecedor.ItemIndex := -1;
    btnTroca.Enabled := FALSE;
    Total;
  end;
end;

procedure TfrmNovaCompraF.cbFornecedorClick(Sender: TObject);
begin
  LimpaProdutos(sgProdutos, 'Valor Un.');

  dbSelect('SELECT ESTOQUE.DESCRICAO, ' +
           'ESTOQUE.CODIGO, ' +
           'ESTOQUE.VLRVENDA, ' +
           'ESTOQUE.QUANTIDADE ' +
           '  FROM ESTOQUE' +
           '      ,PESSOA' +
           ' WHERE ESTOQUE.FORNECEDOR = PESSOA.CODIGO' +
           '   AND PESSOA.NOME = ' + QuotedStr(cbFornecedor.Text) +
           '   AND ESTOQUE.ATIVO = 1');

  With sgProdutos do
  begin
    while not DataF.dbQuery.Eof do
    begin
      Cells[0,RowCount - 1] := DataF.dbQuery.FieldByName('CODIGO').AsString;
      Cells[1,RowCount - 1] := DataF.dbQuery.FieldByName('DESCRICAO').AsString;
      Cells[2,RowCount - 1] := DataF.dbQuery.FieldByName('QUANTIDADE').AsString;
      Cells[3,RowCount - 1] := FormatFloat('##,##0.00',DataF.dbQuery.FieldByName('VlrVenda').AsFloat);
      DataF.dbQuery.Next;
      if not DataF.dbQuery.Eof then
        RowCount := RowCount + 1;
    end;
  end;
  lbFornecedor.Enabled := FALSE;
  cbFornecedor.Enabled := FALSE;
  btnTroca.Enabled := TRUE;
end;

procedure TfrmNovaCompraF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNovaCompraF.FormShow(Sender: TObject);
begin
  dbSelect('SELECT NOME FROM PESSOA WHERE TIPOFORNECEDOR = 1 AND ATIVO = 1');
  while not DataF.dbQuery.Eof do
  begin
    cbFornecedor.Items.Add(DataF.dbQuery.FieldByName('NOME').AsString);
    DataF.dbQuery.Next;
  end;
  LimpaProdutos(sgProdutos, 'Valor Un.');
  LimpaProdutos(sgVenda, 'Total');
end;

procedure TfrmNovaCompraF.LimpaProdutos(Grid : TStringGrid; Valor : String);
begin
  With Grid do
  begin
    Cells[0,0] := 'Código';
    Cells[1,0] := 'Descrição do produto';
    Cells[2,0] := 'Quantidade';
    Cells[3,0] := Valor;
    RowCount := 2;
    Rows[1].Clear;
  end;
end;

procedure TfrmNovaCompraF.sgProdutosDblClick(Sender: TObject);
var I: Integer;
begin
  if sgProdutos.Cells[0,1] = '' then
    exit;

  for I := 1 to sgVenda.RowCount - 1 do
  begin
    if sgVenda.Cells[0,I] = sgProdutos.Cells[0, sgProdutos.Row] then
    begin
      if Application.MessageBox('Este produto já está relacionado, deseja substituí-lo?',
        'Atenção', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        ApagaProduto(sgVenda,I);
        ProdutoSelecionado;
        exit;
      end
      else
      begin
        exit;
      end;
    end;
  end;
  ProdutoSelecionado;
end;

procedure TfrmNovaCompraF.ProdutoSelecionado;
begin
  frmProdutoSelecionadoCF := TfrmProdutoSelecionadoCF.Create(nil);

  frmProdutoSelecionadoCF.edtCodigo.Text := sgProdutos.Cells[0, sgProdutos.Row];
  frmProdutoSelecionadoCF.edtDescricao.Text := sgProdutos.Cells[1, sgProdutos.Row];
  frmProdutoSelecionadoCF.edtValorUn.Text := sgProdutos.Cells[3, sgProdutos.Row];

  frmProdutoSelecionadoCF.ShowModal;

  if frmProdutoSelecionadoCF.vSalvou then
  begin
    With sgVenda do
    begin
      if Cells[1,1] <> '' then
        sgVenda.RowCount := sgVenda.RowCount + 1;
      sgVenda.Cells[0,sgVenda.RowCount - 1] := frmProdutoSelecionadoCF.edtCodigo.Text;
      sgVenda.Cells[1,sgVenda.RowCount - 1] := frmProdutoSelecionadoCF.edtDescricao.Text;
      sgVenda.Cells[2,sgVenda.RowCount - 1] := frmProdutoSelecionadoCF.edtQuantidade.Text;
      sgVenda.Cells[3,sgVenda.RowCount - 1] := FormatFloat('##,##0.00',StrToFloat(StringReplace(frmProdutoSelecionadoCF.edtTotal.Text, '.', '', [rfReplaceAll])));
    end;
    Total;
  end;
  FreeAndNil(frmProdutoSelecionadoCF);
end;

procedure TfrmNovaCompraF.sgVendaDblClick(Sender: TObject);
begin
  if sgVenda.Cells[0,1] <> '' then
  begin
    if Application.MessageBox('Deseja realmente excluir esse produto do pedido?',
      'Confirmar exclusão - Aviso do sistema', MB_YESNO + MB_ICONQUESTION +
      MB_DEFBUTTON2) = IDYES then
    begin
      ApagaProduto(sgVenda,sgVenda.Row);
    end;
  end;
end;

procedure TfrmNovaCompraF.Total;
var Total : Currency;
    i : integer;
begin
  Total := 0;
  for i := 1 to sgVenda.RowCount - 1 do
    if sgVenda.Cells[3,1] <> '' then
      Total := Total + StrToFloat(StringReplace(sgVenda.Cells[3,i], '.', '', [rfReplaceAll]));
  lbVlrTotal.Caption := 'R$ ' + FormatFloat('##,##0.00', StrToFloat(StringReplace(FloatToStr(Total), '.', '', [rfReplaceAll])));
end;

procedure TfrmNovaCompraF.ApagaProduto(Grid: TStringGrid; ARow: Integer);
var i: Integer;
begin
  with Grid do
  begin
    for i := ARow to RowCount-2 do
      Rows[i].Assign(Rows[i+1]);
    If RowCount = 2 then
      Rows[1].Clear
    else
      RowCount := RowCount - 1;
  end;
  Total;
end;
end.

