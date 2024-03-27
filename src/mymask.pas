unit mymask;

interface

uses
  //delphi
  System.SysUtils,
  System.Classes,
  System.UITypes,

  //fmx
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Platform,
  FMX.Edit,
  FMX.Types,

  //codeencode
  mystring;

type
  TMyMask = class
  private
    { private declarations }
    class function Mask(const AMask: String; const AText: String; const AAlphanumeric: Boolean = False): String;
    class procedure EditMaskWindows(const AEdit: TEdit; const AMask: String; const AAlphanumeric: Boolean = False);
    class procedure EditMaskMobile(const AEdit: TEdit; const AMask: String; const AAlphanumeric: Boolean = False);
    class procedure LabelMaskAllPlatforms(const ALabel: TLabel; const AMask: String; const AAlphanumeric: Boolean = False);
    class procedure EditClipBoardKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);

    class procedure EditIntegerWindows(const AEdit: TEdit);
    class procedure EditIntegerMobile(const AEdit: TEdit);
    class procedure LabelIntegerAllPlatforms(const ALabel: TLabel);

    class procedure EditFloatWindows(const AEdit: TEdit; const ADecimal: Integer = 0);
    class procedure EditFloatMobile(const AEdit: TEdit; const ADecimal: Integer = 0);
    class procedure LabelFloatAllPlatforms(const ALabel: TLabel; const ADecimal: Integer = 0);

    class procedure EditCurrencyWindows(const AEdit: TEdit; const ACurrencySymbol: String; const ADecimal: Integer = 0);
    class procedure EditCurrencyMobile(const AEdit: TEdit; const ACurrencySymbol: String; const ADecimal: Integer = 0);
    class procedure LabelCurrencyAllPlatforms(const ALabel: TLabel; const ACurrencySymbol: String; const ADecimal: Integer = 0);

    class procedure GoToTextEndThread(const AEdit: TEdit);
  public
    { public declarations }
    class var MyKeyDown: Word;

///<summary>Use para aplicar máscara a controles Edits ou Labels.</summary>
///<summary>Use to mask Edit or Label controls.</summary>
///<param name="AControl">Controle Edit ou Label onde será aplicado a máscara. Edit or Label control where the mask will be applied.</param>
///<param name="AMask">Máscara que codifica as formas válidas que o texto pode assumir. Mask that encodes the valid forms that the text can take.</param>
///<param name="AAlphanumeric">Use para permitir valores alfanúmericos. Use to allow alphanumeric values.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
    class procedure ApplyMask(const AControl: TStyledControl; const AMask: String; const AAlphanumeric: Boolean = False; const ARaiseExcept: Boolean = False);

///<summary>Use para formatar número inteiros em controles Edits ou Labels.</summary>
///<summary>Use to format integers in Edits or Labels controls.</summary>
///<param name="AControl">Controle Edit ou Label onde será aplicado a formatação. Edit or Label control where the formatting will be applied.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
    class procedure ApplyInteger(const AControl: TStyledControl; const ARaiseExcept: Boolean = False);

///<summary>Use para formatar pontos flutuantes em controles Edits ou Labels.</summary>
///<summary>Use to format floating points in Edits or Labels controls.</summary>
///<param name="AControl">Controle Edit ou Label onde será aplicado a formatação. Edit or Label control where the formatting will be applied.</param>
///<param name="ADecimal">Número de casas decimais. Number of decimal places.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
    class procedure ApplyFloat(const AControl: TStyledControl; const ADecimal: Integer = 0; const ARaiseExcept: Boolean = False);

///<summary>Use para formatar pontos flutuantes em controles Edits ou Labels.</summary>
///<summary>Use to format floating points in Edits or Labels controls.</summary>
///<param name="AControl">Controle Edit ou Label onde será aplicado a formatação. Edit or Label control where the formatting will be applied.</param>
///<param name="ADecimal">Número de casas decimais. Number of decimal places.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
    class procedure ApplyCurrency(const AControl: TStyledControl; const ACurrencySymbol: String; const ADecimal: Integer = 0; const ARaiseExcept: Boolean = False);

