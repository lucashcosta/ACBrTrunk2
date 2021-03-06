{******************************************************************************}
{ Projeto: Componente ACBreSocial                                              }
{  Biblioteca multiplataforma de componentes Delphi para envio dos eventos do  }
{ eSocial - http://www.esocial.gov.br/                                         }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 27/10/2015: Jean Carlo Cantu, Tiago Ravache
|*  - Doa��o do componente para o Projeto ACBr
|* 01/03/2016: Guilherme Costa
|*  - Altera��es para valida��o com o XSD
******************************************************************************}
{$I ACBr.inc}

unit eSocial_S1210;

interface

uses
  SysUtils, Classes,
  eSocial_Common, eSocial_Conversao,
  pcnConversao,
  ACBreSocialGerador, Controls;

type

  TPgtoExt = class;
  TIdeBenef = class;
  TInfoPgtoCollection = class;
  TInfoPgtoItem = class;
  TdetPgtoFlCollection = class;
  TdetPgtoFlItem = class;
  TEvtPgtos = class;
  TS1210CollectionItem = class;
  TS1210Collection = class;
  TDeps = class;
  TDetPgtoBenPr = class;
  TDetPgtoFerCollection = class;
  TDetPgtoFerItem = class;
  TRubricasComPensaoCollection = class;
  TRubricasComPensaoItem = class;
  TDetPgtoAntCollection = class;
  TDetPgtoAntItem = class;
  TInfoPgtoAntCollection = class;
  TInfoPgtoAntItem = class;

  TS1210Collection = class(TOwnedCollection)
    private
      function GetItem(Index: Integer): TS1210CollectionItem;
      procedure SetItem(Index: Integer; Value: TS1210CollectionItem);
    public
      function Add: TS1210CollectionItem;
      property Items[Index: Integer]: TS1210CollectionItem read GetItem write SetItem; default;
  end;

  TS1210CollectionItem = class(TCollectionItem)
    private
      FTipoEvento: TTipoEvento;
      FEvtPgtos: TEvtPgtos;
      procedure setEvtPgtos(const Value: TEvtPgtos);
    public
      constructor Create(AOwner: TComponent); reintroduce;
      destructor Destroy; override;
    published
      property TipoEvento: TTipoEvento read FTipoEvento;
      property evtPgtos: TEvtPgtos read FEvtPgtos write setEvtPgtos;
  end;

  TEvtPgtos = class(TeSocialEvento)
    private
      FIdeEvento : TIdeEvento3;
      FIdeEmpregador : TIdeEmpregador;
      FIdeBenef : TIdeBenef;

      {Geradores da classe}
      procedure GerarIdeBenef(objIdeBenef: TIdeBenef);
      procedure GerarInfoPgto(objInfoPgto: TInfoPgtoCollection; i : Integer);
      procedure GerardetPgtoFl(objdetPgtofl: TdetPgtoFlCollection);
      procedure GerarRubricasComPensao(pRubricasComPensao: TRubricasComPensaoCollection; const GroupName: String = 'retPgtoTot');
      procedure GerarDetPgtoBenPr(pDetPgtoBenPr: TDetPgtoBenPr);
      procedure GerarDetPgtoFer(pDetPgtoFer: TDetPgtoFerCollection);
      procedure GeraridePgtoExt(objPgtoExt: TPgtoExt);
      procedure GerarDeps(pDeps: TDeps);
      procedure GerarCamposRubricas(pRubrica: TRubricaCollectionItem);
      procedure GerarDetPgtoAnt(pDetPgtoAnt: TDetPgtoAntCollection);
      procedure GerarInfoPgtoAnt(pInfoPgtoAnt: TInfoPgtoAntCollection);
    public
      constructor Create(AACBreSocial: TObject);overload;
      destructor Destroy; override;

      function GerarXML: Boolean; override;

      property IdeEvento : TIdeEvento3 read FIdeEvento write FIdeEvento;
      property IdeEmpregador : TIdeEmpregador read FIdeEmpregador write FIdeEmpregador;
      property IdeBenef : TIdeBenef read FIdeBenef write FIdeBenef;
  end;

  TIdeBenef = class(TPersistent)
  private
    FCpfBenef : String;
    FDeps: TDeps;
    FInfoPgto : TInfoPgtoCollection;
    function getDeps: TDeps;
    function getInfoPgto : TInfoPgtoCollection;
  public
    constructor Create;
    destructor  Destroy; override;
    function depsInst: boolean;

    property CpfBenef : String read FCpfBenef write FCpfBenef;
    property deps: TDeps read getDeps write FDeps;
    property InfoPgto : TInfoPgtoCollection read getInfoPgto write FInfoPgto;
  end;

  TDeps = class(TPersistent)
  private
    FVrDedDep: Double;
  public
    property vrDedDep: Double read FVrDedDep write FVrDedDep;
  end;

  TInfoPgtoCollection = class(TCollection)
    private
    function GetItem(Index: Integer): TInfoPgtoItem;
    procedure SetItem(Index: Integer; const Value: TInfoPgtoItem);
  public
    constructor Create; reintroduce;
    function Add: TInfoPgtoItem;
    property Items[Index: Integer]: TInfoPgtoItem read GetItem write SetItem;
  end;

  TInfoPgtoItem = class(TCollectionItem)
  private
    FDtPgto      : TDate;
    FTpPgto      : tpTpPgto;
    FIndResBr    : tpSimNao;
    FdetPgtoFl   : TdetPgtoFlCollection;
    FdetPgtoBenPr: TdetPgtoBenPr;
    FDetPgtoFer  : TDetPgtoFerCollection;
    FDetPgtoAnt  : TDetPgtoAntCollection;
    FIdePgtoExt  : TPgtoExt;
    function GetdetPgtoFl : TdetPgtoFlCollection;
    function GetPgtoExt : TPgtoExt;
    function getDetPgtoBenPr: TdetPgtoBenPr;
    function getDetPgtoFer: TDetPgtoFerCollection;
    function getDetPgtoAnt: TDetPgtoAntCollection;
  public
    constructor Create;
    destructor  Destroy;

    function detPgtoFlInst(): Boolean;
    function detidePgtoExtInst(): Boolean;
    function detPgtoBenPrInst(): Boolean;
    function detPgtoFerInst(): Boolean;
    function detPgtoAntInst(): Boolean;

    property DtPgto : TDate read FDtPgto write FDtPgto;
    property IndResBr : TpSimNao read FIndResBr write FIndResBr;
    property TpPgto : tpTpPgto read FTpPgto write FTpPgto;
    property detPgtoFl: TdetPgtoFlCollection read GetdetPgtoFl write FdetPgtoFl;
    property detPgtoBenPr: TdetPgtoBenPr read getDetPgtoBenPr write FdetPgtoBenPr;
    property detPgtoFer: TDetPgtoFerCollection read getDetPgtoFer write FDetPgtoFer;
    property detPgtoAnt: TDetPgtoAntCollection read getDetPgtoAnt write FDetPgtoAnt;
    property IdePgtoExt : TPgtoExt read GetPgtoExt write FIdePgtoExt;
  end;

  TDetPgtoBenPr = class(TPersistent)
  private
    FPerRef: String;
    FIdeDmDev: string;
    FIndPgtoTt: tpSimNao;
    FVrLiq: Double;
    FRetPgtoTot: TRubricaCollection;
    FInfoPgtoParc: TRubricaCollection;
    function getRetPgtoTot: TRubricaCollection;
    function getInfoPgtoParc: TRubricaCollection;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function retPgtoTotInst: boolean;
    function infoPgtoParcInst: boolean;

    property perRef: string read FPerRef write FPerRef;
    property ideDmDev: string read FIdeDmDev write FIdeDmDev;
    property indPgtoTt: tpSimNao read FIndPgtoTt write FIndPgtoTt;
    property vrLiq: Double read FVrLiq write FVrLiq;
    property retPgtoTot: TRubricaCollection read getRetPgtoTot write FRetPgtoTot;
    property infoPgtoParc: TRubricaCollection read getInfoPgtoParc write FInfoPgtoParc;
  end;

  TRubricasComPensaoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRubricasComPensaoItem;
    procedure SetItem(Index: Integer; const Value: TRubricasComPensaoItem);
  public
    constructor Create; reintroduce;
    function Add: TRubricasComPensaoItem;
    property Items[Index: integer]: TRubricasComPensaoItem read GetItem write SetItem;
      default;
  end;

  TRubricasComPensaoItem = class(TRubricaCollectionItem)
  private
    FPenAlim: TPensaoAlimCollection;
    function getPensaoAlim: TPensaoAlimCollection;
  public
    constructor Create;
    destructor  Destroy;
    function pensaoAlimInst: boolean;
    property penAlim: TPensaoAlimCollection read getPEnsaoAlim write FPenAlim;
  end;

  TdetPgtoFlCollection = class(TCollection)
  private
    function GetITem(Index: Integer): TdetPgtoFlItem;
    procedure SetItem(Index: Integer; const Value: TdetPgtoFlItem);
  public
    constructor Create; reintroduce;
    function Add: TdetPgtoFlItem;
    property Items[Index: Integer]: TdetPgtoFlItem read GetItem write SetItem;
  end;

  TdetPgtoFlItem = class(TCollectionItem)
  private
    FperRef : String;
    FIdeDmDev: string;
    FIndPagtoTt: tpSimNao;
    FVrLiq: Double;
    FNrRecArq: string;
    FRetPagtoTot: TRubricasComPensaoCollection;
    FInfoPgtoParc: TRubricaCollection;

    function getRetPagtoTot: TRubricasComPensaoCollection;
    function getInfoPgtoParc: TRubricaCollection;
  public
    constructor Create;
    destructor  Destroy;
    function retPagtoToInst: boolean;
    function infoPgtoFlInst: boolean;

    property perRef : String read FperRef write FperRef;
    property ideDmDev: string read FIdeDmDev write FIdeDmDev;
    property indPagtoTt: tpSimNao read FIndPagtoTt write FIndPagtoTt;
    property vrLiq: Double read FVrLiq write FVrLiq;
    property nrRecArq: string read FNrRecArq write FNrRecArq;
    property retPagtoTot: TRubricasComPensaoCollection read getRetPagtoTot write FRetPagtoTot;
    property infoPgtoParc: TRubricaCollection read getInfoPgtoParc write FInfoPgtoParc;
  end;

  TPgtoExt = class(TPersistent)
    private
      FidePais : TIdePais;
      FEndExt : TEndExt;
    public
      constructor create;
      destructor  Destroy; override;

      property idePais: TIdePais read FIdePais write FIdePais;
      property endExt: TEndExt read FEndExt write FEndExt;
  end;

  TDetPgtoFerCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TDetPgtoFerItem;
    procedure SetItem(Index: Integer; const Value: TDetPgtoFerItem);
  public
    constructor Create; reintroduce;
    function Add: TDetPgtoFerItem;
    property Items[Index: Integer]: TDetPgtoFerItem read GetItem write SetITem;
      default;
  end;

  TDetPgtoFerItem = class(TCollectionItem)
  private
    FCodCateg: integer;
    FDtIniGoz: TDate;
    FQtDias: Integer;
    FVrLiq: Double;
    FDetRubrFer: TRubricasComPensaoCollection;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    property codCateg: integer read FCodCateg write FCodCateg;
    property dtIniGoz: TDate read FDtIniGoz write FDtIniGoz;
    property qtDias: integer read FQtDias write FQtDias;
    property vrLiq: Double read FVrLiq write FVrLiq;
    property detRubrFer: TRubricasComPensaoCollection read FDetRubrFer write FDetRubrFer;
  end;

  TDetPgtoAntCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TDetPgtoAntItem;
    procedure SetItem(Index: Integer; const Value: TDetPgtoAntItem);
  public
    constructor Create; reintroduce;
    function Add: TDetPgtoAntItem;
    property Items[Index: Integer]: TDetPgtoAntItem read GetItem write SetITem;
      default;
  end;

  TDetPgtoAntItem = class(TCollectionItem)
  private
    FCodCateg: Integer;
    FInfoPgtoAnt: TInfoPgtoAntCollection;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    property codCateg: Integer read FCodCateg write FCodCateg;
    property infoPgtoAnt: TInfoPgtoAntCollection read FInfoPgtoAnt write FInfoPgtoAnt;
  end;

  TInfoPgtoAntCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfoPgtoAntItem;
    procedure SetItem(Index: Integer; const Value: TInfoPgtoAntItem);
  public
    constructor Create; reintroduce;
    function Add: TInfoPgtoAntItem;
    property Items[Index: Integer]: TInfoPgtoAntItem read GetItem write SetITem;
      default;
  end;

  TInfoPgtoAntItem = class(TCollectionItem)
  private
    FTpBcIRRF: tpCodIncIRRF;
    FVrBcIRRF: Double;
  public
    property tpBcIRRF: tpCodIncIRRF read FTpBcIRRF write FTpBcIRRF;
    property vrBcIRRF: Double read FVrBcIRRF write FVrBcIRRF;
  end;

