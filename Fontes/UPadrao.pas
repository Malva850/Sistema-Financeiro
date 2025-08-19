unit UPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient;

type
  TfrmPadrao = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    QPesquisa: TFDQuery;
    DsPesquisa: TDataSource;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExibirMensagem(mensagem, titulo: string; erro: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.dfm}

uses UDM, UPrincipal, UCategorias;

procedure TfrmPadrao.BitBtn2Click(Sender: TObject);
begin
  if QPesquisa.IsEmpty then
  begin
    raise Exception.Create('Você não selecionou nenhum registro!');
  end;

  PageControl1.ActivePage := TabSheet1;


end;

procedure TfrmPadrao.ExibirMensagem(mensagem, titulo: string; erro: Boolean);
begin
if(erro) then
begin
Application.MessageBox(PChar(mensagem), PChar(titulo), MB_OK + MB_ICONERROR);
end
else
begin
Application.MessageBox(PChar(mensagem), PChar(titulo), MB_OK + MB_ICONINFORMATION);
end;
end;


procedure TfrmPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
end;

procedure TfrmPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
    Begin
      Key:= #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
end;

procedure TfrmPadrao.ToolButton4Click(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet2;
end;

end.
