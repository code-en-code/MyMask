unit test.mymask;

interface

uses
  TestFramework,

  //delphi
  System.SysUtils,

  //fmx
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Edit,

  //codeenconde
  mymask;

type
  TestTMyMask = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExceptionApplyMask;
    procedure TestLabelApplyMask;
    procedure TestEditApplyMask;

    procedure TestEditCnpjApplyMask;
    procedure TestEditCpfApplyMask;
    procedure TestEditIeCeApplyMask;
    procedure TestEditIeRnApplyMask;
    procedure TestEditIeToApplyMask;
    procedure TestEditCepApplyMask;
    procedure TestEditTelephoneApplyMask;
    procedure TestEditCellPhoneApplyMask;
    procedure TestEditCardApplyMask;
    procedure TestEditPisApplyMask;
    procedure TestEditSuframaApplyMask;
    procedure TestEditGtinApplyMask;
    procedure TestEditRenavamApplyMask;
    procedure TestEditCnhApplyMask;
    procedure TestEditLicensePlateApplyMask;
    procedure TestEditDateApplyMask;
    procedure TestEditNcmApplyMask;
    procedure TestEditCestApplyMask;

    procedure TestExceptionApplyInteger;
    procedure TestLabelApplyInteger;
    procedure TestEditApplyInteger;

    procedure TestExceptionApplyFloat;
    procedure TestLabelApplyFloat;
    procedure TestEditApplyFloat;

    procedure TestExceptionApplyCurrency;
    procedure TestLabelApplyCurrency;
    procedure TestEditApplyCurrency;

    procedure TestExceptionControlToInteger;
    procedure TestLabelControlToInteger;
    procedure TestEditControlToInteger;

    procedure TestExceptionControlToFloat;
    procedure TestLabelControlToFloat;
    procedure TestEditControlToFloat;

    procedure TestExceptionControlToCurrency;
    procedure TestLabelControlToCurrency;
    procedure TestEditControlToCurrency;

    procedure TestExceptionRemoveMask;
    procedure TestLabelRemoveMask;
    procedure TestEditRemoveMask;
    procedure TestStringRemoveMask;
  end;

implementation

procedure TestTMyMask.SetUp;
begin

end;

procedure TestTMyMask.TearDown;
begin

end;

procedure TestTMyMask.TestExceptionApplyMask;
var
  AControl: TButton;
  AMask: String;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '123456789';
  AMask := '#(#)##-#-####';
  ExpectedException := Exception;
  TMyMask.ApplyMask(AControl, AMask, False, True);
end;

procedure TestTMyMask.TestLabelApplyMask;
var
  AControl: TLabel;
  AMask: String;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '123456789';
  AMask := '#(#)##-#-####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('1(2)34-5-6789', AControl.Text, 'TestLabelApplyMask failed.');
end;

procedure TestTMyMask.TestEditApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '123456789';
  AMask := '#(#)##-#-####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('1(2)34-5-6789', AControl.Text, 'TestEditApplyMask failed.');
end;

procedure TestTMyMask.TestEditCnpjApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '63088668000152';
  AMask := '##.###.###/####-##';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('63.088.668/0001-52', AControl.Text, 'TestEditCnpjApplyMask failed.');
end;

procedure TestTMyMask.TestEditCpfApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '57016632059';
  AMask := '###.###.###-##';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('570.166.320-59', AControl.Text, 'TestEditCpfApplyMask failed.');
end;

procedure TestTMyMask.TestEditIeCeApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '123456789';
  AMask := '########-#';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('12345678-9', AControl.Text, 'TestEditIeCeApplyMask failed.');
end;

procedure TestTMyMask.TestEditIeRnApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345.678-9';
  AMask := '##.###.###-#';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('12.345.678-9', AControl.Text, 'TestEditIeRnApplyMask failed.');
end;

procedure TestTMyMask.TestEditIeToApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345678901';
  AMask := '###########';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('12345678901', AControl.Text, 'TestEditIeToApplyMask failed.');
end;

procedure TestTMyMask.TestEditCepApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '65081468';
  AMask := '#####-###';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('65081-468', AControl.Text, 'TestEditCepApplyMask failed.');
end;