implementation

uses
  eSocial_Periodicos;

{ TS1210Collection }

function TS1210Collection.Add: TS1210CollectionItem;
begin
  Result := TS1210CollectionItem(inherited Add);
  Result.Create(TComponent(Self.Owner));
end;

function TS1210Collection.GetItem(Index: Integer): TS1210CollectionItem;
begin
  Result := TS1210CollectionItem(inherited GetItem(Index));
end;

procedure TS1210Collection.SetItem(Index: Integer; Value: TS1210CollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TS1210CollectionItem }

constructor TS1210CollectionItem.Create(AOwner: TComponent);
begin
  FTipoEvento := teS1210;
  FEvtPgtos   := TEvtPgtos.Create(AOwner);
end;

destructor TS1210CollectionItem.Destroy;
begin
  FEvtPgtos.Free;
  inherited;
end;

procedure TS1210CollectionItem.setEvtPgtos(const Value: TEvtPgtos);
begin
  FEvtPgtos.Assign(Value);
end;

{ TEvtPgtos }

constructor TEvtPgtos.Create(AACBreSocial: TObject);
begin
  inherited;
  FIdeEvento := TIdeEvento3.Create;
  FIdeEmpregador := TIdeEmpregador.Create;
  FIdeBenef := TIdeBenef.Create;
