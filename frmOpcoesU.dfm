object frmOpcoesF: TfrmOpcoesF
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Op'#231#245'es'
  ClientHeight = 311
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tvOpcoes: TTreeView
    Left = 8
    Top = 8
    Width = 121
    Height = 265
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnClick = tvOpcoesClick
    Items.NodeData = {
      0301000000280000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0000000000010547006500720061006C00}
  end
  object btnOK: TButton
    Left = 282
    Top = 279
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancelar: TButton
    Left = 363
    Top = 279
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object pnlGeral: TPanel
    Left = 135
    Top = 8
    Width = 303
    Height = 265
    BevelInner = bvLowered
    TabOrder = 1
    object chbAniversariante: TCheckBox
      Left = 8
      Top = 31
      Width = 257
      Height = 17
      Caption = 'Mostrar colaboradores aniversariantes ao iniciar'
      TabOrder = 0
    end
    object chbIniciaWindows: TCheckBox
      Left = 8
      Top = 8
      Width = 257
      Height = 17
      Caption = 'Iniciar o Cranium junto com o Windows'
      TabOrder = 1
    end
  end
end
