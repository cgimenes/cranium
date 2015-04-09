unit frmNovaVendaU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, CheckLst,
  Buttons;

type
  TfrmNovaVendaF = class(TForm)
    cbCategoria: TComboBox;
    btnFinalizar: TButton;
    gbCategoria: TGroupBox;
    gbAdicionados: TGroupBox;
    sgProdutos: TStringGrid;
    sgVenda: TStringGrid;
    lbTotal: TLabel;
    lbVlrTotal: TLabel;
    lbCategoria: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cbCategoriaClick(Sender: TObject);
    procedure sgProdutosDblClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure sgVendaDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimpaProdutos(Grid : TStringGrid; Valor : String);
    procedure Total;
    procedure ApagaProduto(Grid: TStringGrid; ARow: Integer);
    procedure ProdutoSelecionado;

  public

  end;

var
  frmNovaVendaF: TfrmNovaVendaF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation

uses DataU, frmProdutoSelecionadoVU, frmFinalizarVU;
{$R *.dfm}

procedure TfrmNovaVendaF.btnFinalizarClick(Sender: TObject);
var i : integer;
begin
  if lbVlrTotal.Caption = 'R$ 0,00' then
  begin
    Application.MessageBox('Sem produtos!', 'Nova Venda - Aviso do Sistema', mb_iconinformation+mb_ok);
    Exit;
  end;

  frmFinalizarVF := TfrmFinalizarVF.Create(nil);
  frmFinalizarVF.lbVlrTotal.Caption := lbVlrTotal.Caption;
  frmFinalizarVF.ShowModal;

  if frmFinalizarVF.vSalvou then
  begin
    ComandoSQL('INSERT INTO ' + ' VENDA ' +
               ' VALUES  ' +
               '    (' + frmFinalizarVF.edtCodigo.Text +
               '   , ' + ' (SELECT CODIGO FROM PESSOA WHERE NOME = ' + QuotedStr(frmFinalizarVF.cbCliente.Text) + ')' +
               '   , ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) +
               '   , ' + ' (SELECT CODIGO FROM TIPOPAGAMENTO WHERE NOME = ' + QuotedStr(frmFinalizarVF.cbTipoPagamento.Text) + ')' +
               '   , ' + ' (SELECT CODIGO FROM PESSOA WHERE NOME = ' + QuotedStr(frmFinalizarVF.cbVendedor.Text) + ')' +
               '   ) ');

    for i := 1 to sgVenda.RowCount - 1 do
    begin
      ComandoSQL('INSERT INTO ITENSVENDA ' +
                 ' VALUES ' +
                 '      ( ' + frmFinalizarVF.edtCodigo.Text +
                 '      , ' + sgVenda.Cells[0,i] +
                 '      , ' + sgVenda.Cells[2,i] +
                 '      , ' + StringReplace(FormatFloat('##,##0.00',StrToFloat(StringReplace(sgVenda.Cells[3,i], '.', '', [rfReplaceAll])) / StrToFloat(sgVenda.Cells[2,i])), ',', '.', [rfReplaceAll]) +
                 '   )    ');

      ComandoSQL(' UPDATE ESTOQUE SET ' +
                 ' QUANTIDADE = (SELECT QUANTIDADE FROM ESTOQUE WHERE CODIGO = ' + sgVenda.Cells[0,i] + ') - ' + sgVenda.Cells[2,i] +
                 ' WHERE CODIGO = ' + sgVenda.Cells[0,i]);
    end;

    Application.MessageBox('Gravado com sucesso!', 'Nova Venda - Aviso do Sistema', mb_iconinformation+mb_ok);
    LimpaProdutos(sgProdutos, 'Valor Un.');
    LimpaProdutos(sgVenda, 'Total');
    cbCategoria.ItemIndex := -1;
    Total;
  end;
  FreeAndNil(frmFinalizarVF);
end;