end;

destructor TEvtPgtos.Destroy;
begin
  FIdeEvento.Free;
  FIdeEmpregador.Free;
  FIdeBenef.Free;
  inherited;
end;

procedure TEvtPgtos.GerarCamposRubricas(pRubrica: TRubricaCollectionItem);
begin
  Gerador.wCampo(tcStr, '', 'codRubr', 0, 0, 0, pRubrica.codRubr);
  Gerador.wCampo(tcStr, '', 'ideTabRubr', 0, 0, 0, pRubrica.ideTabRubr);
  Gerador.wCampo(tcDe2, '', 'qtdRubr', 0, 0, 0, pRubrica.qtdRubr);
  Gerador.wCampo(tcDe2, '', 'fatorRubr', 0, 0, 0, pRubrica.fatorRubr);
  Gerador.wCampo(tcDe2, '', 'vrUnit', 0, 0, 0, pRubrica.vrUnit);
  Gerador.wCampo(tcDe2, '', 'vrRubr', 0, 0, 0, pRubrica.vrRubr);
end;


procedure TEvtPgtos.GerarRubricasComPensao(
  pRubricasComPensao: TRubricasComPensaoCollection;
  const GroupName: string = 'retPgtoTot');
var
  i: Integer;
begin
  for i := 0 to pRubricasComPensao.Count - 1 do
  begin
    Gerador.wGrupo(GroupName);
      GerarCamposRubricas(pRubricasComPensao[i]);
      if pRubricasComPensao[i].pensaoAlimInst() then
        GerarPensaoAlim(pRubricasComPensao[i].penAlim, 'penAlim');
    Gerador.wGrupo('/'+GroupName);
  end;
