unit UProcAberturasCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Mask, Vcl.Menus;

type
  TfrmProcAberturasCaixas = class(TForm)
    BitBtn1: TBitBtn;
    DbLookCaixas: TDBLookupComboBox;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    QCaixas: TFDQuery;
    dsCaixas: TDataSource;
    QCaixasCD_CAIXA: TIntegerField;
    QCaixasNM_CAIXA: TStringField;
    Panel1: TPanel;
    edtIdUsuario: TEdit;
    edtAbertura: TMaskEdit;
    Label9: TLabel;
    edtHora: TMaskEdit;
    Label2: TLabel;
    dsAberturas: TDataSource;
    QAberturas: TFDQuery;
    QAberturasCD_ABERTURA_CAIXA: TIntegerField;
    QAberturasCD_CAIXA: TIntegerField;
    QAberturasDT_ABERTURA: TDateField;
    QAberturasHR_ABERTURA: TStringField;
    QAberturasDT_FECHAMENTO: TDateField;
    QAberturasHR_FECHAMENTO: TStringField;
    QAberturasCD_USUARIO: TIntegerField;
    QAberturasNM_CAIXA: TStringField;
    PopupMenu1: TPopupMenu;
    FecharCaixa1: TMenuItem;
    N1: TMenuItem;
    ApagarRegistro1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtAberturaExit(Sender: TObject);
    procedure edtHoraExit(Sender: TObject);
    procedure FecharCaixa1Click(Sender: TObject);
    procedure ApagarRegistro1Click(Sender: TObject);
  private
    procedure MostraAberturas;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcAberturasCaixas: TfrmProcAberturasCaixas;

implementation

{$R *.dfm}

uses UCaixas, UDM, UAberturasCaixas;


procedure  TfrmProcAberturasCaixas.MostraAberturas;
var
  Abcaixa : TAberturasCaixas;
begin
   Abcaixa := TAberturasCaixas.create;
   Abcaixa.MostrarAberturasCaixa(edtIdUsuario.Text, QAberturas);
   Abcaixa.Free;
end;

procedure TfrmProcAberturasCaixas.ApagarRegistro1Click(Sender: TObject);
var
  Abcaixa : TAberturasCaixas;
  mensagem : string;
begin
  if messageDlg('Deseja apagar o registro?', mtWarning, mbYesNo, 0) = mrYes then
  begin

    Abcaixa := TAberturasCaixas.create;
    Abcaixa.CdAberturaCaixa := QAberturasCD_ABERTURA_CAIXA.AsInteger;
    Abcaixa.Deletar(mensagem);
    Abcaixa.Free;

    MostraAberturas;
    ShowMessage(mensagem);


  end;
end;

procedure TfrmProcAberturasCaixas.BitBtn1Click(Sender: TObject);
var
  Abcaixa : TAberturasCaixas;
   retorno : string;
   vcodigo : integer;
begin

  try
    StrToDate(edtAbertura.Text);
  except
     raise Exception.Create('Data inválida!');
  end;

  try
    StrToTime(edtHora.Text);
  except
     raise Exception.Create('Hora inválida!');
  end;


  if DbLookCaixas.KeyValue=null then
  begin
    raise Exception.Create('Selecione um caixa!');
  end;


  Abcaixa := TAberturasCaixas.create;


  if (Abcaixa.CaixaAberto(strtoint(edtIdUsuario.Text), DbLookCaixas.KeyValue, StrToDate(edtAbertura.Text) ) ) = true then
  begin
    Abcaixa.Free;
    raise Exception.Create('O caixa '+ DbLookCaixas.text +' já esta aberto para o usuário '+edtIdUsuario.Text+
                           ' na data '+edtAbertura.Text+'.');
  end;

  Abcaixa.CdCaixa := DbLookCaixas.KeyValue;
  Abcaixa.CdUsuario := strtoint(edtIdUsuario.Text);
  Abcaixa.DtAbertura := StrToDate(edtAbertura.Text);
  Abcaixa.HrAbertura := edtHora.Text;
  Abcaixa.Inserir(vcodigo, retorno);
  Abcaixa.Free;
  MostraAberturas;

end;

procedure TfrmProcAberturasCaixas.FecharCaixa1Click(Sender: TObject);
var
  ab : TAberturasCaixas;
begin

  if not QAberturasDT_FECHAMENTO.IsNull then
  begin
    raise Exception.Create('Caixa já fechado!');
  end;


  ab := TAberturasCaixas.Create;
  if  ab.FecharCaixa(QAberturasCD_ABERTURA_CAIXA.AsInteger) then
  begin
    MostraAberturas;
    ShowMessage('Caixa fechado com sucesso!');
  end;

  ab.Free ;

end;

procedure TfrmProcAberturasCaixas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmProcAberturasCaixas.FormCreate(Sender: TObject);
var
  caixa : TCaixas;
begin
  edtAbertura.Text := DateToStr(now);
  edtHora.Text := FormatDateTime('HH:NN',Now);

  Panel1.Caption := 'Login: '+ UsuarioLogado;

  edtIdUsuario.Text := IntToStr(IdUsuarioLogado);


  caixa := TCaixas.create;
  caixa.RetornaCaixasUsuarios(IdUsuarioLogado, QCaixas);
  caixa.Free;

  MostraAberturas;

end;

procedure TfrmProcAberturasCaixas.edtHoraExit(Sender: TObject);
begin
  try
     StrToTime(edtHora.Text);
  except
    ShowMessage('Horá inválida!');
  end;


end;

procedure TfrmProcAberturasCaixas.edtAberturaExit(Sender: TObject);
begin
  try
    StrToDate(edtAbertura.Text);
  except
    ShowMessage('Data inválida!');
  end;
end;

end.
