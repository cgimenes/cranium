unit frmConsultaMovU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Grids;

type
  TfrmConsultaMovF = class(TForm)
    rgCV: TRadioGroup;
    dtpDataInicial: TDateTimePicker;
    sgConsultas: TStringGrid;
    btnConsultar: TButton;
    cbConsulta: TComboBox;
    lbConsultas: TLabel;
    edtConsultas: TEdit;
    lbAte: TLabel;
    dtpDataFinal: TDateTimePicker;
    lbTipo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure rgCVClick(Sender: TObject);
    procedure cbConsultaClick(Sender: TObject);
    procedure sgConsultasDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimpaGrid(TipoMov : string);

  public

  end;

var
  frmConsultaMovF: TfrmConsultaMovF;
  LinhaAtual : Integer;
  TipoMov : string;

procedure dbSelect(xSQL : String); stdcall;
    external 'CraniumResources.dll';

implementation
uses DataU, frmItensMovU;
{$R *.dfm}

procedure TfrmConsultaMovF.btnConsultarClick(Sender: TObject);
begin
  if cbConsulta.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de consulta!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    cbConsulta.SetFocus;
    exit;
  end;

  if (cbConsulta.ItemIndex <> -1) and (cbConsulta.Text <> 'DATA') and (edtConsultas.Text = '') then
  begin
    Application.MessageBox('Digite algo para consultar!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    edtConsultas.SetFocus;
    exit;
  end;

  TipoMov := rgCV.Items[rgCV.ItemIndex];
  LimpaGrid(rgCV.Items[rgCV.ItemIndex]);

  if rgCV.Items[rgCV.ItemIndex] = 'Venda' then
  begin
    if cbConsulta.Text = 'CÓDIGO' then
    begin
      dbSelect('SELECT VENDA.CODIGO, '
           + '       CLIENTE.NOME, '
           + '       VENDA.DATA, '
           + '       TIPOPAGAMENTO.NOME, '
           + '       VENDEDOR.NOME, '
           + '       SUM(ITENSVENDA.VLRUNITARIO)'
           + 'FROM   VENDA, '
           + '       PESSOA AS VENDEDOR, '
           + '       PESSOA AS CLIENTE, '
           + '       TIPOPAGAMENTO, '
           + '       ITENSVENDA '
           + 'WHERE  VENDA.CODIGO = ' + QuotedStr(edtConsultas.Text)
           + '       AND CLIENTE.CODIGO = VENDA.CODCLIENTE '
           + '       AND VENDEDOR.CODIGO = VENDA.VENDEDOR '
           + '       AND TIPOPAGAMENTO.CODIGO = VENDA.TIPOPAGAMENTO '
           + '       AND ITENSVENDA.CODIGO = VENDA.CODIGO '
           + 'GROUP BY VENDA.CODIGO, '
           + '         CLIENTE.NOME, '
           + '         VENDA.DATA, '
           + '         TIPOPAGAMENTO.NOME, '
           + '         VENDEDOR.NOME');
    end
    else if cbConsulta.Text = 'CLIENTE' then
    begin
      dbSelect('SELECT VENDA.CODIGO, '
           + '       CLIENTE.NOME, '
           + '       VENDA.DATA, '
           + '       TIPOPAGAMENTO.NOME, '
           + '       VENDEDOR.NOME, '
           + '       SUM(ITENSVENDA.VLRUNITARIO)'
           + 'FROM   VENDA, '
           + '       PESSOA AS VENDEDOR, '
           + '       PESSOA AS CLIENTE, '
           + '       TIPOPAGAMENTO, '
           + '       ITENSVENDA '
           + 'WHERE  CLIENTE.NOME LIKE ' + QuotedStr('%' + edtConsultas.Text + '%')
           + '       AND CLIENTE.CODIGO = VENDA.CODCLIENTE '
           + '       AND VENDEDOR.CODIGO = VENDA.VENDEDOR '
           + '       AND TIPOPAGAMENTO.CODIGO = VENDA.TIPOPAGAMENTO '
           + '       AND ITENSVENDA.CODIGO = VENDA.CODIGO '
           + 'GROUP BY VENDA.CODIGO, '
           + '         CLIENTE.NOME, '
           + '         VENDA.DATA, '
           + '         TIPOPAGAMENTO.NOME, '
           + '         VENDEDOR.NOME');
    end
    else if cbConsulta.Text = 'DATA' then
    begin
      dbSelect('SELECT VENDA.CODIGO, '
           + '       CLIENTE.NOME, '
           + '       VENDA.DATA, '
           + '       TIPOPAGAMENTO.NOME, '
           + '       VENDEDOR.NOME, '
           + '       SUM(ITENSVENDA.VLRUNITARIO)'
           + 'FROM   VENDA, '
           + '       PESSOA AS VENDEDOR, '
           + '       PESSOA AS CLIENTE, '
           + '       TIPOPAGAMENTO, '
           + '       ITENSVENDA '
           + 'WHERE  VENDA.DATA >= ' + QuotedStr(FormatDateTime('dd.MM.yyyy', dtpDataInicial.Date))
           + '       AND VENDA.DATA <= ' + QuotedStr(FormatDateTime('dd.MM.yyyy', dtpDataFinal.Date))
           + '       AND CLIENTE.CODIGO = VENDA.CODCLIENTE '
           + '       AND VENDEDOR.CODIGO = VENDA.VENDEDOR '
           + '       AND TIPOPAGAMENTO.CODIGO = VENDA.TIPOPAGAMENTO '
           + '       AND ITENSVENDA.CODIGO = VENDA.CODIGO '
           + 'GROUP BY VENDA.CODIGO, '
           + '         CLIENTE.NOME, '
           + '         VENDA.DATA, '
           + '         TIPOPAGAMENTO.NOME, '
           + '         VENDEDOR.NOME');
    end;

    with DataF.dbQuery do
    begin
      while not Eof do
      begin
        if sgConsultas.Cells[1,1] <> '' then
          sgConsultas.RowCount := sgConsultas.RowCount + 1;
        sgConsultas.Cells[0, sgConsultas.RowCount - 1] := FieldByName('CODIGO').AsString;
        sgConsultas.Cells[1, sgConsultas.RowCount - 1] := FieldByName('NOME').AsString;
        sgConsultas.Cells[2, sgConsultas.RowCount - 1] := FieldByName('DATA').AsString;
        sgConsultas.Cells[3, sgConsultas.RowCount - 1] := FieldByName('NOME_1').AsString;
        sgConsultas.Cells[4, sgConsultas.RowCount - 1] := FieldByName('NOME_2').AsString;
        sgConsultas.Cells[5, sgConsultas.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('SUM').AsFloat);
        Next;
      end;
    end;
  end
  else if rgCV.Items[rgCV.ItemIndex] = 'Compra' then
  begin
    if cbConsulta.Text = 'CÓDIGO' then
    begin
      dbSelect('SELECT COMPRA.CODIGO, '
             + '       FORNECEDOR.NOME, '
             + '       COMPRA.DATA, '
             + '       TIPOPAGAMENTO.NOME, '
             + '       SUM(ITENSCOMPRA.VLRUNITARIO)'
             + 'FROM   COMPRA, '
             + '       PESSOA AS FORNECEDOR, '
             + '       TIPOPAGAMENTO, '
             + '       ITENSCOMPRA '
             + 'WHERE  COMPRA.CODIGO = ' + QuotedStr(edtConsultas.Text)
             + '       AND FORNECEDOR.CODIGO = COMPRA.CODFORNECEDOR '
             + '       AND TIPOPAGAMENTO.CODIGO = COMPRA.TIPOPAGAMENTO '
             + '       AND ITENSCOMPRA.CODIGO = COMPRA.CODIGO '
             + 'GROUP BY COMPRA.CODIGO, '
             + '         FORNECEDOR.NOME, '
             + '         COMPRA.DATA, '
             + '         TIPOPAGAMENTO.NOME ');
    end
    else if cbConsulta.Text = 'FORNECEDOR' then
    begin
      dbSelect('SELECT COMPRA.CODIGO, '
             + '       FORNECEDOR.NOME, '
             + '       COMPRA.DATA, '
             + '       TIPOPAGAMENTO.NOME, '
             + '       SUM(ITENSCOMPRA.VLRUNITARIO)'
             + 'FROM   COMPRA, '
             + '       PESSOA AS FORNECEDOR, '
             + '       TIPOPAGAMENTO, '
             + '       ITENSCOMPRA '
             + 'WHERE FORNECEDOR.NOME LIKE ' + QuotedStr('%' + edtConsultas.Text + '%')
             + '       AND FORNECEDOR.CODIGO = COMPRA.CODFORNECEDOR '
             + '       AND TIPOPAGAMENTO.CODIGO = COMPRA.TIPOPAGAMENTO '
             + '       AND ITENSCOMPRA.CODIGO = COMPRA.CODIGO '
             + 'GROUP BY COMPRA.CODIGO, '
             + '         FORNECEDOR.NOME, '
             + '         COMPRA.DATA, '
             + '         TIPOPAGAMENTO.NOME ');
    end
    else if cbConsulta.Text = 'DATA' then
    begin
      dbSelect('SELECT COMPRA.CODIGO, '
             + '       FORNECEDOR.NOME, '
             + '       COMPRA.DATA, '
             + '       TIPOPAGAMENTO.NOME, '
             + '       SUM(ITENSCOMPRA.VLRUNITARIO)'
             + 'FROM   COMPRA, '
             + '       PESSOA AS FORNECEDOR, '
             + '       TIPOPAGAMENTO, '
             + '       ITENSCOMPRA '
             + 'WHERE  COMPRA.DATA >= ' + QuotedStr(FormatDateTime('dd.MM.yyyy', dtpDataInicial.Date))
             + '       AND COMPRA.DATA <= ' + QuotedStr(FormatDateTime('dd.MM.yyyy', dtpDataFinal.Date))
             + '       AND FORNECEDOR.CODIGO = COMPRA.CODFORNECEDOR '
             + '       AND TIPOPAGAMENTO.CODIGO = COMPRA.TIPOPAGAMENTO '
             + '       AND ITENSCOMPRA.CODIGO = COMPRA.CODIGO '
             + 'GROUP BY COMPRA.CODIGO, '
             + '         FORNECEDOR.NOME, '
             + '         COMPRA.DATA, '
             + '         TIPOPAGAMENTO.NOME ');
    end;

    with DataF.dbQuery do
    begin
      while not Eof do
      begin
        if sgConsultas.Cells[1,1] <> '' then
          sgConsultas.RowCount := sgConsultas.RowCount + 1;
        sgConsultas.Cells[0, sgConsultas.RowCount - 1] := FieldByName('CODIGO').AsString;
        sgConsultas.Cells[1, sgConsultas.RowCount - 1] := FieldByName('NOME').AsString;
        sgConsultas.Cells[2, sgConsultas.RowCount - 1] := FieldByName('DATA').AsString;
        sgConsultas.Cells[3, sgConsultas.RowCount - 1] := FieldByName('NOME_1').AsString;
        sgConsultas.Cells[4, sgConsultas.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('SUM').AsFloat);
        Next;
      end;
    end;
  end;
end;

procedure TfrmConsultaMovF.cbConsultaClick(Sender: TObject);
begin
  if cbConsulta.Text = 'DATA' then
  begin
    dtpDataInicial.Enabled := TRUE;
    dtpDataInicial.Visible := TRUE;
    dtpDataFinal.Enabled := TRUE;
    dtpDataFinal.Visible := TRUE;
    lbAte.Visible := TRUE;
    edtConsultas.Enabled := FALSE;
    edtConsultas.Visible := FALSE;
    dtpDataInicial.SetFocus;
  end
  else
  begin
    dtpDataInicial.Enabled := FALSE;
    dtpDataInicial.Visible := FALSE;
    dtpDataFinal.Enabled := FALSE;
    dtpDataFinal.Visible := FALSE;
    lbAte.Visible := FALSE;
    edtConsultas.Enabled := TRUE;
    edtConsultas.Visible := TRUE;
    edtConsultas.SetFocus;
  end;
end;

procedure TfrmConsultaMovF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConsultaMovF.FormShow(Sender: TObject);
begin
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date;
  rgCVClick(self);
end;

procedure TfrmConsultaMovF.LimpaGrid(TipoMov : string);
var i : integer;
begin
  with sgConsultas do
  begin
    Cells[0,0] := 'Código';
    Cells[2,0] := 'Data';
    Cells[3,0] := 'Tipo Pgto.';
    if TipoMov = 'Venda' then
    begin
      Cells[1,0] := 'Cliente';
      Cells[4,0] := 'Vendedor';
      Cells[5,0] := 'Total';
      for i := 1 to RowCount - 1 do
        Rows[i].Clear;
      RowCount := 2;
      ColCount := 6;
      Rows[1].Clear;
      ColWidths[0] := 53;
      ColWidths[1] := 182;
      ColWidths[2] := 79;
      ColWidths[3] := 84;
      ColWidths[4] := 193;
      ColWidths[5] := 121;
    end
    else if TipoMov = 'Compra' then
    begin
      Cells[1,0] := 'Fornecedor';
      Cells[4,0] := 'Total';
      for i := 1 to RowCount - 1 do
        Rows[i].Clear;
      RowCount := 2;
      ColCount := 5;
      ColWidths[0] := 53;
      ColWidths[1] := 220;
      ColWidths[2] := 79;
      ColWidths[3] := 84;
      ColWidths[4] := 121;
    end;
  end;
end;

procedure TfrmConsultaMovF.rgCVClick(Sender: TObject);
begin
  edtConsultas.Text := '';
  LimpaGrid(rgCV.Items[rgCV.ItemIndex]);
  cbConsulta.Clear;
  cbConsulta.Items.Add('CÓDIGO');
  if rgCV.Items[rgCV.ItemIndex] = 'Venda' then
    cbConsulta.Items.Add('CLIENTE');
  if rgCV.Items[rgCV.ItemIndex] = 'Compra' then
    cbConsulta.Items.Add('FORNECEDOR');
  cbConsulta.Items.Add('DATA');
  cbConsulta.ItemIndex := -1;
  cbConsultaClick(self);
end;

procedure TfrmConsultaMovF.sgConsultasDblClick(Sender: TObject);
begin
  if sgConsultas.Cells[0,1] = '' then
    exit;

  if TipoMov = 'Venda' then
  begin
    dbSelect(' SELECT ITENSVENDA.CODIGO,'
          + '         ITENSVENDA.CODPRODUTO AS CODIGOPRODUTO,'
          + '         ESTOQUE.DESCRICAO,'
          + '         ITENSVENDA.QUANTIDADE,'
          + '         ITENSVENDA.VLRUNITARIO'
          + ' FROM ESTOQUE,'
          + '      ITENSVENDA,'
          + '      VENDA'
          + ' WHERE ITENSVENDA.CODIGO = VENDA.CODIGO'
          + '   AND ITENSVENDA.CODPRODUTO = ESTOQUE.CODIGO'
          + '   AND VENDA.CODIGO = ' + sgConsultas.Cells[0,sgConsultas.Row]);
  end
  else if TipoMov = 'Compra' then
  begin
    dbSelect(' SELECT ITENSCOMPRA.CODIGO,'
          + '         ITENSCOMPRA.CODPRODUTO AS CODIGOPRODUTO,'
          + '         ESTOQUE.DESCRICAO,'
          + '         ITENSCOMPRA.QUANTIDADE,'
          + '         ITENSCOMPRA.VLRUNITARIO'
          + ' FROM ESTOQUE,'
          + '      ITENSCOMPRA,'
          + '      COMPRA'
          + ' WHERE ITENSCOMPRA.CODIGO = COMPRA.CODIGO'
          + '   AND ITENSCOMPRA.CODPRODUTO = ESTOQUE.CODIGO'
          + '   AND COMPRA.CODIGO = ' + sgConsultas.Cells[0,sgConsultas.Row]);
  end;

  With DataF.dbQuery do
  begin
    frmItensMovF := TfrmItensMovF.Create(nil);
    while not eof do
    begin
      if frmItensMovF.sgItens.Cells[0, 1] <> '' then
        frmItensMovF.sgItens.RowCount := frmItensMovF.sgItens.RowCount + 1;
      frmItensMovF.sgItens.Cells[0, frmItensMovF.sgItens.RowCount - 1] := FieldByName('CODIGOPRODUTO').AsString;
      frmItensMovF.sgItens.Cells[1, frmItensMovF.sgItens.RowCount - 1] := FieldByName('DESCRICAO').AsString;
      frmItensMovF.sgItens.Cells[2, frmItensMovF.sgItens.RowCount - 1] := FieldByName('QUANTIDADE').AsString;
      frmItensMovF.sgItens.Cells[3, frmItensMovF.sgItens.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('VLRUNITARIO').AsFloat * FieldByName('QUANTIDADE').AsInteger);
      Next;
    end;
    frmItensMovF.ShowModal;
  end;
end;

end.