end;

procedure TEvtPgtos.GerardetPgtoFl(objdetPgtofl: TdetPgtoFlCollection);
var
  i: Integer;
begin
  for i := 0 to objdetPgtofl.Count - 1 do
  begin
    Gerador.wGrupo('detPgtoFl');
      Gerador.wCampo(tcStr, '', 'perRef', 0, 0, 0, objdetPgtofl.Items[i].perRef);
      Gerador.wCampo(tcStr, '', 'ideDmDev', 0, 0, 0, objdetPgtofl.Items[i].ideDmDev);
      Gerador.wCampo(tcStr, '', 'indPgtoTt', 0, 0, 0, eSSimNaoToStr(objdetPgtofl.Items[i].indPagtoTt));
      Gerador.wCampo(tcDe2, '', 'vrLiq', 0, 0, 1, objdetPgtoFl.items[i].vrLiq);
      Gerador.wCampo(tcStr, '', 'nrRecArq', 0, 0, 0, objdetPgtofl.Items[i].nrRecArq);
      if objdetPgtofl.Items[i].retPagtoToInst() then
        GerarRubricasComPensao(objdetPgtofl.Items[i].retPagtoTot);
      if objdetPgtofl.Items[i].infoPgtoFlInst then
        GerarItensRemun(objdetPgtofl.Items[i].infoPgtoParc, 'infoPgtoParc');
    Gerador.wGrupo('/detPgtoFl');
  end;
end;

procedure TEvtPgtos.GerarDeps(pDeps: TDeps);
begin
  Gerador.wGrupo('deps');
    Gerador.wCampo(tcDe2, '', 'vrDedDep', 0, 0, 0, pDeps.vrDedDep);
  Gerador.wGrupo('/deps');
