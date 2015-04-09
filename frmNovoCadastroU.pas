unit frmNovoCadastroU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, ComCtrls, msxmldom,
  XMLDoc, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  XMLIntf, xmldom;

type
  TfrmNovoCadastroF = class(TForm)
    lbCNPJ: TLabel;
    lbCEP: TLabel;
    lbCod: TLabel;
    lbRS: TLabel;
    lbNomeF: TLabel;
    lbIE: TLabel;
    lbEndereco: TLabel;
    lbBairro: TLabel;
    lbCargo: TLabel;
    lbEmail: TLabel;
    lbCidade: TLabel;
    lbTelefone: TLabel;
    lbFax: TLabel;
    lbContato: TLabel;
    lbCelular: TLabel;
    lbRG: TLabel;
    lbCPF: TLabel;
    cbUF: TComboBox;
    btnGravar: TButton;
    edtCNPJ: TMaskEdit;
    edtCEP: TMaskEdit;
    edtCod: TEdit;
    edtRS: TEdit;
    edtNomeF: TEdit;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    edtCargo: TEdit;
    edtEmail: TEdit;
    edtCidade: TEdit;
    edtContato: TEdit;
    edtTelefone: TMaskEdit;
    edtFax: TMaskEdit;
    edtIE: TEdit;
    rgPessoa: TRadioGroup;
    edtCelular: TMaskEdit;
    gbTipo: TGroupBox;
    chbCliente: TCheckBox;
    chbFornecedor: TCheckBox;
    chbColaborador: TCheckBox;
    lbDN: TLabel;
    edtCPF: TMaskEdit;
    edtRG: TEdit;
    IdHTTP: TIdHTTP;
    XMLBuscaCEP: TXMLDocument;
    lbNumero: TLabel;
    edtNumero: TEdit;
    btnAlterar: TButton;
    dtpData: TDateTimePicker;
    lbUF: TLabel;
    chbAtivo: TCheckBox;
    procedure rgPessoaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

  private
    function Valida: boolean;
    function ValidaCNPJ(CNPJ: string): Boolean;
    function ValidaCPF(CPF: string): boolean;

  public

  end;

var
  frmNovoCadastroF: TfrmNovoCadastroF;
  j : integer;
  selecionou : Boolean;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;

{$R *.dfm}

