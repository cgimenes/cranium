unit frmConsultaPessoaU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Mask;

type
  TfrmConsultaPessoaF = class(TForm)
    cbConsultas: TComboBox;
    edtConsultas: TEdit;
    btnConsultas: TButton;
    lbConsultas: TLabel;
    sgConsultas: TStringGrid;
    lbTipo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConsultasClick(Sender: TObject);
    procedure sgConsultasDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  public

  end;

var
  frmConsultaPessoaF: TfrmConsultaPessoaF;

implementation
uses DataU, frmNovoCadastroU;
{$R *.dfm}

procedure TfrmConsultaPessoaF.btnConsultasClick(Sender: TObject);
begin
  if cbConsultas.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um tipo de consulta!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
    cbConsultas.SetFocus;
    exit;
  end;

  if edtConsultas.Text = '' then
  begin
    Application.MessageBox('Digite algo para consultar!', 'Consulta - Erro do Sistema', mb_iconwarning+mb_ok);
    edtConsultas.SetFocus;
    exit;
  end;

  if cbConsultas.Text = 'NOME' then
    dbSelect('SELECT  CODIGO, '
          + '      NOME, '
          + '        RG, '
          + '       CPF, '
          + '       CNPJ '
          + 'FROM PESSOA '
          + 'WHERE  '
          + cbConsultas.Text
          + ' LIKE '
          + QuotedStr('%' + edtConsultas.Text + '%'))
  else if cbConsultas.Text = 'CÓDIGO' then
    dbSelect('SELECT  CODIGO, '
          + '      NOME, '
          + '        RG, '
          + '       CPF, '
          + '       CNPJ '
          + 'FROM PESSOA '
          + 'WHERE  '
          + 'CODIGO'
          + ' = '
          + QuotedStr(edtConsultas.Text))
  else
    dbSelect('SELECT  CODIGO, '
          + '      NOME, '
          + '        RG, '
          + '       CPF, '
          + '       CNPJ '
          + 'FROM PESSOA '
          + 'WHERE  '
          + cbConsultas.Text
          + ' = '
          + QuotedStr(edtConsultas.Text));

  With sgConsultas do
  begin
    RowCount := 2;
    Rows[1].Clear;
    While not DataF.dbQuery.EOF do
    begin
      Cells[0,RowCount - 1] := DataF.dbQuery.FieldByName('CODIGO').AsString;
      Cells[1,RowCount - 1] := DataF.dbQuery.FieldByName('NOME').AsString;
      Cells[2,RowCount - 1] := DataF.dbQuery.FieldByName('RG').AsString;
      Cells[3,RowCount - 1] := DataF.dbQuery.FieldByName('CPF').AsString;
      Cells[4,RowCount - 1] := DataF.dbQuery.FieldByName('CNPJ').AsString;
      DataF.dbQuery.Next;
      if not DataF.dbQuery.Eof then
        RowCount := RowCount + 1;
    end;
  end;
end;

procedure TfrmConsultaPessoaF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConsultaPessoaF.FormShow(Sender: TObject);
begin
  With sgConsultas do
  begin
    Cells[0,0] := 'Código';
    Cells[1,0] := 'Nome';
    Cells[2,0] := 'RG';
    Cells[3,0] := 'CPF';
    Cells[4,0] := 'CNPJ';
  end;
end;

procedure TfrmConsultaPessoaF.sgConsultasDblClick(Sender: TObject);
begin
  if sgConsultas.Cells[0,1] = '' then
    exit;

  frmNovoCadastroF := TfrmNovoCadastroF.Create(nil);

  With DataF.dbquery do
  begin
    dbSelect('SELECT * FROM PESSOA WHERE CODIGO = ' +
            sgConsultas.Cells[0, sgConsultas.Row]);

    frmNovoCadastroF.btnGravar.Visible := FALSE;
    frmNovoCadastroF.edtNumero.Visible := FALSE;
    frmNovoCadastroF.lbNumero.Visible := FALSE;
    frmNovoCadastroF.btnAlterar.Visible := TRUE;
    frmNovoCadastroF.rgPessoa.Enabled := FALSE;
    frmNovoCadastroF.chbCliente.Enabled := FALSE;
    frmNovoCadastroF.chbColaborador.Enabled := FALSE;
    frmNovoCadastroF.chbFornecedor.Enabled := FALSE;
    frmNovoCadastroF.edtCod.Enabled := FALSE;
    frmNovoCadastroF.lbCod.Enabled := FALSE;
    frmNovoCadastroF.btnAlterar.Enabled := TRUE;
    frmNovoCadastroF.btnAlterar.Default := TRUE;

    frmNovoCadastroF.edtCod.Text := FieldByName('CODIGO').AsString;
    frmNovoCadastroF.edtNomeF.Text := FieldByName('NOME').AsString;
    frmNovoCadastroF.edtRS.Text := FieldByName('RAZSOCIAL').AsString;
    frmNovoCadastroF.edtCPF.Text := FieldByName('CPF').AsString;
    frmNovoCadastroF.edtRG.Text := FieldByName('RG').AsString;
    frmNovoCadastroF.edtCNPJ.Text := FieldByName('CNPJ').AsString;
    frmNovoCadastroF.edtIE.Text := FieldByName('INSCESTADUAL').AsString;
    frmNovoCadastroF.edtEndereco.Text := FieldByName('ENDERECO').AsString;
    frmNovoCadastroF.edtBairro.Text := FieldByName('BAIRRO').AsString;
    frmNovoCadastroF.edtCidade.Text := FieldByName('CIDADE').AsString;
    frmNovoCadastroF.cbUF.ItemIndex := frmNovoCadastroF.cbUF.Items.IndexOf(FieldByName('UF').AsString);
    frmNovoCadastroF.edtCEP.Text := FieldByName('CEP').AsString;
    frmNovoCadastroF.edtTelefone.Text := FieldByName('TELEFONE').AsString;
    frmNovoCadastroF.edtCelular.Text := FieldByName('CELULAR').AsString;
    frmNovoCadastroF.edtFax.Text := FieldByName('FAX').AsString;
    frmNovoCadastroF.edtEmail.Text := FieldByName('EMAIL').AsString;
    frmNovoCadastroF.dtpData.Date := StrToDate(FieldByName('DTNASCIMENTO').AsString);
    frmNovoCadastroF.edtContato.Text := FieldByName('CONTATO').AsString;
    frmNovoCadastroF.edtCargo.Text := FieldByName('CARGO').AsString;
    frmNovoCadastroF.rgPessoa.ItemIndex := FieldByName('TIPOPESSOA').AsInteger;
    if FieldByName('TIPOCLIENTE').AsInteger = 1 then
      frmNovoCadastroF.chbCliente.Checked := TRUE
    else
      frmNovoCadastroF.chbCliente.Checked := TRUE;
    if FieldByName('TIPOFORNECEDOR').AsInteger = 1 then
      frmNovoCadastroF.chbFornecedor.Checked := TRUE
    else
      frmNovoCadastroF.chbFornecedor.Checked := FALSE;
    if FieldByName('TIPOCOLABORADOR').AsInteger = 1 then
      frmNovoCadastroF.chbColaborador.Checked := TRUE
    else
      frmNovoCadastroF.chbColaborador.Checked := FALSE;
    if FieldByName('ATIVO').AsInteger = 1 then
      frmNovoCadastroF.chbAtivo.Checked := TRUE
    else
      frmNovoCadastroF.chbAtivo.Checked := FALSE;

    frmNovoCadastroF.ShowModal;
  end;
end;

end.