end;

procedure TEvtPgtos.GerarIdeBenef(objIdeBenef : TIdeBenef);
begin
  Gerador.wGrupo('ideBenef');
    Gerador.wCampo(tcStr, '', 'cpfBenef', 0, 0, 0, objIdeBenef.cpfBenef);
    if objIdeBenef.depsInst() then
      GerarDeps(objIdeBenef.deps);
    GerarInfoPgto(objIdeBenef.InfoPgto,0);
  Gerador.wGrupo('/ideBenef');
end;

procedure TEvtPgtos.GeraridePgtoExt(objPgtoExt: TPgtoExt);
begin
  Gerador.wGrupo('idePgtoExt');
    GerarIdePais(objPgtoExt.idePais);
    GerarEndExt(objPgtoExt.endExt);
  Gerador.wGrupo('/idePgtoExt');
end;

procedure TEvtPgtos.GerarDetPgtoBenPr(pDetPgtoBenPr: TDetPgtoBenPr);
begin
  Gerador.wGrupo('detPgtoBenPr');
    Gerador.wCampo(tcStr, '', 'perRef', 0, 0, 0, pDetPgtoBenPr.perRef);
    Gerador.wCampo(tcStr, '', 'ideDmDev', 0, 0, 0, pDetPgtoBenPr.ideDmDev);
    Gerador.wCampo(tcStr, '', 'indPgtoTt', 0, 0, 0, eSSimNaoToStr(pDetPgtoBenPr.indPgtoTt));
    Gerador.wCampo(tcDe2, '', 'vrLiq', 0, 0, 0, pDetPgtoBenPr.vrLiq);
    if pDetPgtoBenPr.retPgtoTotInst() then
      GerarItensRemun(pDetPgtoBenPr.retPgtoTot, 'retPgtoTot');
    if pDetPgtoBenPr.infoPgtoParcInst() then
      GerarItensRemun(pDetPgtoBenPr.retPgtoTot, 'infoPgtoParc');
  Gerador.wGrupo('/detPgtoBenPr');
end;

procedure TEvtPgtos.GerarDetPgtoFer(pDetPgtoFer: TDetPgtoFerCollection);
var
  i: integer;
begin
  for i := 0 to pDetPgtoFer.Count - 1 do
  begin
    Gerador.wGrupo('detPgtoFer');
      Gerador.wCampo(tcInt, '', 'codCateg', 0, 0, 0, pDetPgtoFer[i].codCateg);
      Gerador.wCampo(tcDat, '', 'dtIniGoz', 0, 0, 0, pDetPgtoFer[i].dtIniGoz);
      Gerador.wCampo(tcInt, '', 'qtDias', 0, 0, 0, pDetPgtoFer[i].qtDias);
      Gerador.wCampo(tcDe2, '', 'vrLiq', 0, 0, 0, pDetPgtoFer[i].vrLiq);
      GerarRubricasComPensao(pDetPgtoFer[i].detRubrFer, 'detRubrFer');
    Gerador.wGrupo('/detPgtoFer');
  end;
end;

procedure TEvtPgtos.GerarDetPgtoAnt(pDetPgtoAnt: TDetPgtoAntCollection);
var
  i: Integer;
begin
  for i := 0 to pDetPgtoAnt.Count - 1 do
  begin
    Gerador.wGrupo('detPgtoAnt');
      Gerador.wCampo(tcInt, '', 'codCateg', 0, 0, 0, pDetPgtoAnt[i].codCateg);
      GerarInfoPgtoAnt(pDetPgtoAnt[i].infoPgtoAnt);
    Gerador.wGrupo('/detPgtoAnt');
  end;
end;

procedure TEvtPgtos.GerarInfoPgtoAnt(pInfoPgtoAnt: TInfoPgtoAntCollection);
var
  i: Integer;
begin
  for i := 0 to pInfoPgtoAnt.Count - 1 do
  begin
    Gerador.wGrupo('infoPgtoAnt');
      Gerador.wCampo(tcStr, '', 'tpBcIRRF', 0, 0, 0, eSCodIncIRRFToStr(pInfoPgtoAnt[i].tpBcIRRF));
      Gerador.wCampo(tcDe2, '', 'vrBcIRRF', 0, 0, 0, pInfoPgtoAnt[i].vrBcIRRF);
    Gerador.wGrupo('/infoPgtoAnt');
  end;
end;

