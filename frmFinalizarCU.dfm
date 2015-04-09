object frmFinalizarCF: TfrmFinalizarCF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Finalizar Compra'
  ClientHeight = 143
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbTotal: TLabel
    Left = 52
    Top = 109
    Width = 49
    Height = 19
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbVlrTotal: TLabel
    Left = 107
    Top = 98
    Width = 155
    Height = 33
    Caption = 'R$ 9999,99'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbCodigo: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
    Enabled = False
  end
  object lbTipoPagamento: TLabel
    Left = 8
    Top = 52
    Width = 92
    Height = 13
    Caption = 'Tipo de Pagamento'
  end
  object cbTipoPagamento: TComboBox
    Left = 8
    Top = 65
    Width = 254
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object btnFinalizar: TButton
    Left = 122
    Top = 19
    Width = 140
    Height = 25
    Caption = 'Finalizar Compra'
    Default = True
    TabOrder = 2
    OnClick = btnFinalizarClick
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 21
    Width = 81
    Height = 21
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
end
