unit frmRltVendedorU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DataU, RpCon, RpConDS,
  RpDefine, RpRave;

type
  TfrmRltVendedorF = class(TForm)
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    lbDataInicial: TLabel;
    lbDataFinal: TLabel;
    sgRelatorios: TStringGrid;
    btnGerar: TButton;
    btnImprimir: TButton;
    btnNovoRlt: TButton;
    cbPessoa: TComboBox;
    RvVendedor: TRvProject;
    RvConVendedor: TRvDataSetConnection;
    lbVendedor: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnNovoRltClick(Sender: TObject);
    procedure cbPessoaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LimpaGrid;

  public

  end;

var
  frmRltVendedorF: TfrmRltVendedorF;
  LinhaAtual : Integer;

procedure dbSelect(xSQL : String); stdcall;
    external 'CraniumResources.dll';

implementation
{$R *.dfm}

procedure TfrmRltVendedorF.btnGerarClick(Sender: TObject);
begin
  if cbPessoa.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um nome!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    cbPessoa.SetFocus;
    Exit;
  end;
  LimpaGrid;
  with DataF.dbRvVendedor do //sem o uso da função dbSelect porque é uma Query diferente
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT VENDA.CODIGO, '
           + '       CLIENTE.NOME AS CLIENTE, '
           + '       VENDA.DATA, '
           + '       TIPOPAGAMENTO.NOME AS TIPOPAGAMENTO, '
           + '       VENDEDOR.NOME AS VENDEDOR, '
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
           + '       AND VENDEDOR.NOME = ' + QuotedStr(cbPessoa.Text)
           + 'GROUP BY VENDA.CODIGO, '
           + '         CLIENTE.NOME, '
           + '         VENDA.DATA, '
           + '         TIPOPAGAMENTO.NOME, '
           + '         VENDEDOR.NOME');
    Open;

    while not Eof do
    begin
      if sgRelatorios.Cells[1,1] <> '' then
        sgRelatorios.RowCount := sgRelatorios.RowCount + 1;
      sgRelatorios.Cells[0, sgRelatorios.RowCount - 1] := FieldByName('CODIGO').AsString;
      sgRelatorios.Cells[1, sgRelatorios.RowCount - 1] := FieldByName('CLIENTE').AsString;
      sgRelatorios.Cells[2, sgRelatorios.RowCount - 1] := FieldByName('DATA').AsString;
      sgRelatorios.Cells[3, sgRelatorios.RowCount - 1] := FieldByName('TIPOPAGAMENTO').AsString;
      sgRelatorios.Cells[4, sgRelatorios.RowCount - 1] := FieldByName('VENDEDOR').AsString;
      sgRelatorios.Cells[5, sgRelatorios.RowCount - 1] := FormatFloat('##,##0.00', FieldByName('SUM').AsFloat);
      Next;
    end;
  end;

  dtpDataFinal.Enabled := FALSE;
  dtpDataInicial.Enabled := FALSE;
  lbDataInicial.Enabled := FALSE;
  lbDataFinal.Enabled := FALSE;
  btnGerar.Enabled := FALSE;
  btnImprimir.Enabled := TRUE;
  btnNovoRlt.Enabled := TRUE;
  cbPessoa.Enabled := FALSE;
end;

procedure TfrmRltVendedorF.btnImprimirClick(Sender: TObject);
var Titulo : String;
begin
  Titulo := 'Relatório de Vendedor por Venda' +
            ' entre ' +
            FormatDateTime('dd/MM/yyyy', dtpDataInicial.Date) +
            ' e ' +
            FormatDateTime('dd/MM/yyyy', dtpDataFinal.Date);

  RvVendedor.SetParam('Titulo', Titulo);
  RvVendedor.ExecuteReport('RvVendedor');
end;

procedure TfrmRltVendedorF.btnNovoRltClick(Sender: TObject);
begin
  dtpDataFinal.Enabled := TRUE;
  dtpDataInicial.Enabled := TRUE;
  lbDataInicial.Enabled := TRUE;
  lbDataFinal.Enabled := TRUE;
  btnGerar.Enabled := FALSE;
  btnImprimir.Enabled := FALSE;
  btnNovoRlt.Enabled := FALSE;
  cbPessoa.Enabled := TRUE;
  cbPessoa.ItemIndex := -1;
  FormShow(Self);
end;

procedure TfrmRltVendedorF.cbPessoaClick(Sender: TObject);
begin
  btnGerar.Enabled := TRUE;
end;

procedure TfrmRltVendedorF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRltVendedorF.FormShow(Sender: TObject);
begin
  cbPessoa.Items.Clear;
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM PESSOA WHERE TIPOCOLABORADOR = 1');
    while not eof do
    begin
      cbPessoa.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
  end;
  LimpaGrid;
end;

procedure TfrmRltVendedorF.LimpaGrid;
var i : integer;
begin
  with sgRelatorios do
  begin
    Cells[0,0] := 'Código';
    Cells[1,0] := 'Cliente';
    Cells[2,0] := 'Data';
    Cells[3,0] := 'Tipo Pgto.';
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
  end;
end;

end.