///<summary>Use para retornar como ponto flutuante a propriedade "text" do controle.</summary>
///<summary>Use to return the control's "text" property as floating point.</summary>
///<param name="AControl">Controle Edit ou Label onde será capturado o texto. Edit or Label control where the text will be captured.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
///<returns>Retorna um ponto flutuante. Returns a floating point.</returns>
    class function ControlToInteger(const AControl: TStyledControl; const ARaiseExcept: Boolean = False): Integer;

///<summary>Use para retornar como ponto flutuante a propriedade "text" do controle.</summary>
///<summary>Use to return the control's "text" property as floating point.</summary>
///<param name="AControl">Controle Edit ou Label onde será capturado o texto. Edit or Label control where the text will be captured.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
///<returns>Retorna um ponto flutuante. Returns a floating point.</returns>
    class function ControlToFloat(const AControl: TStyledControl; const ARaiseExcept: Boolean = False): Double;

///<summary>Use para retornar como inteiro a propriedade "text" do controle.</summary>
///<summary>Use to return the control's "text" property as integer.</summary>
///<param name="AControl">Controle Edit ou Label onde será capturado o texto. Edit or Label control where the text will be captured.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
///<returns>Retorna um ponto flutuante. Returns a floating point.</returns>
    class function ControlToCurrency(const AControl: TStyledControl; const ACurrencySymbol: String; const ARaiseExcept: Boolean = False): Currency;

///<summary>Use para remover máscara de controles Edits ou Labels.</summary>
///<summary>Use to unmask Edits or Labels controls.</summary>
///<param name="AControl">Controle Edit ou Label que terá a máscara removida. Edit or Label control that will have the mask removed.</param>
///<param name="AAlphanumeric">Use para permitir valores alfanúmericos. Use to allow alphanumeric values.</param>
///<param name="ARaiseExcept">Levanta uma exceção em caso de erro. Raises an exception in case of error.</param>
///<returns>Retorna uma String sem máscara. Returns an unmasked String.</returns>
    class function RemoveMask(const AControl: TStyledControl; const AAlphanumeric: Boolean = False; const ARaiseExcept: Boolean = False): String; overload;

///<summary>Retirar a máscara de uma String.</summary>
///<summary>Remove the mask from a String.</summary>
///<param name="AString">String que será tratada. String that will be treated.</param>
///<param name="AAlphanumeric">Use para permitir valores alfanúmericos. Use to allow alphanumeric values.</param>
///<returns>Retorna uma String sem máscara. Returns an unmasked String.</returns>
///<remarks>Entrada/Input: '(99)99999-9999' Saída/Output: '99999999999'.</remarks>
    class function RemoveMask(const AString: String; const AAlphanumeric: Boolean = False): String; overload;

///<summary>Use no evento "OnKeyDown" de edits para determinar o próximo controle a receber o foco.</summary>
///<summary>Use in the edits "OnKeyDown" event to determine the next control to receive focus.</summary>
///<param name="AControl">Edit com o foco atual. Edit with current focus.</param>
///<param name="ANextControl">Próximo controle a receber o focos. Next control to receive focus.</param>
///<param name="AKey">Tecla pressionada. Key pressed.</param>
    class procedure EditKeyDownNextFocus(const AControl: TCustomEdit; const ANextControl: TControl; AKey: Word);
  end;

implementation

{ TMyMask }

class function TMyMask.Mask(const AMask: String; const AText: String; const AAlphanumeric: Boolean = False): String;
var
  LIndexMask: Integer;
  LIndexText: Integer;
  LMask: String;
  LText: String;
begin
  if AText.Trim.IsEmpty then
    Exit;

  LMask := AMask.Trim.ToUpper;
  if AAlphanumeric then
    LText := TMyString.RemoveCharSpecial(AText).Trim
  else
    LText := TMyString.OnlyNumber(AText).Trim;

  LIndexMask := 0;
  LIndexText := 0;
  while (LIndexText < LText.Length) and (LIndexMask < LMask.Length) do
  begin
    while LMask.Chars[LIndexMask] <> '#' do
    begin
      Result := Result + LMask.Chars[LIndexMask];
      Inc(LIndexMask);
    end;

    Result := Result + LText.Chars[LIndexText];
    Inc(LIndexMask);
    Inc(LIndexText);
  end;
end;

