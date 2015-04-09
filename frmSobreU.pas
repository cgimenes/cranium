unit frmSobreU;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TfrmSobreF = class(TForm)
    pnPainel: TPanel;
    imgLogo: TImage;
    lbNome: TLabel;
    lbVersao: TLabel;
    lbCopyright: TLabel;
    btnOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frmSobreF: TfrmSobreF;

implementation

{$R *.dfm}

procedure TfrmSobreF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

