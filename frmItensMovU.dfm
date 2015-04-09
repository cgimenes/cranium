object frmItensMovF: TfrmItensMovF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Itens da Movimenta'#231#227'o'
  ClientHeight = 368
  ClientWidth = 448
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
  object sgItens: TStringGrid
    Left = 8
    Top = 8
    Width = 433
    Height = 350
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 0
    ColWidths = (
      57
      239
      64
      64)
  end
end