class procedure TMyMask.EditMaskWindows(const AEdit: TEdit; const AMask: String; const AAlphanumeric: Boolean = False);
var
  LCursorPosition: Integer;
begin
  LCursorPosition := AEdit.CaretPosition;
  TThread.Queue(nil,
  procedure
  begin
    AEdit.Text := Mask(AMask, RemoveMask(AEdit.Text, AAlphanumeric), AAlphanumeric);
    if LCursorPosition <> AEdit.Text.Length then
    begin
      try
        if not TMyString.CharIsNum(AEdit.Text[LCursorPosition]) then
        begin
          if LCursorPosition = Pred(AEdit.Text.Length) then
            AEdit.CaretPosition := AEdit.Text.Length
          else
            AEdit.CaretPosition := LCursorPosition;
        end
        else
          AEdit.CaretPosition := LCursorPosition;
      except
        if AEdit.CaretPosition <> 0 then
          AEdit.CaretPosition := AEdit.Text.Length;
      end;
    end
    else
      AEdit.CaretPosition := AEdit.Text.Length;
  end);
end;

class procedure TMyMask.EditMaskMobile(const AEdit: TEdit; const AMask: String; const AAlphanumeric: Boolean = False);
var
  LCursorPosition: Integer;
begin
  LCursorPosition := AEdit.CaretPosition + 1;
  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      AEdit.Text := Mask(AMask, RemoveMask(AEdit.Text, AAlphanumeric), AAlphanumeric);
      if LCursorPosition <> AEdit.Text.Length then
      begin
        try
          if not TMyString.CharIsNum(AEdit.Text[LCursorPosition]) then
          begin
            if LCursorPosition = Pred(AEdit.Text.Length) then
              AEdit.CaretPosition := AEdit.Text.Length
          end
          else
            AEdit.CaretPosition := Pred(LCursorPosition);
        except
          AEdit.CaretPosition := AEdit.Text.Length;
        end;
      end
      else
        AEdit.CaretPosition := AEdit.Text.Length;
    end);
  end).Start;
end;

class procedure TMyMask.LabelMaskAllPlatforms(const ALabel: TLabel; const AMask: String; const AAlphanumeric: Boolean = False);
begin
  TThread.Queue(nil,
  procedure
  begin
    ALabel.Text := Mask(AMask, RemoveMask(ALabel.Text, AAlphanumeric), AAlphanumeric);
  end);
end;

class procedure TMyMask.EditClipBoardKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  Svc: IFMXClipboardService;
begin
  if (key = vkC) and (Shift = [ssCtrl]) then
    if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    begin
      Svc.SetClipboard(TMyMask.RemoveMask(TEdit(Self).Text));
    end;

  if (key = vkV) and (Shift = [ssCtrl]) then
    if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    begin
      TEdit(Self).Text := Svc.GetClipboard.AsString;
      TMyMask.ApplyMask(TEdit(Self), TEdit(Self).Hint);
      TEdit(Self).GoToTextEnd;
    end;
end;

class procedure TMyMask.EditIntegerWindows(const AEdit: TEdit);
var
  LOldValue: String;
  LNewValue: String;
  LText: String;
  LValue: Integer;
begin
  TThread.Queue(nil,
  procedure
  begin
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    LText := AEdit.Text.Trim;
    Delete(LText, Pos(',', LText), LText.Length);
    LValue := StrToIntDef(TMyString.RemoveCharacters('.', LText.Trim), 0);
    AEdit.Text := LValue.ToString;
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        AEdit.GoToTextEnd;
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
        begin
          AEdit.GoToTextEnd;
          Exit;
        end;
        Exit;
      end;
    end;
    AEdit.GoToTextEnd;
  end);
end;

class procedure TMyMask.EditIntegerMobile(const AEdit: TEdit);
var
  LOldValue: String;
  LNewValue: String;
  LText: String;
  LValue: Integer;
begin
  TThread.Queue(nil,
  procedure
  begin
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    LText := AEdit.Text.Trim;
    Delete(LText, Pos(',', LText), LText.Length);
    LValue := StrToIntDef(TMyString.RemoveCharacters('.', LText.Trim), 0);
    AEdit.Text := LValue.ToString;
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        GoToTextEndThread(AEdit);
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
          GoToTextEndThread(AEdit);
        Exit;
      end;
    end;
    GoToTextEndThread(AEdit);
    Exit;
  end);
