unit frmPrincipalU;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, jpeg, ADODB, DB, DBCtrls;

type
  TfrmPrincipalF = class(TForm)
    mmPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Consulta1: TMenuItem;
    imgFundo: TImage;
    Vendas1: TMenuItem;
    Relatrios1: TMenuItem;
    Pessoas1: TMenuItem;
    Produtos1: TMenuItem;
    Categorias1: TMenuItem;
    UnidadesdeMedida1: TMenuItem;
    Pessoas2: TMenuItem;
    Produtos2: TMenuItem;
    iposdePagamento1: TMenuItem;
    Compras1: TMenuItem;
    Sobre1: TMenuItem;
    Sobre2: TMenuItem;
    RelatriodeMovimentaoporData1: TMenuItem;
    MovimentaoporPessoa1: TMenuItem;
    VendasporVendedor1: TMenuItem;
    Arquivo1: TMenuItem;
    Sair1: TMenuItem;
    Movimentao1: TMenuItem;
    dbConexao: TADOConnection;
    dbQuery: TADOQuery;
    N1: TMenuItem;
    Configuraes1: TMenuItem;
    Utilitrios1: TMenuItem;
    Calculadora1: TMenuItem;
    procedure Pessoas1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Categorias1Click(Sender: TObject);
    procedure iposdePagamento1Click(Sender: TObject);
    procedure UnidadesdeMedida1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Pessoas2Click(Sender: TObject);
    procedure Produtos2Click(Sender: TObject);
    procedure Compras1Click(Sender: TObject);
    procedure Sobre2Click(Sender: TObject);
    procedure RelatriodeMovimentaoporData1Click(Sender: TObject);
    procedure MovimentaoporPessoa1Click(Sender: TObject);
    procedure VendasporVendedor1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Movimentao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Configuraes1Click(Sender: TObject);
    procedure Calculadora1Click(Sender: TObject);
  private

  public

  end;

var
  frmPrincipalF: TfrmPrincipalF;

function ShowCategoria : integer; stdcall;
  external 'CraniumResources.dll';

function ShowConsultaMov : integer; stdcall;
  external 'CraniumResources.dll';

function ShowConsultaPessoa : integer; stdcall;
  external 'CraniumResources.dll';

function ShowNovaCompra : integer; stdcall;
  external 'CraniumResources.dll';

function ShowNovaVenda : integer; stdcall;
  external 'CraniumResources.dll';

function ShowNovoCadastro : integer; stdcall;
  external 'CraniumResources.dll';

function ShowTipoPagamento : integer; stdcall;
  external 'CraniumResources.dll';

function ShowUndMedida : integer; stdcall;
  external 'CraniumResources.dll';

function ShowConsultaProduto : integer; stdcall;
  external 'CraniumResources.dll';

function ShowSobre : integer; stdcall;
  external 'CraniumResources.dll';

function ShowRltMovData : integer; stdcall;
  external 'CraniumResources.dll';

function ShowRltVendedor : integer; stdcall;
  external 'CraniumResources.dll';

function ShowRltMovPessoa : integer; stdcall;
  external 'CraniumResources.dll';

function ShowNovoProduto : integer; stdcall;
  external 'CraniumResources.dll';

function ShowOpcoes : integer; stdcall;
  external 'CraniumResources.dll';

function Aniversariante : boolean; stdcall;
  external 'CraniumResources.dll';

procedure CreateDM; stdcall;
  external 'CraniumResources.dll';

procedure DestroyDM; stdcall;
  external 'CraniumResources.dll';

implementation

uses VerificaProcesso;

{$R *.dfm}

procedure TfrmPrincipalF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyDM;
  Action := caFree;
end;

procedure TfrmPrincipalF.FormCreate(Sender: TObject);
var Hoje, DiaNascimento : string;
    Mensagem : String;
    xFlag : Boolean;
begin
  if ProcessoExiste(ExtractFileName(Application.ExeName)) > 1 then
  begin
    Application.MessageBox('O Gestor Cranium já está em execução!', 'Atenção', MB_OK +
        MB_ICONWARNING);
    Application.ProcessMessages;
    Application.Terminate;
  end;

  CreateDM;

  if Aniversariante then
  begin
    xFlag := FALSE;
    Hoje := Copy(FormatDateTime('dd.MM.yyyy', Date), 1, 5);
    With dbQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT NOME, DTNASCIMENTO FROM PESSOA WHERE TIPOCOLABORADOR = 1');
      Open;
      while not Eof do
      begin
        DiaNascimento := Copy(FormatDateTime('dd.MM.yyyy',FieldByName('DTNASCIMENTO').AsDateTime), 1, 5);
        if DiaNascimento = Hoje then
        begin
          Mensagem := Mensagem + 'O(A) ' + FieldByName('NOME').AsString + ' está fazendo aniversário hoje!' + #13;
          xFlag := TRUE;
        end;
        Next;
      end;
    end;
    if xFlag then
      Application.MessageBox(PWideChar(Mensagem), 'Aniversariante - Aviso do Sistema', mb_iconinformation+mb_ok);
  end;
end;

procedure TfrmPrincipalF.Calculadora1Click(Sender: TObject);
begin
  WinExec('calc.exe', SW_NORMAL);
end;

procedure TfrmPrincipalF.Categorias1Click(Sender: TObject);
begin
  ShowCategoria;
end;

procedure TfrmPrincipalF.Compras1Click(Sender: TObject);
begin
  ShowNovaCompra;
end;

procedure TfrmPrincipalF.Configuraes1Click(Sender: TObject);
begin
  ShowOpcoes;
end;

procedure TfrmPrincipalF.iposdePagamento1Click(Sender: TObject);
begin
  ShowTipoPagamento;
end;

procedure TfrmPrincipalF.Movimentao1Click(Sender: TObject);
begin
  ShowConsultaMov;
end;

procedure TfrmPrincipalF.MovimentaoporPessoa1Click(Sender: TObject);
begin
  ShowRltMovPessoa;
end;

procedure TfrmPrincipalF.Pessoas1Click(Sender: TObject);
begin
  ShowNovoCadastro;
end;

procedure TfrmPrincipalF.Pessoas2Click(Sender: TObject);
begin
  ShowConsultaPessoa;
end;

procedure TfrmPrincipalF.Produtos1Click(Sender: TObject);
begin
  ShowNovoProduto;
end;

procedure TfrmPrincipalF.Produtos2Click(Sender: TObject);
begin
  ShowConsultaProduto;
end;

procedure TfrmPrincipalF.RelatriodeMovimentaoporData1Click(Sender: TObject);
begin
  ShowRltMovData;
end;

procedure TfrmPrincipalF.Sobre2Click(Sender: TObject);
begin
  ShowSobre;
end;

procedure TfrmPrincipalF.UnidadesdeMedida1Click(Sender: TObject);
begin
  ShowUndMedida;
end;

procedure TfrmPrincipalF.Vendas1Click(Sender: TObject);
begin
  ShowNovaVenda;
end;

procedure TfrmPrincipalF.VendasporVendedor1Click(Sender: TObject);
begin
  ShowRltVendedor;
end;

procedure TfrmPrincipalF.Sair1Click(Sender: TObject);
begin
  Close;
end;
end.


