library CraniumResources;

uses
  SysUtils,
  Classes,
  Printers,
  Graphics,
  Windows,
  Registry,
  frmCategoriaU in 'frmCategoriaU.pas' {frmCategoriaF},
  frmConsultaMovU in 'frmConsultaMovU.pas' {frmConsultaMovF},
  frmConsultaPessoaU in 'frmConsultaPessoaU.pas' {frmConsultaPessoaF},
  frmConsultaProdutoU in 'frmConsultaProdutoU.pas' {frmConsultaProdutoF},
  frmFinalizarCU in 'frmFinalizarCU.pas' {frmFinalizarCF},
  frmFinalizarVU in 'frmFinalizarVU.pas' {frmFinalizarVF},
  frmItensMovU in 'frmItensMovU.pas' {frmItensMovF},
  frmNovaCompraU in 'frmNovaCompraU.pas' {frmNovaCompraF},
  frmNovaVendaU in 'frmNovaVendaU.pas' {frmNovaVendaF},
  frmNovoCadastroU in 'frmNovoCadastroU.pas' {frmNovoCadastroF},
  frmNovoProdutoU in 'frmNovoProdutoU.pas' {frmNovoProdutoF},
  frmProdutoSelecionadoCU in 'frmProdutoSelecionadoCU.pas' {frmProdutoSelecionadoCF},
  frmProdutoSelecionadoVU in 'frmProdutoSelecionadoVU.pas' {frmProdutoSelecionadoVF},
  frmRltMovDataU in 'frmRltMovDataU.pas' {frmRltMovDataF},
  frmRltMovPessoaU in 'frmRltMovPessoaU.pas' {frmRltMovPessoaF},
  frmRltVendedorU in 'frmRltVendedorU.pas' {frmRltVendedorF},
  frmSobreU in 'frmSobreU.pas' {frmSobreF},
  frmTipoPagamentoU in 'frmTipoPagamentoU.pas' {frmTipoPagamentoF},
  frmUndMedidaU in 'frmUndMedidaU.pas' {frmUndMedidaF},
  VerificaProcesso in 'VerificaProcesso.pas',
  DataU in 'DataU.pas' {DataF: TDataModule},
  frmOpcoesU in 'frmOpcoesU.pas' {frmOpcoesF},
  IniciaComWindows in 'IniciaComWindows.pas';

{$R *.res}

function ShowCategoria : integer; stdcall;
begin
  frmCategoriaF := TfrmCategoriaF.Create(nil);
  Result := frmCategoriaF.ShowModal;
end;

function ShowConsultaMov : integer; stdcall;
begin
  frmConsultaMovF := TfrmConsultaMovF.Create(nil);
  Result := frmConsultaMovF.ShowModal;
end;

function ShowConsultaPessoa : integer; stdcall;
begin
  frmConsultaPessoaF := TfrmConsultaPessoaF.Create(nil);
  Result := frmConsultaPessoaF.ShowModal;
end;

function ShowConsultaProduto : integer; stdcall;
begin
  frmConsultaProdutoF := TfrmConsultaProdutoF.Create(nil);
  Result := frmConsultaProdutoF.ShowModal;
end;

function ShowFinalizarC : integer; stdcall;
begin
  frmFinalizarCF := TfrmFinalizarCF.Create(nil);
  Result := frmFinalizarCF.ShowModal;
end;

function ShowFinalizarV : integer; stdcall;
begin
  frmFinalizarVF := TfrmFinalizarVF.Create(nil);
  Result := frmFinalizarVF.ShowModal;
end;

function ShowItensMov : integer; stdcall;
begin
  frmItensMovF := TfrmItensMovF.Create(nil);
  Result := frmItensMovF.ShowModal;
end;

function ShowNovaCompra : integer; stdcall;
begin
  frmNovaCompraF := TfrmNovaCompraF.Create(nil);
  Result := frmNovaCompraF.ShowModal;
end;

function ShowNovaVenda : integer; stdcall;
begin
  frmNovaVendaF := TfrmNovaVendaF.Create(nil);
  Result := frmNovaVendaF.ShowModal;
end;

function ShowNovoCadastro : integer; stdcall;
begin
  frmNovoCadastroF := TfrmNovoCadastroF.Create(nil);
  Result := frmNovoCadastroF.ShowModal;
end;

function ShowNovoProduto : integer; stdcall;
begin
  frmNovoProdutoF := TfrmNovoProdutoF.Create(nil);
  Result := frmNovoProdutoF.ShowModal;
end;

function ShowProdutoSelecionadoC : integer; stdcall;
begin
  frmProdutoSelecionadoCF := TfrmProdutoSelecionadoCF.Create(nil);
  Result := frmProdutoSelecionadoCF.ShowModal;