end;

class procedure TMyMask.LabelIntegerAllPlatforms(const ALabel: TLabel);
var
  LText: String;
  LValue: Integer;
begin
  TThread.Queue(nil,
  procedure
  begin
    LText := ALabel.Text.Trim;
    Delete(LText, Pos(',', LText), LText.Length);
    LValue := StrToIntDef(TMyString.RemoveCharacters('.', LText.Trim), 0);
    ALabel.Text := LValue.ToString;
  end);
end;

class procedure TMyMask.EditFloatWindows(const AEdit: TEdit; const ADecimal: Integer = 0);
var
  LDecimal: String;
  LDivider: Integer;
  LOldValue: String;
  LNewValue: String;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    AEdit.Text := FormatFloat(',0.'+ LDecimal, (StrToFloatDef(TMyString.OnlyNumber(AEdit.Text), 0) / LDivider));
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        AEdit.GoToTextEnd;
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
        begin
          AEdit.GoToTextEnd;
          Exit;
        end;
        Exit;
      end;
    end;
    AEdit.GoToTextEnd;
  end);
end;

class procedure TMyMask.EditFloatMobile(const AEdit: TEdit; const ADecimal: Integer);
var
  LDecimal: String;
  LDivider: Integer;
  LOldValue: String;
  LNewValue: String;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    AEdit.Text := FormatFloat(',0.'+ LDecimal, (StrToFloatDef(TMyString.OnlyNumber(AEdit.Text), 0) / LDivider));
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        GoToTextEndThread(AEdit);
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
          GoToTextEndThread(AEdit);
        Exit;
      end;
    end;
    GoToTextEndThread(AEdit);
    Exit;
  end);
end;

class procedure TMyMask.LabelFloatAllPlatforms(const ALabel: TLabel; const ADecimal: Integer = 0);
var
  LDecimal: String;
  LDivider: Integer;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    ALabel.Text := FormatFloat(',0.'+ LDecimal, (StrToFloatDef(TMyString.RemoveCharacters('.', ALabel.Text.Trim), 0)));
  end);
end;

class procedure TMyMask.GoToTextEndThread(const AEdit: TEdit);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    Sleep(1);
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      AEdit.GoToTextEnd;
    end)
  end).Start;
  Exit;
end;

class procedure TMyMask.EditCurrencyWindows(const AEdit: TEdit; const ACurrencySymbol: String; const ADecimal: Integer = 0);
var
  LDecimal: String;
  LDivider: Integer;
  LOldValue: String;
  LNewValue: String;
  LCurrencySymbol: String;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    if not ACurrencySymbol.IsEmpty then
      LCurrencySymbol := ACurrencySymbol + ' ';
    AEdit.Text := FormatFloat(LCurrencySymbol + ',0.'+ LDecimal, (StrToFloatDef(TMyString.OnlyNumber(AEdit.Text), 0) / LDivider));
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        AEdit.GoToTextEnd;
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
        begin
          AEdit.GoToTextEnd;
          Exit;
        end;
        Exit;
      end;
    end;
    AEdit.GoToTextEnd;
  end);
end;

class procedure TMyMask.EditCurrencyMobile(const AEdit: TEdit; const ACurrencySymbol: String; const ADecimal: Integer = 0);
var
  LDecimal: String;
  LDivider: Integer;
  LOldValue: String;
  LNewValue: String;
  LCurrencySymbol: String;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    LOldValue := TMyString.OnlyNumber(AEdit.Text);
    if not ACurrencySymbol.IsEmpty then
      LCurrencySymbol := ACurrencySymbol + ' ';
    AEdit.Text := FormatFloat(LCurrencySymbol + ',0.'+ LDecimal, (StrToFloatDef(TMyString.OnlyNumber(AEdit.Text), 0) / LDivider));
    LNewValue := TMyString.OnlyNumber(AEdit.Text);
    if MyKeyDown = vkBack then
    begin
      if AEdit.CaretPosition >= AEdit.Text.Length then
      begin
        GoToTextEndThread(AEdit);
        Exit;
      end
      else
      begin
        if LNewValue < LOldValue then
          GoToTextEndThread(AEdit);
        Exit;
      end;
    end;
    GoToTextEndThread(AEdit);
    Exit;
  end);
