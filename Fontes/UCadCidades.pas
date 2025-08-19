unit UCadCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Buttons, Vcl.DBCtrls;

type
  TfrmCadCidades = class(TfrmPadrao)
    edtUF: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNome: TEdit;
    edtCodigo: TEdit;
    edtUfPesq: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edtNomePesq: TEdit;
    edtCodigoPesq: TEdit;
    QPesquisaCD_CIDADE: TIntegerField;
    QPesquisaNM_CIDADE: TStringField;
    QPesquisaUF: TStringField;
    QCidades: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    DSCidades: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCidades: TfrmCadCidades;

implementation

{$R *.dfm}

uses UCidades;

procedure TfrmCadCidades.BitBtn1Click(Sender: TObject);
var
  objeto : TCidades;
  
begin
  inherited;               
  objeto := TCidades.create; 
  objeto.Localizar(edtCodigoPesq.Text, edtNomePesq.Text, edtUfPesq.Text, QPesquisa);   
  objeto.Free;     
end;

procedure TfrmCadCidades.BitBtn2Click(Sender: TObject);
begin
  inherited;
     edtCodigo.Text :=   QPesquisaCD_CIDADE.AsString;  //QPesquisa.FieldByName('CD_CIDADE').AsString;
  edtNome.Text   :=  QPesquisa.FieldByName('NM_CIDADE').AsString;
  edtUF.Text    :=  QPesquisa.FieldByName('UF').AsString;
end;

procedure TfrmCadCidades.BitBtn3Click(Sender: TObject);
begin
  inherited;
  ShowMessage(inttostr( DBLookupComboBox1.KeyValue ));
end;

procedure TfrmCadCidades.BitBtn4Click(Sender: TObject);
begin
  inherited;
  DBLookupComboBox1.KeyValue := 3;
end;

procedure TfrmCadCidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QCidades.Close;
end;

procedure TfrmCadCidades.FormCreate(Sender: TObject);
begin
  inherited;
  QCidades.Open();
end;

procedure TfrmCadCidades.ToolButton1Click(Sender: TObject);
begin
  inherited;
  edtCodigo.Clear;
  edtNome.Clear;
  edtUF.Clear;
  edtNome.SetFocus;
end;

procedure TfrmCadCidades.ToolButton2Click(Sender: TObject);
var
  objeto : TCidades;

  vCodigo : integer;
  vMensagem : string ;
begin    
  inherited;
  objeto := TCidades.create;

  objeto.NmCidade := edtNome.Text;
  objeto.UF       := edtUF.Text ;

  if trim(edtCodigo.Text) = '' then
  begin

    if objeto.Inserir(vCodigo, vMensagem) = true then
    begin
      edtCodigo.Text := inttostr(vCodigo);

      Application.MessageBox(Pchar(vMensagem) , 'Aviso', MB_ICONINFORMATION + MB_OK);
    end
    else
    begin
      Application.MessageBox(Pchar('ERRO AO INSERIR REGISTRO!!'+#10+
                            'Motivo: '+vMensagem) , 'Aviso', MB_ICONERROR + MB_OK);
    end;
  end
  else
  begin
    objeto.CdCidade := StrToInt(edtCodigo.Text);

    if objeto.Alterar(vMensagem) = true then
    begin
      Application.MessageBox(Pchar(vMensagem) , 'Aviso', MB_ICONINFORMATION + MB_OK);
    end
    else
    begin
      Application.MessageBox(Pchar('ERRO AO ALTERAR REGISTRO!!'+#10+
                            'Motivo: '+vMensagem) , 'Aviso', MB_ICONERROR + MB_OK);
    end;

  end;

  objeto.Free;

  QPesquisa.Close;

end;

procedure TfrmCadCidades.ToolButton3Click(Sender: TObject);
var
  objeto : TCidades;
  vMensagem : string ;
begin
  inherited;

  if Trim(edtCodigo.Text) = '' then
  begin
    Application.MessageBox(Pchar('Localize uma cidade!') , 'Aviso', MB_ICONINFORMATION + MB_OK);
    exit;
  end ;

  if  Application.MessageBox('Deseja exclu�r?' , 'Aviso', MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    objeto := TCidades.create;

    objeto.CdCidade := StrToInt(edtCodigo.Text);

    if objeto.Apagar(vMensagem) then
    begin
       ToolButton1.OnClick(self);          
       Application.MessageBox(Pchar(vMensagem) , 'Aviso', MB_ICONINFORMATION + MB_OK);
    end
    else
    begin
       Application.MessageBox(Pchar('ERRO AO APAGAR REGISTRO!!'+#10+
                              'Motivo: '+vMensagem) , 'Aviso', MB_ICONERROR + MB_OK);

    end;
  end;

   objeto.Free;

   QPesquisa.Close;
   

end;

end.
