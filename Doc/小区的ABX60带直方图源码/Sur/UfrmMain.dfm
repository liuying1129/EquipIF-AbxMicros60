object frmMain: TfrmMain
  Left = 223
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25968#25454#25509#25910#26381#21153
  ClientHeight = 404
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    000000000000000000000000000000000000000000BBB0000000000000000000
    000000000BB0BB00000000000000000000000000BB0B0BB00000000000000000
    0000000BB0BBB0BB0000000000000000000000BB0BBBBB0BB000000000000000
    00000BB0BBBBBBB0BB000000000000000000BB0BBBBBBBBB0BB0000000000000
    000BB0BBBBBBBBBBB0BB00000000000000BB0BBBBBBBBBBBBB0BB00000000000
    0BB0BB000BBBBBBBBBB0BB0000000000BB0BBB000BBBBBBBBBBB0BB00000000B
    B0BBBB000BBBBBBBBBBBB0BB000000BB0BBBBB000BBBBBBBBBBBBB0BB0000BB0
    BBBBBB000BBBBBBBBBBBBBB0BB000B0BBBBBBB000BBBBBB0BBBBBBBB0B000BB0
    BBBBBB000BBBBBB00BBBBBB0BB0000BB0BBBBB000000000000BBBB0BB000000B
    B0BBBB0000000000000BB0BB00000000BB0BBBB00000000000BB0BB000000000
    0BB0BBBBBBBBBBB00BB0BB000000000000BB0BBBBBBBBBB0BB0BB00000000000
    000BB0BBBBBBBBBBB0BB0000000000000000BB0BBBBBBBBB0BB0000000000000
    00000BB0BBBBBBB0BB00000000000000000000BB0BBBBB0BB000000000000000
    0000000BB0BBB0BB000000000000000000000000BB0B0BB00000000000000000
    000000000BB0BB0000000000000000000000000000BBB0000000000000000000
    0000000000000000000000000000FFFFFFFFFFFC7FFFFFF83FFFFFF01FFFFFE0
    0FFFFFC007FFFF8003FFFF0001FFFE0000FFFC00007FF800003FF000001FE000
    000FC00000078000000300000001000000010000000180000003C0000007E000
    000FF000001FF800003FFC00007FFE0000FFFF0001FFFF8003FFFFC007FFFFE0
    0FFFFFF01FFFFFF83FFFFFFC7FFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    000BB0000000000000B00B00000000000B0BB0B000000000B0BBBB0B0000000B
    0B0BBBB0B00000B0BB0BBBBB0B000B0BBB0BB0BBB0B00B0BBB00000BB0B000B0
    BBBBB0BB0B00000B0BBBBBB0B0000000B0BBBB0B000000000B0BB0B000000000
    00B00B0000000000000BB00000000000000000000000FE7F0000FC3F0000F81F
    0000F00F0000E0070000C003000080010000000000000000000080010000C003
    0000E0070000F00F0000F81F0000FC3F0000FE7F0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 25
    Width = 574
    Height = 379
    ActivePage = TabSheet3
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #27979#35797#25968#25454
      object Label_status: TLabel
        Left = 0
        Top = 0
        Width = 35
        Height = 13
        Caption = 'ready'
        Color = clSilver
        ParentColor = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = #38169#35823#26085#24535
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 348
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 0
        object BitBtn3: TBitBtn
          Left = 489
          Top = 7
          Width = 75
          Height = 25
          Caption = #23548#20837
          TabOrder = 0
          OnClick = BitBtn3Click
        end
        object Memo1: TMemo
          Left = 2
          Top = 2
          Width = 481
          Height = 344
          Align = alLeft
          Color = clInfoBk
          Ctl3D = False
          ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #21442#25968#35774#32622
      ImageIndex = 3
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 348
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 0
        object Label29: TLabel
          Left = 42
          Top = 8
          Width = 52
          Height = 13
          Caption = #20018#21475#36873#25321
        end
        object Label30: TLabel
          Left = 351
          Top = 7
          Width = 39
          Height = 13
          Caption = #39033#30446#21495
        end
        object Label1: TLabel
          Left = 170
          Top = 58
          Width = 39
          Height = 13
          Caption = #25968#25454#20301
        end
        object Label2: TLabel
          Left = 286
          Top = 58
          Width = 39
          Height = 13
          Caption = #20572#27490#20301
        end
        object Label3: TLabel
          Left = 56
          Top = 58
          Width = 39
          Height = 13
          Caption = #27874#29305#29575
        end
        object Label4: TLabel
          Left = 403
          Top = 58
          Width = 52
          Height = 13
          Caption = #22855#20598#26657#39564
        end
        object Label6: TLabel
          Left = 4
          Top = 295
          Width = 635
          Height = 15
          Caption = #27880':1'#34920#31034#20572#27490#20301#20026'1,2'#20026'2,0'#20026'1.5'#65307'1'#34920#31034#22855#20598#26657#39564#20026'Even,2'#20026'Mark,3'#20026'None,4'#20026'Odd,5'#20026'Space'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 286
          Top = 30
          Width = 104
          Height = 13
          Caption = #26816#39564#31995#32479#31383#20307#26631#39064
        end
        object Label7: TLabel
          Left = 16
          Top = 30
          Width = 78
          Height = 13
          Caption = #26816#39564#31995#32479#31867#21517
        end
        object Label8: TLabel
          Left = 4
          Top = 317
          Width = 444
          Height = 15
          Caption = #27880':"'#20027#31243#24207#37197#32622#25991#20214#36335#24452'"'#29992#20110#26597#25214#35813#25991#20214#20013#30149#20154#22522#26412#20449#24687#30340#40664#35748#20540
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 8
          Top = 126
          Width = 117
          Height = 13
          Caption = #20027#31243#24207#37197#32622#25991#20214#36335#24452
        end
        object Label16: TLabel
          Left = 424
          Top = 102
          Width = 52
          Height = 13
          Caption = #32852#26426#23376#27597
        end
        object chkboxAutorun: TCheckBox
          Left = 103
          Top = 98
          Width = 113
          Height = 17
          Caption = #24320#26426#21518#33258#21160#36816#34892
          Color = clBtnFace
          Ctl3D = True
          Enabled = False
          ParentColor = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object cbCOMM: TComboBox
          Left = 103
          Top = 4
          Width = 122
          Height = 23
          Hint = #36873#25321#20018#21475
          BevelKind = bkFlat
          Style = csDropDownList
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
          ItemHeight = 15
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Items.Strings = (
            'COM1'
            'COM2'
            'COM3'
            'COM4')
        end
        object btnSet: TBitBtn
          Left = 144
          Top = 256
          Width = 75
          Height = 25
          Caption = #21442#25968#35774#32622
          TabOrder = 2
          OnClick = btnSetClick
        end
        object btnOK: TBitBtn
          Left = 241
          Top = 256
          Width = 76
          Height = 25
          Caption = #30830#23450
          Enabled = False
          TabOrder = 3
          OnClick = btnOKClick
        end
        object btnCancel: TBitBtn
          Left = 344
          Top = 256
          Width = 75
          Height = 25
          Caption = #21462#28040
          Enabled = False
          TabOrder = 4
          OnClick = btnCancelClick
        end
        object edtBaudRate: TEdit
          Left = 103
          Top = 55
          Width = 57
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 5
        end
        object edtStopbit: TEdit
          Left = 333
          Top = 55
          Width = 57
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 6
        end
        object edtDatabit: TEdit
          Left = 217
          Top = 55
          Width = 57
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 7
        end
        object edtParity: TEdit
          Left = 464
          Top = 55
          Width = 57
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 8
        end
        object edtLisClassName: TEdit
          Left = 103
          Top = 28
          Width = 122
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 9
        end
        object edtLisFormCaption: TEdit
          Left = 401
          Top = 27
          Width = 120
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 10
        end
        object SpEdtItmeID: TEdit
          Left = 401
          Top = 6
          Width = 120
          Height = 19
          Color = clBtnFace
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 11
        end
        object btnTestConnStr: TBitBtn
          Left = 440
          Top = 256
          Width = 113
          Height = 25
          Caption = #33719#21462#36830#25509#23383#31526#20018
          TabOrder = 12
          OnClick = btnTestConnStrClick
        end
        object GroupBox1: TGroupBox
          Left = 16
          Top = 169
          Width = 529
          Height = 85
          Caption = #36136#25511#35774#32622
          TabOrder = 13
          object Label9: TLabel
            Left = 79
            Top = 12
            Width = 91
            Height = 13
            Caption = #24120#20540#36136#25511#26679#26412#21495
          end
          object Label10: TLabel
            Left = 367
            Top = 64
            Width = 52
            Height = 13
            Caption = #36136#25511#26376#20221
          end
          object Label11: TLabel
            Left = 367
            Top = 39
            Width = 52
            Height = 13
            Caption = #36136#25511#24180#20221
          end
          object Label13: TLabel
            Left = 364
            Top = 14
            Width = 52
            Height = 13
            Caption = #36136#25511#31867#22411
          end
          object Label14: TLabel
            Left = 79
            Top = 36
            Width = 91
            Height = 13
            Caption = #39640#20540#36136#25511#26679#26412#21495
          end
          object Label15: TLabel
            Left = 79
            Top = 60
            Width = 91
            Height = 13
            Caption = #20302#20540#36136#25511#26679#26412#21495
          end
          object edtQuaContSpecNo: TEdit
            Left = 177
            Top = 9
            Width = 71
            Height = 19
            Color = clInfoBk
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ParentCtl3D = False
            TabOrder = 0
          end
          object edtQuaContMonth: TEdit
            Left = 425
            Top = 61
            Width = 71
            Height = 19
            Color = clInfoBk
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ParentCtl3D = False
            TabOrder = 1
          end
          object edtQuaContyear: TEdit
            Left = 425
            Top = 36
            Width = 71
            Height = 19
            Color = clInfoBk
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ParentCtl3D = False
            TabOrder = 2
          end
          object ComboBox1: TComboBox
            Left = 424
            Top = 11
            Width = 97
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ItemHeight = 13
            ParentCtl3D = False
            TabOrder = 3
            Items.Strings = (
              #21333#20540#36136#25511
              #22810#20540#36136#25511)
          end
          object Edit1: TEdit
            Left = 177
            Top = 33
            Width = 71
            Height = 19
            Color = clInfoBk
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ParentCtl3D = False
            TabOrder = 4
          end
          object Edit2: TEdit
            Left = 177
            Top = 57
            Width = 71
            Height = 19
            Color = clInfoBk
            Ctl3D = False
            Enabled = False
            ImeName = #32043#20809#25340#38899#36755#20837#27861
            ParentCtl3D = False
            TabOrder = 5
          end
        end
        object edtMainAppProfilePath: TEdit
          Left = 131
          Top = 123
          Width = 390
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 14
        end
        object editcommword: TEdit
          Left = 481
          Top = 98
          Width = 40
          Height = 19
          Color = clInfoBk
          Ctl3D = False
          Enabled = False
          ImeName = #32043#20809#25340#38899#36755#20837#27861
          ParentCtl3D = False
          TabOrder = 15
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #35843#35797#25968#25454
      ImageIndex = 3
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 348
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 0
        object Memo2: TMemo
          Left = 8
          Top = 8
          Width = 532
          Height = 298
          Color = clInfoBk
          ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
          Lines.Strings = (
            #2'00769'
            #63733' RESULT  '
            'p 23'
            'q 05/12/16 15h30mn00s'
            'u 0000000000000007'
            's 0008'
            'v                               '
            't M'
            #8364' D'
            '! 006.1  '
            '2 04.23  '
            '3 00108 l'
            '4  .312 l'
            '5 00074 l'
            '6 025.6 l'
            '7 00347  '
            '8 015.0  '
            '@ 00213  '
            'A 006.8  '
            'B  .146  '
            'C 012.7  '
            '# 028.0  '
            '% 003.1 l'
            #39' 068.9  '
            '" 001.7  '
            '$ 000.1 l'
            '& 004.3  '
            
              'W         &*.,2;Pc'#22715#27595'?'#34552#24604#28206'cN?720.,,0279;;=CGJLT_goz'#8364#21087#23237#12369#30446#24917#20142#26691#34164#23631#25335#38271#26828#24374#21074 +
              'xrrmicXRLGAAC?722.,*((&$&$$"""$"   "         ('
            
              'X            !""  !!#"&'#39'16DPh'#20199#57776'?'#30232#35766#59236#24063'z~wrgfeXYTKIKE@?;<62.0).-)+)' +
              '&%$%#""#"" "!! "!  ! !                                    %'
            
              'Y           !%>Yqy'#22684#23214'}ypus||mia`YYRQHD>@>>5200..*)()())(%$%"%%%$' +
              '"%""!"$!!!!!!"!   !    !"""!!   !!!   !!  !!    !!"!!!!!!!   "$%'
            'S       '
            '_ 105'
            'P             '
            '] 000 000 000 030 042'
            '?0001'
            '?MICROS60'
            '?V2.8 '
            '?AC1F'
            #3)
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object Button1: TButton
          Left = 418
          Top = 315
          Width = 121
          Height = 25
          Caption = #20445#23384#21040#25968#25454#24211
          TabOrder = 1
          OnClick = Button1Click
        end
      end
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 574
    Height = 25
    AutoSize = True
    Bands = <
      item
        Break = False
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 21
        Width = 570
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 252
      Height = 21
      Align = alNone
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 87
      Caption = 'ToolBar1'
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton7: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #20851#20110'(F1)'
        ImageIndex = 5
        OnClick = ToolButton7Click
      end
      object ToolButton8: TToolButton
        Left = 65
        Top = 0
        Width = 8
        Caption = 'ToolButton8'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object ToolButton1: TToolButton
        Left = 73
        Top = 0
        AutoSize = True
        Caption = #20462#25913#23494#30721'(F2)'
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
      object ToolButton4: TToolButton
        Left = 164
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton3: TToolButton
        Left = 172
        Top = 0
        AutoSize = True
        Caption = #36864#20986'(Esc)'
        ImageIndex = 2
        OnClick = N3Click
      end
      object ToolButton6: TToolButton
        Left = 244
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
  end
  object LYTray1: TLYTray
    Icon.Data = {
      0000010002002020100000000000E80200002600000010101000000000002801
      00000E0300002800000020000000400000000100040000000000800200000000
      0000000000000000000000000000000000000000800000800000008080008000
      0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
      0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000BBB0000000000000000000
      000000000BB0BB00000000000000000000000000BB0B0BB00000000000000000
      0000000BB0BBB0BB0000000000000000000000BB0BBBBB0BB000000000000000
      00000BB0BBBBBBB0BB000000000000000000BB0BBBBBBBBB0BB0000000000000
      000BB0BBBBBBBBBBB0BB00000000000000BB0BBBBBBBBBBBBB0BB00000000000
      0BB0BB000BBBBBBBBBB0BB0000000000BB0BBB000BBBBBBBBBBB0BB00000000B
      B0BBBB000BBBBBBBBBBBB0BB000000BB0BBBBB000BBBBBBBBBBBBB0BB0000BB0
      BBBBBB000BBBBBBBBBBBBBB0BB000B0BBBBBBB000BBBBBB0BBBBBBBB0B000BB0
      BBBBBB000BBBBBB00BBBBBB0BB0000BB0BBBBB000000000000BBBB0BB000000B
      B0BBBB0000000000000BB0BB00000000BB0BBBB00000000000BB0BB000000000
      0BB0BBBBBBBBBBB00BB0BB000000000000BB0BBBBBBBBBB0BB0BB00000000000
      000BB0BBBBBBBBBBB0BB0000000000000000BB0BBBBBBBBB0BB0000000000000
      00000BB0BBBBBBB0BB00000000000000000000BB0BBBBB0BB000000000000000
      0000000BB0BBB0BB000000000000000000000000BB0B0BB00000000000000000
      000000000BB0BB0000000000000000000000000000BBB0000000000000000000
      0000000000000000000000000000FFFFFFFFFFFC7FFFFFF83FFFFFF01FFFFFE0
      0FFFFFC007FFFF8003FFFF0001FFFE0000FFFC00007FF800003FF000001FE000
      000FC00000078000000300000001000000010000000180000003C0000007E000
      000FF000001FF800003FFC00007FFE0000FFFF0001FFFF8003FFFFC007FFFFE0
      0FFFFFF01FFFFFF83FFFFFFC7FFF280000001000000020000000010004000000
      0000C00000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
      000BB0000000000000B00B00000000000B0BB0B000000000B0BBBB0B0000000B
      0B0BBBB0B00000B0BB0BBBBB0B000B0BBB0BB0BBB0B00B0BBB00000BB0B000B0
      BBBBB0BB0B00000B0BBBBBB0B0000000B0BBBB0B000000000B0BB0B000000000
      00B00B0000000000000BB00000000000000000000000FE7F0000FC3F0000F81F
      0000F00F0000E0070000C003000080010000000000000000000080010000C003
      0000E0070000F00F0000F81F0000FC3F0000FE7F0000}
    Hint = #25968#25454#25509#25910#26381#21153
    PopupMenu = PopupMenu1
    ActButton = abRightButton
    Left = 206
    Top = 147
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    OwnerDraw = True
    Left = 234
    Top = 147
    object N1: TMenuItem
      Caption = #35774#32622
      ImageIndex = 1
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #36864#20986
      ImageIndex = 0
      OnClick = N3Click
    end
  end
  object XPMenu1: TXPMenu
    Font.Charset = GB2312_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clBtnFace
    IconBackColor = clCream
    MenuBarColor = clBackground
    SelectColor = clHighlight
    SelectBorderColor = clBlue
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clGradientActiveCaption
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = False
    Active = True
    Left = 262
    Top = 147
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 354
    Top = 147
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select checkunid as '#21807#19968#32534#21495',checkid AS '#26816#39564#21333#21495','
      '  patientname as '#30149#20154#22995#21517',sex AS '#24615#21035',age as '#24180#40836',Caseno as '#30149#21382#21495','
      '  bedno as '#24202#21495',deptname as '#30149#21306',check_date as '#26816#39564#26085#26399','
      '  check_doctor as '#26816#39564#21307#29983',report_date as '#25253#21578#26085#26399','
      '  report_doctor as '#25253#21578#21307#29983',operator as '#25805#20316#32773',printtimes as '#25171#21360#27425#25968','
      '  Itemid as '#20027#39033#30446#31867#21035'ID,itemname as '#20027#39033#30446#21517#31216','
      '  Diagnosetype as '#35786#26029#24773#20917',flagetype as '#26631#26412#31867#21035',diagnose as '#20020#24202#35786#26029','
      '  nationality as '#27665#26063',typeflagcase as '#26631#26412#24773#20917',getmoney as '#25910#36153','
      '  longvalue as '#25551#36848#32467#26524
      '  From chk_con')
    Left = 382
    Top = 147
  end
  object ImageList1: TImageList
    Left = 290
    Top = 147
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000009452945294529452945294529452
      9452945294529452945294529452945200000000000000000000000000000000
      000000000000000000000000000000000000CE210000872400380000091C0000
      000000000000000000000900CE0100000200FF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDE7BDE7BDE7BDE7BDE7BDE7BDE7B
      BF02DE7BDE7BDE7BDE7BDE7BDE7BBE7B524A0000000000000000000000000000
      0000000000000000F25EB3568F52D35A00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE77FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FBE77524A9873366736673667366736673667
      3667366736679252BD77FF7FF65E9452D35A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE77FF7FA47EA47EA47EA47EA47E
      A47EA47EA47EA47EA47EA47EFF7FBE77524AFF7FC618E61CA5140821E71C2925
      C618292529259452C618A514EF3D524A34670000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE77FF7FA47EA47EA47EA47EA47E
      A47EA47EA47EA47EA47EA47EFF7FBE77524A786F304631461042EF3D0F423146
      3146EF3D524A386793529352F75E146300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE77FF7FA47EA47EA47E747FDD7F
      917FB97FDC7FA47EA47EA47EFF7FBE77524A0000724E7A6F3867CD39CE39AD35
      AD35AD35EE3D93523867596B714E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47E2E7FB87F077F
      077F057F4F7F717FA47EA47EFF7FBE77524A00002104FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47EB87F0C7F0A7F
      257F257F257FFF7FA47EA47EFF7FBE77524A00002104DE7B987F777BD77FD77F
      D77FD67FD67FD67FD67FBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47E977F2F7FE97E
      FF7F257F057FDD7FA47EA47EFF7FBE77524A00002104FF7F427E4276417B407F
      207F6A7F8A7F086F007BBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47E2E7FFF7F077F
      DD7F257F757F2E7FA47EA47EFF7FBE77524A00002104DF7F837E637EE376627F
      617F407F2076264E007BBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47EA47E517FFF7F
      DD7F257F747FA47EA47EA47EFF7FBE77524A00002104DF7FA47E847E657AA37F
      627F407F407F407F007BBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47EA47EA47EA47E
      DD7FA47EA47EA47EA47EA47EFF7FBE77524A00002104DE7FA67E867E657EC37F
      827F417F207F407F207BBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FA47EA47EA47EA47EA47E
      A47EA47EA47EA47EA47EA47EFF7FBE77524A00002104DE7FC77EA77E867EC47F
      837F617F407F407F207BBD770000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BE7BFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FBE77524A00002104DE7F077FC77EC67E657F
      C37FA27F807F407F407FBD770000000000009873366736673667366736673667
      3667366736679252BD77FF7FF65E9452D35AFF7FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FF25EB3568F52D35AFF7F524A524A524A524A524A524A524A
      524A524A524A524A524A524A524A524A524A00002104BD77DE7BDE7BDE7BDE7B
      DE7BDE7BDF7BDF7BDF7BBD77000000000000FF7F2104FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F724E7A6F3867CD39CE39AD35
      AD35AD35EE3D93523867596B714EFF7FFF7F0000000000000000000000000000
      0000000000000000000000000000000000000000000021042104210421042104
      210421042104210421042104000000000000FF7F2104DF7FA47E847E657AA37F
      627F407F407F407F007BBD77FF7FFF7FFF7FFF7F2104DF7F837E637EE376627F
      617F407F2076264E007BBD77FF7FFF7FFF7F424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF000001FFFFF5F3F3400000FFE1E8E9E840
      00000000FFFFFF4000000000FFFFFF40000000010C0C0C40000080030C0C0C40
      000080070C0C0C40000080070C0C0C40000080070C0C0C40000080070C0C0C40
      00008007FFFFFF4000008007642C1703000080074C000000000080073E2020EC
      0000800700000000FFFFC0070000000000000000000000000000000000000000
      000000000000}
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    Left = 318
    Top = 147
  end
  object LYAboutBox1: TLYAboutBox
    ProcuctName = 'ProductName'
    Version = 'Version'
    Copyright = 'Copyright'
    Comments = 'Comments'
    Author = 'Author'
    WebPage = 'WebPage'
    Left = 178
    Top = 147
  end
  object ActionList1: TActionList
    Left = 150
    Top = 147
    object editpass: TAction
      Caption = 'editpass'
      ShortCut = 113
      OnExecute = ToolButton1Click
    end
    object about: TAction
      Caption = 'about'
      ShortCut = 112
      OnExecute = ToolButton7Click
    end
    object stop: TAction
      Caption = 'stop'
      ShortCut = 27
      OnExecute = N3Click
    end
  end
  object ADOQuery_temp: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 416
    Top = 148
  end
  object ADOConn_Test: TADOConnection
    Left = 112
    Top = 145
  end
  object Comm1: TComm
    CommName = 'COM1'
    BaudRate = 9600
    ParityCheck = False
    Outx_CtsFlow = False
    Outx_DsrFlow = False
    DtrControl = DtrEnable
    DsrSensitivity = False
    TxContinueOnXoff = False
    Outx_XonXoffFlow = False
    Inx_XonXoffFlow = False
    ReplaceWhenParityError = False
    IgnoreNullChar = False
    RtsControl = RtsEnable
    XonLimit = 500
    XoffLimit = 500
    ByteSize = _8
    Parity = None
    StopBits = _1
    XonChar = #17
    XoffChar = #19
    ReplacedChar = #0
    ReadIntervalTimeout = 1000
    ReadTotalTimeoutMultiplier = 0
    ReadTotalTimeoutConstant = 0
    WriteTotalTimeoutMultiplier = 0
    WriteTotalTimeoutConstant = 0
    OnReceiveData = Comm1ReceiveData
    Left = 80
    Top = 145
  end
end