end;

class procedure TMyMask.LabelCurrencyAllPlatforms(const ALabel: TLabel; const ACurrencySymbol: String; const ADecimal: Integer = 0);
var
  LDecimal: String;
  LDivider: Integer;
  LCurrencySymbol: String;
begin
  TThread.Queue(nil,
  procedure
  begin
    LDecimal := LDecimal.PadLeft(ADecimal, '0');
    LDivider := StrToIntDef('1' + LDecimal, 0);
    if not ACurrencySymbol.IsEmpty then
      LCurrencySymbol := ACurrencySymbol + ' ';
    ALabel.Text := FormatFloat(LCurrencySymbol + ',0.'+ LDecimal,
                               StrToFloatDef(TMyString.RemoveCharacters(LCurrencySymbol, TMyString.RemoveCharacters('.', ALabel.Text.Trim)), 0));
  end);
end;

class procedure TMyMask.ApplyMask(const AControl: TStyledControl; const AMask: String; const AAlphanumeric: Boolean = False; const ARaiseExcept: Boolean = False);
var
  LClass: TClass;
  LOldHint: String;
  LOldKeyEvent: TKeyEvent;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
    Exit;
  end;

  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
    begin
      {$IFDEF MSWINDOWS}
        EditMaskWindows(TEdit(AControl), AMask, AAlphanumeric);
      {$ENDIF}
      {$IFDEF ANDROID}
        LOldHint := TEdit(AControl).Hint;
        LOldKeyEvent := TEdit(AControl).OnKeyDown;
        TEdit(AControl).Hint := AMask;
        TEdit(AControl).OnKeyDown := EditClipBoardKeyDown;
        EditMaskMobile(TEdit(AControl), AMask, AAlphanumeric);
        TEdit(AControl).Hint := LOldHint;
        TEdit(AControl).OnKeyDown := LOldKeyEvent;
      {$ENDIF}
      {$IFDEF IOS}
        LOldHint := TEdit(AControl).Hint;
        LOldKeyEvent := TEdit(AControl).OnKeyDown;
        TEdit(AControl).Hint := AMask;
        TEdit(AControl).OnKeyDown := EditClipBoardKeyDown;
        EditMaskMobile(TEdit(AControl), AMask, AAlphanumeric);
        TEdit(AControl).Hint := LOldHint;
        TEdit(AControl).OnKeyDown := LOldKeyEvent;
      {$ENDIF}
    end
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      LabelMaskAllPlatforms(TLabel(AControl), AMask, AAlphanumeric);
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class procedure TMyMask.ApplyInteger(const AControl: TStyledControl; const ARaiseExcept: Boolean);
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
    Exit;
  end;

  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
    begin
      {$IFDEF MSWINDOWS}
        EditIntegerWindows(TEdit(AControl));
      {$ENDIF}
      {$IFDEF ANDROID}
        EditIntegerMobile(TEdit(AControl));
      {$ENDIF}
      {$IFDEF IOS}
        EditIntegerMobile(TEdit(AControl));
      {$ENDIF}
    end
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      LabelIntegerAllPlatforms(TLabel(AControl));
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class procedure TMyMask.ApplyFloat(const AControl: TStyledControl; const ADecimal: Integer = 0; const ARaiseExcept: Boolean = False);
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
    Exit;
  end;

  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
    begin
      {$IFDEF MSWINDOWS}
        EditFloatWindows(TEdit(AControl), ADecimal);
      {$ENDIF}
      {$IFDEF ANDROID}
        EditFloatMobile(TEdit(AControl), ADecimal);
      {$ENDIF}
      {$IFDEF IOS}
        EditFloatMobile(TEdit(AControl), ADecimal);
      {$ENDIF}
    end
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      LabelFloatAllPlatforms(TLabel(AControl), ADecimal);
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class procedure TMyMask.ApplyCurrency(const AControl: TStyledControl; const ACurrencySymbol: String; const ADecimal: Integer = 0; const ARaiseExcept: Boolean = False);
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
    Exit;
  end;

  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
    begin
      {$IFDEF MSWINDOWS}
        EditCurrencyWindows(TEdit(AControl), ACurrencySymbol, ADecimal);
      {$ENDIF}
      {$IFDEF ANDROID}
        EditCurrencyMobile(TEdit(AControl), ACurrencySymbol, ADecimal);
      {$ENDIF}
      {$IFDEF IOS}
        EditCurrencyMobile(TEdit(AControl), ACurrencySymbol, ADecimal);
      {$ENDIF}
    end
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      LabelCurrencyAllPlatforms(TLabel(AControl), ACurrencySymbol, ADecimal);
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class function TMyMask.ControlToInteger(const AControl: TStyledControl; const ARaiseExcept: Boolean): Integer;
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
  end;

  Result := 0;
  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
      Result := StrToIntDef(TMyString.RemoveCharacters('.', TEdit(AControl).Text.Trim), 0)
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      Result := StrToIntDef(TMyString.RemoveCharacters('.', Copy(TLabel(AControl).Text.Trim, 1, Pred(Pos(',', TLabel(AControl).Text.Trim)))), 0);
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class function TMyMask.ControlToFloat(const AControl: TStyledControl; const ARaiseExcept: Boolean): Double;
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
  end;

  Result := 0;
  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
      Result := StrToFloatDef(TMyString.RemoveCharacters('.', TEdit(AControl).Text.Trim), 0)
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
      Result := StrToFloatDef(TMyString.RemoveCharacters('.', TLabel(AControl).Text.Trim), 0);
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class function TMyMask.ControlToCurrency(const AControl: TStyledControl; const ACurrencySymbol: String; const ARaiseExcept: Boolean = False): Currency;
var
  LClass: TClass;
  LText: String;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
  end;

  Result := 0;
  try
    if AnsiCompareText(LClass.ClassName.ToUpper, TEdit.ClassName.ToUpper) = 0 then
    begin
      LText := TEdit(AControl).Text.Trim;
      if not ACurrencySymbol.IsEmpty then
        Delete(LText, 1, ACurrencySymbol.Length + 1);
      Result := StrToCurrDef(TMyString.RemoveCharacters('.', LText), 0);
    end
    else if AnsiCompareText(LClass.ClassName.ToUpper, TLabel.ClassName.ToUpper) = 0 then
    begin
      LText := TLabel(AControl).Text.Trim;
      if not ACurrencySymbol.IsEmpty then
        Delete(LText, 1, ACurrencySymbol.Length + 1);
      Result := StrToCurrDef(TMyString.RemoveCharacters('.', LText), 0);
    end;
  except
    on E:Exception do
    begin
      if ARaiseExcept then
        raise Exception.Create('Internal error when applying the mask. ' + E.Message);
    end;
  end;
