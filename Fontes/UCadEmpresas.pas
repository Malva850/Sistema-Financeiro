unit UCadEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPadrao, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, UEmpresas;

type
  TfrmCadEmpresas = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    edtPesqCodigo: TEdit;
    edtPesqNome: TEdit;
    Label3: TLabel;
    edtCNPJ: TMaskEdit;
    DsDados: TDataSource;
    QDados: TFDQuery;
    QDadosCD_EMPRESA: TIntegerField;
    QDadosNM_EMPRESA: TStringField;
    QDadosNR_CPF_CNPJ: TStringField;
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    empresa : TEmpresas;
    procedure LimparCampos;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmCadEmpresas: TfrmCadEmpresas;

implementation

{$R *.dfm}

uses UDM;

procedure TfrmCadEmpresas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  FreeAndNil(Empresa);
end;

procedure TfrmCadEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  Empresa := TEmpresas.create;
end;

procedure TfrmCadEmpresas.TabSheet2Show(Sender: TObject);
begin
  inherited;
  //QDados.Refresh;
end;

procedure TfrmCadEmpresas.ToolButton1Click(Sender: TObject);
begin
  inherited;
    LimparCampos;
  edtPesqNome.SetFocus;
end;

procedure TfrmCadEmpresas.ToolButton2Click(Sender: TObject);
begin
  inherited;

   if Trim(edtPesqNome.Text) = '' then
  begin
    showMessage('Nome da empresa deve ser preenchido!');
    Exit;
  end;

  if Trim(edtCNPJ.Text) = '' then
  begin
    showMessage('CNPJ da empresa deve ser preenchido!');
    Exit;
  end;

  if edtPesqCodigo.Text = '' then
  begin
    empresa.CdEmpresa := 0;
    empresa.NmEmpresa := edtPesqNome.Text;
    empresa.Nr_CPF_CNPJ := edtCNPJ.Text;

    if empresa.Inserir('') = true then
    begin
      showMessage('Registro Salvo!');

      LimparCampos;
    end
    else
    begin
      showMessage('Erro ao salvar registro!');
    end;
  end
  else
  begin
    empresa.CdEmpresa := StrToInt(edtPesqCodigo.Text);
    empresa.NmEmpresa := edtPesqNome.Text;
    empresa.Nr_CPF_CNPJ := edtCNPJ.Text;

    if empresa.Alterar('') = true then
    begin
      showMessage('Registro alterado com sucesso!');

      LimparCampos;
    end
    else
    begin
      showMessage('Erro ao alterar registro!');
    end;
  end;
end;

procedure TfrmCadEmpresas.ToolButton3Click(Sender: TObject);
begin
  inherited;


   if Trim(edtPesqCodigo.Text) = '' then
  begin
    showMessage('Abra um registro para poder excluir!');
    Exit;
  end;

  if messageDlg('Deseja apagar o registro?', mtWarning, mbYesNo, 0) = mrYes then
  begin
    empresa.CdEmpresa := StrToInt(edtPesqCodigo.Text);
    empresa.NmEmpresa := '';
    empresa.Nr_CPF_CNPJ := '';

    if empresa.Apagar('') = true then
    begin
      showMessage('Registro apagado com sucesso!');
      LimparCampos;
    end
    else
    begin
      showMessage('Erro ao apagar registro!');
    end;
  end;
end;

procedure TfrmCadEmpresas.ToolButton4Click(Sender: TObject);
begin
  inherited;
  if empresa.Localizar(edtPesqCodigo.Text, edtPesqNome.Text, edtCNPJ.Text, QDados) = true then
  begin
    PageControl1.ActivePage := TabSheet2;
  end;
end;

procedure TfrmCadEmpresas.ToolButton6Click(Sender: TObject);
begin
  inherited;
  if Trim(edtPesqCodigo.Text) = '' then
  begin
    showMessage('Abra um registro para poder excluir!');
    Exit;
  end;

  if messageDlg('Deseja apagar o registro?', mtWarning, mbYesNo, 0) = mrYes then
  begin
    empresa.CdEmpresa := StrToInt(edtPesqCodigo.Text);
    empresa.NmEmpresa := '';
    empresa.Nr_CPF_CNPJ := '';

    if empresa.Apagar('') = true then
    begin
      showMessage('Registro apagado com sucesso!');
      LimparCampos;
    end
    else
    begin
      showMessage('Erro ao apagar registro!');
    end;
  end;
end;

procedure TfrmCadEmpresas.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage := TabSheet1;
  ToolButton1Click(Self);
  edtPesqCodigo.Text := QDadosCD_EMPRESA.AsString;
  edtPesqNome.Text := QDadosNM_EMPRESA.AsString;
  edtCNPJ.Text := QDadosNR_CPF_CNPJ.AsString;
end;

procedure TfrmCadEmpresas.LimparCampos;
begin
  edtPesqCodigo.Clear;
  edtPesqNome.Clear;
  edtCNPJ.Clear;
end;

procedure TfrmCadEmpresas.ToolButton7Click(Sender: TObject);
begin
  inherited;
  if empresa.Localizar(edtPesqCodigo.Text, edtPesqNome.Text, edtCNPJ.Text, QDados) = true then
  begin
    PageControl1.ActivePage := TabSheet2;
  end;
end;

end.
