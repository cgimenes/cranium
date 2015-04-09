unit frmRltMovDataU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Grids, Printers;

type
  TfrmRltMovDataF = class(TForm)
    rgCV: TRadioGroup;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    lbDataInicial: TLabel;
    lbDataFinal: TLabel;
    sgRelatorios: TStringGrid;
    btnGerar: TButton;
    btnImprimir: TButton;
    btnNovoRlt: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnNovoRltClick(Sender: TObject);
    procedure rgCVClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimpaGrid(TipoMov : string);

  public

  end;

var
  frmRltMovDataF: TfrmRltMovDataF;
  LinhaAtual : Integer;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure RltCabecalho(Titulo : String; out LinhaAtual : Integer); stdcall;
  external 'CraniumResources.dll';

procedure ImprimeCanvas(Coluna : Integer; Texto : String; out LinhaAtual : Integer ); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmRltMovDataF.btnGerarClick(Sender: TObject);
begin
  LimpaGrid(rgCV.Items[rgCV.ItemIndex]);
  if rgCV.Items[rgCV.ItemIndex] = 'Venda' then
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

    with DataF.dbQuery do
    begin
      while not Eof do
      begin
        if sgRelatorios.Cells[1,1] <> '' then
          sgRelatorios.RowCount := sgRelatorios.RowCount + 1;
        sgRelatorios.Cells[0, sgRelatorios.RowCount - 1] := FieldByName('CODIGO').AsString;
        sgRelatorios.Cells[1, sgRelatorios.RowCount - 1] := FieldByName('NOME').AsString;
        sgRelatorios.Cells[2, sgRelatorios.RowCount - 1] := FieldByName('DATA').AsString;
        sgRelatorios.Cells[3, sgRelatorios.RowCount - 1] := FieldByName('NOME_1').AsString;
        sgRelatorios.Cells[4, sgRelatorios.RowCount - 1] := FieldByName('NOME_2').AsString;
        sgRelatorios.Cells[5, sgRelatorios.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('SUM').AsFloat);
        Next;
      end;
    end;
  end
  else if rgCV.Items[rgCV.ItemIndex] = 'Compra' then
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

    with DataF.dbQuery do
    begin
      while not Eof do
      begin
        if sgRelatorios.Cells[1,1] <> '' then
          sgRelatorios.RowCount := sgRelatorios.RowCount + 1;
        sgRelatorios.Cells[0, sgRelatorios.RowCount - 1] := FieldByName('CODIGO').AsString;
        sgRelatorios.Cells[1, sgRelatorios.RowCount - 1] := FieldByName('NOME').AsString;
        sgRelatorios.Cells[2, sgRelatorios.RowCount - 1] := FieldByName('DATA').AsString;
        sgRelatorios.Cells[3, sgRelatorios.RowCount - 1] := FieldByName('NOME_1').AsString;
        sgRelatorios.Cells[4, sgRelatorios.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('SUM').AsFloat);
        Next;
      end;
    end;
  end;

  rgCV.Enabled := FALSE;
  dtpDataFinal.Enabled := FALSE;
  dtpDataInicial.Enabled := FALSE;
  lbDataInicial.Enabled := FALSE;
  lbDataFinal.Enabled := FALSE;
  btnGerar.Enabled := FALSE;
  btnImprimir.Enabled := TRUE;
  btnNovoRlt.Enabled := TRUE;
end;