procedure TfrmNovoCadastroF.btnAlterarClick(Sender: TObject);
var xCliente, xFornecedor, xColaborador, xAtivo : Integer;
begin
  j := j + 1;
  if j = 1 then
  begin
    rgPessoaClick(Self);
    chbAtivo.Enabled := TRUE;
  end
  else if j >= 2 then
  begin
    if (Length(edtCEP.Text) < 8) and (edtCEP.Text <> '') then
    begin
      edtCEPExit(self);
      exit;
    end;

    if (not chbCliente.Checked) and (not chbFornecedor.Checked) and (not chbColaborador.Checked) then
    begin
      Application.MessageBox('Selecione um tipo!', 'Alterar Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
      exit;
    end;

    if edtNomeF.Text = '' then
    begin
      Application.MessageBox('Digite um nome!', 'Alterar Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
      edtNomeF.SetFocus;
      exit;
    end;

    xCliente := 0;
    xFornecedor := 0;
    xColaborador := 0;
    xAtivo := 0;
    if chbCliente.Checked then
      xCliente := 1;
    if chbFornecedor.Checked then
      xFornecedor := 1;
    if chbColaborador.Checked then
      xColaborador := 1;
    if chbAtivo.Checked then
      xAtivo := 1;

    if edtNumero.Text <> '' then
      edtEndereco.Text := edtEndereco.Text + ', ' + edtNumero.Text;

    if rgPessoa.ItemIndex = 0 then
      ComandoSQL('UPDATE ' +
                 ' PESSOA ' +
                 ' SET ' +
                 'NOME =     ' + QuotedStr(edtNomeF.Text) +
                 ',CPF =      ' + QuotedStr(edtCPF.Text) +
                 ',RG =       ' + QuotedStr(edtRG.Text) +
                 ',ENDERECO = ' + QuotedStr(edtEndereco.Text) +
                 ',BAIRRO =   ' + QuotedStr(edtBairro.Text) +
                 ',CIDADE =   ' + QuotedStr(edtCidade.Text) +
                 ',UF =       ' + QuotedStr(cbUF.Text) +
                 ',CEP =      ' + QuotedStr(edtCEP.Text) +
                 ',TELEFONE = ' + QuotedStr(edtTelefone.Text) +
                 ',CELULAR =  ' + QuotedStr(edtCelular.Text) +
                 ',EMAIL =    ' + QuotedStr(edtEmail.Text) +
                 ',DTNASCIMENTO =    ' + QuotedStr(FormatDateTime('yyyy-MM-dd', dtpData.Date)) +
                 ',TIPOPESSOA =      ' + QuotedStr(InttoStr(rgPessoa.ItemIndex)) +
                 ',TIPOCLIENTE =     ' + QuotedStr(InttoStr(xCliente)) +
                 ',TIPOFORNECEDOR =  ' + QuotedStr(InttoStr(xFornecedor)) +
                 ',TIPOCOLABORADOR = ' + QuotedStr(InttoStr(xColaborador)) +
                 ',ATIVO =           ' + QuotedStr(InttoStr(xAtivo)) +
                 'WHERE CODIGO = ' + edtCod.Text)

    else if rgPessoa.ItemIndex = 1 then
      ComandoSQL('UPDATE ' +
                 ' PESSOA ' +
                 ' SET ' +
                 'NOME =         ' + QuotedStr(edtNomeF.Text) +
                 ',RAZSOCIAL =    ' + QuotedStr(edtRS.Text) +
                 ',CNPJ =         ' + QuotedStr(edtCNPJ.Text) +
                 ',INSCESTADUAL = ' + QuotedStr(edtIE.Text) +
                 ',ENDERECO =     ' + QuotedStr(edtEndereco.Text) +
                 ',BAIRRO =       ' + QuotedStr(edtBairro.Text) +
                 ',CIDADE =       ' + QuotedStr(edtCidade.Text) +
                 ',UF =           ' + QuotedStr(cbUF.Text) +
                 ',CEP =          ' + QuotedStr(edtCEP.Text) +
                 ',TELEFONE =     ' + QuotedStr(edtTelefone.Text) +
                 ',CELULAR =      ' + QuotedStr(edtCelular.Text) +
                 ',FAX =          ' + QuotedStr(edtFax.Text) +
                 ',EMAIL =        ' + QuotedStr(edtEmail.Text) +
                 ',CONTATO =      ' + QuotedStr(edtContato.Text) +
                 ',CARGO =        ' + QuotedStr(edtCargo.Text) +
                 ',TIPOPESSOA =      ' + QuotedStr(InttoStr(rgPessoa.ItemIndex)) +
                 ',TIPOCLIENTE =     ' + QuotedStr(InttoStr(xCliente)) +
                 ',TIPOFORNECEDOR =  ' + QuotedStr(InttoStr(xFornecedor)) +
                 ',TIPOCOLABORADOR = ' + QuotedStr(InttoStr(xColaborador)) +
                 ',ATIVO =           ' + QuotedStr(InttoStr(xAtivo)) +
                 'WHERE CODIGO = ' + edtCod.Text);

    Application.MessageBox('Alterado com sucesso!', 'Alterar Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
  end;
end;

procedure TfrmNovoCadastroF.btnGravarClick(Sender: TObject);
var xCliente, xFornecedor, xColaborador, xAtivo, i : Integer;
begin
  if (Length(edtCEP.Text) < 8) and (edtCEP.Text <> '') then
  begin
    edtCEPExit(self);
    exit;
  end;

  if not Valida then
    exit;

  if (not chbCliente.Checked) and (not chbFornecedor.Checked) and (not chbColaborador.Checked) then
  begin
    Application.MessageBox('Selecione um tipo!', 'Novo Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
    exit;
  end;

  if edtNomeF.Text = '' then
  begin
    Application.MessageBox('Digite um nome!', 'Novo Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
    edtNomeF.SetFocus;
    exit;
  end;

  if edtCPF.Text <> '' then
    if not ValidaCPF(edtCPF.Text) then
    begin
      Application.MessageBox('Digite um CPF válido!', 'Novo Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
      edtCPF.SetFocus;
      exit;
    end;

  if edtCNPJ.Text <> '' then
    if not ValidaCNPJ(edtCNPJ.Text) then
    begin
      Application.MessageBox('Digite um CNPJ válido!', 'Novo Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);
      edtCNPJ.SetFocus;
      exit;
    end;

  xCliente := 0;
  xFornecedor := 0;
  xColaborador := 0;
  xAtivo := 0;
  if chbCliente.Checked then
    xCliente := 1;
  if chbFornecedor.Checked then
    xFornecedor := 1;
  if chbColaborador.Checked then
    xColaborador := 1;
  if chbAtivo.Checked then
    xAtivo := 1;

  if edtNumero.Text <> '' then
    edtEndereco.Text := edtEndereco.Text + ', ' + edtNumero.Text;

  if rgPessoa.ItemIndex = 0 then
    ComandoSQL('INSERT INTO ' +
               ' PESSOA ' +
               '    (CODIGO   ' +
               '    ,NOME     ' +
               '    ,CPF      ' +
               '    ,RG       ' +
               '    ,ENDERECO ' +
               '    ,BAIRRO   ' +
               '    ,CIDADE   ' +
               '    ,UF       ' +
               '    ,CEP      ' +
               '    ,TELEFONE ' +
               '    ,CELULAR  ' +
               '    ,EMAIL    ' +
               '    ,DTNASCIMENTO   '+
               '    ,TIPOPESSOA     '+
               '    ,TIPOCLIENTE    '+
               '    ,TIPOFORNECEDOR '+
               '    ,TIPOCOLABORADOR'+
               '    ,ATIVO ) ' +
               ' VALUES  ' +
               '    (' + edtCod.Text +
               '   , ' + QuotedStr(edtNomeF.Text) +
               '   , ' + QuotedStr(edtCPF.Text) +
               '   , ' + QuotedStr(edtRG.Text) +
               '   , ' + QuotedStr(edtEndereco.Text) +
               '   , ' + QuotedStr(edtBairro.Text) +
               '   , ' + QuotedStr(edtCidade.Text) +
               '   , ' + QuotedStr(cbUF.Text) +
               '   , ' + QuotedStr(edtCEP.Text) +
               '   , ' + QuotedStr(edtTelefone.Text) +
               '   , ' + QuotedStr(edtCelular.Text) +
               '   , ' + QuotedStr(edtEmail.Text) +
               '   , ' + QuotedStr(FormatDateTime('yyyy-MM-dd', dtpData.Date)) +
               '   , ' + QuotedStr(InttoStr(rgPessoa.ItemIndex)) +
               '   , ' + QuotedStr(InttoStr(xCliente)) +
               '   , ' + QuotedStr(InttoStr(xFornecedor)) +
               '   , ' + QuotedStr(InttoStr(xColaborador)) +
               '   , ' + QuotedStr(InttoStr(xAtivo)) + ')')

  else if rgPessoa.ItemIndex = 1 then
    ComandoSQL('INSERT INTO ' +
               ' PESSOA ' +
               '    (CODIGO         ' +
               '    ,NOME           ' +
               '    ,RAZSOCIAL      ' +
               '    ,CNPJ           ' +
               '    ,INSCESTADUAL   ' +
               '    ,ENDERECO       ' +
               '    ,BAIRRO         ' +
               '    ,CIDADE         ' +
               '    ,UF             ' +
               '    ,CEP            ' +
               '    ,TELEFONE       ' +
               '    ,CELULAR        ' +
               '    ,FAX            ' +
               '    ,EMAIL          ' +
               '    ,CONTATO        ' +
               '    ,CARGO          ' +
               '    ,TIPOPESSOA     ' +
               '    ,TIPOCLIENTE    ' +
               '    ,TIPOFORNECEDOR ' +
               '    ,TIPOCOLABORADOR' +
               '    ,ATIVO ) ' +
               ' VALUES  ' +
               '    (' + edtCod.Text +
               '   , ' + QuotedStr(edtNomeF.Text) +
               '   , ' + QuotedStr(edtRS.Text) +
               '   , ' + QuotedStr(edtCNPJ.Text) +
               '   , ' + QuotedStr(edtIE.Text) +
               '   , ' + QuotedStr(edtEndereco.Text) +
               '   , ' + QuotedStr(edtBairro.Text) +
               '   , ' + QuotedStr(edtCidade.Text) +
               '   , ' + QuotedStr(cbUF.Text) +
               '   , ' + QuotedStr(edtCEP.Text) +
               '   , ' + QuotedStr(edtTelefone.Text) +
               '   , ' + QuotedStr(edtCelular.Text) +
               '   , ' + QuotedStr(edtFax.Text) +
               '   , ' + QuotedStr(edtEmail.Text) +
               '   , ' + QuotedStr(edtContato.Text) +
               '   , ' + QuotedStr(edtCargo.Text) +
               '   , ' + QuotedStr(InttoStr(rgPessoa.ItemIndex)) +
               '   , ' + QuotedStr(InttoStr(xCliente)) +
               '   , ' + QuotedStr(InttoStr(xFornecedor)) +
               '   , ' + QuotedStr(InttoStr(xColaborador)) +
               '   , ' + QuotedStr(InttoStr(xAtivo)) + ')');

  Application.MessageBox('Gravado com sucesso!', 'Novo Cadastro - Aviso do Sistema', mb_iconinformation+mb_ok);

  dbSelect('SELECT MAX(CODIGO) MAXCODIGO FROM PESSOA');
  edtCod.Text := IntToStr(DataF.dbQuery.FieldByName('MAXCODIGO').AsInteger + 1);

  cbUF.ItemIndex := -1;
  edtCNPJ.Text := '';
  edtCEP.Text := '';
  edtRS.Text := '';
  edtNomeF.Text := '';
  edtEndereco.Text := '';
  edtBairro.Text := '';
  edtCargo.Text := '';
  edtEmail.Text := '';
  edtCidade.Text := '';
  edtContato.Text := '';
  edtTelefone.Text := '';
  edtFax.Text := '';
  edtIE.Text := '';
  rgPessoa.ItemIndex := -1;
  edtCelular.Text := '';
  chbCliente.Checked := FALSE;
  chbFornecedor.Checked := FALSE;
  chbColaborador.Checked := FALSE;
  edtCPF.Text := '';
  edtRG.Text := '';
  dtpData.Date := Date;
  edtNumero.Text := '';

  for i := 0 To ComponentCount -1 Do
    If (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TMaskEdit) or (Components[i] Is TComboBox) or (Components[i] Is TDateTimePicker) then
      TEdit(Components[i]).Enabled := FALSE;

  lbCod.Enabled := TRUE;
  edtCod.Enabled := TRUE;
end;

procedure TfrmNovoCadastroF.edtCEPExit(Sender: TObject);
var Resposta: TStringStream;
    TSConsulta: TStringList;
begin
  if edtCEP.Text = '' then
  begin
    exit;
  end
  else if Length(edtCEP.Text) < 8 then
  begin
    Application.MessageBox('CEP inválido!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    edtCEP.SetFocus;
    exit;
  end;

  Resposta := TStringStream.Create('');
  TSConsulta := TStringList.Create;
  IdHTTP.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV2';
  TSConsulta.Values['&cep'] := edtCEP.Text;
  TSConsulta.Values['&formato'] := 'xml';

  IdHTTP.Post('http://cep.republicavirtual.com.br/web_cep.php?', TSConsulta, Resposta);
  XMLBuscaCEP.Active := TRUE;
  XMLBuscaCEP.Encoding := 'iso-8859-1';
  XMLBuscaCEP.LoadFromStream(Resposta);

  if XMLBuscaCEP.DocumentElement.ChildNodes['resultado'].NodeValue = '1' then
  begin
    edtEndereco.Text := XMLBuscaCEP.DocumentElement.ChildNodes['tipo_logradouro'].NodeValue+' '+XMLBuscaCEP.DocumentElement.ChildNodes['logradouro'].NodeValue;
    edtBairro.Text := XMLBuscaCEP.DocumentElement.ChildNodes['bairro'].NodeValue;
    edtCidade.Text := XMLBuscaCEP.DocumentElement.ChildNodes['cidade'].NodeValue;
    cbUF.ItemIndex := cbUF.Items.IndexOf(XMLBuscaCEP.DocumentElement.ChildNodes['uf'].NodeValue);

    TSConsulta.Free;
    Resposta.Free;
    XMLBuscaCEP.Active := FALSE;
  end
  else
  begin
    Application.MessageBox('CEP não encontrado!', 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
    edtCEP.SetFocus;
  end;
end;

procedure TfrmNovoCadastroF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNovoCadastroF.FormCreate(Sender: TObject);
var i : integer;
begin
  j := 0;
  for i := 0 To ComponentCount -1 Do
    If (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TMaskEdit) or (Components[i] Is TComboBox) or (Components[i] Is TDateTimePicker) then
      TEdit(Components[i]).Enabled := FALSE;

  dtpData.Date := Date;
  dbSelect('SELECT MAX(CODIGO) MAXCODIGO FROM PESSOA');
  edtCod.Text := IntToStr(DataF.dbQuery.FieldByName('MAXCODIGO').AsInteger + 1);
end;

procedure TfrmNovoCadastroF.rgPessoaClick(Sender: TObject);
var i : integer;
begin
  if rgPessoa.ItemIndex = 0 then
  begin
    for i := 0 To ComponentCount -1 Do
      if (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TMaskEdit) or (Components[i] Is TComboBox) or (Components[i] Is TDateTimePicker) then
        TEdit(Components[i]).Enabled := TRUE;

    btnGravar.Enabled := TRUE;
    lbRS.Enabled := FALSE;
    lbCNPJ.Enabled := FALSE;
    lbIE.Enabled := FALSE;
    lbFax.Enabled := FALSE;
    lbContato.Enabled := FALSE;
    lbCargo.Enabled := FALSE;
    edtRS.Enabled := FALSE;
    edtCNPJ.Enabled := FALSE;
    edtIE.Enabled := FALSE;
    edtFax.Enabled := FALSE;
    edtContato.Enabled := FALSE;
    edtCargo.Enabled := FALSE;
  end
  else if rgPessoa.ItemIndex = 1 then
  begin
    for i := 0 To ComponentCount -1 Do
      if (Components[i] Is TEdit) or (Components[i] Is TLabel) or (Components[i] Is TMaskEdit) or (Components[i] Is TComboBox) then
        TEdit(Components[i]).Enabled := TRUE;

    btnGravar.Enabled := TRUE;
    lbRG.Enabled := FALSE;
    lbCPF.Enabled := FALSE;
    edtRG.Enabled := FALSE;
    edtCPF.Enabled := FALSE;
    dtpData.Enabled := FALSE;
    lbDN.Enabled := FALSE;
  end;
end;

function TfrmNovoCadastroF.Valida : boolean;
Var xTexto : string;
begin
  Result := TRUE;
  xTexto := '';
  With DataF.dbQuery do
  begin
    if edtRG.Text <> '' then
    begin
      dbSelect('SELECT RG FROM PESSOA WHERE RG = ' + QuotedStr(edtRG.Text));
      if not eof then
      begin
        xTexto := xTexto + 'RG já está sendo utilizado!' + #13 ;
        Result := FALSE;
      end;
    end;
    if edtCPF.Text <> '' then
    begin
      dbSelect('SELECT CPF FROM PESSOA WHERE CPF = ' + QuotedStr(edtCPF.Text));
      if not eof then
      begin
        xTexto := xTexto + 'CPF já está sendo utilizado!' + #13 ;
        Result := FALSE;
      end;
    end;
    if edtCNPJ.Text <> '' then
    begin
      dbSelect('SELECT CNPJ FROM PESSOA WHERE CNPJ = ' + QuotedStr(edtCNPJ.Text));
      if not eof then
      begin
        xTexto := xTexto + 'CNPJ já está sendo utilizado!' + #13 ;
        Result := FALSE;
      end;
    end;
    if edtIE.Text <> '' then
    begin
      dbSelect('SELECT INSCESTADUAL FROM PESSOA WHERE INSCESTADUAL = ' + QuotedStr(edtIE.Text));
      if not eof then
      begin
        xTexto := xTexto + 'IE já está sendo utilizado!' + #13 ;
        Result := FALSE;
      end;
    end;
  end;

  if not Result then
    Application.MessageBox(PWideChar(xTexto), 'Erro - Aviso do Sistema', mb_iconwarning+mb_ok);
end;

function TfrmNovoCadastroF.ValidaCPF(CPF:string):boolean;
var Want:char;
    Wvalid:boolean;
    i,Wdigit1,Wdigit2:integer;
begin
    Wvalid := false;
    Wdigit1:=0;
    Wdigit2:=0;
    Want:=cpf[1];
    Delete(cpf,ansipos('.',cpf),1);
    Delete(cpf,ansipos('.',cpf),1);
    Delete(cpf,ansipos('-',cpf),1);

   for i:=1 to length(cpf) do
     begin
       if cpf[i] <> Want then
         begin
            Wvalid:=true;
            break
         end;
     end;

     if not Wvalid then
       begin
          result:=false;
          exit;
       end;

     for i:=1 to 9 do
       begin
          wdigit1:=Wdigit1+(strtoint(cpf[10-i])*(I+1));
       end;
        Wdigit1:= ((11 - (Wdigit1 mod 11))mod 11) mod 10;

        if IntToStr(Wdigit1) <> cpf[10] then
          begin
             result:=false;
             exit;
          end;

         for i:=1 to 10 do
       begin
          wdigit2:=Wdigit2+(strtoint(cpf[11-i])*(I+1));
       end;
       Wdigit2:= ((11 - (Wdigit2 mod 11))mod 11) mod 10;

       if IntToStr(Wdigit2) <> cpf[11] then
          begin
             result:=false;
             exit;
          end;

   result:=true;
end;

function TfrmNovoCadastroF.ValidaCNPJ(CNPJ: string): Boolean;
var i, digito1, digito2, cont: integer;
begin
  Delete(CNPJ, AnsiPos('.', CNPJ), 1);
  Delete(CNPJ, AnsiPos('.', CNPJ), 1);
  Delete(CNPJ, AnsiPos('/', CNPJ), 1);
  Delete(CNPJ, AnsiPos('-', CNPJ), 1);
  if (Length(CNPJ) <> 14) then
    Result := False
  else if (CNPJ = '00000000000000') then
    Result := False
  else
  begin
    digito1 := 0;
    digito2 := 0;
    cont := 2;
    try
      for i := 12 downto 1 do
      begin
        if cont = 10 then
          cont := 2;
        digito1 := digito1 + (StrToInt(CNPJ[i]) * cont);
        digito2 := digito2 + (StrToInt(CNPJ[i + 1]) * cont);
        cont := cont + 1;
      end;
      digito2 := digito2 + (StrToInt(CNPJ[1]) * 6);
      if (digito1 mod 11) < 2 then
        digito1 := 0
      else
        digito1 := 11 - (digito1 mod 11);
      if (digito2 mod 11) < 2 then
        digito2 := 0
      else
        digito2 := 11 - (digito2 mod 11);
      if (digito1 <> StrToInt(CNPJ[13])) or (digito2 <> StrToInt(CNPJ[14])) then
        Result := False
      else
        Result := True;
    except
      Result := False;
    end;
  end;
end;

end.