procedure TestTMyMask.TestEditTelephoneApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '8433333445';
  AMask := '(##)####-####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('(84)3333-3445', AControl.Text, 'TestEditTelephoneApplyMask failed.');
end;

procedure TestTMyMask.TestEditCellPhoneApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '84998180015';
  AMask := '(##)#####-####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('(84)99818-0015', AControl.Text, 'TestEditCellPhoneApplyMask failed.');
end;

procedure TestTMyMask.TestEditCardApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '5207742765786592';
  AMask := '#### #### #### ####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('5207 7427 6578 6592', AControl.Text, 'TestEditCardApplyMask failed.');
end;

procedure TestTMyMask.TestEditPisApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '21229762886';
  AMask := '###.#####.##-#';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('212.29762.88-6', AControl.Text, 'TestEditPisApplyMask failed.');
end;

procedure TestTMyMask.TestEditSuframaApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '123456789';
  AMask := '#########';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('123456789', AControl.Text, 'TestEditSuframaApplyMask failed.');
end;

procedure TestTMyMask.TestEditGtinApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '17898357410043';
  AMask := '##############';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('17898357410043', AControl.Text, 'TestEditGtinApplyMask failed.');
end;

procedure TestTMyMask.TestEditRenavamApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '59184689570';
  AMask := '###########';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('59184689570', AControl.Text, 'TestEditRenavamApplyMask failed.');
end;

procedure TestTMyMask.TestEditCnhApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '27221776451';
  AMask := '###########';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('27221776451', AControl.Text, 'TestEditCnhApplyMask failed.');
end;

procedure TestTMyMask.TestEditLicensePlateApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := 'IYL2846';
  AMask := '###-####';
  TMyMask.ApplyMask(AControl, AMask, True);
  CheckEquals('IYL-2846', AControl.Text, 'TestEditLicensePlateApplyMask failed.');
end;

procedure TestTMyMask.TestEditDateApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '10022021';
  AMask := '##/##/####';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('10/02/2021', AControl.Text, 'TestEditDateApplyMask failed.');
end;

procedure TestTMyMask.TestEditNcmApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345678';
  AMask := '####.##.##';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('1234.56.78', AControl.Text, 'TestEditNcmApplyMask failed.');
end;

procedure TestTMyMask.TestEditCestApplyMask;
var
  AControl: TEdit;
  AMask: String;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '1234567';
  AMask := '##.###.##';
  TMyMask.ApplyMask(AControl, AMask);
  CheckEquals('12.345.67', AControl.Text, 'TestEditCestApplyMask failed.');
end;

procedure TestTMyMask.TestExceptionApplyInteger;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  ExpectedException := Exception;
  TMyMask.ApplyInteger(AControl, True);
end;

procedure TestTMyMask.TestLabelApplyInteger;
var
  AControl: TLabel;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyInteger(AControl);
  CheckEquals('12345', AControl.Text, 'TestLabelApplyInteger failed.');
end;

procedure TestTMyMask.TestEditApplyInteger;
var
  AControl: TEdit;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyInteger(AControl);
  CheckEquals('12345', AControl.Text, 'TestEditApplyInteger failed.');
end;

procedure TestTMyMask.TestExceptionApplyFloat;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  ExpectedException := Exception;
  TMyMask.ApplyFloat(AControl, 2, True);
end;

procedure TestTMyMask.TestLabelApplyFloat;
var
  AControl: TLabel;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyFloat(AControl, 2);
  CheckEquals('12.345,50', AControl.Text, 'TestLabelApplyFloat failed.');
end;

procedure TestTMyMask.TestEditApplyFloat;
var
  AControl: TEdit;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyFloat(AControl, 2);
  CheckEquals('12.345,50', AControl.Text, 'TestEditApplyFloat failed.');
end;

procedure TestTMyMask.TestExceptionApplyCurrency;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  ExpectedException := Exception;
  TMyMask.ApplyCurrency(AControl, 'R$', 2, True);
end;

procedure TestTMyMask.TestLabelApplyCurrency;
var
  AControl: TLabel;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyCurrency(AControl, 'R$', 2, True);
  CheckEquals('R$ 12.345,50', AControl.Text, 'TestLabelApplyCurrency failed.');