procedure TEvtPgtos.GerarInfoPgto(objInfoPgto: TInfoPgtoCollection; i : Integer);
begin
  Gerador.wGrupo('infoPgto');
    Gerador.wCampo(tcDat, '', 'dtPgto', 0, 0, 0, objInfoPgto.Items[i].dtPgto);
    Gerador.wCampo(tcStr, '', 'tpPgto', 0, 0, 0, eSTpTpPgtoToStr(objInfoPgto.Items[i].tpPgto));
    Gerador.wCampo(tcStr, '', 'indResBr', 0, 0, 0, eSSimNaoToStr(objInfoPgto.Items[i].indResBr));
    if (objInfoPgto.Items[i].tpPgto=tpPgtoFl) then
      if (objInfoPgto.Items[i].detPgtoFlInst()) then
        GerardetPgtoFl(objInfoPgto.Items[i].detPgtoFl);
    if objInfoPgto.Items[i].detPgtoBenPrInst() then
      GerarDetPgtoBenPr(objInfoPgto.Items[i].detPgtoBenPr);
    if objInfoPgto.Items[i].detPgtoFerInst() then
      GerarDetPgtoFer(objInfoPgto.Items[i].detPgtoFer);
    if objInfoPgto.Items[i].detPgtoAntInst() then
      GerarDetPgtoAnt(objInfoPgto.Items[i].detPgtoAnt);
    if (objInfoPgto.Items[i].indResBr = tpNao) then
      if (objInfoPgto.Items[i].detidePgtoExtInst) then
        GeraridePgtoExt(objInfoPgto.Items[i].idePgtoExt);
  Gerador.wGrupo('/infoPgto');
end;

function TEvtPgtos.GerarXML: Boolean;
begin
  try
    GerarCabecalho('evtPgtos');
      Gerador.wGrupo('evtPgtos Id="'+GerarChaveEsocial(now, self.ideEmpregador.NrInsc, 0)+'"');
        //GerarIdVersao(Self);
        GerarIdeEvento3(Self.IdeEvento);
        GerarIdeEmpregador(Self.ideEmpregador);
        GerarIdeBenef(Self.IdeBenef);
      Gerador.wGrupo('/evtPgtos');
    GerarRodape;
    XML := Assinar(Gerador.ArquivoFormatoXML, 'evtPgtos');
    Validar('evtPgtos');
  except on e:exception do
    raise Exception.Create(e.Message);
  end;
  Result := (Gerador.ArquivoFormatoXML <> '')
end;


{ TIdeBenef }

constructor TIdeBenef.create;
begin
  inherited;
  FDeps := nil;
  FInfoPgto := TInfoPgtoCollection.Create;
end;

destructor TIdeBenef.destroy;
begin
  FreeAndNil(FDeps);
  FInfoPgto.Free;
  inherited;
end;

function TIdeBenef.getDeps: TDeps;
begin
  if not Assigned(FDeps) then
    FDeps := TDeps.Create;
  Result := FDeps;
end;

function TIdeBenef.depsInst: boolean;
begin
  result := Assigned(FDeps);
end;

function TIdeBenef.getInfoPgto: TInfoPgtoCollection;
begin
  if (not Assigned(FInfoPgto)) then
    Result := TInfoPgtoCollection.Create;
  Result := FInfoPgto;
end;


{ TInfoPgtoAntCollection }

function TInfoPgtoAntCollection.Add: TInfoPgtoAntItem;
begin
  Result := TInfoPgtoAntItem(inherited add);
end;

constructor TInfoPgtoAntCollection.Create;
begin
  inherited create(TInfoPgtoAntItem);
end;

function TInfoPgtoAntCollection.GetItem(Index: Integer): TInfoPgtoAntItem;
begin
  Result := TInfoPgtoAntItem(inherited GetItem(Index));
end;

procedure TInfoPgtoAntCollection.SetItem(Index: Integer; const Value: TInfoPgtoAntItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfoPgtoCollection }

function TInfoPgtoCollection.Add: TInfoPgtoItem;
begin
  Result := TInfoPgtoItem(inherited add);
end;

constructor TInfoPgtoCollection.Create;
begin
  inherited create(TInfoPgtoItem);
end;

function TInfoPgtoCollection.GetItem(Index: Integer): TInfoPgtoItem;
begin
  Result := TInfoPgtoItem(inherited GetItem(Index));
end;

procedure TInfoPgtoCollection.SetItem(Index: Integer; const Value: TInfoPgtoItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfoPgtoItem }

