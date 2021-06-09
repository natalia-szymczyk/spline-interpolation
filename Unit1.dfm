object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 493
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object x_label: TLabel
    Left = 55
    Top = 46
    Width = 6
    Height = 13
    Caption = 'x'
  end
  object f_label: TLabel
    Left = 228
    Top = 46
    Width = 4
    Height = 13
    Caption = 'f'
  end
  object st_label: TLabel
    Left = 519
    Top = 465
    Width = 9
    Height = 13
    Caption = 'st'
  end
  object i_output_label: TLabel
    Left = 479
    Top = 311
    Width = 31
    Height = 13
    Caption = 'Wyniki'
  end
  object xx_label: TLabel
    Left = 144
    Top = 233
    Width = 12
    Height = 13
    Caption = 'xx'
  end
  object xa_label: TLabel
    Left = 519
    Top = 46
    Width = 16
    Height = 13
    Caption = 'x.a'
  end
  object i_st_label: TLabel
    Left = 61
    Top = 462
    Width = 9
    Height = 13
    Caption = 'st'
  end
  object output_label: TLabel
    Left = 18
    Top = 311
    Width = 31
    Height = 13
    Caption = 'Wyniki'
  end
  object xxa_label: TLabel
    Left = 600
    Top = 211
    Width = 22
    Height = 13
    Caption = 'xx.a'
  end
  object xb_label: TLabel
    Left = 575
    Top = 46
    Width = 16
    Height = 13
    Caption = 'x.b'
  end
  object fb_label: TLabel
    Left = 752
    Top = 46
    Width = 14
    Height = 13
    Caption = 'f.b'
  end
  object fa_label: TLabel
    Left = 689
    Top = 46
    Width = 14
    Height = 13
    Caption = 'f.a'
  end
  object xxb_label: TLabel
    Left = 663
    Top = 211
    Width = 22
    Height = 13
    Caption = 'xx.b'
  end
  object n_label: TLabel
    Left = 366
    Top = 46
    Width = 68
    Height = 13
    Caption = 'liczba w'#281'z'#322#243'w '
  end
  object x_list: TListBox
    Left = 55
    Top = 89
    Width = 113
    Height = 108
    ItemHeight = 13
    TabOrder = 0
  end
  object f_list: TListBox
    Left = 228
    Top = 90
    Width = 113
    Height = 108
    ItemHeight = 13
    TabOrder = 1
  end
  object output_list: TListBox
    Left = 55
    Top = 311
    Width = 286
    Height = 145
    ItemHeight = 13
    TabOrder = 2
  end
  object x_add: TButton
    Left = 55
    Top = 15
    Width = 113
    Height = 25
    Caption = 'dodaj x'
    TabOrder = 3
    OnClick = x_addClick
  end
  object f_add: TButton
    Left = 228
    Top = 15
    Width = 113
    Height = 25
    Caption = 'dodaj f'
    TabOrder = 4
    OnClick = f_addClick
  end
  object value_button: TButton
    Left = 55
    Top = 266
    Width = 139
    Height = 25
    Caption = 'Obliczanie warto'#347'ci'
    TabOrder = 5
    OnClick = value_buttonClick
  end
  object x_input: TEdit
    Left = 55
    Top = 62
    Width = 113
    Height = 21
    TabOrder = 6
  end
  object f_input: TEdit
    Left = 228
    Top = 63
    Width = 113
    Height = 21
    TabOrder = 7
  end
  object st_output: TEdit
    Left = 76
    Top = 462
    Width = 80
    Height = 21
    TabOrder = 8
  end
  object xx_input: TEdit
    Left = 162
    Top = 230
    Width = 80
    Height = 21
    TabOrder = 9
  end
  object clear_button: TButton
    Left = 366
    Top = 460
    Width = 123
    Height = 25
    Caption = 'Wyczy'#347#263' wszystko'
    TabOrder = 10
    OnClick = clear_buttonClick
  end
  object coeffns_button: TButton
    Left = 200
    Top = 266
    Width = 141
    Height = 25
    Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w'
    TabOrder = 11
    OnClick = coeffns_buttonClick
  end
  object i_x_list: TListBox
    Left = 516
    Top = 89
    Width = 113
    Height = 108
    ItemHeight = 13
    TabOrder = 12
  end
  object i_f_list: TListBox
    Left = 686
    Top = 89
    Width = 116
    Height = 108
    ItemHeight = 13
    TabOrder = 13
  end
  object i_output_list: TListBox
    Left = 516
    Top = 311
    Width = 461
    Height = 145
    ItemHeight = 13
    TabOrder = 14
  end
  object i_x_add: TButton
    Left = 516
    Top = 15
    Width = 110
    Height = 25
    Caption = 'dodaj x'
    TabOrder = 15
    OnClick = i_x_addClick
  end
  object i_f_add: TButton
    Left = 689
    Top = 15
    Width = 113
    Height = 25
    Caption = 'dodaj f'
    TabOrder = 16
    OnClick = i_f_addClick
  end
  object i_value_button: TButton
    Left = 519
    Top = 266
    Width = 138
    Height = 25
    Caption = 'Obliczanie warto'#347'ci'
    TabOrder = 17
    OnClick = i_value_buttonClick
  end
  object xa_input: TEdit
    Left = 516
    Top = 62
    Width = 53
    Height = 21
    TabOrder = 18
  end
  object i_st_output: TEdit
    Left = 534
    Top = 462
    Width = 80
    Height = 21
    TabOrder = 19
  end
  object xxa_input: TEdit
    Left = 600
    Top = 230
    Width = 57
    Height = 21
    TabOrder = 20
  end
  object i_coeffns_button: TButton
    Left = 663
    Top = 266
    Width = 139
    Height = 25
    Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w'
    TabOrder = 21
    OnClick = i_coeffns_buttonClick
  end
  object xb_input: TEdit
    Left = 575
    Top = 62
    Width = 54
    Height = 21
    TabOrder = 22
  end
  object fa_input: TEdit
    Left = 686
    Top = 62
    Width = 50
    Height = 21
    TabOrder = 23
  end
  object fb_input: TEdit
    Left = 752
    Top = 62
    Width = 50
    Height = 21
    TabOrder = 24
  end
  object xxb_input: TEdit
    Left = 663
    Top = 230
    Width = 58
    Height = 21
    TabOrder = 25
  end
  object n_input: TEdit
    Left = 366
    Top = 62
    Width = 123
    Height = 21
    TabOrder = 26
  end
  object n_button: TButton
    Left = 366
    Top = 15
    Width = 123
    Height = 25
    Caption = 'zatwierd'#380
    TabOrder = 27
    OnClick = n_buttonClick
  end
  object przyklad1_a_b: TButton
    Left = 854
    Top = 60
    Width = 123
    Height = 25
    Caption = 'przyklad1_a_b'
    TabOrder = 28
    OnClick = przyklad1_a_bClick
  end
  object n_list: TListBox
    Left = 366
    Top = 89
    Width = 123
    Height = 40
    ItemHeight = 13
    TabOrder = 29
  end
  object przyklad2_intread: TButton
    Left = 854
    Top = 173
    Width = 123
    Height = 25
    Caption = 'przyklad2_intread'
    TabOrder = 30
    OnClick = przyklad2_intreadClick
  end
  object przyklad1_intread: TButton
    Left = 854
    Top = 91
    Width = 123
    Height = 25
    Caption = 'przyklad1_intread'
    TabOrder = 31
    OnClick = przyklad1_intreadClick
  end
  object przyklad2_a_b: TButton
    Left = 854
    Top = 142
    Width = 123
    Height = 25
    Caption = 'przyklad2_a_b'
    TabOrder = 32
    OnClick = przyklad2_a_bClick
  end
end