end;

function ShowProdutoSelecionadoV : integer; stdcall;
begin
  frmProdutoSelecionadoVF := TfrmProdutoSelecionadoVF.Create(nil);
  Result := frmProdutoSelecionadoVF.ShowModal;
end;

function ShowRltMovData : integer; stdcall;
begin
  frmRltMovDataF := TfrmRltMovDataF.Create(nil);
  Result := frmRltMovDataF.ShowModal;
end;

function ShowRltMovPessoa : integer; stdcall;
begin
  frmRltMovPessoaF := TfrmRltMovPessoaF.Create(nil);
  Result := frmRltMovPessoaF.ShowModal;
end;

function ShowRltVendedor : integer; stdcall;
begin
  frmRltVendedorF := TfrmRltVendedorF.Create(nil);
  Result := frmRltVendedorF.ShowModal;
end;

function ShowSobre : integer; stdcall;
begin
  frmSobreF := TfrmSobreF.Create(nil);
  Result := frmSobreF.ShowModal;
end;

function ShowTipoPagamento : integer; stdcall;
begin
  frmTipoPagamentoF := TfrmTipoPagamentoF.Create(nil);
  Result := frmTipoPagamentoF.ShowModal;
end;

function ShowUndMedida : integer; stdcall;
begin
  frmUndMedidaF := TfrmUndMedidaF.Create(nil);
  Result := frmUndMedidaF.ShowModal;
end;

function ShowOpcoes : integer; stdcall;
begin
  frmOpcoesF := TfrmOpcoesF.Create(nil);
  Result := frmOpcoesF.ShowModal;
end;

procedure ComandoSQL(xSQL : String); stdcall;
begin
  With DataF.dbComando do
  begin
    CommandText := xSQL;
    Execute;
    CommandText := 'COMMIT';
    Execute;
  end;
end;

procedure dbSelect(xSQL : String); stdcall;
begin
  With DataF.dbQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add(xSQL);
    Open;
  end;
end;

procedure ImprimeCanvas(Coluna : Integer; Texto : String; out LinhaAtual : Integer ); stdcall;
begin
  Printer.Canvas.TextOut(Coluna, LinhaAtual, Texto);
  LinhaAtual := LinhaAtual + Printer.Canvas.TextHeight('A') + 10;
end;

function CentralizaTexto(Texto : String) : Integer; stdcall;
var TamanhoTexto : integer;
begin
  TamanhoTexto := Printer.Canvas.TextWidth(Texto);
  Result := Round((Printer.PageWidth - TamanhoTexto) / 2);
end;

procedure RltCabecalho(Titulo : String; out LinhaAtual : Integer); stdcall;
const Tracos = '-----------------------------------------------------------------------------------------------------------------------';
begin
  Printer.Canvas.Font.Style := Printer.Canvas.Font.Style + [fsBold];
  Printer.Canvas.Font.Size := 12;
  ImprimeCanvas(CentralizaTexto('Cranium Solutions'), 'Cranium Solutions', LinhaAtual);
  ImprimeCanvas(CentralizaTexto(Titulo), Titulo, LinhaAtual);
  ImprimeCanvas(CentralizaTexto(Tracos), Tracos, LinhaAtual);
  Printer.Canvas.Font.Style := Printer.Canvas.Font.Style - [fsBold];
end;

function Aniversariante : boolean; stdcall;
var Registro : TRegistry;
begin
  Result := FALSE;
  Registro := TRegistry.Create;
  if Registro.OpenKey('Cranium',FALSE) then
  begin
    if Registro.ValueExists('Aniversariante') then
      Result := Registro.ReadBool('Aniversariante');
  end;
  Registro.CloseKey;
  Registro.Free;
end;

procedure CreateDM; stdcall;
begin
  DataF := TDataF.Create(nil);
end;

procedure DestroyDM; stdcall;
begin
  FreeAndNil(DataF);
end;

exports
  CentralizaTexto,
  ComandoSQL,
  dbSelect,
  ImprimeCanvas,
  RltCabecalho,
  ShowCategoria,
  ShowConsultaMov,
  ShowConsultaPessoa,
  ShowConsultaProduto,
  ShowFinalizarC,
  ShowFinalizarV,
  ShowItensMov,
  ShowNovaCompra,
  ShowNovaVenda,
  ShowNovoCadastro,
  ShowNovoProduto,
  ShowProdutoSelecionadoC,
  ShowProdutoSelecionadoV,
  ShowRltMovData,
  ShowRltMovPessoa,
  ShowRltVendedor,
  ShowSobre,
  ShowTipoPagamento,
  ShowUndMedida,
  ShowOpcoes,
  Aniversariante,
  CreateDM,
  DestroyDM;

begin

end.