constructor TInfoPgtoItem.create;
begin
//  inherited
  FdetPgtoFl := TdetPgtoFlCollection.Create;
  FIdePgtoExt := TPgtoExt.Create;
  FdetPgtoBenPr := nil;
  FDetPgtoFer := nil;
  FDetPgtoAnt := nil;
  end;

destructor TInfoPgtoItem.destroy;
begin
  FdetPgtoFl.Free;
  FIdePgtoExt.Free;
  FreeAndNil(FdetPgtoBenPr);
  FreeAndNil(FDetPgtoFer);
  FreeAndNil(FDetPgtoAnt);
  inherited;
end;

function TInfoPgtoItem.detPgtoAntInst: boolean;
begin
  Result := Assigned(FDetPgtoAnt);
end;

function TInfoPgtoItem.detPgtoFerInst: boolean;
begin
  Result := Assigned(FDetPgtoFer);
end;

function TInfoPgtoItem.detidePgtoExtInst: Boolean;
begin
  Result := Assigned(FidePgtoExt);
end;

function TInfoPgtoItem.detPgtoFlInst: Boolean;
begin
  Result := Assigned(FdetPgtoFl);
end;

function TInfoPgtoItem.detPgtoBenPrInst: boolean;
begin
  Result := Assigned(FdetPgtoBenPr);
end;

function TInfoPgtoItem.GetDetPgtoAnt: TDetPgtoAntCollection;
begin
  if not Assigned(FDetPgtoAnt) then
    FDetPgtoAnt := TDetPgtoAntCollection.Create;
  Result := FDetPgtoAnt;
end;

function TInfoPgtoItem.GetdetPgtoFl: TdetPgtoFlCollection;
begin
  if not (Assigned(FdetPgtoFl)) then
    FdetPgtoFl := TdetPgtoFlCollection.Create;
  Result := FdetPgtoFl;
end;

function TInfoPgtoItem.getDetPgtoBenPr: TDetPgtoBenPr;
begin
  if not Assigned(FdetPgtoBenPr) then
    FdetPgtoBenPr := TDetPgtoBenPr.Create;
  Result := FdetPgtoBenPr;
end;

function TInfoPgtoItem.GetPgtoExt: TPgtoExt;
begin
  if not (Assigned(FIdePgtoExt)) then
    FIdePgtoExt := TPgtoExt.Create;
  Result := FIdePgtoExt;
end;

function TInfoPgtoItem.getDetPgtoFer: TDetPgtoFerCollection;
begin
  if not Assigned(FDetPgtoFer) then
    FDetPgtoFer := TDetPgtoFerCollection.Create;
  Result := FDetPgtoFer;
end;

{ TPgtoExt }

constructor TPgtoExt.create;
begin
  FIdePais := TIdePais.Create;
  FEndExt := TEndExt.Create;
end;

destructor TPgtoExt.destroy;
begin
  FIdePais.Free;
  FEndExt.Free;
  inherited;
end;

{ TRubricasComPensaoCollection }

function TRubricasComPensaoCollection.add: TRubricasComPensaoItem;
begin
  Result := TRubricasComPensaoItem(inherited add);
end;

constructor TRubricasComPensaoCollection.Create;
begin
  inherited create(TRubricasComPensaoItem);
end;

function TRubricasComPensaoCollection.GetItem(Index: Integer): TRubricasComPensaoItem;
begin
  Result := TRubricasComPensaoItem(inherited GetItem(Index));
end;

procedure TRubricasComPensaoCollection.SetItem(Index: Integer; const Value: TRubricasComPensaoItem);
begin
  inherited SetItem(Index, Value);
end;


{ TRubricasComPensaoItem }

constructor TRubricasComPensaoItem.Create;
begin
  inherited;
  FPenAlim := nil;
end;

destructor TRubricasComPensaoItem.Destroy;
begin
  FreeAndNil(FPenAlim);
  inherited;
end;

function TRubricasComPensaoItem.pensaoAlimInst: boolean;
begin
  result := Assigned(FPenAlim);
end;

function TRubricasComPensaoItem.getPensaoAlim: TPensaoAlimCollection;
begin
  if not Assigned(FPenAlim) then
    FPenAlim := TPensaoAlimCollection.Create;
  Result := FPenAlim;
end;

{ TdetPgtoFlCollection }

function TdetPgtoFlCollection.add: TdetPgtoFlItem;
begin
  result := TdetPgtoFlItem(inherited add);
end;

constructor TdetPgtoFlCollection.Create;
begin
  inherited create(TdetPgtoFlItem);
end;