procedure TfrmRltMovDataF.btnImprimirClick(Sender: TObject);
var I: Integer;
begin
  Printer.BeginDoc;
  LinhaAtual := 10;
  RltCabecalho('Relat�rio de Movimenta��o de ' +
               rgCV.Items[rgCV.ItemIndex] +
               ' entre ' +
               FormatDateTime('dd/MM/yyyy', dtpDataInicial.Date) +
               ' e ' +
               FormatDateTime('dd/MM/yyyy', dtpDataFinal.Date), LinhaAtual);

  if rgCV.Items[rgCV.ItemIndex] = 'Venda' then
  begin
    Printer.Canvas.Font.Style := Printer.Canvas.Font.Style + [fsBold];
    Printer.Canvas.TextOut(337, LinhaAtual, 'C�digo');
    Printer.Canvas.TextOut(720, LinhaAtual, 'Cliente');
    Printer.Canvas.TextOut(2200, LinhaAtual, 'Data');
    Printer.Canvas.TextOut(2600, LinhaAtual, 'Tipo Pgto.');
    Printer.Canvas.TextOut(3100, LinhaAtual, 'Vendedor');
    ImprimeCanvas(4200, 'Total', LinhaAtual);
    Printer.Canvas.Font.Style := Printer.Canvas.Font.Style - [fsBold];
    LinhaAtual := LinhaAtual + 20;

    Printer.Canvas.Font.Size := 8;
    for I := 1 to sgRelatorios.RowCount - 1 do
    begin
      Printer.Canvas.TextOut(337, LinhaAtual, sgRelatorios.Cells[0,I]);
      Printer.Canvas.TextOut(720, LinhaAtual, sgRelatorios.Cells[1,I]);
      Printer.Canvas.TextOut(2200, LinhaAtual, sgRelatorios.Cells[2,I]);
      Printer.Canvas.TextOut(2600, LinhaAtual, sgRelatorios.Cells[3,I]);
      Printer.Canvas.TextOut(3100, LinhaAtual, sgRelatorios.Cells[4,I]);
      ImprimeCanvas(4200, sgRelatorios.Cells[5,I], LinhaAtual);
    end;
  end
  else
  begin
    Printer.Canvas.Font.Style := Printer.Canvas.Font.Style + [fsBold];
    Printer.Canvas.TextOut(337, LinhaAtual, 'C�digo');
    Printer.Canvas.TextOut(720, LinhaAtual, 'Fornecedor');
    Printer.Canvas.TextOut(3000, LinhaAtual, 'Data');
    Printer.Canvas.TextOut(3500, LinhaAtual, 'Tipo Pgto.');
    ImprimeCanvas(4200, 'Total', LinhaAtual);
    Printer.Canvas.Font.Style := Printer.Canvas.Font.Style - [fsBold];
    LinhaAtual := LinhaAtual + 20;

    Printer.Canvas.Font.Size := 8;
    for I := 1 to sgRelatorios.RowCount - 1 do
    begin
      Printer.Canvas.TextOut(337, LinhaAtual, sgRelatorios.Cells[0,I]);
      Printer.Canvas.TextOut(720, LinhaAtual, sgRelatorios.Cells[1,I]);
      Printer.Canvas.TextOut(3000, LinhaAtual, sgRelatorios.Cells[2,I]);
      Printer.Canvas.TextOut(3500, LinhaAtual, sgRelatorios.Cells[3,I]);
      ImprimeCanvas(4200, sgRelatorios.Cells[4,I], LinhaAtual);
    end;
  end;

  Printer.EndDoc;
end;

procedure TfrmRltMovDataF.btnNovoRltClick(Sender: TObject);
begin
  rgCV.Enabled := TRUE;
  dtpDataFinal.Enabled := TRUE;
  dtpDataInicial.Enabled := TRUE;
  lbDataInicial.Enabled := TRUE;
  lbDataFinal.Enabled := TRUE;
  btnGerar.Enabled := FALSE;
  btnImprimir.Enabled := FALSE;
  btnNovoRlt.Enabled := FALSE;
  rgCV.ItemIndex := -1;
  FormShow(Self);
end;

procedure TfrmRltMovDataF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRltMovDataF.FormShow(Sender: TObject);
begin
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date;
end;

procedure TfrmRltMovDataF.LimpaGrid(TipoMov : string);
var i : integer;
begin
  with sgRelatorios do
  begin
    Cells[0,0] := 'C�digo';
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
      sgRelatorios.ColWidths[0] := 53;
      sgRelatorios.ColWidths[1] := 182;
      sgRelatorios.ColWidths[2] := 79;
      sgRelatorios.ColWidths[3] := 84;
      sgRelatorios.ColWidths[4] := 193;
      sgRelatorios.ColWidths[5] := 121;
    end
    else if TipoMov = 'Compra' then
    begin
      Cells[1,0] := 'Fornecedor';
      Cells[4,0] := 'Total';
      for i := 1 to RowCount - 1 do
        Rows[i].Clear;
      RowCount := 2;
      ColCount := 5;
      sgRelatorios.ColWidths[0] := 53;
      sgRelatorios.ColWidths[1] := 220;
      sgRelatorios.ColWidths[2] := 79;
      sgRelatorios.ColWidths[3] := 84;
      sgRelatorios.ColWidths[4] := 121;
    end;
  end;
end;

procedure TfrmRltMovDataF.rgCVClick(Sender: TObject);
begin
  btnGerar.Enabled := TRUE;
end;

end.