procedure TfrmNovaVendaF.cbCategoriaClick(Sender: TObject);
begin
  LimpaProdutos(sgProdutos, 'Valor Un.');

  dbSelect('SELECT ESTOQUE.DESCRICAO, ' +
           'ESTOQUE.CODIGO, ' +
           'ESTOQUE.VLRVENDA, ' +
           'ESTOQUE.QUANTIDADE ' +
           '  FROM ESTOQUE' +
           '      ,CATEGORIA' +
           ' WHERE ESTOQUE.CATEGORIA = CATEGORIA.CODIGO' +
           '   AND CATEGORIA.NOME = ' + QuotedStr(cbCategoria.Text) +
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
end;

procedure TfrmNovaVendaF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNovaVendaF.FormShow(Sender: TObject);
begin
  dbSelect('SELECT NOME FROM CATEGORIA WHERE ATIVO = 1');
  while not DataF.dbQuery.Eof do
  begin
    cbCategoria.Items.Add(DataF.dbQuery.FieldByName('NOME').AsString);
    DataF.dbQuery.Next;
  end;
  LimpaProdutos(sgProdutos, 'Valor Un.');
  LimpaProdutos(sgVenda, 'Total');
end;

procedure TfrmNovaVendaF.LimpaProdutos(Grid : TStringGrid; Valor : String);
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

procedure TfrmNovaVendaF.sgProdutosDblClick(Sender: TObject);
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

procedure TfrmNovaVendaF.ProdutoSelecionado;
begin
  frmProdutoSelecionadoVF := TfrmProdutoSelecionadoVF.Create(nil);

  frmProdutoSelecionadoVF.edtCodigo.Text := sgProdutos.Cells[0, sgProdutos.Row];
  frmProdutoSelecionadoVF.edtDescricao.Text := sgProdutos.Cells[1, sgProdutos.Row];
  frmProdutoSelecionadoVF.edtValorUn.Text := sgProdutos.Cells[3, sgProdutos.Row];

  frmProdutoSelecionadoVF.ShowModal;

  if frmProdutoSelecionadoVF.vSalvou then
  begin
    With sgVenda do
    begin
      if Cells[1,1] <> '' then
        sgVenda.RowCount := sgVenda.RowCount + 1;
      sgVenda.Cells[0,sgVenda.RowCount - 1] := frmProdutoSelecionadoVF.edtCodigo.Text;
      sgVenda.Cells[1,sgVenda.RowCount - 1] := frmProdutoSelecionadoVF.edtDescricao.Text;
      sgVenda.Cells[2,sgVenda.RowCount - 1] := frmProdutoSelecionadoVF.edtQuantidade.Text;
      sgVenda.Cells[3,sgVenda.RowCount - 1] := FormatFloat('##,##0.00',StrToFloat(StringReplace(frmProdutoSelecionadoVF.edtTotal.Text, '.', '', [rfReplaceAll])));
    end;
    Total;
  end;
  FreeAndNil(frmProdutoSelecionadoVF);
end;

procedure TfrmNovaVendaF.sgVendaDblClick(Sender: TObject);
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

procedure TfrmNovaVendaF.Total;
var Total : Currency;
    i : integer;
begin
  Total := 0;
  for i := 1 to sgVenda.RowCount - 1 do
    if sgVenda.Cells[3,1] <> '' then
      Total := Total + StrToFloat(StringReplace(sgVenda.Cells[3,i], '.', '', [rfReplaceAll]));
  lbVlrTotal.Caption := 'R$ ' + FormatFloat('##,##0.00', StrToFloat(StringReplace(FloatToStr(Total), '.', '', [rfReplaceAll])));
end;

procedure TfrmNovaVendaF.ApagaProduto(Grid: TStringGrid; ARow: Integer);
var i: Integer;
begin
  with Grid do
  begin
    for i := ARow to RowCount-2 do Rows[i].Assign(Rows[i+1]);
    If RowCount = 2 then
      Rows[1].Clear
    else
      RowCount := RowCount - 1;
  end;
  Total;
end;
end.