end;

class function TMyMask.RemoveMask(const AControl: TStyledControl; const AAlphanumeric: Boolean = False; const ARaiseExcept: Boolean = False): String;
var
  LClass: TClass;
begin
  LClass := AControl.ClassType;
  if (LClass <> TEdit) and (LClass <> TLabel) then
  begin
    if ARaiseExcept then
      raise Exception.Create('Unknown control. Enter a TEdit or TLabel.');
    Exit;
  end;

  if AControl is TEdit then
  begin
    Result := RemoveMask(TEdit(AControl).Text, AAlphanumeric);
    TEdit(AControl).Text := Result;
  end
  else if AControl is TLabel then
  begin
    Result := RemoveMask(TLabel(AControl).Text, AAlphanumeric);
    TLabel(AControl).Text := Result;
  end;
end;

class function TMyMask.RemoveMask(const AString: String; const AAlphanumeric: Boolean = False): String;
begin
  if AAlphanumeric then
    Result := TMyString.RemoveCharSpecial(AString)
  else
    Result := TMyString.OnlyNumber(AString);
end;

class procedure TMyMask.EditKeyDownNextFocus(const AControl: TCustomEdit; const ANextControl: TControl; AKey: Word);
begin
  {$IFDEF MSWINDOWS}
    if AKey in [vkReturn, vkTab] then
    begin
      AControl.KillFocusByReturn := False;
      ANextControl.SetFocus;
      TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(1);
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AControl.KillFocusByReturn := True;
        end)
      end).Start;
    end;
  {$ENDIF}
end;

end.
