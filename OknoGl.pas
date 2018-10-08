unit OknoGl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, jpeg, StdCtrls, Buttons, math, Mask, Spin,
  DBCtrls, DB, Grids, DBGrids, ADODB, TeEngine, Series, TeeProcs, Chart,ShellAPI,
  VclTee.TeeGDIPlus, Vcl.Imaging.pngimage;

type
  TAOknoGl = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Bevel2: TBevel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    ADOConnection1: TADOConnection;
    TabSheet2: TTabSheet;
    ADODataSet1: TADODataSet;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Label12: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    SpeedButton2: TSpeedButton;
    TabSheet3: TTabSheet;
    Chart1: TChart;
    Series1: TAreaSeries;
    Label13: TLabel;
    Label14: TLabel;
    Edit5: TEdit;
    SpinEdit2: TSpinEdit;
    Label15: TLabel;
    SpeedButton3: TSpeedButton;
    Label16: TLabel;
    SpeedButton4: TSpeedButton;
    TabSheet4: TTabSheet;
    Image2: TImage;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure ShellOpen(const Url: string; const Params: string = '');
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AOknoGl: TAOknoGl;

implementation

{$R *.dfm}

procedure TAOknoGl.FormCreate(Sender: TObject);
begin
ADOConnection1.Close;
ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(Application.ExeName)+'BazaIzotopow.mdb;Persist Security Info=False;';
ADOConnection1.Connected:=True;
ADODataSet1.Open;
TabSheet3.TabVisible:=False;
end;

procedure TAOknoGl.Label23Click(Sender: TObject);
begin
ShellOpen(Label23.Caption);
end;

procedure TAOknoGl.SpeedButton1Click(Sender: TObject);
Var
 ap, tm, td, ak : Real;
 dokl : Integer;
 pom : String;
begin
if (Edit1.Text<>'') and (Edit2.Text<>'') and (Edit3.Text<>'') then
Begin
 pom:=Edit1.Text;
if Pos('.',pom)>0 then
 Begin
  pom:=StringReplace(pom,'.',',',[rfReplaceAll, rfIgnoreCase]);
  Edit1.Text:=pom;
 End;
 pom:=Edit2.Text;
if Pos('.',pom)>0 then
 Begin
  pom:=StringReplace(pom,'.',',',[rfReplaceAll, rfIgnoreCase]);
  Edit2.Text:=pom;
 End;
pom:=Edit3.Text;
if Pos('.',pom)>0 then
 Begin
  pom:=StringReplace(pom,'.',',',[rfReplaceAll, rfIgnoreCase]);
  Edit3.Text:=pom;
 End;

 dokl:=SpinEdit1.Value;
 ap:=StrToFloat(Edit1.Text);
 tm:=StrToFloat(Edit2.Text);
 td:=StrToFloat(Edit3.Text);

 if td<>0 then
 Begin
 if CheckBox1.Checked=True then ak:=ap*(exp((-0.693*tm)/td))
 else ak:=(ap)/(power(2,tm/td));
 End
 else ak:=0;

 Edit4.Text:=FloatToStr(RoundTo(ak,-dokl));
End;
end;

procedure TAOknoGl.SpeedButton2Click(Sender: TObject);
Var
 aktywnosc, okres : String;
begin
 aktywnosc:=ADODataSet1.FieldByName('Aktywnosc').AsString;
 okres:=ADODataSet1.FieldByName('Polrozpad').AsString;
 Edit1.Text:=aktywnosc;
 Edit3.Text:=okres;
 Edit4.Text:='';

 Label13.Visible:=True;
 Label14.Visible:=True;
 Label15.Visible:=True;
 Label16.Visible:=True;
 SpeedButton3.Visible:=True;
 Edit5.Visible:=True;
 SpinEdit2.Visible:=True;
end;

procedure TAOknoGl.SpeedButton3Click(Sender: TObject);
Var
 i, ile : Integer;
 ap, tm, td, ak, skok : Real;
begin
Chart1.Series[0].Clear;
Edit2.Text:='0';
ile:=SpinEdit2.Value;
skok:=StrToFloat(Edit5.Text);

for i := 1 to ile do
 Begin
  ap:=StrToFloat(Edit1.Text);
  tm:=StrToFloat(Edit2.Text);
  td:=StrToFloat(Edit3.Text);

 if CheckBox1.Checked=True then ak:=ap*(exp((-0.693*tm)/td))
 else ak:=(ap)/(power(2,tm/td));
 tm:=tm+skok;
 if ak<0 then ak:=0;
 Edit2.Text:=FloatToSTr(tm);
  Chart1.Series[0].Add(ak,'+'+IntToStr(i),536870912);
 End;
Chart1.Series[0].Add(0,'+...',536870912);
TabSheet3.TabVisible:=True;
TabSheet3.Show;
end;

procedure TAOknoGl.SpeedButton4Click(Sender: TObject);
Var
 nap, wartS : String;
 wart : Real;
 dokl : Integer;
begin
  wartS := Edit1.Text;
  if wartS <> '' then
  Begin
    wart:=StrToFloat(wartS);
    dokl := SpinEdit1.Value;
    if Label10.Caption = 'MBq' then
      nap := 'GBq';
    if Label10.Caption = 'GBq' then
      nap := 'Bq';
    if Label10.Caption = 'Bq' then
      nap := 'KBq';
    if Label10.Caption = 'KBq' then
      nap := 'MBq';

    Label10.Caption := nap;
    Label11.Caption := nap;

    if nap = 'MBq' then
      wart := wart / 1000;
    if nap = 'GBq' then
      wart := wart / 1000;
    if nap = 'KBq' then
      wart := wart / 1000;
    if nap = 'Bq' then
      wart := wart * 1000 * 1000 * 1000;

    Edit1.Text := FloatToStr(RoundTo(wart, -dokl));
    if Edit4.Text <> '' then
      SpeedButton1Click(Self);
  End;
end;

procedure TAOknoGl.ShellOpen(const Url: string; const Params: string = '');
begin
  ShellAPI.ShellExecute(0, 'Open', PChar(Url), PChar(Params), nil, SW_SHOWNORMAL);
end;

end.
