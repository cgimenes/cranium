unit frmUndMedidaU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  TfrmUndMedidaF = class(TForm)
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
    procedure ComandoSQL(xSQL: String);
    procedure MudarEstado(vEstado: String; vList: TListBox);

  public

  end;

var
  frmUndMedidaF: TfrmUndMedidaF;

procedure dbSelect(xSQL : String); stdcall;
    external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
    external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmUndMedidaF.btnAdicionarClick(Sender: TObject);
begin
  if edtNovoTipo.Text = '' then
  begin
    Application.MessageBox('Digite um nome para a nova unidade de medida!', 'Gerenciar Unidades de Medida - Erro do Sistema', mb_iconerror+mb_ok);
    edtNovoTipo.SetFocus;
    exit;
  end;

  ComandoSQL('INSERT INTO ' +
             ' UNDMEDIDA ' +
             ' VALUES  ' +
             '    ((SELECT MAX(CODIGO) + 1 FROM UNDMEDIDA), ' + QuotedStr(edtNovoTipo.Text) +
             '   , 1)');
  Lista('1', listAtivos);
  edtNovoTipo.Text := '';
end;

procedure TfrmUndMedidaF.ComandoSQL(xSQL : String);
begin
  With DataF.dbComando do
  begin
    CommandText := xSQL;
    Execute;
    CommandText := 'COMMIT';
    Execute;
  end;
end;

procedure TfrmUndMedidaF.MudarEstado(vEstado : String; vList : TListBox);
begin
  if vList.ItemIndex = -1 then
    exit;

  ComandoSQL('UPDATE UNDMEDIDA SET ATIVO = ' + QuotedStr(vEstado) + ' WHERE NOME = ' + QuotedStr(vList.Items[vList.ItemIndex]));
  FormShow(self);
end;

procedure TfrmUndMedidaF.btnAtivarClick(Sender: TObject);
begin
  MudarEstado('1', listInativos);
end;

procedure TfrmUndMedidaF.btnDesativarClick(Sender: TObject);
begin
  MudarEstado('0', listAtivos);
end;

procedure TfrmUndMedidaF.Lista(vAtivo : String; vList : TListBox);
begin
  vList.Items.Clear;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM UNDMEDIDA WHERE ATIVO = ' + vAtivo);
    While not EOF do
    begin
      vList.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
  End;
end;

procedure TfrmUndMedidaF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUndMedidaF.FormShow(Sender: TObject);
begin
  Lista('1', listAtivos);
  Lista('0', listInativos);
end;
end.

