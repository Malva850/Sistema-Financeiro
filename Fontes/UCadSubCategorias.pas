unit UCadSubCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPadrao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, Vcl.DBCtrls;

type
  TfrmCadSubCategorias = class(TfrmPadrao)
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    lblCategoria: TLabel;
    DBLookupCBCategoria: TDBLookupComboBox;
    QCBCategoria: TFDQuery;
    DsCatogoria: TDataSource;
    QCBCategoriaCD_CATEGORIA: TIntegerField;
    QCBCategoriaNM_CATEGORIA: TStringField;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    QPesquisaCD_SUBCATEGORIA: TIntegerField;
    QPesquisaCD_CATEGORIA: TIntegerField;
    QPesquisaNM_SUBCATEGORIA: TStringField;
    QPesquisaCD_CATEGORIA_1: TIntegerField;
    QPesquisaNM_CATEGORIA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadSubCategorias: TfrmCadSubCategorias;

implementation

{$R *.dfm}

uses UDM, USubCategorias;

procedure TfrmCadSubCategorias.BitBtn1Click(Sender: TObject);
var
  subcategoria: TSubCategorias;
begin
  inherited;
  subcategoria := TSubCategorias.create;
  subcategoria.Localizar(edtPesquisa.Text, QPesquisa);

  subcategoria.Free();
end;

procedure TfrmCadSubCategorias.BitBtn2Click(Sender: TObject);
begin
  if (QPesquisa.IsEmpty) then
  begin
    Application.MessageBox('Nenhum registro selecionado!', 'Errouuu',
      MB_OK + MB_ICONERROR);

    Abort;
  end;
  inherited;
  edtCodigo.Text := QPesquisa.FieldByName('CD_SUBCATEGORIA').AsString;
  edtNome.Text := QPesquisa.FieldByName('NM_SUBCATEGORIA').AsString;
  DBLookupCBCategoria.KeyValue := QPesquisa.FieldByName('CD_CATEGORIA')
    .AsInteger;
end;

procedure TfrmCadSubCategorias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  QCBCategoria.Close;
end;

procedure TfrmCadSubCategorias.FormCreate(Sender: TObject);
begin
  inherited;
  QCBCategoria.Open();
end;

procedure TfrmCadSubCategorias.ToolButton1Click(Sender: TObject);
begin
  inherited;
  edtCodigo.Clear;
  edtNome.Clear;
  DBLookupCBCategoria.KeyValue := Null;
end;

procedure TfrmCadSubCategorias.ToolButton2Click(Sender: TObject);
var
  subcategoria: TSubCategorias;
  codigo: Integer;
  mensagem: string;
begin
  inherited;
  subcategoria := TSubCategorias.create;
  subcategoria.NmSubCategoria := edtNome.Text;
  subcategoria.CdCategoria := DBLookupCBCategoria.KeyValue;

  if edtCodigo.Text = '' then
  begin
    if subcategoria.Inserir(codigo, mensagem) = True then
    begin
      edtCodigo.Text := IntToStr(codigo);
      Application.MessageBox('Inserido com sucesso', 'Mensagem',
        MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      Application.MessageBox(pchar(mensagem), 'Errouuu', MB_OK + MB_ICONERROR);
    end;
  end
  else
  begin
    subcategoria.CdSubCategoria := StrToInt(edtCodigo.Text);
    if subcategoria.Alterar(mensagem) = True then
    begin
      Application.MessageBox('Alterado com sucesso', 'Mensagem',
        MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      Application.MessageBox(pchar(mensagem), 'Errouuu', MB_OK + MB_ICONERROR);
    end;
  end;

  subcategoria.Free;
  QPesquisa.Close;

end;

procedure TfrmCadSubCategorias.ToolButton3Click(Sender: TObject);
var
  subcategoria: TSubCategorias;
  mensagem: string;
begin
  inherited;
  subcategoria := TSubCategorias.create();
  subcategoria.CdSubCategoria := StrToInt(edtCodigo.Text);

  if (Application.MessageBox('Deseja apagar o registro?', 'Questionamento',
    MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    if (subcategoria.Apagar(mensagem) = True) then
    begin
      Application.MessageBox('Apagado com sucesso', 'Mensagem',
        MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      Application.MessageBox(pchar(mensagem), 'Errouuu', MB_OK + MB_ICONERROR);
    end;

    subcategoria.Free;
    QPesquisa.Close;

    edtCodigo.Clear;
    edtNome.Clear;
    DBLookupCBCategoria.KeyValue := Null;
  end;
end;

end.