end;

procedure TestTMyMask.TestEditApplyCurrency;
var
  AControl: TEdit;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12345,50';
  TMyMask.ApplyCurrency(AControl, 'R$', 2, True);
  CheckEquals('R$ 12.345,50', AControl.Text, 'TestEditApplyCurrency failed.');
end;

procedure TestTMyMask.TestExceptionControlToInteger;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,50';
  ExpectedException := Exception;
  TMyMask.ControlToInteger(AControl, True);
end;

procedure TestTMyMask.TestLabelControlToInteger;
var
  AControl: TLabel;
  ReturnValue: Integer;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,50';
  ReturnValue := TMyMask.ControlToInteger(AControl);
  CheckEquals(12345, ReturnValue, 'TestLabelControlToInteger failed.');
end;

procedure TestTMyMask.TestEditControlToInteger;
var
  AControl: TEdit;
  ReturnValue: Double;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345';
  ReturnValue := TMyMask.ControlToInteger(AControl);
  CheckEquals(12345, ReturnValue, 'TestEditControlToInteger failed.');
end;

procedure TestTMyMask.TestExceptionControlToFloat;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,50';
  ExpectedException := Exception;
  TMyMask.ControlToFloat(AControl, True);
end;

procedure TestTMyMask.TestLabelControlToFloat;
var
  AControl: TLabel;
  ReturnValue: Double;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,50';
  ReturnValue := TMyMask.ControlToFloat(AControl);
  CheckEquals(12345.50, ReturnValue, 'TestLabelControlToFloat failed.');
end;

procedure TestTMyMask.TestEditControlToFloat;
var
  AControl: TEdit;
  ReturnValue: Double;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,00';
  ReturnValue := TMyMask.ControlToFloat(AControl);
  CheckEquals(12345, ReturnValue, 'TestEditControlToFloat failed.');
end;

procedure TestTMyMask.TestExceptionControlToCurrency;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '12.345,50';
  ExpectedException := Exception;
  TMyMask.ControlToCurrency(AControl, 'R$', True);
end;

procedure TestTMyMask.TestLabelControlToCurrency;
var
  AControl: TLabel;
  ReturnValue: Currency;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := 'R$ 12.345,50';
  ReturnValue := TMyMask.ControlToCurrency(AControl, 'R$');
  CheckEquals(12345.50, ReturnValue, 'TestLabelControlToCurrency failed.');
end;

procedure TestTMyMask.TestEditControlToCurrency;
var
  AControl: TEdit;
  ReturnValue: Currency;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := 'R$ 12.345,00';
  ReturnValue := TMyMask.ControlToCurrency(AControl, 'R$');
  CheckEquals(12345, ReturnValue, 'TestEditControlToCurrency failed.');
end;







procedure TestTMyMask.TestExceptionRemoveMask;
var
  AControl: TButton;
begin
  AControl := TButton.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '9(9)99-9-9999';
  ExpectedException := Exception;
  TMyMask.RemoveMask(AControl, False, True);
end;

procedure TestTMyMask.TestLabelRemoveMask;
var
  ReturnValue: String;
  AControl: TLabel;
begin
  AControl := TLabel.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '9(9)99-9-9999';
  ReturnValue := TMyMask.RemoveMask(AControl);
  CheckEquals('999999999', AControl.Text, 'TestLabelRemoveMask failed.');
end;

procedure TestTMyMask.TestEditRemoveMask;
var
  ReturnValue: String;
  AControl: TEdit;
begin
  AControl := TEdit.Create(nil);
  AControl.Parent := nil;
  AControl.Text := '9(9)99-9-9999';
  ReturnValue := TMyMask.RemoveMask(AControl);
  CheckEquals('999999999', AControl.Text, 'TestEditRemoveMask failed.');
end;

procedure TestTMyMask.TestStringRemoveMask;
var
  ReturnValue: String;
  AString: String;
begin
  AString := '9(9)99-9-9999';
  ReturnValue := TMyMask.RemoveMask(AString);
  CheckEquals('999999999', ReturnValue, 'TestStringRemoveMask failed.');
end;

initialization
  RegisterTest(TestTMyMask.Suite);

end.

