unit IniciaComWindows;

interface

uses Windows, Registry;

  procedure RunOnStartup(Titulo, Caminho : string; Cria : boolean);

implementation

procedure RunOnStartup(Titulo, Caminho : string; Cria : boolean);
var Registro : TRegistry;
begin
  Registro := TRegistry.Create;
  Registro.RootKey := HKEY_LOCAL_MACHINE;
  Registro.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', FALSE);

  if Cria then
    Registro.WriteString(Titulo, Caminho)
  else
    Registro.DeleteValue(Titulo);

  Registro.CloseKey;
  Registro.Free;
end;
end.

