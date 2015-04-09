unit frmCategoriaU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB, Mask, DBCtrls;

type
  TfrmCategoriaF = class(TForm)
    lbCategoria: TLabel;
    btnAdicionar: TButton;
    gbInativas: TGroupBox;
    listAtivas: TListBox;
    gbAtivas: TGroupBox;
    listInativas: TListBox;
    btnAtivar: TBitBtn;
    tblCategoria: TADOTable;
    tblCategoriaNOME: TStringField;
    edtNovoTipo: TDBEdit;
    dsCategoria: TDataSource;
    tblCategoriaCODIGO: TIntegerField;
    tblCategoriaATIVO: TStringField;
    btnDesativar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDesativarClick(Sender: TObject);
  private
    procedure Lista(vAtivo: String; vList: TListBox);
    procedure MudarEstado(vEstado: String; vList: TListBox);

  public

  end;

var
  frmCategoriaF: TfrmCategoriaF;

procedure dbSelect(xSQL : String); stdcall;
  external 'CraniumResources.dll';

procedure ComandoSQL(xSQL : String); stdcall;
  external 'CraniumResources.dll';

implementation
uses DataU;
{$R *.dfm}

procedure TfrmCategoriaF.btnAdicionarClick(Sender: TObject);
begin
  if edtNovoTipo.Text = '' then
  begin
    Application.MessageBox('Digite um nome para a nova categoria!', 'Gerenciar Categorias - Erro do Sistema', mb_iconerror+mb_ok);
    edtNovoTipo.SetFocus;
    exit;
  end;

  dbSelect('SELECT MAX(CODIGO) +1 AS MAXCODIGO FROM CATEGORIA');
  tblCategoria.FieldByName('CODIGO').AsInteger := DataF.dbQuery.FieldByName('MAXCODIGO').AsInteger;
  tblCategoria.FieldByName('NOME').AsString := edtNovoTipo.Text;
  tblCategoria.FieldByName('ATIVO').AsInteger := 1;
  tblCategoria.Append;
  Lista('1', listAtivas);
  edtNovoTipo.Text := '';
end;

procedure TfrmCategoriaF.MudarEstado(vEstado : String; vList : TListBox);
begin
  if vList.ItemIndex = -1 then
    exit;

  ComandoSQL('UPDATE CATEGORIA SET ATIVO = ' +
             QuotedStr(vEstado) +
             ' WHERE NOME = ' +
             QuotedStr(vList.Items[vList.ItemIndex]));

  FormShow(Self);
end;

procedure TfrmCategoriaF.btnAtivarClick(Sender: TObject);
begin
  MudarEstado('1', listInativas);
end;

procedure TfrmCategoriaF.btnDesativarClick(Sender: TObject);
begin
  if listAtivas.ItemIndex = -1 then
    exit;

  dbSelect('SELECT ESTOQUE.CATEGORIA '
         + 'FROM ESTOQUE, CATEGORIA '
         + 'WHERE ESTOQUE.CATEGORIA = CATEGORIA.CODIGO '
         + 'AND ESTOQUE.CATEGORIA = (SELECT CATEGORIA.CODIGO FROM CATEGORIA WHERE CATEGORIA.NOME = '
         + QuotedStr(listAtivas.Items[listAtivas.ItemIndex]) + ')');

  if DataF.dbQuery.FieldByName('CATEGORIA').AsString <> '' then
  begin
    if Application.MessageBox('Existem produtos adicionados à esta categoria,' +
      #13#10 + 'deseja realmente desativar esta categoria?', 'Atenção', MB_YESNO
      + MB_ICONWARNING) = IDYES then
    begin
      MudarEstado('0', listAtivas);
    end;
  end
  else
  begin
    MudarEstado('0', listAtivas);
  end;
end;

procedure TfrmCategoriaF.Lista(vAtivo : String; vList : TListBox);
begin
  vList.Items.Clear;
  With DataF.dbQuery do
  begin
    dbSelect('SELECT NOME FROM CATEGORIA WHERE ATIVO = ' + vAtivo);
    While not EOF do
    begin
      vList.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
  End;
end;

procedure TfrmCategoriaF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCategoriaF.FormShow(Sender: TObject);
begin
  tblCategoria.Open;
  Lista('1', listAtivas);
  Lista('0', listInativas);
  tblCategoria.Append ;
end;
end.