function TdetPgtoFlCollection.GetItem(Index: Integer): TdetPgtoFlItem;
begin
  Result := TdetPgtoFlItem(inherited GetItem(Index));
end;

procedure TdetPgtoFlCollection.SetItem(Index: Integer; const Value: TdetPgtoFlItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdetPgtoFlItem }

constructor TdetPgtoFlItem.create;
begin
  FRetPagtoTot := nil;
  FInfoPgtoParc := nil;
end;

destructor TdetPgtoFlItem.destroy;
begin
  FreeAndNil(FRetPagtoTot);
  FreeAndNil(FInfoPgtoParc);
  inherited;
end;

function TdetPgtoFlItem.getRetPagtoTot: TRubricasComPensaoCollection;
begin
  if not Assigned(FRetPagtoTot) then
    FRetPagtoTot := TRubricasComPensaoCollection.Create;
  Result := FRetPagtoTot;
end;

function TdetPgtoFlItem.retPagtoToInst: boolean;
begin
  Result := Assigned(FRetPagtoTot);
end;

function TdetPgtoFlItem.getInfoPgtoParc: TRubricaCollection;
begin
  if not Assigned(FInfoPgtoParc) then
    FInfoPgtoParc := TRubricaCollection.Create;
  Result := FInfoPgtoParc;
end;

function TdetPgtoFlItem.infoPgtoFlInst: boolean;
begin
  Result := Assigned(FInfoPgtoParc);
end;

{ TDetPgtoAntCollection }

function TDetPgtoAntCollection.add: TDetPgtoAntItem;
begin
  result := TDetPgtoAntItem(inherited add);
  Result.Create;
end;

constructor TDetPgtoAntCollection.Create;
begin
  inherited Create(TDetPgtoAntItem);
end;

function TDetPgtoAntCollection.GetItem(Index: Integer): TDetPgtoAntItem;
begin
  result := TDetPgtoAntItem(inherited GetItem(Index));
end;

procedure TDetPgtoAntCollection.SetItem(Index: Integer; const Value: TDetPgtoAntItem);
begin
  inherited SetItem(Index, Value);
end;

{ TDetPgtoAntItem }

constructor TDetPgtoAntItem.Create;
begin
  FInfoPgtoAnt := TInfoPgtoAntCollection.Create;
end;

destructor TDetPgtoAntItem.Destroy;
begin
  FInfoPgtoAnt.Free;
  inherited;
end;

{ TDetPgtoFerCollection }

function TDetPgtoFerCollection.add: TDetPgtoFerItem;
begin
  result := TDetPgtoFerItem(inherited add);
  Result.Create;
end;

constructor TDetPgtoFerCollection.Create;
begin
  inherited create(TDetPgtoFerItem);
end;

function TDetPgtoFerCollection.GetItem(Index: Integer): TDetPgtoFerItem;
begin
  result := TDetPgtoFerItem(inherited GetItem(Index));
end;

procedure TDetPgtoFerCollection.SetITem(Index: Integer; const Value: TDetPgtoFerItem);
begin
  inherited SetItem(Index, Value);
end;

{ TDetPgtoFerItem }

constructor TDetPgtoFerItem.Create;
begin
  FDetRubrFer := TRubricasComPensaoCollection.Create;
end;

destructor TDetPgtoFerItem.Destroy;
begin
  inherited;
  FDetRubrFer.Free;
end;

{ TDetPgtoBenPr }

constructor TDetPgtoBenPr.Create;
begin
  inherited;
  FRetPgtoTot := nil;
  FInfoPgtoParc := nil;
end;

destructor TDetPgtoBenPr.Destroy;
begin
  FreeAndNil(FRetPgtoTot);
  FreeAndNil(FInfoPgtoParc);
  inherited;
end;

function TDetPgtoBenPr.getInfoPgtoParc: TRubricaCollection;
begin
  if not Assigned(FInfoPgtoParc) then
    FInfoPgtoParc := TRubricaCollection.Create;
  Result := FInfoPgtoParc;
end;

function TDetPgtoBenPr.getRetPgtoTot: TRubricaCollection;
begin
  if not Assigned(FRetPgtoTot) then
    FRetPgtoTot := TRubricaCollection.Create;
  Result := FRetPgtoTot;
end;

function TDetPgtoBenPr.infoPgtoParcInst: boolean;
begin
  Result := Assigned(FInfoPgtoParc);
end;

function TDetPgtoBenPr.retPgtoTotInst: boolean;
begin
  Result := Assigned(FRetPgtoTot);
end;

end.
