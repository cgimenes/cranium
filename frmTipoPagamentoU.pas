unit frmTipoPagamentoU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TfrmTipoPagamentoF = class(TForm)
    lbNovoTipo: TLabel;
    edtNovoTipo: TEdit;
    btnAdicionar: TButton;
    gbInativos: TGroupBox;
    listAtivos: TListBox;
    gbAtivos: TGroupBox;
    listInativos: TListBox;
    btnDesativar: TBitBtn;
    btnAtivar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure btnDesativarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Lista(vAtivo: String; vList: TListBox);
    procedure MudarEstado(vEstado: String; vList: TListBox);

  public

  end;

var
  frmTipoPagamentoF: TfrmTipoPagamentoF;

procedure dbSelect(xSQL : String); stdcall;
    external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
    external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmTipoPagamentoF.btnAdicionarClick(Sender: TObject);
begin
  if edtNovoTipo.Text = '' then
  begin
    Application.MessageBox('Digite um nome para o novo tipo de pagamento!', 'Gerenciar Tipos de Pagamento - Erro do Sistema', mb_iconerror+mb_ok);
    edtNovoTipo.SetFocus;
    exit;
  end;

  ComandoSQL('INSERT INTO ' +
             ' TIPOPAGAMENTO ' +
             ' VALUES  ' +
             ' ((SELECT MAX(CODIGO) + 1 FROM TIPOPAGAMENTO), ' + QuotedStr(edtNovoTipo.Text) +
             '   , 1)');
  Lista('1', listAtivos);
  edtNovoTipo.Text := '';
end;

procedure TfrmTipoPagamentoF.MudarEstado(vEstado : String; vList : TListBox);
begin
  if vList.ItemIndex = -1 then
    exit;

  ComandoSQL('UPDATE TIPOPAGAMENTO SET ATIVO = ' + QuotedStr(vEstado) + ' WHERE NOME = ' + QuotedStr(vList.Items[vList.ItemIndex]));
  FormShow(self);
end;

procedure TfrmTipoPagamentoF.btnAtivarClick(Sender: TObject);
begin
  MudarEstado('1', listInativos);
end;

procedure TfrmTipoPagamentoF.btnDesativarClick(Sender: TObject);
begin
  MudarEstado('0', listAtivos);
end;

procedure TfrmTipoPagamentoF.Lista(vAtivo : String; vList : TListBox);
begin
  vList.Items.Clear;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM TIPOPAGAMENTO WHERE ATIVO = ' + vAtivo);
    While not Eof do
    begin
      vList.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
  End;
end;

procedure TfrmTipoPagamentoF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTipoPagamentoF.FormShow(Sender: TObject);
begin
  Lista('1', listAtivos);
  Lista('0', listInativos);
end;
end.

