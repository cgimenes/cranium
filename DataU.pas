unit DataU;

interface

uses
  SysUtils, Classes, DB, ADODB, Graphics;

type
  TDataF = class(TDataModule)
    dbConexao: TADOConnection;
    dbComando: TADOCommand;
    dbQuery: TADOQuery;
    dbRvVendedor: TADOQuery;
  private

  public

  end;

var
  DataF: TDataF;

implementation

{$R *.dfm}

end.

