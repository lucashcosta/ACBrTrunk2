{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{  de Servi�o eletr�nica - NFSe                                                }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFSeWebServices;

interface

uses
  Classes, SysUtils, pcnAuxiliar, pcnConversao,
  ACBrDFe, ACBrDFeWebService, ACBrDFeSSL,
  ACBrNFSeNotasFiscais, ACBrNFSeConfiguracoes,
  pnfsNFSe, pnfsNFSeG, pnfsConversao, pnfsLerListaNFSe, pnfsEnvLoteRpsResposta,
  pnfsConsSitLoteRpsResposta, pnfsCancNfseResposta, pnfsSubsNfseResposta,
  pnfsAbrirSessaoResposta, synacode;

type

  { TNFSeWebService }

  TNFSeWebService = class(TDFeWebService)
  private
  protected
    FPConfiguracoesNFSe: TConfiguracoesNFSe;

    FNotasFiscais: TNotasFiscais;

    FProvedor: TNFSeProvedor;
    FPStatus: TStatusACBrNFSe;
    FPLayout: TLayOutNFSe;
    FNameSpaceDad: String;
    FNameSpaceCab: String;
    FURI: String;
    FURISig: String;
    FURIRef: String;
    FTagI: String;
    FTagF: String;
    FDadosSenha: String;
    FDadosEnvelope: String;
    FaMsg: String;
    FSeparador: String;
    FPrefixo2: String;
    FPrefixo3: String;
    FPrefixo4: String;
    FNameSpace: String;
    FDefTipos: String;
    FCabecalho: String;
    FxsdServico: String;
    FVersaoXML: String;
    FVersaoNFSe: TVersaoNFSe;
    FxSignatureNode: String;
    FxDSIGNSLote: String;
    FxIdSignature: String;
    FHashIdent: String;
    FTagGrupo: String;
    FdocElemento: String;
    FinfElemento: String;

    FCabecalhoStr: Boolean;
    FDadosStr: Boolean;

    FvNotas: String;
    FXML_NFSe: String;

    FProtocolo: String;
    FDataRecebimento: TDateTime;

    FRetornoNFSe: TRetornoNFSe;
    FGerarDadosMsg: TNFSeG;

    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirEnvelopeSoap; override;
    procedure InicializarServico; override;
    function GerarVersaoDadosSoap: String; override;
    function GerarCabecalhoSoap: String; override;
    procedure InicializarDadosMsg(AIncluiEncodingCab: Boolean);
    procedure FinalizarServico; override;
    procedure IncluirEncoding(Incluir: Boolean);
    function ExtrairRetorno(GrupoMsgRet: String): String;
    function ExtrairNotasRetorno: Boolean;
    function GerarRetornoNFSe(ARetNFSe: String): String;
    procedure DefinirSignatureNode(TipoEnvio: String);
    procedure GerarLoteRPScomAssinatura(RPS: String);
    procedure GerarLoteRPSsemAssinatura(RPS: String);
    procedure InicializarTagITagF;
    procedure InicializarGerarDadosMsg;
    function ExtrairGrupoMsgRet(AGrupo: String): String;

  public
    constructor Create(AOwner: TACBrDFe); override;

    property Provedor: TNFSeProvedor read FProvedor;
    property Status: TStatusACBrNFSe read FPStatus;
    property Layout: TLayOutNFSe     read FPLayout;
    property NameSpaceCab: String    read FNameSpaceCab;
    property NameSpaceDad: String    read FNameSpaceDad;
    property URI: String             read FURI;
    property URISig: String          read FURISig;
    property URIRef: String          read FURIRef;
    property TagI: String            read FTagI;
    property TagF: String            read FTagF;
    property DadosSenha: String      read FDadosSenha;
    property DadosEnvelope: String   read FDadosEnvelope;
    property aMsg: String            read FaMsg;
    property Separador: String       read FSeparador;
    property Prefixo2: String        read FPrefixo2;
    property Prefixo3: String        read FPrefixo3;
    property Prefixo4: String        read FPrefixo4;
    property NameSpace: String       read FNameSpace;
    property DefTipos: String        read FDefTipos;
    property Cabecalho: String       read FCabecalho;
    property xsdServico: String      read FxsdServico;
    property VersaoXML: String       read FVersaoXML;
    property VersaoNFSe: TVersaoNFSe read FVersaoNFSe;
    property xSignatureNode: String  read FxSignatureNode;
    property xDSIGNSLote: String     read FxDSIGNSLote;
    property xIdSignature: String    read FxIdSignature;
    property HashIdent: String       read FHashIdent;
    property TagGrupo: String        read FTagGrupo;
    property docElemento: String     read FdocElemento;
    property infElemento: String     read FinfElemento;

    property vNotas: String   read FvNotas;
    property XML_NFSe: String read FXML_NFSe;

    property DataRecebimento: TDateTime read FDataRecebimento;
    property Protocolo: String          read FProtocolo;

    property RetornoNFSe: TRetornoNFSe read FRetornoNFSe   write FRetornoNFSe;
    property GerarDadosMsg: TNFSeG     read FGerarDadosMsg write FGerarDadosMsg;
  end;

  { TNFSeEnviarLoteRPS }

  TNFSeEnviarLoteRPS = class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;
    // Retorno
    FRetEnvLote: TRetEnvLote;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroLote: String read FNumeroLote;

    property RetEnvLote: TRetEnvLote read FRetEnvLote write FRetEnvLote;
  end;

  { TNFSeTesteEnvioLoteRPS }

  TNFSeTesteEnvioLoteRPS = class(TNFSeEnviarLoteRPS)
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
  end;

{ TNFSeEnviarSincrono }

  TNFSeEnviarSincrono = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;
    // Retorno
    FNotaRetornada: Boolean;
    FRetEnvLote: TRetEnvLote;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroLote: String read FNumeroLote;

    property NotaRetornada: Boolean  read FNotaRetornada;
    property RetEnvLote: TRetEnvLote read FRetEnvLote write FRetEnvLote;
  end;

{ TNFSeGerarNFSe }

  TNFSeGerarNFSe = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroRps: String;
    FNumeroLote: String;
    // Retorno
    FSituacao: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroRps: String read FNumeroRps;
    property NumeroLote: String read FNumeroLote;
    property Situacao: String   read FSituacao;
  end;

  { TNFSeGerarLoteRPS }

  TNFSeGerarLoteRPS = Class(TNFSeEnviarLoteRPS)
  private
    // Entrada
    FNumeroLote: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;
    function Executar: Boolean; override;

    property NumeroLote: String read FNumeroLote;
  end;

{ TNFSeConsultarSituacaoLoteRPS }

  TNFSeConsultarSituacaoLoteRPS = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;
    // Retorno
    FSituacao: String;
    FRetSitLote: TRetSitLote;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    function TratarRespostaFinal: Boolean;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property NumeroLote: String   read FNumeroLote   write FNumeroLote;
    property Situacao: String     read FSituacao;

    property RetSitLote: TRetSitLote read FRetSitLote write FRetSitLote;
  end;

{ TNFSeConsultarLoteRPS }

  TNFSeConsultarLoteRPS = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    //usado pelo provedor IssDsf
    property NumeroLote: String   read FNumeroLote   write FNumeroLote;
  end;

{ TNFSeConsultarNFSeRPS }

  TNFSeConsultarNFSeRPS = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroRps: String;
    FSerie: String;
    FTipo: String;
    FNumeroLote: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroRps: String  read FNumeroRps  write FNumeroRps;
    property Serie: String      read FSerie      write FSerie;
    property Tipo: String       read FTipo       write FTipo;
    //usado pelo provedor IssDsf
    property NumeroLote: String read FNumeroLote write FNumeroLote;
  end;

{ TNFSeConsultarNFSe }

  TNFSeConsultarNFSe = Class(TNFSeWebService)
  private
    // Entrada
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FNumeroNFSe: String;
    FPagina: Integer;
    FCNPJTomador: String;
    FIMTomador: String;
    FNomeInter: String;
    FCNPJInter: String;
    FIMInter: String;
    FSerie: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property DataInicial: TDateTime read FDataInicial  write FDataInicial;
    property DataFinal: TDateTime   read FDataFinal    write FDataFinal;
    property NumeroNFSe: String     read FNumeroNFSe   write FNumeroNFSe;
    property Pagina: Integer        read FPagina       write FPagina;
    property CNPJTomador: String    read FCNPJTomador  write FCNPJTomador;
    property IMTomador: String      read FIMTomador    write FIMTomador;
    property NomeInter: String      read FNomeInter    write FNomeInter;
    property CNPJInter: String      read FCNPJInter    write FCNPJInter;
    property IMInter: String        read FIMInter      write FIMInter;
    property Serie: String          read FSerie        write FSerie;
  end;

{ TNFSeCancelarNFSe }

  TNFSeCancelarNFSe = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroNFSe: String;
    FCodigoVerificacao: String;
    FCodigoCancelamento: String;
    FMotivoCancelamento: String;
    FNumeroLote: String;

    // Retorno
    FDataHora: TDateTime;
    FRetCancNFSe: TRetCancNFSe;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroNFSe: String         read FNumeroNFSe         write FNumeroNFSe;
    property CodigoVerificacao: String  read FCodigoVerificacao  write FCodigoVerificacao;
    property CodigoCancelamento: String read FCodigoCancelamento write FCodigoCancelamento;
    property MotivoCancelamento: String read FMotivoCancelamento write FMotivoCancelamento;
    //usado pelo provedor IssDsf
    property NumeroLote: String         read FNumeroLote         write FNumeroLote;

    property DataHora: TDateTime        read FDataHora           write FDataHora;

    property RetCancNFSe: TRetCancNFSe read FRetCancNFSe write FRetCancNFSe;
  end;

{ TNFSeSubstituirNFSe }

 TNFSeSubstituirNFSe = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroNFSe: String;
    FCodigoCancelamento: String;
    FMotivoCancelamento: String;
    FNumeroRps: String;
    
    // Retorno
    FDataHora: TDateTime;
    FSituacao: String;

    FNFSeRetorno: TretSubsNFSe;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property CodigoCancelamento: String read FCodigoCancelamento write FCodigoCancelamento;
    property MotivoCancelamento: String read FMotivoCancelamento write FMotivoCancelamento;
    property DataHora: TDateTime        read FDataHora           write FDataHora;
    property NumeroNFSe: String         read FNumeroNFSe         write FNumeroNFSe;

    property NumeroRps: String          read FNumeroRps;
    property Situacao: String           read FSituacao;

    property NFSeRetorno: TretSubsNFSe read FNFSeRetorno write FNFSeRetorno;
  end;

 { TNFSeAbrirSessao }

  TNFSeAbrirSessao = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;

    // Retorno
    FRetAbrirSessao: TRetAbrirSessao;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroLote: String read FNumeroLote;

    property RetAbrirSessao: TRetAbrirSessao read FRetAbrirSessao write FRetAbrirSessao;
  end;

 { TNFSeFecharSessao }

  TNFSeFecharSessao = Class(TNFSeWebService)
  private
    // Entrada
    FNumeroLote: String;

    // Retorno
//    FRetAbrirSessao: TRetAbrirSessao;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NumeroLote: String read FNumeroLote;

//    property RetAbrirSessao: TRetAbrirSessao read FRetAbrirSessao write FRetAbrirSessao;
  end;

 { TNFSeEnvioWebService }

  TNFSeEnvioWebService = class(TNFSeWebService)
  private
    FXMLEnvio: String;
    FPURLEnvio: String;
    FVersao: String;
    FSoapActionEnvio: String;

  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property XMLEnvio: String        read FXMLEnvio        write FXMLEnvio;
    property URLEnvio: String        read FPURLEnvio       write FPURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebServices }

  TWebServices = class
  private
    FACBrNFSe: TACBrDFe;
    
    FGerarLoteRPS: TNFSeGerarLoteRPS;
    FEnviarLoteRPS: TNFSeEnviarLoteRPS;
    FTesteEnvioLoteRPS: TNFSeTesteEnvioLoteRPS;
    FEnviarSincrono: TNFSeEnviarSincrono;
    FGerarNFSe: TNFSeGerarNFSe;
    FConsSitLoteRPS: TNFSeConsultarSituacaoLoteRPS;
    FConsLote: TNFSeConsultarLoteRPS;
    FConsNFSeRps: TNFSeConsultarNFSeRps;
    FConsNFSe: TNFSeConsultarNFSe;
    FCancNFSe: TNFSeCancelarNFSe;
    FSubNFSe: TNFSeSubstituirNFSe;
    FAbrirSessao: TNFSeAbrirSessao;
    FFecharSessao: TNFSeFecharSessao;

    FEnvioWebService: TNFSeEnvioWebService;

  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function GeraLote(ALote: Integer): Boolean; overload;
    function GeraLote(ALote: String): Boolean; overload;

    function Envia(ALote: Integer): Boolean; overload;
    function Envia(ALote: String): Boolean; overload;

    function TestaEnvio(ALote: String): Boolean;

    function EnviaSincrono(ALote:Integer): Boolean; overload;
    function EnviaSincrono(ALote:String): Boolean; overload;

    function Gera(ARps: Integer; ALote: Integer = 1): Boolean;

    function ConsultaSituacao(AProtocolo: String;
                              const ANumLote: String = ''): Boolean;
    function ConsultaLoteRps(ANumLote,
                             AProtocolo: String): Boolean;
    function ConsultaNFSeporRps(ANumero,
                                ASerie,
                                ATipo: String;
                                const ANumLote: String = ''): Boolean;
    function ConsultaNFSe(ADataInicial,
                          ADataFinal: TDateTime;
                          NumeroNFSe: String = '';
                          APagina: Integer = 1;
                          ACNPJTomador: String = '';
                          AIMTomador: String = '';
                          ANomeInter: String = '';
                          ACNPJInter: String = '';
                          AIMInter: String = '';
                          ASerie: String = ''): Boolean;

    function CancelaNFSe(ACodigoCancelamento: String;
                         ANumeroNFSe: String = '';
                         AMotivoCancelamento: String = '';
                         const ANumLote: String = ''): Boolean;

    function SubstituiNFSe(ACodigoCancelamento,
                           ANumeroNFSe: String;
                           AMotivoCancelamento: String = ''): Boolean;

    property ACBrNFSe: TACBrDFe                            read FACBrNFSe        write FACBrNFSe;
    property GerarLoteRPS: TNFSeGerarLoteRPS               read FGerarLoteRPS    write FGerarLoteRPS;
    property EnviarLoteRPS: TNFSeEnviarLoteRPS             read FEnviarLoteRPS   write FEnviarLoteRPS;
    property TesteEnvioLoteRPS: TNFSeTesteEnvioLoteRPS     read FTesteEnvioLoteRPS   write FTesteEnvioLoteRPS;
    property EnviarSincrono: TNFSeEnviarSincrono           read FEnviarSincrono  write FEnviarSincrono;
    property GerarNFSe: TNFSeGerarNFSe                     read FGerarNFSe       write FGerarNFSe;
    property ConsSitLoteRPS: TNFSeConsultarSituacaoLoteRPS read FConsSitLoteRPS  write FConsSitLoteRPS;
    property ConsLote: TNFSeConsultarLoteRPS               read FConsLote        write FConsLote;
    property ConsNFSeRps: TNFSeConsultarNFSeRps            read FConsNFSeRps     write FConsNFSeRps;
    property ConsNFSe: TNFSeConsultarNFSe                  read FConsNFSe        write FConsNFSe;
    property CancNFSe: TNFSeCancelarNFSe                   read FCancNFSe        write FCancNFSe;
    property SubNFSe: TNFSeSubstituirNFSe                  read FSubNFSe         write FSubNFSe;
    property AbrirSessao: TNFSeAbrirSessao                 read FAbrirSessao     write FAbrirSessao;
    property FecharSessao: TNFSeFecharSessao               read FFecharSessao    write FFecharSessao;

    property EnvioWebService: TNFSeEnvioWebService         read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
  StrUtils, Math,
  ACBrUtil, ACBrNFSe,
  pcnGerador, pcnLeitor;

{ TNFSeWebService }

constructor TNFSeWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesNFSe := TConfiguracoesNFSe(FPConfiguracoes);
  FPLayout := LayNFSeRecepcaoLote;
  FPStatus := stNFSeIdle;
  FCabecalhoStr:= False;
  FDadosStr:= False;
end;

procedure TNFSeWebService.DefinirURL;
var
  Versao: Double;
begin
  { sobrescrever apenas se necess�rio.
    Voc� tamb�m pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';

  TACBrNFSe(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

procedure TNFSeWebService.DefinirServicoEAction;
begin
  if Pos('%NomeURL_HP%', FPSoapAction) > 0 then
  begin
    if FPConfiguracoesNFSe.WebServices.Ambiente = taHomologacao then
      FPSoapAction := StringReplace(FPSoapAction, '%NomeURL_HP%', FPConfiguracoesNFSe.Geral.xNomeURL_H, [rfReplaceAll])
    else
      FPSoapAction := StringReplace(FPSoapAction, '%NomeURL_HP%', FPConfiguracoesNFSe.Geral.xNomeURL_P, [rfReplaceAll]);
  end;

  if FProvedor = proActconv202 then
  begin
    if FPConfiguracoesNFSe.WebServices.Ambiente = taHomologacao then
      FPSoapAction := StringReplace(FPSoapAction, '%Ambiente%', 'homologacao', [rfReplaceAll])
    else
      FPSoapAction := StringReplace(FPSoapAction, '%Ambiente%', 'nfseserv', [rfReplaceAll]);
  end;
end;

procedure TNFSeWebService.DefinirEnvelopeSoap;
var
  Texto, DadosMsg, CabMsg, NameSpace: String;
begin
  {$IFDEF FPC}
   Texto := '<' + ENCODING_UTF8 + '>';    // Envelope j� est� sendo montado em UTF8
  {$ELSE}
   Texto := '';  // Isso for�ar� a convers�o para UTF8, antes do envio
  {$ENDIF}

  Texto := Texto + FDadosEnvelope;

  if FPConfiguracoesNFSe.WebServices.Ambiente = taProducao then
    NameSpace := FPConfiguracoesNFSe.Geral.ConfigNameSpace.Producao
  else
    NameSpace := FPConfiguracoesNFSe.Geral.ConfigNameSpace.Homologacao;

  if FProvedor = proSafeWeb then
    FPCabMsg := StringReplace(FPCabMsg, '%SenhaMsg%' , FDadosSenha, [rfReplaceAll]);
    
  CabMsg := FPCabMsg;
  if FCabecalhoStr then
    CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  CabMsg := StringReplace(CabMsg, '%NameSpace%', NameSpace  , [rfReplaceAll]);

  DadosMsg := FPDadosMsg;
  if FDadosStr then
    DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  // Altera��es no conteudo de DadosMsg especificas para alguns provedores
  case FProvedor of
    proGinfes: begin
                 if (FPLayout = LayNfseCancelaNfse) then
                   DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
               end;

    proPronim:   DadosMsg := StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

    proPronimV2: DadosMsg := StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/nfse.xsd"', '', [rfReplaceAll]);

    proSigep:    DadosMsg := Copy(DadosMsg, (pos('&lt;p:credenciais',DadosMsg)), length(DadosMsg));
  end;

  // %SenhaMsg%  : Representa a Mensagem que contem o usu�rio e senha
  // %NameSpace% : Representa o NameSpace de Homologa��o/Produ��o
  // %CabMsg%    : Representa a Mensagem de Cabe�alho
  // %DadosMsg%  : Representa a Mensagem de Dados

  Texto := StringReplace(Texto, '%SenhaMsg%' , FDadosSenha, [rfReplaceAll]);
  Texto := StringReplace(Texto, '%NameSpace%', NameSpace  , [rfReplaceAll]);
  Texto := StringReplace(Texto, '%CabMsg%'   , CabMsg     , [rfReplaceAll]);
  Texto := StringReplace(Texto, '%DadosMsg%' , DadosMsg   , [rfReplaceAll]);
  Texto := StringReplace(Texto, '%inscricaoMunicipal%', FPConfiguracoesNFSe.Geral.Emitente.InscMun, [rfReplaceAll]);

  FPEnvelopeSoap := Texto;
end;

procedure TNFSeWebService.InicializarServico;
begin
  { Sobrescrever apenas se necess�rio }
  inherited InicializarServico;

  FProvedor := FPConfiguracoesNFSe.Geral.Provedor;

  if FPConfiguracoesNFSe.Geral.ConfigGeral.VersaoSoap = '' then
    FPMimeType := 'application/xml'
  else if FPConfiguracoesNFSe.Geral.ConfigGeral.VersaoSoap = '1.2' then
    FPMimeType := 'application/soap+xml'
  else
    FPMimeType := 'text/xml';

  FPDFeOwner.SSL.UseCertificateHTTP := FPConfiguracoesNFSe.Geral.ConfigGeral.UseCertificateHTTP;

  TACBrNFSe(FPDFeOwner).SetStatus(FPStatus);
end;

function TNFSeWebService.GerarVersaoDadosSoap: String;
begin
  { Sobrescrever apenas se necess�rio }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrNFSe(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

function TNFSeWebService.GerarCabecalhoSoap: String;
begin
  Result := FPCabMsg;
end;

procedure TNFSeWebService.InicializarDadosMsg(AIncluiEncodingCab: Boolean);
var
  Texto, xmlns2, xmlns3, xmlns4: String;
  Ok: Boolean;
begin
  FvNotas := '';
  FURI    := '';
  FURISig := '';
  FURIRef := '';

  FPConfiguracoesNFSe.WebServices.QuebradeLinha := FPConfiguracoesNFSe.Geral.ConfigGeral.QuebradeLinha;

  FNameSpace  := FPConfiguracoesNFSe.Geral.ConfigXML.NameSpace;

  if Pos('%NomeURL_HP%', FNameSpace) > 0 then
  begin
    if FPConfiguracoesNFSe.WebServices.Ambiente = taHomologacao then
    begin
      FNameSpace := StringReplace(FNameSpace, '%NomeURL_HP%', FPConfiguracoesNFSe.Geral.xNomeURL_H, [rfReplaceAll]);

      if FProvedor in [proActcon, proActconv202] then
        FNameSpace := StringReplace(FNameSpace, '/nfseserv/', '/homologacao/', [rfReplaceAll])
    end
    else
      FNameSpace := StringReplace(FNameSpace, '%NomeURL_HP%', FPConfiguracoesNFSe.Geral.xNomeURL_P, [rfReplaceAll]);
  end;

  FVersaoXML  := FPConfiguracoesNFSe.Geral.ConfigXML.VersaoXML;
  FVersaoNFSe := StrToVersaoNFSe(Ok, FVersaoXML);
  FDefTipos   := FPConfiguracoesNFSe.Geral.ConfigSchemas.DefTipos;

  if (FProvedor = proGinfes) and (FPLayout = LayNfseCancelaNfse) then
    FDefTipos := 'tipos_v02.xsd';

  FCabecalho := FPConfiguracoesNFSe.Geral.ConfigSchemas.Cabecalho;
  FPrefixo2  := FPConfiguracoesNFSe.Geral.ConfigGeral.Prefixo2;
  FPrefixo3  := FPConfiguracoesNFSe.Geral.ConfigGeral.Prefixo3;
  FPrefixo4  := FPConfiguracoesNFSe.Geral.ConfigGeral.Prefixo4;
  FPCabMsg   := FPConfiguracoesNFSe.Geral.ConfigEnvelope.CabecalhoMsg;

  if FPrefixo2 <> '' then
    xmlns2 := 'xmlns:' + StringReplace(FPrefixo2, ':', '', []) + '="'
  else
    xmlns2 := 'xmlns="';

  if FPrefixo3 <> '' then
    xmlns3 := 'xmlns:' + StringReplace(FPrefixo3, ':', '', []) + '="'
  else
    xmlns3 := 'xmlns="';

  if FPrefixo4 <> '' then
    xmlns4 := 'xmlns:' + StringReplace(FPrefixo4, ':', '', []) + '="'
  else
    xmlns4 := 'xmlns="';

  if FProvedor = proSigep then
  begin
    xmlns3 := '';
    xmlns2 := '';
    xmlns4 := '';
  end;

  if AIncluiEncodingCab then
    FPCabMsg := '<' + ENCODING_UTF8 + '>' + FPCabMsg;

  if RightStr(FNameSpace, 1) = '/' then
    FSeparador := ''
  else
    FSeparador := '/';

  if FCabecalho <> '' then
    FNameSpaceCab := ' ' + xmlns2 + FNameSpace + FSeparador + FCabecalho +'">'
  else
    FNameSpaceCab := '>';

  // Seta o NameSpace para realizar a valida��o do Lote.
  FPDFeOwner.SSL.NameSpaceURI := FNameSpace;

  if FxsdServico <> '' then
  begin
    case FProvedor of
      // incluido em 23/06/2017 por italo
      proGovBr: FNameSpaceDad := 'xmlns:ns2="http://www.w3.org/2000/09/xmldsig#"' +
                                 ' xmlns:ns3="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"';

      proInfisc,
      proInfiscv11,
      proSMARAPD: FNameSpaceDad := xmlns3 + FNameSpace + '"';

      proIssDSF: FNameSpaceDad := xmlns3 + FNameSpace + '"' +
                                  ' xmlns:tipos="http://localhost:8080/WsNFe2/tp"' +
                                  ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                  ' xsi:schemaLocation="http://localhost:8080/WsNFe2/lote' +
                                  ' http://localhost:8080/WsNFe2/xsd/' + FxsdServico + '"';

      proWebISS,
      proWebISSv2: FNameSpaceDad := xmlns3 + FNameSpace + '"' ;
//                                  ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
//                                  ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"';

      proNFSeBrasil: FNameSpaceDad := ' xmlns:xs="http://www.nfsebrasil.net.br/nfse/rps/xsd/rps.xsd"' +
                                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"';

      proEL: FNameSpaceDad := 'xmlns="' + FNameSpace + FSeparador + FxsdServico + '" ' +
                              'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                              'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                              'xsi:schemaLocation="' + FNameSpace + FSeparador + FxsdServico + ' ' + FxsdServico + ' "';

      proSigep: FNameSpaceDad :=  FNameSpace;

      else begin
        if (FSeparador = '') then
        begin
          FNameSpaceDad := xmlns3 + FNameSpace + FSeparador + FxsdServico + '"';
          FPDFeOwner.SSL.NameSpaceURI := FNameSpace + FSeparador + FxsdServico;
        end
        else
          FNameSpaceDad := xmlns3 + FNameSpace + '"';
      end;
    end;
  end
  else
    FNameSpaceDad := '';

  if FDefTipos <> '' then
    FNameSpaceDad := FNameSpaceDad + ' ' + xmlns4 + FNameSpace + FSeparador + FDefTipos + '"';

  if FNameSpaceDad <> '' then
    FNameSpaceDad := ' ' + FNameSpaceDad;

  Texto := FPConfiguracoesNFSe.Geral.ConfigGeral.DadosSenha;
  // %Usuario% : Representa o nome do usu�rio ou CNPJ
  // %Senha%   : Representa a senha do usu�rio
  Texto := StringReplace(Texto, '%Municipio%', IntToStr(FPConfiguracoesNFSe.Geral.CodigoMunicipio), [rfReplaceAll]);
  Texto := StringReplace(Texto, '%Usuario%', FPConfiguracoesNFSe.Geral.UserWeb, [rfReplaceAll]);

  // Fazer o parse da senha, pois pode ter caracteres especiais
  case FProvedor of
    proSimplISS: Texto := StringReplace(Texto, '%Senha%', ParseText(FPConfiguracoesNFSe.Geral.SenhaWeb, False), [rfReplaceAll]);

    proSMARAPD: Texto := StringReplace(Texto, '%Senha%', EncodeBase64(SHA1(FPConfiguracoesNFSe.Geral.SenhaWeb)) , [rfReplaceAll]);
  else
    Texto := StringReplace(Texto, '%Senha%', FPConfiguracoesNFSe.Geral.SenhaWeb, [rfReplaceAll]);
  end;

  FDadosSenha := Texto;
end;

procedure TNFSeWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necess�rio }

  TACBrNFSe(FPDFeOwner).SetStatus(stNFSeIdle);
end;

function TNFSeWebService.ExtrairRetorno(GrupoMsgRet: String): String;
var
  AuxXML, XMLRet: String;
begin
  // Alguns provedores retornam a resposta em String
  // Aplicado a convers�o de String para XML
  FPRetornoWS := StringReplace(StringReplace(FPRetornoWS, '&lt;', '<', [rfReplaceAll]), '&gt;', '>', [rfReplaceAll]);

  FPRetornoWS := StringReplace(FPRetornoWS, '&#xD;'   , '', [rfReplaceAll]);
  FPRetornoWS := StringReplace(FPRetornoWS, '&#xd;'   , '', [rfReplaceAll]);
  FPRetornoWS := StringReplace(FPRetornoWS, '#9#9#9#9', '', [rfReplaceAll]); //proCONAM
  // Remover quebras de linha //
  FPRetornoWS := StringReplace(FPRetornoWS, #10       , '', [rfReplaceAll]);
  FPRetornoWS := StringReplace(FPRetornoWS, #13       , '', [rfReplaceAll]);

  FPRetornoWS := RemoverDeclaracaoXML(FPRetornoWS);

  if (FProvedor = proNFSeBrasil) then
    AuxXML := ParseText(FPRetornoWS, true, false)
  else
    AuxXML := ParseText(FPRetornoWS);

  if FPConfiguracoesNFSe.Geral.RetirarAcentos then
    AuxXML := TiraAcentos(AuxXML);

  if GrupoMsgRet <> '' then
    XMLRet := SeparaDados(AuxXML, GrupoMsgRet)
  else
  begin
    XMLRet := SeparaDados(AuxXML, 'return');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'ns:return');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'outputXML');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'RetornoXML');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 's:Body');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'soap:Body');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'env:Body');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'soapenv:Body');

    if XMLRet = '' then
      XMLRet := SeparaDados(AuxXML, 'SOAP-ENV:Body');
  end;

  // Caso n�o consiga extrai o retorno, retornar a resposta completa.
  if XMLRet = '' then
    XMLRet := AuxXML;

  XMLRet := RemoverDeclaracaoXML(XMLRet);

  Result := XMLRet;
end;

function TNFSeWebService.ExtrairNotasRetorno: Boolean;
var
  FRetNFSe, PathArq, NomeArq, xCNPJ: String;
  i, l, ii: Integer;
  xData: TDateTime;
  NovoRetorno, CondicaoNovoRetorno: Boolean;
begin
  FRetornoNFSe := TRetornoNFSe.Create;

  FRetornoNFSe.Leitor.Arquivo := FPRetWS;
  FRetornoNFSe.Provedor       := FProvedor;
  FRetornoNFSe.TabServicosExt := FPConfiguracoesNFSe.Arquivos.TabServicosExt;
  FRetornoNFSe.PathIniCidades := FPConfiguracoesNFSe.Geral.PathIniCidades;
  FRetornoNFSe.LerXml;

  ii := 0;
  for i := 0 to FRetornoNFSe.ListaNFSe.CompNFSe.Count -1 do
  begin
    // O provedor EGoverneISS n�o retorna o XML da NFS-e esse � obtido pelo
    // Link retornado e atribuido a propriedade Link, bem como o numero da nota
    // que � atribuido a propriedade Numero
    if (FProvedor = proEGoverneISS) then
    begin
      FNotasFiscais.Items[0].NFSe.Autenticador := FRetornoNFSe.ListaNFSe.CompNFSe.Items[0].NFSe.Autenticador;
      FNotasFiscais.Items[0].NFSe.Link         := FRetornoNFSe.ListaNFSe.CompNFSe.Items[0].NFSe.Link;
      FNotasFiscais.Items[0].NFSe.Numero       := FRetornoNFSe.ListaNFSe.CompNFSe.Items[0].NFSe.Numero;

      break;
    end;

    // provedor CTA na consulta por lote somente retorna os dados do RPS
    if (FProvedor = proCTA) and (FPLayout = LayNfseConsultaLote) then
    begin
         // todo: tratar provedor CTA
    end;

    // Considerar o retorno sempre como novo, avaliar abaixo se o RPS est� na lista
    NovoRetorno := True;
    for l := 0 to FNotasFiscais.Count -1 do
    begin
      // Provedor de goinaia em modo de homologa��o sempre retorna o mesmo dados
      if (FProvedor = proGoiania) and (FPConfiguracoes.WebServices.Ambiente = taHomologacao) then
      begin
        FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Numero := '14';
        FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Serie  := 'UNICA';
      end;
      // Se o RPS na lista de NFS-e consultado est� na lista de FNotasFiscais, ent�o atualiza os dados da mesma. A n�o existencia, implica em adcionar novo ponteiro em FNotasFiscais
      // foi alterado para testar o Numero, serie e tipo, pois o numero pode voltar ao terminar a seria��o.
      {
      if ((not (FProvedor in [proNFSeBrasil, proEL])) and
         ((StrToInt64Def(FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Numero, 0) = StrToInt64Def(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Numero, 0)) and
           (FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Serie = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Serie) and
           (FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Tipo = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Tipo)) or
          (FNotasFiscais.Items[l].NFSe.InfID.ID = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.InfID.ID)) or
         ((FProvedor in [proNFSeBrasil, proEL]) and
          (StrToInt64Def(FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Numero, 0) = StrToInt64Def(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Numero, 0))) then
      }

      if FProvedor in [proNFSeBrasil, proEL] then
        // Se o provedor for NFSeBrasil ou EL compara apenas o numero do RPS
        CondicaoNovoRetorno := (StrToInt64Def(FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Numero, 0) = StrToInt64Def(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Numero, 0))
      else
        // caso contrario compara se j� esta adicionado comparando pelo n�mero, s�rie e (tipo ou InfId.ID)
        CondicaoNovoRetorno := (StrToInt64Def(FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Numero, 0) = StrToInt64Def(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Numero, 0)) and
              (FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Serie = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Serie) and
              ((FNotasFiscais.Items[l].NFSe.IdentificacaoRps.Tipo = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Tipo) or
              (FNotasFiscais.Items[l].NFSe.InfID.ID = FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.InfID.ID));

      if CondicaoNovoRetorno then
      begin
        NovoRetorno := False;
        ii := l;
        break;
      end;
    end;

    if NovoRetorno then
    begin
      FNotasFiscais.Add;
      ii := FNotasFiscais.Count -1;
    end;

    FNotasFiscais.Items[ii].Confirmada := True;

    FNotasFiscais.Items[ii].NFSe.XML := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.XML;

    FNotasFiscais.Items[ii].NFSe.InfID.ID := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.InfID.ID;

    // Retorno do GerarNfse e EnviarLoteRpsSincrono
    if FPLayout in [LayNFSeGerar, LayNFSeRecepcaoLoteSincrono] then
    begin
      FProtocolo := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Protocolo;

      if (Provedor = ProTecnos) then
      begin
        if (FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NumeroLote <> '0') then
        begin
          FNotasFiscais.Items[ii].NFSe.NumeroLote    := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NumeroLote;
          FNotasFiscais.Items[ii].NFSe.dhRecebimento := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.dhRecebimento;
          FNotasFiscais.Items[ii].NFSe.Protocolo     := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Protocolo;
        end;
      end
      else
      begin
        FNotasFiscais.Items[ii].NFSe.NumeroLote    := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NumeroLote;
        FNotasFiscais.Items[ii].NFSe.dhRecebimento := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.dhRecebimento;
        FNotasFiscais.Items[ii].NFSe.Protocolo     := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Protocolo;
      end;
    end;

    // Retorno do GerarNfse e ConsultarLoteRps
    if (FPLayout in [LayNFSeGerar, LayNfseConsultaLote]) or ((FPLayout = LayNfseConsultaNfseRps) and (FProvedor = proISSNET)) then
      FNotasFiscais.Items[ii].NFSe.Situacao := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Situacao;

    FNotasFiscais.Items[ii].NFSe.CodigoVerificacao := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.CodigoVerificacao;
    FNotasFiscais.Items[ii].NFSe.Numero            := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Numero;
    FNotasFiscais.Items[ii].NFSe.Competencia       := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Competencia;
    FNotasFiscais.Items[ii].NFSe.NFSeSubstituida   := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NFSeSubstituida;
    FNotasFiscais.Items[ii].NFSe.OutrasInformacoes := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.OutrasInformacoes;
    FNotasFiscais.Items[ii].NFSe.DataEmissao       := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.DataEmissao;

    FNotasFiscais.Items[ii].NFSe.ValoresNfse.BaseCalculo      := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.ValoresNfse.BaseCalculo;
    FNotasFiscais.Items[ii].NFSe.ValoresNfse.Aliquota         := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.ValoresNfse.Aliquota;
    FNotasFiscais.Items[ii].NFSe.ValoresNfse.ValorIss         := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.ValoresNfse.ValorIss;
    FNotasFiscais.Items[ii].NFSe.ValoresNfse.ValorLiquidoNfse := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.ValoresNfse.ValorLiquidoNfse;

    FNotasFiscais.Items[ii].NFSe.Servico.xItemListaServico := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Servico.xItemListaServico;

    FNotasFiscais.Items[ii].NFSe.PrestadorServico.RazaoSocial  := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.RazaoSocial;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.NomeFantasia := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.NomeFantasia;

    FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.CNPJ               := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.IdentificacaoPrestador.CNPJ;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;

    FNotasFiscais.Items[ii].NFSe.IdentificacaoRps.Tipo   := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Tipo;
    FNotasFiscais.Items[ii].NFSe.IdentificacaoRps.Serie  := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Serie;
    FNotasFiscais.Items[ii].NFSe.IdentificacaoRps.Numero := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Numero;

    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Endereco        := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.Endereco;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Numero          := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.Numero;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Complemento     := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.Complemento;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Bairro          := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.Bairro;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CodigoMunicipio := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.CodigoMunicipio;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.UF              := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.UF;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CEP             := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.CEP;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.xMunicipio      := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Endereco.xMunicipio;

    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Telefone := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Contato.Telefone;
    FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Email    := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.Contato.Email;

    FNotasFiscais.Items[ii].NFSe.Tomador.Endereco.xMunicipio      := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Tomador.Endereco.xMunicipio;
    FNotasFiscais.Items[ii].NFSe.Tomador.Endereco.CodigoMunicipio := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Tomador.Endereco.CodigoMunicipio;

    FNotasFiscais.Items[ii].NFSe.NfseCancelamento.DataHora := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NfseCancelamento.DataHora;
    FNotasFiscais.Items[ii].NFSe.NfseCancelamento.Pedido.CodigoCancelamento := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.NfseCancelamento.Pedido.CodigoCancelamento;

    FNotasFiscais.Items[ii].NFSe.Cancelada := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Cancelada;
    FNotasFiscais.Items[ii].NFSe.Status    := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Status;

    FNotasFiscais.Items[ii].NFSe.NfseSubstituidora := FRetornoNFSe.ListaNfse.CompNfse.Items[i].NFSe.NfseSubstituidora;

    FRetNFSe := GerarRetornoNFSe(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.XML);

    if FPConfiguracoesNFSe.Arquivos.EmissaoPathNFSe then
      xData := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.DataEmissao
    else
      xData := Date;

    xCNPJ := OnlyNumber(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.PrestadorServico.IdentificacaoPrestador.CNPJ);

    if FPConfiguracoesNFSe.Arquivos.NomeLongoNFSe then
      NomeArq := GerarNomeNFSe(FPConfiguracoesNFSe.WebServices.UFCodigo,
                               FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.DataEmissao,
                               xCNPJ,
                               StrToInt64Def(FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Numero, 0)) + '-nfse.xml'
    else
      NomeArq := FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.Numero +
                 FRetornoNFSe.ListaNFSe.CompNFSe.Items[i].NFSe.IdentificacaoRps.Serie +
                 '-nfse.xml';

    PathArq := PathWithDelim(FPConfiguracoesNFSe.Arquivos.GetPathNFSe(xData, xCNPJ));

    FNotasFiscais.Items[ii].NomeArq := PathArq + NomeArq;
    FNotasFiscais.Items[ii].XMLNFSe := FRetNFSe;

    if FPConfiguracoesNFSe.Arquivos.Salvar then
      FPDFeOwner.Gravar(NomeArq, FRetNFSe, PathArq);

    inc(ii);
  end;

  // todo: tratar provedor CTA

  if FRetornoNFSe.ListaNFSe.CompNFSe.Count > 0 then
  begin
    FDataRecebimento := FRetornoNFSe.ListaNFSe.CompNFSe[0].NFSe.dhRecebimento;

    if FDataRecebimento = 0 then
      FDataRecebimento := FRetornoNFSe.ListaNFSe.CompNFSe[0].NFSe.DataEmissao;

    if (FProvedor = ProTecnos) and (DateToStr(FDataRecebimento) = '01/01/0001') then
      FDataRecebimento := 0;

    if FProvedor in [proGovDigital, proInfisc, proInfiscv11, proNFSeBrasil,
                     proTecnos, proVersaTecnologia] then
      FProtocolo := FRetornoNFSe.ListaNFSe.CompNFSe[0].NFSe.Protocolo;
  end
  else
    FDataRecebimento := 0;

  // Lista de Mensagem de Retorno
  FPMsg := '';
  FaMsg := '';
  if FRetornoNFSe.ListaNFSe.MsgRetorno.Count > 0 then
  begin
    for i := 0 to FRetornoNFSe.ListaNFSe.MsgRetorno.Count - 1 do
    begin
      if (FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Codigo <> 'L000') and
         (FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Codigo <> 'A0000') then
      begin
        FPMsg := FPMsg + FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Mensagem + LineBreak +
                         FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + FRetornoNFSe.ListaNFSe.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
      end;
    end;
  end
  else begin
    if FRetornoNFSe.ListaNFSe.CompNFSe.Count > 0 then
      FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
               'Situa��o...... : ' + FRetornoNFSe.ListaNFSe.CompNFSe[0].NFSe.Situacao + LineBreak +
               'Recebimento... : ' + IfThen(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
               'Protocolo..... : ' + FProtocolo + LineBreak +
               'Provedor...... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak
    else
      FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
               'Recebimento... : ' + IfThen(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
               'Protocolo..... : ' + FProtocolo + LineBreak +
               'Provedor...... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
  end;
  // Valida��o de sucesso para provedores que n�o retornam data de recebimento
  if FProvedor in [ProNotaBlu] then
    Result := UpperCase(FRetornoNFSe.ListaNFSe.Sucesso) = UpperCase('true')
  else // Valida��o atrav�s da data de recebimento
    Result := (FDataRecebimento <> 0);
end;

function TNFSeWebService.GerarRetornoNFSe(ARetNFSe: String): String;
var
  Texto: String;
begin
  Texto := FPConfiguracoesNFSe.Geral.ConfigGeral.RetornoNFSe;

  // %NomeURL_P% : Representa o Nome da cidade na URL
  // %DadosNFSe% : Representa a NFSe

  Texto := StringReplace(Texto, '%NomeURL_P%', FPConfiguracoesNFSe.Geral.xNomeURL_P, [rfReplaceAll]);
  Texto := StringReplace(Texto, '%DadosNFSe%', ARetNFSe, [rfReplaceAll]);

  Result := Texto;
end;

procedure TNFSeWebService.DefinirSignatureNode(TipoEnvio: String);
var
  EnviarLoteRps, xmlns, xPrefixo: String;
  i, j: Integer;
begin
  if FPLayout = LayNFSeGerar then
  begin
    case FProvedor of
      proSimplISS:    EnviarLoteRps := 'GerarNovaNfseEnvio';

      proEGoverneISS: EnviarLoteRps := 'request';

      proSP, 
      proNotaBlu:     EnviarLoteRps := 'PedidoEnvioRPS';
    else
      EnviarLoteRps := 'GerarNfseEnvio';
    end;
  end
  else begin
    case FProvedor of
      proEquiplano: EnviarLoteRps := 'enviarLoteRps' + TipoEnvio + 'Envio';

      proInfisc,
      proInfiscv11: EnviarLoteRps := 'envioLote';

      proIssDsf,
      proCTA:       EnviarLoteRps := 'ReqEnvioLoteRPS';

      proSP, 
      proNotaBlu:   EnviarLoteRps := 'PedidoEnvioLoteRPS';

      proSMARAPD:   EnviarLoteRps := ''

//      proTinus:     EnviarLoteRps := 'Arg';
    else
      EnviarLoteRps := 'EnviarLoteRps' + TipoEnvio + 'Envio';
    end;
  end;

  FxSignatureNode := '';
  FxDSIGNSLote := '';
  FxIdSignature := '';

  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS) or
     ((FPConfiguracoesNFSe.Geral.ConfigAssinar.RpsGerar) and (FPLayout = LayNFSeGerar)) then
  begin
    if (URI <> '') then
    begin
      if not (FProvedor in [proAbaco, proBetha, proFISSLex, proIssCuritiba,
                            proPublica, proRecife, proRJ]) then
      begin
        FxSignatureNode := './/ds:Signature[@' +
                   FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador +
                   '="AssLote_' + URI + '"]';
        FxIdSignature := ' ' + FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador +
                   '="AssLote_' + URI;
      end;
    end
    else begin
      if FPrefixo3 = '' then
      begin
        xPrefixo := 'ds1:';
        xmlns := ' xmlns="';
      end
      else begin
        xPrefixo := FPrefixo3;
        xmlns := ' xmlns:' + StringReplace(FPrefixo3, ':', '', []) + '="';
      end;

      FxSignatureNode := './/' + xPrefixo + EnviarLoteRps + '/ds:Signature';

      i := pos(EnviarLoteRps + xmlns, FPDadosMsg);
      i := i + Length(EnviarLoteRps + xmlns) - 1;
      j := Pos('">', FPDadosMsg) + 1;

      FxDSIGNSLote := 'xmlns:' + StringReplace(xPrefixo, ':', '', []) + '=' +
                       Copy(FPDadosMsg, i, j - i);

      if FProvedor = proSigep then
        FxDSIGNSLote := 'xmlns:ds=';
    end;
  end;
end;

procedure TNFSeWebService.GerarLoteRPScomAssinatura(RPS: String);
begin
  case FVersaoNFSe of
    // RPS vers�o 2.00
    ve200: case FProvedor of
             proTecnos: FvNotas := FvNotas +
                         '<' + FPrefixo4 + 'Rps>' +
                          '<' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico' +
                            RetornarConteudoEntre(RPS,
                              '<' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico', '</Signature>') +
                            '</Signature>'+
                         '</' + FPrefixo4 + 'Rps>';

             proFriburgo: FvNotas := FvNotas +
                       '<' + FPrefixo4 + 'Rps>' +
                        '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico Id="' + RetornarConteudoEntre(RPS, '<Numero>', '</Numero>') + '"' +
                          RetornarConteudoEntre(RPS,
                            '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                          '</Signature>'+
                       '</' + FPrefixo4 + 'Rps>';

             proSigep: FvNotas := FvNotas +
                       '<' + FPrefixo4 + 'credenciais>' +
                          RetornarConteudoEntre(RPS,
                            '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                          '</Signature>'+
                       '</' + FPrefixo4 + 'Rps>';
           else
             FvNotas := FvNotas +
                       '<' + FPrefixo4 + 'Rps>' +
                        '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico' +
                          RetornarConteudoEntre(RPS,
                            '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                          '</Signature>'+
                       '</' + FPrefixo4 + 'Rps>';
           end;

        (*
        proSystemPro,
        proFreire: FvNotas := FvNotas +
                              '<' + FPrefixo4 + 'Rps>' +
                               '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico Id ="'+ FNotasFiscais.Items[I].NFSe.InfID.ID +'"' +
                                 RetornarConteudoEntre(RPS,
                                   '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                               '</Signature>'+
                              '</' + FPrefixo4 + 'Rps>';

    // RPS vers�o 1.10
    ve110: FvNotas := FvNotas +
                      '<' + FPrefixo4 + 'Rps ' +
                        RetornarConteudoEntre(RPS,
                          '<' + FPrefixo4 + 'Rps', '</Signature>') +
                        '</Signature>'+
                      '</' + Prefixo4 + 'Rps>';
        *)

    // RPS vers�o 1.00
    else begin
      case FProvedor of
        proEgoverneISS: FvNotas := FvNotas +
                          '<rgm:NotaFiscal' +
                            RetornarConteudoEntre(RPS,
                              '<rgm:NotaFiscal', '</Signature>') +
                            '</Signature>' +
                         '</rgm:NotaFiscal>';

        proSMARAPD: FvNotas := RPS;
      else
        FvNotas := FvNotas +
                    '<' + FPrefixo4 + 'Rps>' +
                      '<' + FPrefixo4 + 'InfRps' +
                        RetornarConteudoEntre(RPS,
                          '<' + FPrefixo4 + 'InfRps', '</Signature>') +
                        '</Signature>'+
                    '</' + FPrefixo4 + 'Rps>';
      end;
    end;
  end;
end;

procedure TNFSeWebService.GerarLoteRPSsemAssinatura(RPS: String);
var
  SRpsTmp: String;
begin
  case FVersaoNFSe of
    // RPS vers�o 2.00
    ve200: case FProvedor of
             proTecnos: FvNotas := FvNotas +
                         '<' + FPrefixo4 + 'Rps>' +
                          '<' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico' +
                            RetornarConteudoEntre(RPS,
                              '<' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico', '</' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico>') +
                            '</' + FPrefixo4 + 'tcDeclaracaoPrestacaoServico>'+
                         '</' + FPrefixo4 + 'Rps>';

             proCONAM: FvNotas := FvNotas + RPS;

             proAgiliv2: FvNotas := FvNotas +
                          '<' + FPrefixo4 + 'DeclaracaoPrestacaoServico' +
                            RetornarConteudoEntre(RPS,
                            '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>') +
                          '</' + FPrefixo4 + 'DeclaracaoPrestacaoServico>';

             proSigep: FvNotas := FvNotas +
                      '<' + FPrefixo4 + 'credenciais>' +
                          RetornarConteudoEntre(RPS,
                         '<' + FPrefixo4 + 'credenciais>' , '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>') +
//                         '</' + FPrefixo4 + 'Rps>' +
                         '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>'+
                      '</' + FPrefixo4 + 'Rps>';
           else
             FvNotas := FvNotas +
                      '<' + FPrefixo4 + 'Rps>' +
                       '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico' +
                         RetornarConteudoEntre(RPS,
                           '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>') +
                         '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>'+
                      '</' + FPrefixo4 + 'Rps>';
           end;

    // RPS vers�o 1.00
    else
    begin
      case FProvedor of
        proAgili: FvNotas := FvNotas +
                   '<' + FPrefixo4 + 'DeclaracaoPrestacaoServico' +
                     RetornarConteudoEntre(RPS,
                     '<' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico', '</' + FPrefixo4 + 'InfDeclaracaoPrestacaoServico>') +
                   '</' + FPrefixo4 + 'DeclaracaoPrestacaoServico>';

        proEL,
        proGoverna: FvNotas :=  FvNotas + RPS;

        proCTA: FvNotas := FvNotas + '<RPS xmlns=""' +
                                      RetornarConteudoEntre(RPS, '<RPS', '</RPS>') +
                                     '</RPS>';

        proSP, 
        proNotaBlu: FvNotas :=  FvNotas + '<RPS xmlns=""' +
                                      RetornarConteudoEntre(RPS, '<RPS', '</RPS>') +
                                     '</RPS>';

        proInfisc,
        proInfiscv11: FvNotas := FvNotas +
                                '<NFS-e' +
                                  RetornarConteudoEntre(RPS, '<NFS-e', '</NFS-e>') +
                                '</NFS-e>';

        proIssDSF,
        proEquiplano: FvNotas :=  FvNotas + StringReplace(RPS, '<' + ENCODING_UTF8 + '>', '', [rfReplaceAll]);

        proEgoverneISS: FvNotas := FvNotas +
                                   '<rgm:NotaFiscal>' +
                                     RetornarConteudoEntre(RPS,
                                     '<rgm:NotaFiscal>', '</rgm:NotaFiscal>') +
                                   '</rgm:NotaFiscal>';

        proNFSeBrasil: begin
                         SRpsTmp := StringReplace(RPS, '</Rps>', '', [rfReplaceAll]);
                         SRpsTmp := StringReplace(SRpsTmp, '<Rps>', '', [rfReplaceAll]);
                         FvNotas := FvNotas + '<Rps>' + StringReplace(SRpsTmp, '<InfRps>', '', [rfReplaceAll]) + '</Rps>';
                       end;

        proSMARAPD: FvNotas := RPS;
      else
        FvNotas := FvNotas +
                    '<' + FPrefixo4 + 'Rps>' +
                     '<' + FPrefixo4 + 'InfRps' +
                       RetornarConteudoEntre(RPS,
                         '<' + FPrefixo4 + 'InfRps', '</Rps>') +
                    '</' + FPrefixo4 + 'Rps>';
      end;
    end;
  end;
end;

procedure TNFSeWebService.InicializarTagITagF;
begin
  // Inicializa a TagI
  case FPLayout of
    LayNfseRecepcaoLote:
       begin
         case FProvedor of
           proABase: FTagI := '<' + FTagGrupo + FNameSpaceDad +
                                ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proEquiplano: FTagI := '<' + FTagGrupo +
                                    ' xmlns:es="http://www.equiplano.com.br/esnfs" ' +
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xsi:schemaLocation="http://www.equiplano.com.br/enfs esRecepcionarLoteRpsEnvio_v01.xsd">';

           proCONAM,
           proEL,
           proFISSLex,
           proSimplISS: FTagI := '<' + FTagGrupo + '>';

           proCTA: FTagI := '<' + FTagGrupo + ' xmlns:ns1="http://localhost:8080/WsNFe2/lote" '+
                                    'xmlns:tipos="http://localhost:8080/WsNFe2/tp" '+
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                                    'xsi:schemaLocation="http://localhost:8080/WsNFe2/lote '+
                                    'http://localhost:8080/WsNFe2/xsd/ReqEnvioLoteRPS.xsd">';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;

         if FProvedor in [proInfisc, proInfiscv11, proGoverna] then
           FTagI := '';
       end;

    LayNfseConsultaSitLoteRps:
       begin
        case FProvedor of
           proEquiplano: FTagI := '<' + FTagGrupo +
                                    ' xmlns:es="http://www.equiplano.com.br/esnfs" ' +
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xsi:schemaLocation="http://www.equiplano.com.br/enfs esConsultarSituacaoLoteRpsEnvio_v01.xsd">';

           proEL,
           proInfisc,
           proInfiscv11,
           proSimplISS: FTagI := '<' + FTagGrupo + '>';

           proSP: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://www.prefeitura.sp.gov.br/nfe" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proNotaBlu: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://nfse.blumenau.sc.gov.br" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;

         if FProvedor = proFISSLex then
           FTagI := '';

         if FProvedor in [proDBSeller] then
           FTagI := '<ConsultarSituacaoLoteRps>' + FTagI;
       end;

    LayNfseConsultaLote:
       begin
        case FProvedor of
           proAgili: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                               '<UnidadeGestora>' +
                               OnlyNumber(FPConfiguracoesNFSe.Geral.CNPJPrefeitura) +
                               '</UnidadeGestora>';

           proAgiliv2: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';

           proEquiplano: FTagI := '<' + FTagGrupo +
                                    ' xmlns:es="http://www.equiplano.com.br/esnfs" ' +
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xsi:schemaLocation="http://www.equiplano.com.br/enfs esConsultarLoteRpsEnvio_v01.xsd">';

           proEL,
           proSimplISS: FTagI := '<' + FTagGrupo + '>';

           proSP: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://www.prefeitura.sp.gov.br/nfe" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proNotaBlu: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://nfse.blumenau.sc.gov.br" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;

         if FProvedor = proFISSLex then
           FTagI := '';
       end;

    LayNfseConsultaNfseRps:
       begin
         case FProvedor of
           proEquiplano: FTagI := '<' + FTagGrupo +
                                    ' xmlns:es="http://www.equiplano.com.br/esnfs" ' +
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xsi:schemaLocation="http://www.equiplano.com.br/enfs esConsultarNfsePorRpsEnvio_v01.xsd">';

           proEL,
           proSimplISS: FTagI := '<' + FTagGrupo + '>';

           proSP: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://www.prefeitura.sp.gov.br/nfe" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proNotaBlu: FTagI := '<' + FTagGrupo +
                             ' xmlns:p1="http://nfse.blumenau.sc.gov.br" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;

         if FProvedor in [proGoverna, proFISSLex] then
           FTagI := '';

         if FProvedor in [proDBSeller] then
           FTagI := '<ConsultarNfsePorRps>' + FTagI;
       end;

    LayNfseConsultaNfse:
       begin
         case FProvedor of
           proEL,
           proInfisc,
           proInfiscv11,
           proSimplISS,
           proSP, 
           proNotaBlu: FTagI := '<' + FTagGrupo + '>';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;

         if FProvedor = proFISSLex then
           FTagI := '';
       end;

    LayNfseCancelaNfse:
       begin
         case FProvedor of
           proAgili: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                               '<UnidadeGestora>' +
                                 OnlyNumber(FPConfiguracoesNFSe.Geral.CNPJPrefeitura) +
                               '</UnidadeGestora>' +
                               '<' + FPrefixo3 + 'PedidoCancelamento>';

           proAgiliv2: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                                 '<' + FPrefixo3 + 'PedidoCancelamento>';

           proBetha: FTagI := '<Pedido>' +
                               '<' + FPrefixo4 + 'InfPedidoCancelamento' +
                                 ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                 FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';

           proEquiplano: FTagI := '<' + FTagGrupo +
                                    ' xmlns:es="http://www.equiplano.com.br/esnfs" ' +
                                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xsi:schemaLocation="http://www.equiplano.com.br/enfs esCancelarNfseEnvio_v01.xsd">';

           proGinfes: FTagI := '<' + FTagGrupo +
                                 ' xmlns="http://www.ginfes.com.br/servico_cancelar_nfse_envio"' +
                                 ' xmlns:ns4="http://www.ginfes.com.br/tipos">';

           proGoverna: FTagI := '';

           proEGoverneISS,
           proISSDSF,
           proCTA: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';

           proCONAM,
           proEL,
           proInfisc,
           proInfiscv11: FTagI := '<' + FTagGrupo + '>';

           proSP, 
           proNotaBlu: FTagI := '<' + FTagGrupo + FNameSpaceDad +
                             ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';

           proISSCuritiba: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                                     '<' + FPrefixo3 + 'Pedido>';

           proISSNet: FTagI := '<p1:' + FTagGrupo + ' xmlns:p1="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_envio.xsd" ' +
                                                    'xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd" ' +
                                                    'xmlns:ts="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_simples.xsd">' +
                                '<' + FPrefixo3 + 'Pedido>' +
                                 '<' + FPrefixo4 + 'InfPedidoCancelamento' +
                                   ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                   FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';

           proTecnos: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                                '<' + FPrefixo3 + 'Pedido>' +
                                 '<' + FPrefixo4 + 'InfPedidoCancelamento ' +
                                   FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '" ' +
                                   'xmlns="http://www.abrasf.org.br/nfse.xsd">';

           proSimplISS: FTagI := '<' + FTagGrupo + '>' +
                                  '<' + FPrefixo3 + 'Pedido' + FNameSpaceDad + '>' +
                                   '<' + FPrefixo4 + 'InfPedidoCancelamento' +
                                     ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                     FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';

           proSpeedGov: FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                                  '<Pedido>' +
                                   '<' + FPrefixo4 + 'InfPedidoCancelamento ' +
                                     FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '">';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>' +
                     '<' + FPrefixo3 + 'Pedido>' +
                      '<' + FPrefixo4 + 'InfPedidoCancelamento' +
                        ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                        FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';
         end;

         if FProvedor in [proDBSeller] then
           FTagI := '<CancelarNfse>' + FTagI;
       end;

    LayNfseGerar:
       begin
         case FProvedor of
     //      proEGoverneISS: FTagI := '<' + FTagGrupo + ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
     //                                                ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
           proEGoverneISS,
           proSimplISS: FTagI := '<' + FTagGrupo + '>';

           proSMARAPD: FTagI := '';
         else
           FTagI := '<' + FTagGrupo + FNameSpaceDad + '>';
         end;
       end;

    LayNfseRecepcaoLoteSincrono: FTagI := '<' + FPrefixo3 + 'EnviarLoteRpsSincronoEnvio' + FNameSpaceDad + '>';

    LayNfseSubstituiNfse:
       begin
         case FProvedor of
           proAgili: FTagI := '<' + FPrefixo3 + 'SubstituirNfseEnvio' + FNameSpaceDad + '>' +
                               '<UnidadeGestora>' +
                                OnlyNumber(FPConfiguracoesNFSe.Geral.CNPJPrefeitura) +
                               '</UnidadeGestora>' +
                              '<' + FPrefixo4 + 'PedidoCancelamento' +
                               ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                      FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';

           proAgiliv2: FTagI := '<' + FPrefixo3 + 'SubstituirNfseEnvio' + FNameSpaceDad + '>' +
                                '<' + FPrefixo4 + 'PedidoCancelamento' +
                                 ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                        FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';

           proSMARAPD: FTagI := '';
         else begin
                FTagI := '<' + FPrefixo3 + 'SubstituirNfseEnvio' + FNameSpaceDad + '>' +
                          '<' + FPrefixo3 + 'SubstituicaoNfse>' +
                           '<' + FPrefixo3 + 'Pedido>' +
                            '<' + FPrefixo4 + 'InfPedidoCancelamento' +
                              ifThen(FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador <> '', ' ' +
                                     FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador + '="' + FURI + '"', '') + '>';
              end;
         end;
       end;

    LayNfseAbrirSessao: FTagI := '';

    LayNfseFecharSessao: FTagI := '';
  end;

  // Inicializa a TagF
  case FPLayout of
    LayNfseRecepcaoLote:
       begin
         FTagF := '</' + FTagGrupo + '>';

         if FProvedor in [proInfisc, proInfiscv11, proGoverna, proSMARAPD] then
           FTagF := '';
       end;

    LayNfseConsultaSitLoteRps:
       begin
         FTagF := '</' + FTagGrupo + '>';

         if FProvedor in [proFISSLex, proSMARAPD] then
           FTagF := '';

         if FProvedor in [proDBSeller] then
           FTagF := FTagF + '</ConsultarSituacaoLoteRps>';
       end;

    LayNfseConsultaLote:
       begin
         FTagF := '</' + FTagGrupo + '>';

         if FProvedor in [proFISSLex, proSMARAPD] then
           FTagF := '';
       end;

    LayNfseConsultaNfseRps:
       begin
         FTagF := '</' + FTagGrupo + '>';

         if FProvedor in [proGoverna, proFISSLex, proSMARAPD] then
           FTagF := '';

         if FProvedor in [proDBSeller] then
           FTagF := FTagF + '</ConsultarNfsePorRps>';
       end;

    LayNfseConsultaNfse:
       begin
         FTagF := '</' + FTagGrupo + '>';

         if FProvedor in [proFISSLex, proSMARAPD] then
           FTagF := '';
       end;

    LayNfseCancelaNfse:
       begin
         case FProvedor of
           proAgili,
           proAgiliv2: FTagF :=  '</' + FPrefixo3 + 'PedidoCancelamento>' +
                                '</' + FTagGrupo + '>';

           proBetha: FTagF := '</Pedido>';

           proGoverna,
           proSMARAPD: FTagF := '';

           proEquiplano,
           proGinfes,
           proEGoverneISS,
           proISSDSF,
           proCONAM,
           proEL,
           proInfisc,
           proInfiscv11,
           proSP, 
           proNotaBlu,
           proCTA: FTagF := '</' + FTagGrupo + '>';

           proISSNet: FTagF :=  '</' + FPrefixo3 + 'Pedido>' +
                               '</p1:' + FTagGrupo + '>';

           proSpeedGov: FTagF :=  '</Pedido>' +
                                 '</' + FTagGrupo + '>';

         else
           FTagF :=  '</' + FPrefixo3 + 'Pedido>' +
                    '</' + FTagGrupo + '>';
         end;

         if FProvedor in [proDBSeller] then
           FTagF := FTagF + '</CancelarNfse>';
       end;

    LayNfseGerar: FTagF := '</' + FTagGrupo + '>';

    LayNfseRecepcaoLoteSincrono: FTagF := '</' + FPrefixo3 + 'EnviarLoteRpsSincronoEnvio>';

    LayNfseSubstituiNfse:
       begin
         case FProvedor of
           proAgili,
           proAgiliv2: FTagF := '</' + FPrefixo3 + 'SubstituirNfseEnvio>';

           proSMARAPD: FTagF := '';
         else
           FTagF :=  '</' + FPrefixo3 + 'SubstituicaoNfse>' +
                    '</' + FPrefixo3 + 'SubstituirNfseEnvio>';
         end;
       end;

    LayNfseAbrirSessao: FTagF := '';

    LayNfseFecharSessao: FTagF := '';
  end;
end;

procedure TNFSeWebService.InicializarGerarDadosMsg;
begin
  with GerarDadosMsg do
  begin
    Provedor      := FProvedor;
    VersaoNFSe    := FVersaoNFSe;
    Prefixo3      := FPrefixo3;
    Prefixo4      := FPrefixo4;
    NameSpaceDad  := FNameSpaceDad;
    VersaoXML     := FVersaoXML;
    CodMunicipio  := FPConfiguracoesNFSe.Geral.CodigoMunicipio;
    Identificador := FPConfiguracoesNFSe.Geral.ConfigGeral.Identificador;
    VersaoDados   := FPConfiguracoesNFSe.Geral.ConfigXML.VersaoDados;

    UserWeb        := FPConfiguracoesNFSe.Geral.UserWeb;
    SenhaWeb       := FPConfiguracoesNFSe.Geral.SenhaWeb;
    CNPJPrefeitura := OnlyNumber(FPConfiguracoesNFSe.Geral.CNPJPrefeitura);

    // Dados do Emitente
    CNPJ := FPConfiguracoesNFSe.Geral.Emitente.CNPJ;
    if CNPJ = '' then
      GerarException(ACBrStr('O CNPJ n�o informado em: Configuracoes.Geral.Emitente.CNPJ'));
    IM := FPConfiguracoesNFSe.Geral.Emitente.InscMun;
    if (IM = '') and (not (Provedor in [proBetha, proBethav2])) then
      GerarException(ACBrStr('A I.M. n�o informada em: Configuracoes.Geral.Emitente.InscMun'));
    RazaoSocial := FPConfiguracoesNFSe.Geral.Emitente.RazSocial;
    if RazaoSocial = '' then
      GerarException(ACBrStr('A Raz�o Social n�o informada em: Configuracoes.Geral.Emitente.RazSocial'));

    Senha        := FPConfiguracoesNFSe.Geral.Emitente.WebSenha;
    FraseSecreta := FPConfiguracoesNFSe.Geral.Emitente.WebFraseSecr;

    ChaveAcessoPrefeitura := FPConfiguracoesNFSe.Geral.Emitente.WebChaveAcesso;
  end;
end;

function TNFSeWebService.ExtrairGrupoMsgRet(AGrupo: String): String;
var
  aMsgRet: String;
begin
  Result := FPRetWS;

  if AGrupo <> '' then
  begin
    aMsgRet := SeparaDados(FPRetWS, AGrupo);

    if aMsgRet <> '' then
      Result := aMsgRet;
  end;
end;

procedure TNFSeWebService.IncluirEncoding(Incluir: Boolean);
begin
  FPDadosMsg := StringReplace(FPDadosMsg, '<' + ENCODING_UTF8 + '>', '', [rfReplaceAll]);
  if Incluir then
    FPDadosMsg := '<' + ENCODING_UTF8 + '>' + FPDadosMsg;
end;

{ TNFSeGerarLoteRPS }

constructor TNFSeGerarLoteRPS.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner, ANotasFiscais);
end;

destructor TNFSeGerarLoteRPS.Destroy;
begin
  inherited Destroy;
end;

procedure TNFSeGerarLoteRPS.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeRecepcao;
  FPLayout := LayNFSeRecepcaoLote;
  FPArqEnv := 'lot-rps';
  FPArqResp := ''; // O lote � apenas gerado n�o h� retorno de envio.
end;

procedure TNFSeGerarLoteRPS.DefinirURL;
begin
  inherited DefinirURL;
end;

procedure TNFSeGerarLoteRPS.DefinirDadosMsg;
begin
  TNFSeEnviarLoteRPS(Self).FNumeroLote := NumeroLote;

  inherited DefinirDadosMsg;
end;

function TNFSeGerarLoteRPS.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FNotasFiscais.Items[0].NomeArq := FPConfiguracoes.Arquivos.PathSalvar +
                                  GerarPrefixoArquivo + '-' + FPArqEnv + '.xml';
  Result := True;
end;

procedure TNFSeGerarLoteRPS.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeGerarLoteRPS.GerarMsgLog: String;
begin
  Result := inherited GerarMsgLog;
end;

function TNFSeGerarLoteRPS.GerarPrefixoArquivo: String;
begin
  Result := inherited GerarPrefixoArquivo;
end;

function TNFSeGerarLoteRPS.Executar: Boolean;
begin
  InicializarServico;
  try
    DefinirDadosMsg;
    DefinirEnvelopeSoap;
    SalvarEnvio;
    TratarResposta;
  finally
    FinalizarServico;
  end;
  Result := True;
end;

{ TNFSeEnviarLoteRPS }

constructor TNFSeEnviarLoteRPS.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeEnviarLoteRPS.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  if Assigned(FRetEnvLote) then
    FRetEnvLote.Free;

  inherited Destroy;
end;

procedure TNFSeEnviarLoteRPS.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeRecepcao;
  FPLayout := LayNFSeRecepcaoLote;
  FPArqEnv := 'env-lot';
  FPArqResp := 'rec';

  FProtocolo := '';
  
  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeEnviarLoteRPS.DefinirURL;
begin
  FPLayout := LayNFSeRecepcaoLote;
  
  inherited DefinirURL;
end;

procedure TNFSeEnviarLoteRPS.DefinirServicoEAction;
begin
  FPServico := 'EnviarLoteRPS';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.Recepcionar;

  inherited DefinirServicoEAction;
end;

procedure TNFSeEnviarLoteRPS.DefinirDadosMsg;
var
  I, iTributos: Integer;
  dDataInicial, dDataFinal: TDateTime;
  TotalServicos, TotalDeducoes, TotalISS,
  TotalTributos, TotalISSRetido: Double;
  TagElemento: String;
begin
  if FNotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum RPS adicionado ao Lote'));

  if FNotasFiscais.Count > 50 then
    GerarException(ACBrStr('ERRO: Conjunto de RPS transmitidos (m�ximo de 50 RPS)' +
      ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoEnviar;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case Provedor of
      proCONAM:     FTagGrupo := 'ws_nfe.PROCESSARPS';

      proInfisc,
      proInfiscv11: FTagGrupo := 'envioLote';

      proISSDSF,
      proCTA:       FTagGrupo := 'ReqEnvioLoteRPS';

      proEquiplano: FTagGrupo := 'enviarLoteRpsEnvio';

      proSP, 
      proNotaBlu:   FTagGrupo := 'PedidoEnvioLoteRPS';

      proSMARAPD:   FTagGrupo := '';

//      proTinus:     FTagGrupo := 'Arg';
    else
      FTagGrupo := 'EnviarLoteRpsEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    case FProvedor of
      proCONAM:     TagElemento := 'Reg20';

      proInfisc,
      proinfiscv11: TagElemento := 'infNFSe';

      proSP, 
      proNotaBlu:   TagElemento := '';

      proSMARAPD:   TagElemento := 'nfd';

      proIssDSF,
      proCTA:       TagElemento := 'Lote';
    else
      TagElemento := 'LoteRps';
    end;

    if (TagElemento <> '') and not (Provedor in [proBetha, proBethav2, proIssDSF, proCTA]) then
      TagElemento := FPrefixo3 + TagElemento;

    if FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS then
    begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPScomAssinatura(FNotasFiscais.Items[I].XMLAssinado);
    end
    else begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPSsemAssinatura(FNotasFiscais.Items[I].XMLOriginal);
    end;

    InicializarTagITagF;

    dDataInicial   := FNotasFiscais.Items[0].NFSe.DataEmissao;
    dDataFinal     := dDataInicial;
    iTributos      := 0;
    TotalServicos  := 0.0;
    TotalDeducoes  := 0.0;
    TotalISS       := 0.0;
    TotalISSRetido := 0.0;
    TotalTributos  := 0.0;

    for i := 0 to FNotasFiscais.Count-1 do
    begin
      if FNotasFiscais.Items[i].NFSe.DataEmissao < dDataInicial then
        dDataInicial := FNotasFiscais.Items[i].NFSe.DataEmissao;
      if FNotasFiscais.Items[i].NFSe.DataEmissao > dDataFinal then
        dDataFinal := FNotasFiscais.Items[i].NFSe.DataEmissao;

      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaPis > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaCofins > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaCsll > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaInss > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaIr > 0 then
        iTributos := iTributos + 1;

      TotalServicos  := TotalServicos + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorServicos;
      TotalDeducoes  := TotalDeducoes + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorDeducoes;
      TotalISS       := TotalISS + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIss;
      TotalISSRetido := TotalISSRetido + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIssRetido;
      TotalTributos  := TotalTributos + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIr
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorCofins
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorPis
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorInss
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorCsll;
    end;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroLote := FNumeroLote;
      QtdeNotas  := FNotasFiscais.Count;
      Notas      := FvNotas;

      // Necess�rio para o provedor ISSDSF
      Transacao   := FNotasFiscais.Transacao;
      DataInicial := dDataInicial;
      DataFinal   := dDataFinal;

      ValorTotalServicos := TotalServicos;
      ValorTotalDeducoes := TotalDeducoes;

      // Necess�rio para o provedor Equiplano - EL
      NumeroRps      := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
      SerieRps       := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Serie;
      OptanteSimples := FNotasFiscais.Items[0].NFSe.OptanteSimplesNacional;

      if FProvedor = proCTA then
        ChaveAcessoPrefeitura := FPConfiguracoesNFSe.Geral.Emitente.WebChaveAcesso
      else // Necess�rio para o provedor Governa
        ChaveAcessoPrefeitura := FNotasFiscais.Items[0].NFSe.Prestador.ChaveAcesso;

      if FProvedor = proCONAM then
      begin
        AliquotaIss    := FNotasFiscais.Items[0].NFSe.Servico.Valores.Aliquota;
        TipoTributacao := '4';
        QtdTributos    := iTributos;
        ValorNota      := TotalServicos;
        ValorIss       := TotalIss;
        ValorIssRetido := TotalIssRetido;
        ValorTotalDeducoes := TotalDeducoes;
        ValorTotalTributos := TotalTributos;
        {Todo:// Acrescentados estas duas linhas abaixo por masl}
        ExigibilidadeISS := FNotasFiscais.Items[0].NFSe.Servico.ExigibilidadeISS;
        DataOptanteSimples := FNotasFiscais.Items[0].NFSe.DataOptanteSimplesNacional;
      end;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    if FProvedor = proEL then
    begin
      FPDadosMsg := GerarDadosMsg.Gera_DadosMsgEnviarLote;
      FPDadosMsg := StringReplace(FPDadosMsg, '<' + ENCODING_UTF8 + '>', '', [rfReplaceAll]);
      FPDadosMsg := FTagI +
                     '<identificacaoPrestador>' +
                       FPConfiguracoesNFSe.Geral.Emitente.CNPJ +
                     '</identificacaoPrestador>' +
                     '<hashIdentificador>' +
                       FHashIdent +
                     '</hashIdentificador>' +
                     '<arquivo>' +
                       StringReplace(StringReplace(FPDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                     '</arquivo>' +
                    FTagF;
    end
    else
      FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgEnviarLote + FTagF;

  finally
    GerarDadosMsg.Free;
  end;

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar;

  if (FProvedor = proThema) and (FNotasFiscais.Count < 4) then
  begin
    FDadosEnvelope := StringReplace(FDadosEnvelope, 'recepcionarLoteRps', 'recepcionarLoteRpsLimitado', [rfReplaceAll]);
    FPSoapAction := StringReplace(FPSoapAction, 'recepcionarLoteRps', 'recepcionarLoteRpsLimitado', [rfReplaceAll]);
  end;

  if (FPDadosMsg <> '') and (FDadosEnvelope <> '') then
  begin
    DefinirSignatureNode('');

    FPDadosMsg := FNotasFiscais.AssinarLote(FPDadosMsg, FTagGrupo, TagElemento,
                                   FPConfiguracoesNFSe.Geral.ConfigAssinar.Lote,
                                   xSignatureNode, xDSIGNSLote, xIdSignature);

    // Incluido a linha abaixo por ap�s realizar a assinatura esta gerando o
    // atributo xmlns vazio.
    if not (FProvedor in [proSP, proNotaBlu]) then
      FPDadosMsg := StringReplace(FPDadosMsg, 'xmlns=""', '', [rfReplaceAll]);

    if FProvedor = proSMARAPD then
      FPDadosMsg := StringReplace(FPDadosMsg, '<?xml version="1.0" encoding="UTF-8"?>', '', [rfReplaceAll]);

    if FPConfiguracoesNFSe.Geral.ConfigSchemas.Validar then
      FNotasFiscais.ValidarLote(FPDadosMsg,
                         FPConfiguracoes.Arquivos.PathSchemas +
                         FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoEnviar);
  end
  else
    GerarException(ACBrStr('A funcionalidade [Enviar Lote] n�o foi disponibilizada pelo provedor: ' +
      FPConfiguracoesNFSe.Geral.xProvedor));

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar_IncluiEncodingDados);

  // Lote tem mais de 500kb ? //
  if Length(FPDadosMsg) > (500 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));
end;

function TNFSeEnviarLoteRPS.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  if Assigned(FRetEnvLote) then
    FreeAndNil(FRetEnvLote);
  FRetEnvLote := TRetEnvLote.Create;

  FRetEnvLote.Leitor.Arquivo := FPRetWS;
  FRetEnvLote.Provedor := FProvedor;
  FRetEnvLote.LerXml;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Recepcionar);

  FDataRecebimento := RetEnvLote.InfRec.DataRecebimento;
  FProtocolo       := RetEnvLote.InfRec.Protocolo;
  if RetEnvLote.InfRec.NumeroLote <> '' then
    FNumeroLote := RetEnvLote.InfRec.NumeroLote;

  // Lista de Mensagem de Retorno
  FPMsg := '';
  FaMsg := '';

  if FProtocolo <> '' then
  begin
    for i := 0 to FNotasFiscais.Count -1 do
    begin
      FNotasFiscais.Items[i].NFSe.Protocolo     := FProtocolo;
      FNotasFiscais.Items[i].NFSe.dhRecebimento := FDataRecebimento;
      if FProvedor = proGoverna then
        FNotasFiscais.Items[i].NFSe.Numero := RetEnvLote.InfRec.ListaChaveNFeRPS[I].ChaveNFeRPS.Numero;
 
      if FProvedor in [proCTA, proSP, ProNotaBlu] then
      if (FProvedor in [proCTA, proSP]) or
         ( (FProvedor = ProNotaBlu) and
           (RetEnvLote.InfRec.InformacoesLote.QtdNotasProcessadas > 0) ) then
      begin
        FNotasFiscais.Items[i].NFSe.Numero := RetEnvLote.InfRec.ListaChaveNFeRPS[I].ChaveNFeRPS.Numero;
        FNotasFiscais.Items[i].NFSe.CodigoVerificacao := RetEnvLote.InfRec.ListaChaveNFeRPS[I].ChaveNFeRPS.CodigoVerificacao;
        FNotasFiscais.Items[i].NFSe.NumeroLote := RetEnvLote.InfRec.NumeroLote;
      end;
    end;
    FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
             'Numero do Lote : ' + RetEnvLote.InfRec.NumeroLote + LineBreak +
             'Recebimento... : ' + IfThen(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
             'Protocolo..... : ' + FProtocolo + LineBreak +
             'Provedor...... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
  end;

  if FProvedor in [proSP, ProNotaBlu] then
    Result := UpperCase(RetEnvLote.infRec.Sucesso) = UpperCase('true')
  else
    Result := (RetEnvLote.InfRec.Protocolo <> '');

  if RetEnvLote.InfRec.MsgRetorno.Count > 0 then
  begin
    for i := 0 to RetEnvLote.InfRec.MsgRetorno.Count - 1 do
    begin
      if (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'L000') and
         (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'A0000') then
      begin
        FPMsg := FPMsg + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                         RetEnvLote.infRec.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;

        if FProvedor = proDBSeller then
          Result := False;
      end;
    end;
  end;
end;

procedure TNFSeEnviarLoteRPS.FinalizarServico;
begin
  inherited FinalizarServico;

//  if Assigned(FRetornoNFSe) then
//    FreeAndNil(FRetornoNFSe);
end;

function TNFSeEnviarLoteRPS.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeEnviarLoteRPS.GerarPrefixoArquivo: String;
begin
  Result := NumeroLote;
end;

{ TNFSeTesteEnvioLoteRPS }

procedure TNFSeTesteEnvioLoteRPS.DefinirDadosMsg;
var
  I, iTributos: Integer;
  dDataInicial, dDataFinal: TDateTime;
  TotalServicos, TotalDeducoes, TotalISS,
  TotalTributos, TotalISSRetido: Double;
  TagElemento: String;
begin

  if FNotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum RPS adicionado ao Lote'));

  if FNotasFiscais.Count > 50 then
    GerarException(ACBrStr('ERRO: Conjunto de RPS transmitidos (m�ximo de 50 RPS)' +
      ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Teste_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Teste_DadosStr;
  //Para o teste o schema � o mesmo do Envio
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoTeste;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Teste_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case Provedor of
      proNotaBlu: FTagGrupo := 'PedidoEnvioLoteRPS';
      proSigep:   FTagGrupo := 'Rps';
    else
      FTagGrupo := 'EnviarLoteRpsEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    case FProvedor of
      proSP, proNotaBlu: TagElemento := '';
    else
      TagElemento := 'LoteRps';
    end;

    if (TagElemento <> '') and not (Provedor in [proBetha, proBethav2, proIssDSF, proCTA]) then
      TagElemento := FPrefixo3 + TagElemento;

    if FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS then
    begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPScomAssinatura(FNotasFiscais.Items[I].XMLAssinado);
    end
    else begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPSsemAssinatura(FNotasFiscais.Items[I].XMLOriginal);
    end;

    InicializarTagITagF;

    dDataInicial   := FNotasFiscais.Items[0].NFSe.DataEmissao;
    dDataFinal     := dDataInicial;
    iTributos      := 0;
    TotalServicos  := 0.0;
    TotalDeducoes  := 0.0;
    TotalISS       := 0.0;
    TotalISSRetido := 0.0;
    TotalTributos  := 0.0;

    for i := 0 to FNotasFiscais.Count-1 do
    begin
      if FNotasFiscais.Items[i].NFSe.DataEmissao < dDataInicial then
        dDataInicial := FNotasFiscais.Items[i].NFSe.DataEmissao;
      if FNotasFiscais.Items[i].NFSe.DataEmissao > dDataFinal then
        dDataFinal := FNotasFiscais.Items[i].NFSe.DataEmissao;

      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaPis > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaCofins > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaCsll > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaInss > 0 then
        iTributos := iTributos + 1;
      if FNotasFiscais.Items[i].NFSe.Servico.Valores.AliquotaIr > 0 then
        iTributos := iTributos + 1;

      TotalServicos  := TotalServicos + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorServicos;
      TotalDeducoes  := TotalDeducoes + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorDeducoes;
      TotalISS       := TotalISS + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIss;
      TotalISSRetido := TotalISSRetido + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIssRetido;
      TotalTributos  := TotalTributos + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorIr
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorCofins
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorPis
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorInss
                                      + FNotasFiscais.Items[i].NFSe.Servico.Valores.ValorCsll;
    end;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroLote := FNumeroLote;
      QtdeNotas  := FNotasFiscais.Count;
      Notas      := FvNotas;

      // Necess�rio para o provedor ISSDSF
      Transacao   := FNotasFiscais.Transacao;
      DataInicial := dDataInicial;
      DataFinal   := dDataFinal;

      ValorTotalServicos := TotalServicos;
      ValorTotalDeducoes := TotalDeducoes;

      // Necess�rio para o provedor Equiplano - EL
      NumeroRps      := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
      SerieRps       := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Serie;
      OptanteSimples := FNotasFiscais.Items[0].NFSe.OptanteSimplesNacional;

      if FProvedor = proCTA then
        ChaveAcessoPrefeitura := FPConfiguracoesNFSe.Geral.Emitente.WebChaveAcesso
      else // Necess�rio para o provedor Governa
        ChaveAcessoPrefeitura := FNotasFiscais.Items[0].NFSe.Prestador.ChaveAcesso;

      if FProvedor = proCONAM then
      begin
        AliquotaIss    := FNotasFiscais.Items[0].NFSe.Servico.Valores.Aliquota;
        TipoTributacao := '4';
        QtdTributos    := iTributos;
        ValorNota      := TotalServicos;
        ValorIss       := TotalIss;
        ValorIssRetido := TotalIssRetido;
        ValorTotalDeducoes := TotalDeducoes;
        ValorTotalTributos := TotalTributos;
        {Todo:// Acrescentados estas duas linhas abaixo por masl}
        ExigibilidadeISS := FNotasFiscais.Items[0].NFSe.Servico.ExigibilidadeISS;
        DataOptanteSimples := FNotasFiscais.Items[0].NFSe.DataOptanteSimplesNacional;
      end;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgEnviarLote + FTagF;

  finally
    GerarDadosMsg.Free;
  end;

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Teste;

  if (FPDadosMsg <> '') and (FDadosEnvelope <> '') then
  begin
    DefinirSignatureNode('');

    FPDadosMsg := FNotasFiscais.AssinarLote(FPDadosMsg, FTagGrupo, TagElemento,
                                   FPConfiguracoesNFSe.Geral.ConfigAssinar.Lote,
                                   xSignatureNode, xDSIGNSLote, xIdSignature);

    if FPConfiguracoesNFSe.Geral.ConfigSchemas.Validar then
      FNotasFiscais.ValidarLote(FPDadosMsg,
                         FPConfiguracoes.Arquivos.PathSchemas +
                         FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoEnviar);
  end
  else
    GerarException(ACBrStr('A funcionalidade [Enviar Lote] n�o foi disponibilizada pelo provedor: ' +
      FPConfiguracoesNFSe.Geral.xProvedor));

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Recepcionar_IncluiEncodingDados);

  // Lote tem mais de 500kb ? //
  if Length(FPDadosMsg) > (500 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));

end;

procedure TNFSeTesteEnvioLoteRPS.DefinirServicoEAction;
begin
  inherited DefinirServicoEAction;

  FPServico := 'TesteEnvioLoteRPS';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.Teste;

end;

function TNFSeTesteEnvioLoteRPS.TratarResposta: Boolean;
var
  i : Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  if Assigned(FRetEnvLote) then
    FreeAndNil(FRetEnvLote);
  FRetEnvLote := TRetEnvLote.Create;

  FRetEnvLote.Leitor.Arquivo := FPRetWS;
  FRetEnvLote.Provedor := FProvedor;
  FRetEnvLote.LerXml;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Recepcionar);

  FDataRecebimento := RetEnvLote.InfRec.DataRecebimento;
  FProtocolo       := RetEnvLote.InfRec.Protocolo;
  if RetEnvLote.InfRec.NumeroLote <> '' then
    FNumeroLote := RetEnvLote.InfRec.NumeroLote;

  // Lista de Mensagem de Retorno
  FPMsg := '';
  FaMsg := '';

  if FProtocolo <> '' then
  begin
    FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
             'Numero do Lote : ' + RetEnvLote.InfRec.NumeroLote + LineBreak +
             'Recebimento... : ' + IfThen(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
             'Protocolo..... : ' + FProtocolo + LineBreak +
             'Provedor...... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
  end;

  Result := UpperCase(RetEnvLote.infRec.Sucesso) = UpperCase('true');

  if RetEnvLote.InfRec.MsgRetorno.Count > 0 then
  begin
    for i := 0 to RetEnvLote.InfRec.MsgRetorno.Count - 1 do
    begin
      if (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'L000') and
         (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'A0000') then
      begin
        FPMsg := FPMsg + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                         RetEnvLote.infRec.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;

      end;
    end;
  end;
end;

{ TNFSeEnviarSincrono }

constructor TNFSeEnviarSincrono.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeEnviarSincrono.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  if Assigned(FRetEnvLote) then
    FRetEnvLote.Free;

  inherited Destroy;
end;

procedure TNFSeEnviarSincrono.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeRecepcao;
  FPLayout := LayNFSeRecepcaoLoteSincrono;
  FPArqEnv := 'env-lotS';
  FPArqResp := 'recS';

  FProtocolo := '';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeEnviarSincrono.DefinirURL;
begin
  FPLayout := LayNFSeRecepcaoLoteSincrono;

  inherited DefinirURL;
end;

procedure TNFSeEnviarSincrono.DefinirServicoEAction;
begin
  FPServico :=  'NFSeEnviarSincrono';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.RecSincrono;

  inherited DefinirServicoEAction;
end;

procedure TNFSeEnviarSincrono.DefinirDadosMsg;
var
  I: Integer;
  TagElemento: String;
begin
  if FNotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum RPS adicionado ao Lote'));

  if FNotasFiscais.Count > 50 then
    GerarException(ACBrStr('ERRO: Conjunto de RPS transmitidos (m�ximo de 50 RPS)' +
      ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.RecSincrono_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.RecSincrono_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoEnviarSincrono;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.RecSincrono_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proIssDSF: TagElemento := 'Lote';
    else
      TagElemento := 'LoteRps';
    end;

    if (TagElemento <> '') and not (Provedor in [proBetha, proBethav2, proIssDSF]) then
      TagElemento := FPrefixo3 + TagElemento;

    if FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS then
    begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPScomAssinatura(FNotasFiscais.Items[I].XMLAssinado);
    end
    else begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPSsemAssinatura(FNotasFiscais.Items[I].XMLOriginal);
    end;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroLote := FNumeroLote; 
      QtdeNotas  := FNotasFiscais.Count;
      Notas      := FvNotas;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgEnviarSincrono + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.RecSincrono;

  if (FPDadosMsg <> '') and (FDadosEnvelope <> '') then
  begin
    DefinirSignatureNode('Sincrono');

    FPDadosMsg := TNFSeEnviarSincrono(Self).FNotasFiscais.AssinarLote(FPDadosMsg,
                                  FPrefixo3 + 'EnviarLoteRpsSincronoEnvio',
                                  TagElemento,
                                  FPConfiguracoesNFSe.Geral.ConfigAssinar.Lote,
                                  xSignatureNode, xDSIGNSLote, xIdSignature);

    if FPConfiguracoesNFSe.Geral.ConfigSchemas.Validar then
      TNFSeEnviarSincrono(Self).FNotasFiscais.ValidarLote(FPDadosMsg,
                 FPConfiguracoes.Arquivos.PathSchemas +
                 FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoEnviarSincrono);
   end
   else
     GerarException(ACBrStr('A funcionalidade [Enviar Sincrono] n�o foi disponibilizada pelo provedor: ' +
      FPConfiguracoesNFSe.Geral.xProvedor));

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.RecSincrono_IncluiEncodingDados);

  // Lote tem mais de 500kb ? //
  if Length(FPDadosMsg) > (500 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));
end;

function TNFSeEnviarSincrono.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPMsg := '';
  FaMsg := '';

  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  FNotaRetornada := (Pos('CompNfse', FPRetWS) > 0);

  if FNotaRetornada then
  begin
    FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Gerar);
    Result := ExtrairNotasRetorno;
  end
  else
  begin
    if Assigned(FRetEnvLote) then
      FreeAndNil(FRetEnvLote);
    FRetEnvLote := TRetEnvLote.Create;

    FRetEnvLote.Leitor.Arquivo := FPRetWS;
    FRetEnvLote.Provedor := FProvedor;
    FRetEnvLote.LerXml;

    FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.RecSincrono);

    FDataRecebimento := RetEnvLote.InfRec.DataRecebimento;
    FProtocolo       := RetEnvLote.InfRec.Protocolo;
    if RetEnvLote.InfRec.NumeroLote <> '' then
      FNumeroLote := RetEnvLote.InfRec.NumeroLote;

    // Lista de Mensagem de Retorno

    if FProtocolo <> '' then
    begin
      for i := 0 to FNotasFiscais.Count -1 do
      begin
        FNotasFiscais.Items[i].NFSe.Protocolo     := FProtocolo;
        FNotasFiscais.Items[i].NFSe.dhRecebimento := FDataRecebimento;
      end;
      FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
               'Numero do Lote : ' + RetEnvLote.InfRec.NumeroLote + LineBreak +
               'Recebimento... : ' + IfThen(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
               'Protocolo..... : ' + FProtocolo + LineBreak +
               'Provedor...... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
    end;

    if RetEnvLote.InfRec.MsgRetorno.Count > 0 then
    begin
      for i := 0 to RetEnvLote.InfRec.MsgRetorno.Count - 1 do
      begin
        if (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'L000') and
           (RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo <> 'A0000') then
        begin
          FPMsg := FPMsg + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                           RetEnvLote.infRec.MsgRetorno.Items[i].Correcao + LineBreak;

          FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                           'C�digo Erro : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Codigo + LineBreak +
                           'Mensagem... : ' + RetEnvLote.infRec.MsgRetorno.Items[i].Mensagem + LineBreak +
                           'Corre��o... : ' + RetEnvLote.InfRec.MsgRetorno.Items[i].Correcao + LineBreak +
                           'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
        end;
      end;
    end;

    Result := (RetEnvLote.InfRec.Protocolo <> '');
  end;
end;

procedure TNFSeEnviarSincrono.FinalizarServico;
begin
  inherited FinalizarServico;

//  if Assigned(FRetornoNFSe) then
//    FreeAndNil(FRetornoNFSe);
end;

function TNFSeEnviarSincrono.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeEnviarSincrono.GerarPrefixoArquivo: String;
begin
  Result := NumeroLote;
end;

{ TNFSeGerarNFSe }

constructor TNFSeGerarNFSe.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeGerarNFSe.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeGerarNFSe.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeRecepcao;
  FPLayout := LayNFSeGerar;
  FPArqEnv := 'ger-nfse';
  FPArqResp := 'lista-nfse';

  FProtocolo := '';
  FSituacao := '';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeGerarNFSe.DefinirURL;
begin
  FPLayout := LayNFSeGerar;
  
  inherited DefinirURL;
end;

procedure TNFSeGerarNFSe.DefinirServicoEAction;
begin
  FPServico :=  'NFSeGerarNFSe';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.Gerar;

  inherited DefinirServicoEAction;
end;

procedure TNFSeGerarNFSe.DefinirDadosMsg;
var
  I: Integer;
  TagElemento: String;
begin
  if FNotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhum RPS adicionado ao componente'));

  if FProvedor in [proBHISS, proWebISS, proWebISSv2] then
  begin
    if FNotasFiscais.Count > 3 then
      GerarException(ACBrStr('ERRO: Conjunto de RPS transmitidos (m�ximo de 3 RPS)' +
        ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));
  end
  else begin
    if FNotasFiscais.Count > 1 then
      GerarException(ACBrStr('ERRO: Conjunto de RPS transmitidos (m�ximo de 1 RPS)' +
        ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));
  end;

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Gerar_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Gerar_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoGerar;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Gerar_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proSimplISS:    FTagGrupo := 'GerarNovaNfseEnvio';

      proEGoverneISS: FTagGrupo := 'request';

      //proPublica:     FTagGrupo := 'Rps></GerarNfseEnvio';

      proSP,
      proNotaBlu:     FTagGrupo := 'PedidoEnvioRPS';
    else
      FTagGrupo := 'GerarNfseEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    case FProvedor of
      proBHISS:       TagElemento := 'LoteRps';

      proEGoverneISS: TagElemento := 'rgm:NotaFiscal';

      proSP, 
      proNotaBlu:     TagElemento := '';
    else
      TagElemento := 'Rps';
    end;

    if not (FProvedor in [proEGoverneISS]) then
      TagElemento := FPrefixo3 + TagElemento;

    if FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS or FPConfiguracoesNFSe.Geral.ConfigAssinar.RpsGerar then
    begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPScomAssinatura(FNotasFiscais.Items[I].XMLAssinado);
    end
    else begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPSsemAssinatura(FNotasFiscais.Items[I].XMLOriginal);
    end;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroRps  := FNumeroRps;
      NumeroLote := FNumeroLote;
      QtdeNotas  := FNotasFiscais.Count;
      Notas      := FvNotas;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgGerarNFSe + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Gerar;

  if (FPDadosMsg <> '') and (FDadosEnvelope <> '') then
  begin
    DefinirSignatureNode('');

    case FProvedor of
      proBethav2,
      proPublica: FTagGrupo := FPrefixo3 + 'Rps></GerarNfseEnvio';

      proSigep: FTagGrupo := FPrefixo3 + 'Rps></' + FPrefixo3 + 'GerarNfseEnvio';
    end;

    FPDadosMsg := TNFSeGerarNFSe(Self).FNotasFiscais.AssinarLote(FPDadosMsg,
                              FTagGrupo, TagElemento,
                              FPConfiguracoesNFSe.Geral.ConfigAssinar.LoteGerar,
                              xSignatureNode, xDSIGNSLote, xIdSignature);

    if FPConfiguracoesNFSe.Geral.ConfigSchemas.Validar then
      TNFSeGerarNFSe(Self).FNotasFiscais.ValidarLote(FPDadosMsg,
                          FPConfiguracoes.Arquivos.PathSchemas +
                          FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoGerar);
  end
  else
    GerarException(ACBrStr('A funcionalidade [Gerar NFSe] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Gerar_IncluiEncodingDados);
end;

function TNFSeGerarNFSe.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);
  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Gerar);
  Result := ExtrairNotasRetorno;
end;

procedure TNFSeGerarNFSe.FinalizarServico;
begin
  inherited FinalizarServico;

//  if Assigned(FRetornoNFSe) then
//    FreeAndNil(FRetornoNFSe);
end;

function TNFSeGerarNFSe.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeGerarNFSe.GerarPrefixoArquivo: String;
begin
  Result := NumeroRPS;
end;

{ TNFSeConsultarSituacaoLoteRPS }

constructor TNFSeConsultarSituacaoLoteRPS.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeConsultarSituacaoLoteRPS.Destroy;
begin
  if Assigned(FRetSitLote) then
    FRetSitLote.Free;

  inherited Destroy;
end;

procedure TNFSeConsultarSituacaoLoteRPS.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeConsultaSituacao;
  FPLayout := LayNFSeConsultaSitLoteRps;
  FPArqEnv := 'con-sit';
  FPArqResp := 'sit';

  FSituacao := '';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeConsultarSituacaoLoteRPS.DefinirURL;
begin
  FPLayout := LayNfseConsultaSitLoteRps;

  inherited DefinirURL;
end;

procedure TNFSeConsultarSituacaoLoteRPS.DefinirServicoEAction;
begin
  FPServico :=  'NFSeConsSitLoteRPS';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.ConsSit;

  inherited DefinirServicoEAction;
end;

procedure TNFSeConsultarSituacaoLoteRPS.DefinirDadosMsg;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsSit_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsSit_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoConSit;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsSit_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proCONAM:     FTagGrupo := 'ws_nfe.CONSULTAPROTOCOLO';

      proInfisc,
      proInfiscv11: FTagGrupo := 'pedidoStatusLote';

      proEquiplano: FTagGrupo := 'esConsultarSituacaoLoteRpsEnvio';

      proSimplISS:  FTagGrupo := 'ConsultarSituacaoLoteRpsEnvio';

      proSP, 
      proNotaBlu:   FTagGrupo := 'p1:PedidoInformacoesLote';

//      proTinus:     FTagGrupo := 'Arg';
    else
      FTagGrupo := 'ConsultarSituacaoLoteRpsEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      Protocolo := FProtocolo; 

      // Necess�rio para o provedor Equiplano / Infisc
      NumeroLote := FNumeroLote; 
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgConsSitLote + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.ConsSit) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Consultar Situa��o do Lote: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsSit_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsSit;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Consultar Situa��o do Lote] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

procedure TNFSeConsultarSituacaoLoteRPS.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeConsultarSituacaoLoteRPS.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeConsultarSituacaoLoteRPS.GerarPrefixoArquivo: String;
begin
  Result := Protocolo;
end;

function TNFSeConsultarSituacaoLoteRPS.Executar: Boolean;
var
  IntervaloTentativas, Tentativas: integer;
  cSituacao: String;
begin
  Result := False;

  TACBrNFSe(FPDFeOwner).SetStatus(stNFSeConsultaSituacao);
  try
    Sleep(FPConfiguracoesNFSe.WebServices.AguardarConsultaRet);

    Tentativas := 0;
    IntervaloTentativas := max(FPConfiguracoesNFSe.WebServices.IntervaloTentativas, 1000);

    while (inherited Executar) and
      (Tentativas < FPConfiguracoesNFSe.WebServices.Tentativas) do
    begin
      Inc(Tentativas);
      sleep(IntervaloTentativas);
    end;
  finally
    TACBrNFSe(FPDFeOwner).SetStatus(stNFSeIdle);
  end;

  if (FProvedor in [proEquiplano, proEL]) then
    cSituacao := '2'  // N�o Processado, lote com erro
  else
    cSituacao := '1'; // Lote N�o Recebido

  // Lote processado ?    Situa�ao 5 usado para sucesso no provedor CONAM
  if (FSituacao = cSituacao) or (FSituacao = '3') or (FSituacao = '4') or
     (FSituacao = '5') or (FSituacao = 'Erro') then
    Result := TratarRespostaFinal;
end;

function TNFSeConsultarSituacaoLoteRPS.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FRetSitLote.Free;
  FRetSitLote := TretSitLote.Create;

  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  FRetSitLote.Leitor.Arquivo := FPRetWS;
  FRetSitLote.Provedor       := FProvedor;

  RetSitLote.LerXml;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.ConsSit);

  FSituacao := RetSitLote.InfSit.Situacao;
  // FSituacao: 1 = N�o Recebido
  //            2 = N�o Processado
  //            3 = Processado com Erro
  //            4 = Processado com Sucesso

  if (FProvedor in [proEquiplano, proEL]) then
    Result := (FSituacao = '1')  // Aguardando processamento
  else
    Result := (FSituacao = '2'); // Lote n�o Processado
end;

function TNFSeConsultarSituacaoLoteRPS.TratarRespostaFinal: Boolean;
var
  xSituacao: String;
  i: Integer;
  Ok: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  // Lista de Mensagem de Retorno
  if RetSitLote.InfSit.MsgRetorno.Count > 0 then
  begin
    for i := 0 to RetSitLote.InfSit.MsgRetorno.Count - 1 do
    begin
      FPMsg := FPMsg + RetSitLote.infSit.MsgRetorno.Items[i].Mensagem + LineBreak +
                       RetSitLote.infSit.MsgRetorno.Items[i].Correcao + LineBreak;

      FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                       'C�digo Erro : ' + RetSitLote.infSit.MsgRetorno.Items[i].Codigo + LineBreak +
                       'Mensagem... : ' + RetSitLote.infSit.MsgRetorno.Items[i].Mensagem + LineBreak +
                       'Corre��o... : ' + RetSitLote.infSit.MsgRetorno.Items[i].Correcao + LineBreak +
                       'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
    end;
  end
  else begin
    for i:=0 to FNotasFiscais.Count -1 do
      FNotasFiscais.Items[i].NFSe.Situacao := FSituacao;

    case FProvedor of
      proEquiplano: begin
                      case FSituacao[1] of
                        '1' : xSituacao := 'Aguardando processamento';
                        '2' : xSituacao := 'N�o Processado, lote com erro';
                        '3' : xSituacao := 'Lote Processado com sucesso';
                        '4' : xSituacao := 'Lote Processado com avisos';
                      end;
                    end;

      proEL: begin
               case FSituacao[1] of
                 '1' : xSituacao := 'Aguardando processamento';
                 '2' : xSituacao := 'N�o Processado, lote com erro';
                 '3' : xSituacao := 'Lote Processado com avisos';
                 '4' : xSituacao := 'Lote Processado com sucesso';
               end;
             end;

    else begin
           case StrToSituacaoLoteRPS(Ok, FSituacao) of
            slrNaoRecibo        : xSituacao := 'Lote n�o Recebido.';
            slrNaoProcessado    : xSituacao := 'Lote n�o Processado.';
            slrProcessadoErro   : xSituacao := 'Lote Processado com Erro.';
            slrProcessadoSucesso: xSituacao := 'Lote Processado com Sucesso.';
           end;
         end;
    end;

    FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
             'Numero do Lote : ' + RetSitLote.InfSit.NumeroLote + LineBreak +
             'Situa��o...... : ' + FSituacao + '-' + xSituacao + LineBreak;
  end;

  Result := (FPMsg = '');
end;

{ TNFSeConsultarLoteRPS }

constructor TNFSeConsultarLoteRPS.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeConsultarLoteRPS.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeConsultarLoteRPS.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeConsulta;
  FPLayout := LayNfseConsultaLote;
  FPArqEnv := 'con-lot';
  FPArqResp := 'lista-nfse';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeConsultarLoteRPS.DefinirURL;
begin
  FPLayout := LayNfseConsultaLote;

  inherited DefinirURL;
end;

procedure TNFSeConsultarLoteRPS.DefinirServicoEAction;
begin
  FPServico := 'NFSeConsLote';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.ConsLote;

  inherited DefinirServicoEAction;
end;

procedure TNFSeConsultarLoteRPS.DefinirDadosMsg;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsLote_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsLote_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoConLot;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsLote_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proABase:     FTagGrupo := 'ConsultaLoteRpsEnvio';

      proCONAM:     FTagGrupo := 'ws_nfe.CONSULTANOTASPROTOCOLO';

      proEquiplano: FTagGrupo := 'esConsultarLoteRpsEnvio';

      proISSDSF,
      proCTA:       FTagGrupo := 'ReqConsultaLote';

      proSP,
      proNotaBlu:   FTagGrupo := 'p1:PedidoConsultaLote';

      proSMARAPD:   FTagGrupo := '';

//      proTinus:     FTagGrupo := 'Arg';
    else
      FTagGrupo := 'ConsultarLoteRpsEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      Protocolo := FProtocolo; 

      // Necess�rio para o provedor Equiplano - EL
      NumeroLote := FNumeroLote; 
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgConsLote + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  if Provedor = proNFSeBrasil then
    FPDadosMsg := FProtocolo;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.ConsLote) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Consultar Lote de RPS: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsLote_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsLote;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Consultar Lote] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeConsultarLoteRPS.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);
  Result := ExtrairNotasRetorno;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.ConsLote);
end;

procedure TNFSeConsultarLoteRPS.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeConsultarLoteRPS.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeConsultarLoteRPS.GerarPrefixoArquivo: String;
begin
  Result := Protocolo;
end;

{ TNFSeConsultarNfseRPS }

constructor TNFSeConsultarNfseRPS.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeConsultarNfseRPS.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeConsultarNFSeRPS.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeConsulta;
  FPLayout := LayNfseConsultaNfseRps;
  FPArqEnv := 'con-nfse-rps';
  FPArqResp := 'comp-nfse';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeConsultarNfseRPS.DefinirURL;
begin
  FPLayout := LayNfseConsultaNfseRps;

  inherited DefinirURL;
end;

procedure TNFSeConsultarNfseRPS.DefinirServicoEAction;
begin
  FPServico := 'NFSeConsNfseRPS';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.ConsNfseRps;

  inherited DefinirServicoEAction;
end;

procedure TNFSeConsultarNfseRPS.DefinirDadosMsg;
var
  i: Integer;
  Gerador: TGerador;
begin
  if (FNotasFiscais.Count <= 0) and (FProvedor in [proGoverna,proIssDSF]) then
    GerarException(ACBrStr('ERRO: Nenhum RPS carregado ao componente'));

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSeRps_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSeRps_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoConRps;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSeRps_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proISSDSF,
      proCTA:       FTagGrupo := 'ReqConsultaNFSeRPS';

      proEquiplano: FTagGrupo := 'esConsultarNfsePorRpsEnvio';

      proSP, 
      proNotaBlu:   FTagGrupo := 'p1:PedidoConsultaNFe';

//      proTinus:     FTagGrupo := 'Arg';
    else
      FTagGrupo := 'ConsultarNfseRpsEnvio';
    end;

    FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    if FProvedor in [proIssDSF, proCTA] then
    begin
      Gerador := TGerador.Create;
      try
        Gerador.ArquivoFormatoXML := '';

        if FNotasFiscais.Count > 0 then
        begin
          if FNotasFiscais.Items[0].NFSe.Numero = '' then
          begin
            Gerador.wGrupoNFSe('RPSConsulta');
            for i := 0 to FNotasFiscais.Count-1 do
            begin
              with FNotasFiscais.Items[I] do
                if NFSe.IdentificacaoRps.Numero <> '' then
                begin
                  Gerador.wGrupoNFSe('RPS Id="rps:' + NFSe.IdentificacaoRps.Numero + '"');
                  Gerador.wCampoNFSe(tcStr, '', 'InscricaoMunicipalPrestador', 01, 11,  1, NFSe.Prestador.InscricaoMunicipal, '');
                  Gerador.wCampoNFSe(tcStr, '#1', 'NumeroRPS', 01, 12, 1, OnlyNumber(NFSe.IdentificacaoRps.Numero), '');
                  // Roberto godinho - Para o provedor CTA deve enviar a s�rie de presta��o (99) e n�o a s�rie do RPS
                  if FProvedor = proCTA then
                    Gerador.wCampoNFSe(tcStr, '', 'SeriePrestacao', 01, 2,  1, IIf(NFSe.SeriePrestacao='', '99', NFSe.SeriePrestacao), '')
                  else
                    Gerador.wCampoNFSe(tcStr, '', 'SeriePrestacao', 01, 2,  1, NFSe.SeriePrestacao, '');
                  Gerador.wGrupoNFSe('/RPS');
                end;
            end;
            Gerador.wGrupoNFSe('/RPSConsulta');
          end
          else begin
            Gerador.wGrupoNFSe('NotaConsulta');
            for i := 0 to FNotasFiscais.Count-1 do
            begin
              with FNotasFiscais.Items[I] do
                if NFSe.Numero <> '' then
                begin
                  Gerador.wGrupoNFSe('Nota Id="nota:' + NFSe.Numero + '"');
                  Gerador.wCampoNFSe(tcStr, '', 'InscricaoMunicipalPrestador', 01, 11,  1, FPConfiguracoesNFSe.Geral.Emitente.InscMun, '');
                  Gerador.wCampoNFSe(tcStr, '#1', 'NumeroNota', 01, 12, 1, OnlyNumber(NFSe.Numero), '');
                  Gerador.wCampoNFSe(tcStr, '', 'CodigoVerificacao', 01, 255,  1, NFSe.CodigoVerificacao, '');
                  Gerador.wGrupoNFSe('/Nota');
                end;
            end;
            Gerador.wGrupoNFSe('/NotaConsulta');
          end;
        end;

        FvNotas := Gerador.ArquivoFormatoXML;
      finally
        Gerador.Free;
      end;
    end;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroRps := FNumeroRPS;
      SerieRps  := FSerie;
      TipoRps   := FTipo;

      // Necess�rio para o provedor ISSDSF e CTA
      if FProvedor in [proIssDSF, proCTA] then
      begin
        NumeroLote := FNumeroLote;
        Transacao  := FNotasFiscais.Transacao;
        Notas      := FvNotas;
      end;

      // Necess�rio para o provedor Governa
      if FProvedor = proGoverna then
      begin
        ChaveAcessoPrefeitura := FNotasFiscais.Items[0].NFSe.Prestador.ChaveAcesso;
        CodVerificacaoRPS     := FNotasFiscais.Items[0].NFSe.CodigoVerificacao;
      end;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgConsNFSeRPS + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  if Provedor = proNFSeBrasil then
    FPDadosMsg := NumeroRps;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.ConsNFSeRps) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Consultar NFSe por RPS: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSeRps_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSeRps;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Consultar NFSe por RPS] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeConsultarNfseRPS.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);
  Result := ExtrairNotasRetorno;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.ConsNFSeRPS);
end;

procedure TNFSeConsultarNfseRPS.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeConsultarNfseRPS.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeConsultarNfseRPS.GerarPrefixoArquivo: String;
begin
  Result := NumeroRps + Serie;
end;

{ TNFSeConsultarNfse }

constructor TNFSeConsultarNfse.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeConsultarNfse.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeConsultarNFSe.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeConsulta;
  FPLayout := LayNfseConsultaNfse;
  FPArqEnv := 'con-nfse';
  FPArqResp := 'lista-nfse';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeConsultarNfse.DefinirURL;
begin
  FPLayout := LayNfseConsultaNfse;

  inherited DefinirURL;
end;

procedure TNFSeConsultarNfse.DefinirServicoEAction;
begin
  FPServico := 'NFSeConsNfse';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.ConsNfse;

  inherited DefinirServicoEAction;
end;

procedure TNFSeConsultarNfse.DefinirDadosMsg;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSe_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSe_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoConNfse;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSe_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proPronimv2,
      proDigifred:  FTagGrupo := 'ConsultarNfseServicoPrestadoEnvio';

      proInfisc,
      proInfiscv11: FTagGrupo := 'pedidoLoteNFSe';

      proISSDSF,
      proCTA:       FTagGrupo := 'ReqConsultaNotas';

      proAgili,
      proAgiliv2,
      proPVH,
      proTecnos,
      proSystemPro: FTagGrupo := 'ConsultarNfseFaixaEnvio';

      proSP, 
      proNotaBlu:   FTagGrupo := 'PedidoConsultaNFe';

      proGoverna :  FTagGrupo := 'ConsultaCancelamento';
    else
      FTagGrupo := 'ConsultarNfseEnvio';
    end;

    if FProvedor = proGoverna then
      FTagGrupo := FPrefixo4 + FTagGrupo
    else
      FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      DataInicial := TNFSeConsultarNfse(Self).DataInicial;
      DataFinal   := TNFSeConsultarNfse(Self).DataFinal;
      NumeroNFSe  := TNFSeConsultarNfse(Self).NumeroNFSe;
      Pagina      := TNFSeConsultarNfse(Self).FPagina;
      CNPJTomador := TNFSeConsultarNfse(Self).FCNPJTomador;
      IMTomador   := TNFSeConsultarNfse(Self).FIMTomador;
      NomeInter   := TNFSeConsultarNfse(Self).FNomeInter;
      CNPJInter   := TNFSeConsultarNfse(Self).FCNPJInter;
      IMInter     := TNFSeConsultarNfse(Self).FIMInter;

      // Necessario para o provedor Infisc
      SerieNFSe := TNFSeConsultarNfse(Self).Serie;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgConsNFSe + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  if (FProvedor = proNFSeBrasil)
    then FPDadosMsg := NumeroNFSe;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.ConsNFSe) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Consultar NFSe: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSe_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.ConsNFSe;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Consultar NFSe] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeConsultarNfse.TratarResposta: Boolean;
begin
  FPMsg := '';
  FaMsg := '';
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);
  Result := ExtrairNotasRetorno;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.ConsNFSe);
end;

procedure TNFSeConsultarNfse.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeConsultarNfse.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeConsultarNfse.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmdd', DataInicial) +
            FormatDateTime('yyyymmdd', DataFinal);
end;

{ TNFSeCancelarNfse }

constructor TNFSeCancelarNfse.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeCancelarNfse.Destroy;
begin
  if Assigned(FRetCancNFSe) then
    FRetCancNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeCancelarNFSe.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeCancelamento;
  FPLayout := LayNfseCancelaNfse;
  FPArqEnv := 'ped-can';
  FPArqResp := 'can';

  FDataHora := 0;

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeCancelarNfse.DefinirURL;
begin
  FPLayout := LayNfseCancelaNfse;

  inherited DefinirURL;
end;

procedure TNFSeCancelarNfse.DefinirServicoEAction;
begin
  FPServico := 'NFSeCancNfse';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.Cancelar;

  inherited DefinirServicoEAction;
end;

procedure TNFSeCancelarNfse.DefinirDadosMsg;
var
  i: Integer;
  Gerador: TGerador;
  sAssinatura: String;
begin
  if FNotasFiscais.Count <= 0 then
    GerarException(ACBrStr('ERRO: Nenhuma NFS-e carregada ao componente'));

  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Cancelar_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Cancelar_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoCancelar;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Cancelar_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    case FProvedor of
      proCONAM:       FTagGrupo := 'ws_nfe.CANCELANOTAELETRONICA';

      proEGoverneISS: FTagGrupo := 'request';

      proEquiplano:   FTagGrupo := 'esCancelarNfseEnvio';

      proInfisc,
      proInfiscv11:   FTagGrupo := 'pedCancelaNFSe';

      proISSDSF,
      proCTA:         FTagGrupo := 'ReqCancelamentoNFSe';

      proSP,
      proNotaBlu:     FTagGrupo := 'PedidoCancelamentoNFe';

      proSMARAPD:     FTagGrupo := '';

//      proTinus:       FTagGrupo := 'Arg';
    else
      FTagGrupo := 'CancelarNfseEnvio';
    end;

    if FProvedor <> proGinfes then
      FTagGrupo := FPrefixo3 + FTagGrupo;

    case FProvedor of
      proBetha:  FdocElemento := 'Pedido';

      proDBSeller: FdocElemento := FPrefixo3 + 'Pedido></' + FTagGrupo + '></CancelarNfse';

      proISSDSF,
      proEquiplano,
      proInfisc,
      proInfiscv11,
      proSP,
      proNotaBlu:  FdocElemento := FTagGrupo;

      proGinfes: FdocElemento := FTagGrupo;

      proISSNet: FdocElemento := FPrefixo3 + 'Pedido></p1:' + FTagGrupo;

      proSMARAPD: FdocElemento := 'nfd';
    else
      FdocElemento := FPrefixo3 + 'Pedido></' + FTagGrupo;
    end;

    case FProvedor of
      proISSe,
      proFiorilli,
      proTecnos: FinfElemento := 'InfPedidoCancelamento';
    else
      FinfElemento := '';
    end;

    if FNotasFiscais.Count > 0 then
      begin
        FNumeroNFSe := FNotasFiscais.Items[0].NFSe.Numero;
        if FProvedor = proISSDSF then
          FCodigoVerificacao := FNotasFiscais.Items[0].NFSe.CodigoVerificacao;
      end;

    case FProvedor of
      proCONAM: FURI := 'Sdt_cancelanfe';

      proDigifred: FURI := 'CANC' + TNFSeCancelarNfse(Self).FNumeroNFSe;

      proEquiplano,
      proISSCuritiba,
      proPronimv2,
      proPublica,
      proSP,
      proNotaBlu,
      proSMARAPD: FURI := '';

      proGovDigital: FURI := TNFSeCancelarNfse(Self).FNumeroNFSe;

      proIssIntel,
      proISSNet: begin
                   FURI := '';
                   FURIRef := 'http://www.w3.org/TR/2000/REC-xhtml1-20000126/';
                 end;

      proABase,
      proTecnos: FURI := '2' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ +
                  IntToStrZero(StrToInt(TNFSeCancelarNfse(Self).FNumeroNFSe), 16);

      proRJ,
      proFriburgo: FURI := 'Cancelamento_NF' + TNFSeCancelarNfse(Self).FNumeroNFSe;

      proSaatri: FURI := 'Cancelamento_' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ;
    else
      FURI := 'pedidoCancelamento_' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ +
                                   FPConfiguracoesNFSe.Geral.Emitente.InscMun +
                                   TNFSeCancelarNfse(Self).FNumeroNFSe;
    end;

    InicializarTagITagF;

    if FProvedor in [proIssDSF, proCTA] then
    begin
      Gerador := TGerador.Create;
      try
        Gerador.ArquivoFormatoXML := '';

        for i := 0 to FNotasFiscais.Count-1 do
        begin
          with FNotasFiscais.Items[I] do
          begin
            Gerador.wGrupoNFSe('Nota Id="nota:' + NFSe.Numero + '"');
            Gerador.wCampoNFSe(tcStr, '', 'InscricaoMunicipalPrestador', 01, 11,  1, FPConfiguracoesNFSe.Geral.Emitente.InscMun, '');
            Gerador.wCampoNFSe(tcStr, '#1', 'NumeroNota', 01, 12, 1, OnlyNumber(NFSe.Numero), '');
            Gerador.wCampoNFSe(tcStr, '', 'CodigoVerificacao', 01, 255,  1, NFSe.CodigoVerificacao, '');
            Gerador.wCampoNFSe(tcStr, '', 'MotivoCancelamento', 01, 80, 1, TNFSeCancelarNfse(Self).FMotivoCancelamento, '');
            Gerador.wGrupoNFSe('/Nota');
          end;
        end;

        FvNotas := Gerador.ArquivoFormatoXML;
      finally
        Gerador.Free;
      end;
    end;

    if (FProvedor in [proInfisc, proInfiscv11] ) then
    begin
      Gerador := TGerador.Create;
      try
        Gerador.ArquivoFormatoXML := '';
        for i := 0 to FNotasFiscais.Count-1 do
        begin
          with FNotasFiscais.Items[I] do
          begin
            Gerador.wCampoNFSe(tcStr, '', 'chvAcessoNFS-e', 1, 39, 1, NFSe.ChaveNFSe, '');
//            Gerador.wCampoNFSe(tcStr, '', 'motivo', 1, 39, 1, TNFSeCancelarNfse(Self).FMotivoCancelamento, '');
            Gerador.wCampoNFSe(tcStr, '', 'motivo', 1, 39, 1, TNFSeCancelarNfse(Self).FCodigoCancelamento, ''); {@/\@}
          end;
        end;

        FvNotas := Gerador.ArquivoFormatoXML;
      finally
        Gerador.Free;
      end;
    end;

    if FProvedor in [proGoverna] then
    begin
      Gerador := TGerador.Create;
      try
        Gerador.ArquivoFormatoXML := '';
        Gerador.Prefixo := Prefixo4;
        for i := 0 to FNotasFiscais.Count-1 do
        begin
          Gerador.wGrupoNFSe('NotCan');
          with FNotasFiscais.Items[I] do
          begin
            Gerador.wGrupoNFSe('InfNotCan');
            Gerador.Prefixo := Prefixo3;
            Gerador.wCampoNFSe(tcStr, '', 'NumNot', 01, 10, 1, OnlyNumber(NFSe.Numero), '');
            Gerador.wCampoNFSe(tcStr, '', 'CodVer', 01, 255,  1, NFSe.CodigoVerificacao, '');
            Gerador.wCampoNFSe(tcStr, '', 'DesMotCan', 01, 80, 1, TNFSeCancelarNfse(Self).FMotivoCancelamento, '');
            Gerador.Prefixo := Prefixo4;
            Gerador.wGrupoNFSe('/InfNotCan');
          end;
          Gerador.wGrupoNFSe('/NotCan');
        end;

        FvNotas := Gerador.ArquivoFormatoXML;
      finally
        Gerador.Free;
      end;
    end;

    InicializarGerarDadosMsg;

    if FProvedor in [proSP, proNotaBlu] then
    begin
      sAssinatura := Poem_Zeros(GerarDadosMsg.IM, 8) + Poem_Zeros(TNFSeCancelarNfse(Self).NumeroNFSe, 12);
      GerarDadosMsg.AssinaturaCan := FPDFeOwner.SSL.CalcHash(sAssinatura, dgstSHA1, outBase64, True);
    end;

    with GerarDadosMsg do
    begin
      case FProvedor of
        proISSNet: if FPConfiguracoesNFSe.WebServices.AmbienteCodigo = 2 then
                     CodMunicipio := 999;
                     
        proBetha,
        proBethav2: CodMunicipio := StrToIntDef(FNotasFiscais.Items[0].NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0);
      else
        CodMunicipio := FPConfiguracoesNFSe.Geral.CodigoMunicipio;
      end;

      NumeroNFSe := TNFSeCancelarNfse(Self).NumeroNFSe;
      CodigoCanc := TNFSeCancelarNfse(Self).FCodigoCancelamento;
      MotivoCanc := TNFSeCancelarNfse(Self).FMotivoCancelamento;

      SerieNFSe  := FNotasFiscais.Items[0].NFSe.SeriePrestacao;
      NumeroRPS  := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
      SerieRps   := FNotasFiscais.Items[0].NFSe.IdentificacaoRps.Serie;
      ValorNota  := FNotasFiscais.Items[0].NFSe.ValoresNfse.ValorLiquidoNfse;

      // Necess�rio para o provedor ISSDSF
      NumeroLote := FNumeroLote;
      Transacao  := FNotasFiscais.Transacao;
      NumeroLote := FNotasFiscais.NumeroLote;
      Notas      := FvNotas;

      if FProvedor = proEGoverneISS then
        Transacao := (SimNaoToStr(FNotasFiscais.Items[0].NFSe.Producao) = '2');

      if FProvedor = proCTA then
        ChaveAcessoPrefeitura := FPConfiguracoesNFSe.Geral.Emitente.WebChaveAcesso
      else
        ChaveAcessoPrefeitura := FNotasFiscais.Items[0].NFSe.Prestador.ChaveAcesso;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgCancelarNFSe + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  if (FProvedor = proNFSeBrasil)
    then FPDadosMsg := NumeroNFSe;
      
  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.Cancelar) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FdocElemento, FinfElemento, 'Falha ao Assinar - Cancelar NFS-e: ');

  if FProvedor = proBetha then
    FPDadosMsg := '<' + FTagGrupo + FNameSpaceDad + '>' + FPDadosMsg + '</' + FTagGrupo + '>';

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Cancelar_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Cancelar;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Cancelar NFSe] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeCancelarNfse.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  if Assigned(FRetCancNFSe) then
    FRetCancNFSe.Free;

  FRetCancNFSe := TRetCancNfse.Create;
  FRetCancNFSe.Leitor.Arquivo := FPRetWS;
  FRetCancNFSe.Provedor       := FProvedor;
  FRetCancNFSe.VersaoXML      := FVersaoXML;

  FRetCancNFSe.LerXml;

  FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Cancelar);

  FDataHora := RetCancNFSe.InfCanc.DataHora;

  // Lista de Mensagem de Retorno
  FPMsg := '';
  FaMsg := '';
  if RetCancNFSe.InfCanc.MsgRetorno.Count > 0 then
  begin
    for i := 0 to RetCancNFSe.InfCanc.MsgRetorno.Count - 1 do
    begin
      FPMsg := FPMsg + RetCancNFSe.infCanc.MsgRetorno.Items[i].Mensagem + LineBreak +
                       RetCancNFSe.InfCanc.MsgRetorno.Items[i].Correcao + LineBreak;

      FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                       'C�digo Erro : ' + RetCancNFSe.InfCanc.MsgRetorno.Items[i].Codigo + LineBreak +
                       'Mensagem... : ' + RetCancNFSe.infCanc.MsgRetorno.Items[i].Mensagem + LineBreak +
                       'Corre��o... : ' + RetCancNFSe.InfCanc.MsgRetorno.Items[i].Correcao + LineBreak +
                       'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
    end;
  end
  else FaMsg := 'M�todo........ : ' + LayOutToStr(FPLayout) + LineBreak +
                'Numero da NFSe : ' + TNFSeCancelarNfse(Self).FNumeroNFSe + LineBreak +
                'Data Hora..... : ' + ifThen(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak;

  Result := (FDataHora > 0) or (RetCancNFSe.InfCanc.Sucesso='S') or (UpperCase(RetCancNFSe.InfCanc.Sucesso)='TRUE');
end;

procedure TNFSeCancelarNFSe.SalvarResposta;
var
  aPath: String;
begin
  inherited SalvarResposta;

  if FPConfiguracoesNFSe.Arquivos.Salvar then
  begin
    aPath := PathWithDelim(FPConfiguracoesNFSe.Arquivos.GetPathNFSe(0, ''{xData, xCNPJ}));
    FPDFeOwner.Gravar(GerarPrefixoArquivo + '-' + ArqResp + '.xml', FPRetWS, aPath);
  end;
end;

procedure TNFSeCancelarNfse.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeCancelarNfse.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeCancelarNfse.GerarPrefixoArquivo: String;
begin
  Result := NumeroNFSe;
end;

{ TNFSeSubstituirNFSe }

constructor TNFSeSubstituirNFSe.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeSubstituirNFSe.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeSubstituirNFSe.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeSubstituicao;
  FPLayout := LayNfseSubstituiNfse;
  FPArqEnv := 'ped-sub';
  FPArqResp := 'sub';

  FDataHora := 0;
  FSituacao := '';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeSubstituirNFSe.DefinirURL;
begin
  FPLayout := LayNfseSubstituiNfse;

  inherited DefinirURL;
end;

procedure TNFSeSubstituirNFSe.DefinirServicoEAction;
begin
  FPServico := 'NFSeSubNfse';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.Substituir;

  inherited DefinirServicoEAction;
end;

procedure TNFSeSubstituirNFSe.DefinirDadosMsg;
var
  i: Integer;
  Gerador: TGerador;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Substituir_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Substituir_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoSubstituir;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Substituir_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
(*
    FTagGrupo := FPrefixo3 + 'Pedido';
*)
    FTagGrupo := 'SubstituirNfseEnvio';

    if FProvedor <> proGinfes then
      FTagGrupo := FPrefixo3 + FTagGrupo;

    FdocElemento := FPrefixo3 + 'Pedido></' +
                    FPrefixo3 + 'SubstituicaoNfse></' + FTagGrupo;

    FinfElemento := 'InfPedidoCancelamento';

    if FPConfiguracoesNFSe.Geral.ConfigAssinar.RPS then
    begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPScomAssinatura(FNotasFiscais.Items[I].XMLAssinado);
    end
    else begin
      for I := 0 to FNotasFiscais.Count - 1 do
        GerarLoteRPSsemAssinatura(FNotasFiscais.Items[I].XMLOriginal);
    end;

    case FProvedor of
      proEquiplano,
      proPublica: FURI:= '';

      proDigifred:  FURI := 'CANC' + TNFSeSubstituirNfse(Self).FNumeroNFSe;

      proSaatri: FURI := 'Cancelamento_' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ;

      proIssIntel,
      proISSNet: begin
                   FURI := '';
                   FURIRef := 'http://www.w3.org/TR/2000/REC-xhtml1-20000126/';
                 end;

      proTecnos: FURI := '2' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ +
                            IntToStrZero(StrToInt(TNFSeSubstituirNfse(Self).FNumeroNFSe), 16);

    else  FURI := 'pedidoCancelamento_' + FPConfiguracoesNFSe.Geral.Emitente.CNPJ +
                      FPConfiguracoesNFSe.Geral.Emitente.InscMun +
                      TNFSeSubstituirNfse(Self).FNumeroNFSe;
    end;

    InicializarTagITagF;

    if FProvedor in [proIssDSF] then
    begin
      Gerador := TGerador.Create;
      try
        Gerador.ArquivoFormatoXML := '';

        for i := 0 to FNotasFiscais.Count-1 do
        begin
          with FNotasFiscais.Items[I] do
          begin
            Gerador.wGrupoNFSe('Nota Id="nota:' + NFSe.Numero + '"');
            Gerador.wCampoNFSe(tcStr, '', 'InscricaoMunicipalPrestador', 01, 11,  1, FPConfiguracoesNFSe.Geral.Emitente.InscMun, '');
            Gerador.wCampoNFSe(tcStr, '#1', 'NumeroNota', 01, 12, 1, OnlyNumber(NFSe.Numero), '');
            Gerador.wCampoNFSe(tcStr, '', 'CodigoVerificacao', 01, 255,  1, NFSe.CodigoVerificacao, '');
            Gerador.wCampoNFSe(tcStr, '', 'MotivoCancelamento', 01, 80, 1, TNFSeSubstituirNfse(Self).FMotivoCancelamento, '');
            Gerador.wGrupoNFSe('/Nota');
          end;
        end;

        FvNotas := Gerador.ArquivoFormatoXML;
      finally
        Gerador.Free;
      end;
    end;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      NumeroNFSe := TNFSeSubstituirNfse(Self).NumeroNFSe;
      CodigoCanc := TNFSeSubstituirNfse(Self).FCodigoCancelamento;
      MotivoCanc := TNFSeSubstituirNfse(Self).FMotivoCancelamento;
      NumeroRps  := TNFSeSubstituirNfse(Self).FNumeroRps;
      QtdeNotas  := FNotasFiscais.Count;
      Notas      := FvNotas;

      // Necess�rio para o provedor ISSDSF - CTA
      NumeroLote := FNotasFiscais.NumeroLote;
      Transacao  := FNotasFiscais.Transacao;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgSubstituirNFSe + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.Cancelar) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FdocElemento, FinfElemento, 'Falha ao Assinar - Cancelar NFS-e: ');

  FPDadosMsg := '<' + FPrefixo3 + 'SubstituirNfseEnvio' + FNameSpaceDad + '>' +
                '<' + FPrefixo3 + 'SubstituicaoNfse>' +
                 SeparaDados(FPDadosMsg, FPrefixo3 + 'Pedido', True) +
                 FvNotas  + FTagF;

  if FPConfiguracoesNFSe.Geral.ConfigSchemas.Validar then
    FNotasFiscais.ValidarLote(FPDadosMsg,
                              FPConfiguracoes.Arquivos.PathSchemas +
                              FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoSubstituir);


  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.Substituir_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.Substituir;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Substituir NFSe] n�o foi disponibilizada pelo provedor: ' +
                           FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeSubstituirNFSe.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  FNFSeRetorno := TRetSubsNfse.Create;
  try
    FNFSeRetorno.Leitor.Arquivo := FPRetWS;
    FNFSeRetorno.Provedor       := FProvedor;

    FNFSeRetorno.LerXml;

    FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.Substituir);

//      FDataHora := FNFSeRetorno.InfCanc.DataHora;

    // Lista de Mensagem de Retorno
    FPMsg := '';
    FaMsg := '';
    if FNFSeRetorno.MsgRetorno.Count > 0 then
    begin
      for i := 0 to FNFSeRetorno.MsgRetorno.Count - 1 do
      begin
        FPMsg := FPMsg + FNFSeRetorno.MsgRetorno.Items[i].Mensagem + LineBreak +
                         FNFSeRetorno.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + FNFSeRetorno.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + FNFSeRetorno.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + FNFSeRetorno.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
      end;
    end;
//    else FaMsg := 'Numero da NFSe : ' + FNFSeRetorno.Pedido.IdentificacaoNfse.Numero + LineBreak +
//                  'Data Hora..... : ' + ifThen(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak;

    Result := (FPMsg = '');
  finally
    FNFSeRetorno.Free;
  end;
end;

procedure TNFSeSubstituirNFSe.FinalizarServico;
begin
  inherited FinalizarServico;

//  if Assigned(FRetornoNFSe) then
//    FreeAndNil(FRetornoNFSe);
end;

function TNFSeSubstituirNFSe.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeSubstituirNFSe.GerarPrefixoArquivo: String;
begin
  Result := NumeroNFSe;
end;

{ TNFSeAbrirSessao }

constructor TNFSeAbrirSessao.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeAbrirSessao.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeAbrirSessao.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeAbrirSessao;
  FPLayout := LayNfseAbrirSessao;
  FPArqEnv := 'abr-ses';
  FPArqResp := 'sesA';

  FHashIdent := '';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeAbrirSessao.DefinirURL;
begin
  FPLayout := LayNfseAbrirSessao;

  inherited DefinirURL;
end;

procedure TNFSeAbrirSessao.DefinirServicoEAction;
begin
  FPServico := 'NFSeAbrirSessao';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.AbrirSessao;

  inherited DefinirServicoEAction;
end;

procedure TNFSeAbrirSessao.DefinirDadosMsg;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.AbrirSessao_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.AbrirSessao_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoAbrirSessao;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.AbrirSessao_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    FTagGrupo := '';

    FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgAbrirSessao + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.AbrirSessao) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Abrir Sess�o: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.AbrirSessao_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.AbrirSessao;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Abrir Sess�o] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeAbrirSessao.TratarResposta: Boolean;
var
  i: Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

  FRetAbrirSessao := TRetAbrirSessao.Create;
  try
    FRetAbrirSessao.Leitor.Arquivo := FPRetWS;
    FRetAbrirSessao.Provedor       := FProvedor;

    FRetAbrirSessao.LerXml;

    FHashIdent := FRetAbrirSessao.InfAbrirSessao.HashIdent;

    FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.AbrirSessao);

    // Lista de Mensagem de Retorno
    FPMsg := '';
    FaMsg := '';
    if FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Count > 0 then
    begin
      for i := 0 to FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Count - 1 do
      begin
        FPMsg := FPMsg + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Mensagem + LineBreak +
                         FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
      end;
    end;
//    else FaMsg := 'Numero da NFSe : ' + FNFSeRetorno.Pedido.IdentificacaoNfse.Numero + LineBreak +
//                  'Data Hora..... : ' + ifThen(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak;

    Result := (FPMsg = '');
  finally
    FRetAbrirSessao.Free;
  end;
end;

procedure TNFSeAbrirSessao.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeAbrirSessao.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeAbrirSessao.GerarPrefixoArquivo: String;
begin
  Result := NumeroLote;
end;

{ TNFSeFecharSessao }

constructor TNFSeFecharSessao.Create(AOwner: TACBrDFe;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFSeFecharSessao.Destroy;
begin
  if Assigned(FRetornoNFSe) then
    FRetornoNFSe.Free;

  inherited Destroy;
end;

procedure TNFSeFecharSessao.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeFecharSessao;
  FPLayout := LayNfseFecharSessao;
  FPArqEnv := 'fec-ses';
  FPArqResp := 'sesF';

  if Assigned(FRetornoNFSe) then
    FreeAndNil(FRetornoNFSe);
end;

procedure TNFSeFecharSessao.DefinirURL;
begin
  FPLayout := LayNfseFecharSessao;

  inherited DefinirURL;
end;

procedure TNFSeFecharSessao.DefinirServicoEAction;
begin
  FPServico := 'NFSeFecharSessao';
  FPSoapAction := FPConfiguracoesNFSe.Geral.ConfigSoapAction.FecharSessao;

  inherited DefinirServicoEAction;
end;

procedure TNFSeFecharSessao.DefinirDadosMsg;
begin
  FCabecalhoStr := FPConfiguracoesNFSe.Geral.ConfigEnvelope.FecharSessao_CabecalhoStr;
  FDadosStr     := FPConfiguracoesNFSe.Geral.ConfigEnvelope.FecharSessao_DadosStr;
  FxsdServico   := FPConfiguracoesNFSe.Geral.ConfigSchemas.ServicoFecharSessao;

  InicializarDadosMsg(FPConfiguracoesNFSe.Geral.ConfigEnvelope.FecharSessao_IncluiEncodingCab);

  GerarDadosMsg := TNFSeG.Create;
  try
    FTagGrupo := '';

    FTagGrupo := FPrefixo3 + FTagGrupo;

    InicializarTagITagF;

    InicializarGerarDadosMsg;

    with GerarDadosMsg do
    begin
      HashIdent := TNFSeFecharSessao(Self).HashIdent;
    end;

    AjustarOpcoes( GerarDadosMsg.Gerador.Opcoes );

    FPDadosMsg := FTagI + GerarDadosMsg.Gera_DadosMsgFecharSessao + FTagF;
  finally
    GerarDadosMsg.Free;
  end;

  // O procedimento recebe como parametro o XML a ser assinado e retorna o
  // mesmo assinado da propriedade FPDadosMsg
  if (FPConfiguracoesNFSe.Geral.ConfigAssinar.FecharSessao) and (FPDadosMsg <> '') then
    AssinarXML(FPDadosMsg, FTagGrupo, '', 'Falha ao Assinar - Fechar Sess�o: ');

  IncluirEncoding(FPConfiguracoesNFSe.Geral.ConfigEnvelope.FecharSessao_IncluiEncodingDados);

  FDadosEnvelope := FPConfiguracoesNFSe.Geral.ConfigEnvelope.FecharSessao;

  if (FPDadosMsg = '') or (FDadosEnvelope = '') then
    GerarException(ACBrStr('A funcionalidade [Fechar Sess�o] n�o foi disponibilizada pelo provedor: ' +
     FPConfiguracoesNFSe.Geral.xProvedor));
end;

function TNFSeFecharSessao.TratarResposta: Boolean;
//var
//  i: Integer;
begin
  FPRetWS := ExtrairRetorno(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.GrupoMsg);

//  FRetAbrirSessao := TRetAbrirSessao.Create;
  try
//    FRetAbrirSessao.Leitor.Arquivo := FPRetWS;
//    FRetAbrirSessao.Provedor       := FProvedor;

//    FRetAbrirSessao.LerXml;

    FPRetWS := ExtrairGrupoMsgRet(FPConfiguracoesNFSe.Geral.ConfigGrupoMsgRet.FecharSessao);

    // Lista de Mensagem de Retorno
    FPMsg := '';
    FaMsg := '';
    (*
    if FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Count > 0 then
    begin
      for i := 0 to FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Count - 1 do
      begin
        FPMsg := FPMsg + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Mensagem + LineBreak +
                         FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Correcao + LineBreak;

        FaMsg := FaMsg + 'M�todo..... : ' + LayOutToStr(FPLayout) + LineBreak +
                         'C�digo Erro : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Codigo + LineBreak +
                         'Mensagem... : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Mensagem + LineBreak +
                         'Corre��o... : ' + FRetAbrirSessao.InfAbrirSessao.MsgRetorno.Items[i].Correcao + LineBreak +
                         'Provedor... : ' + FPConfiguracoesNFSe.Geral.xProvedor + LineBreak;
      end;
    end;
//    else FaMsg := 'Numero da NFSe : ' + FNFSeRetorno.Pedido.IdentificacaoNfse.Numero + LineBreak +
//                  'Data Hora..... : ' + ifThen(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak;
    *)
    Result := (FPMsg = '');
  finally
//    FRetAbrirSessao.Free;
  end;
end;

procedure TNFSeFecharSessao.FinalizarServico;
begin
  inherited FinalizarServico;
end;

function TNFSeFecharSessao.GerarMsgLog: String;
begin
  Result := ACBrStr(FaMsg)
end;

function TNFSeFecharSessao.GerarPrefixoArquivo: String;
begin
  Result := NumeroLote;
end;

{ TNFSeEnvioWebService }

constructor TNFSeEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);
end;

destructor TNFSeEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TNFSeEnvioWebService.Clear;
begin
  inherited Clear;

  FPStatus := stNFSeEnvioWebService;
  FVersao := '';
end;

function TNFSeEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFSeEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TNFSeEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;

  inherited DefinirServicoEAction;
end;

procedure TNFSeEnvioWebService.DefinirDadosMsg;
var
  LeitorXML: TLeitor;
begin
  FCabecalhoStr:= FPConfiguracoesNFSe.Geral.ConfigXML.CabecalhoStr;
  FDadosStr:= FPConfiguracoesNFSe.Geral.ConfigXML.DadosStr;

  LeitorXML := TLeitor.Create;
  try
    LeitorXML.Arquivo := FXMLEnvio;
    LeitorXML.Grupo := FXMLEnvio;
    FVersao := LeitorXML.rAtributo('versao')
  finally
    LeitorXML.Free;
  end;

  FPDadosMsg := FXMLEnvio;
end;

function TNFSeEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');
  Result := True;
end;

function TNFSeEnvioWebService.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: '+FPServico + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TNFSeEnvioWebService.GerarVersaoDadosSoap: String;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrNFSe := TACBrNFSe(AOwner);

  FGerarLoteRPS   := TNFSeGerarLoteRPS.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FEnviarLoteRPS  := TNFSeEnviarLoteRPS.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FEnviarSincrono := TNFSeEnviarSincrono.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FGerarNfse      := TNFSeGerarNfse.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FConsSitLoteRPS := TNFSeConsultarSituacaoLoteRPS.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FConsLote       := TNFSeConsultarLoteRPS.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FConsNfseRps    := TNFSeConsultarNfseRps.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FConsNfse       := TNFSeConsultarNfse.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FCancNfse       := TNFSeCancelarNfse.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FSubNfse        := TNFSeSubstituirNfse.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FAbrirSessao    := TNFSeAbrirSessao.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
  FFecharSessao   := TNFSeFecharSessao.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);

  FEnvioWebService := TNFSeEnvioWebService.Create(FACBrNFSe);

  FTesteEnvioLoteRPS := TNFSeTesteEnvioLoteRPS.Create(FACBrNFSe, TACBrNFSe(FACBrNFSe).NotasFiscais);
end;

destructor TWebServices.Destroy;
begin
  FGerarLoteRPS.Free;
  FEnviarLoteRPS.Free;
  FEnviarSincrono.Free;
  FGerarNfse.Free;
  FConsSitLoteRPS.Free;
  FConsLote.Free;
  FConsNfseRps.Free;
  FConsNfse.Free;
  FCancNfse.Free;
  FSubNfse.Free;
  FAbrirSessao.Free;
  FFecharSessao.Free;

  FEnvioWebService.Free;

  FTesteEnvioLoteRPS.Free;

  inherited Destroy;
end;

function TWebServices.GeraLote(ALote: Integer): Boolean;
begin
  Result := GeraLote(IntToStr(ALote));
end;

function TWebServices.GeraLote(ALote: String): Boolean;
begin
  FGerarLoteRPS.FNumeroLote := ALote;

  Result := GerarLoteRPS.Executar;

  if not (Result) then
    GerarLoteRPS.GerarException( GerarLoteRPS.Msg );
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  Result := Envia(IntToStr(ALote));
end;

function TWebServices.Envia(ALote: String): Boolean;
begin
  if TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor = proEL then
  begin
    FAbrirSessao.FNumeroLote := ALote;

    Result := FAbrirSessao.Executar;

    FEnviarLoteRPS.FHashIdent := FAbrirSessao.FHashIdent;

    if not (Result) then
      FAbrirSessao.GerarException( FAbrirSessao.Msg );
  end;

  FEnviarLoteRPS.FNumeroLote := ALote;

  Result := FEnviarLoteRPS.Executar;

  if not (Result) then
    FEnviarLoteRPS.GerarException( FEnviarLoteRPS.Msg );

  if TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor = proEL then
  begin
    FFecharSessao.FNumeroLote := ALote;
    FFecharSessao.FHashIdent := FEnviarLoteRPS.HashIdent;

    Result := FFecharSessao.Executar;

    if not (Result) then
      FFecharSessao.GerarException( FFecharSessao.Msg );
  end;

  FConsSitLoteRPS.FProtocolo  := FEnviarLoteRPS.Protocolo;
  FConsSitLoteRPS.FNumeroLote := FEnviarLoteRPS.NumeroLote;

  FConsLote.FProtocolo := FEnviarLoteRPS.Protocolo;
  FConsLote.FNumeroLote := FEnviarLoteRPS.NumeroLote;

  if (TACBrNFSe(FACBrNFSe).Configuracoes.Geral.ConsultaLoteAposEnvio) and (Result) then
  begin
    //==========================================================================
    // Provedores que seguem a vers�o 1.0 do layout da ABRASF devem primeiro
    // Consultar a Situa��o do Lote
    if ProvedorToVersaoNFSe(TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor) = ve100 then
    begin
      // Provedores cuja vers�o � 1.0 mas n�o possuem o m�todo Consulta
      // a Situa��o do Lote devem ser relacionados no case abaixo.
      case TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor of
        proGoverna,
        proIssDSF: Result := True
      else
        Result := FConsSitLoteRPS.Executar;
      end;

      if not (Result) then
        FConsSitLoteRPS.GerarException( FConsSitLoteRPS.Msg );
    end;

    // Provedores que n�o possuem o m�todo Consultar o Lote devem ser
    // relacionados no case abaixo.
    case TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor of
      proEL,
      proGoverna,
      proInfisc,
      proInfiscv11: Result := True
    else
      Result := FConsLote.Executar;
    end;

    if not (Result) then
      FConsLote.GerarException( FConsLote.Msg );
  end;
end;

function TWebServices.EnviaSincrono(ALote: Integer): Boolean;
begin
  Result := EnviaSincrono(IntToStr(ALote));
end;

function TWebServices.EnviaSincrono(ALote: String): Boolean;
begin
  FEnviarSincrono.FNumeroLote := ALote;

  Result := FEnviarSincrono.Executar;

  if not (Result) then
    FEnviarSincrono.GerarException( FEnviarSincrono.Msg );

  if not FEnviarSincrono.FNotaRetornada then
  begin
    // Alguns provedores requerem que sejam feitas as consultas para obter o XML
    // da NFS-e
    FConsSitLoteRPS.FProtocolo  := FEnviarSincrono.Protocolo;
    FConsSitLoteRPS.FNumeroLote := FEnviarSincrono.NumeroLote;

    FConsLote.FProtocolo := FEnviarSincrono.Protocolo;

    if (TACBrNFSe(FACBrNFSe).Configuracoes.Geral.ConsultaLoteAposEnvio) and (Result) then
    begin
      if ProvedorToVersaoNFSe(TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor) = ve100 then
      begin
        Result := FConsSitLoteRPS.Executar;

        if not (Result) then
          FConsSitLoteRPS.GerarException( FConsSitLoteRPS.Msg );
      end;

      case TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor of
        proInfisc,
        proInfiscv11: Result := True
      else
        Result := FConsLote.Executar;
      end;

      if not (Result) then
        FConsLote.GerarException( FConsLote.Msg );
    end;
  end;
end;

function TWebServices.Gera(ARps: Integer; ALote: Integer): Boolean;
begin
 FGerarNfse.FNumeroRps  := IntToStr(ARps);
 FGerarNfse.FNumeroLote := IntToStr(ALote);

 Result := FGerarNfse.Executar;

 if not (Result) then
   FGerarNfse.GerarException( FGerarNfse.Msg );
end;

function TWebServices.ConsultaSituacao(AProtocolo: String;
  const ANumLote: String): Boolean;
begin
  FConsSitLoteRPS.FProtocolo  := AProtocolo;
  FConsSitLoteRPS.FNumeroLote := ANumLote;

  Result := FConsSitLoteRPS.Executar;

  if not (Result) then
   FConsSitLoteRPS.GerarException( FConsSitLoteRPS.Msg );
end;

function TWebServices.ConsultaLoteRps(ANumLote, AProtocolo: String): Boolean;
begin
  FConsLote.FNumeroLote := ANumLote;
  FConsLote.FProtocolo  := AProtocolo;

  Result := FConsLote.Executar;

  if not (Result) then
    FConsLote.GerarException( FConsLote.Msg );
end;

function TWebServices.ConsultaNFSeporRps(ANumero, ASerie, ATipo: String;
                                         const ANumLote: String = ''): Boolean;
begin
  FConsNfseRps.FNumeroRps  := ANumero;
  FConsNfseRps.FSerie      := ASerie;
  FConsNfseRps.FTipo       := ATipo;
  FConsNfseRps.FNumeroLote := ANumLote;

  Result := FConsNfseRps.Executar;

  if not (Result) then
    FConsNfseRps.GerarException( FConsNfseRps.Msg );
end;

function TWebServices.ConsultaNFSe(ADataInicial, ADataFinal: TDateTime;
  NumeroNFSe: String; APagina: Integer; ACNPJTomador, AIMTomador, ANomeInter,
  ACNPJInter, AIMInter, ASerie: String): Boolean;
begin
  FConsNfse.FDataInicial := ADataInicial;
  FConsNfse.FDataFinal   := ADataFinal;
  FConsNfse.FNumeroNFSe  := NumeroNFSe;
  FConsNfse.FPagina      := APagina;
  FConsNfse.FCNPJTomador := ACNPJTomador;
  FConsNfse.FIMTomador   := AIMTomador;
  FConsNfse.FNomeInter   := ANomeInter;
  FConsNfse.FCNPJInter   := ACNPJInter;
  FConsNfse.FIMInter     := AIMInter;
  FConsNfse.FSerie       := ASerie;

  Result := FConsNfse.Executar;

  if not (Result) then
    FConsNfse.GerarException( FConsNfse.Msg );
end;

function TWebServices.CancelaNFSe(ACodigoCancelamento: String;
  ANumeroNFSe: String = ''; AMotivoCancelamento: String = '';
  const ANumLote: String = ''): Boolean;
begin
  FCancNfse.FCodigoCancelamento := ACodigoCancelamento;
  FCancNfse.FNumeroNFSe         := ANumeroNFSe;
  FCancNfse.FMotivoCancelamento := AMotivoCancelamento;
  FCancNfse.FNumeroLote         := ANumLote;

  Result := FCancNfse.Executar;

  if not (Result) then
    FCancNfse.GerarException( FCancNfse.Msg );

  if not (TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor in [proABase, proCONAM, proEL, proISSNet, proSMARAPD]) then
  begin
    if TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor in [proSystemPro] then
    begin
      FConsNfse.FNumeroNFSe := TACBrNFSe(FACBrNFSe).NotasFiscais.Items[0].NFSe.Numero;

      // Utilizado por alguns provedores para realizar a consulta de uma NFS-e
      FConsNfse.FPagina := 1;

      Result := FConsNfse.Executar;

      if not (Result) then
        FConsNfse.GerarException( FConsNfse.Msg );
    end
    else begin
      FConsNfseRps.FNumeroRps := TACBrNFSe(FACBrNFSe).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
      FConsNfseRps.FSerie     := TACBrNFSe(FACBrNFSe).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Serie;
      FConsNfseRps.FTipo      := TipoRPSToStr(TACBrNFSe(FACBrNFSe).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Tipo);

      case TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor of
        proInfisc,
        proInfiscv11: Result := True
      else
        Result := FConsNfseRps.Executar;
      end;

      if not (Result) then
        FConsNfseRps.GerarException( FConsNfseRps.Msg );
    end;
  end;
end;

function TWebServices.SubstituiNFSe(ACodigoCancelamento, ANumeroNFSe: String;
  AMotivoCancelamento: String): Boolean;
begin
  Result := False;

  FSubNfse.FNumeroNFSe         := ANumeroNFSe;
  FSubNfse.FCodigoCancelamento := ACodigoCancelamento;

  if TACBrNFSe(FACBrNFSe).NotasFiscais.Count <= 0 then
    FSubNfse.GerarException(ACBrStr('ERRO: Nenhum RPS adicionado ao Lote'))
  else begin
    FSubNfse.FNumeroRps         := TACBrNFSe(FACBrNFSe).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
    FSubNfse.MotivoCancelamento := AMotivoCancelamento;

    Result := FSubNfse.Executar;

    if not (Result) then
      FSubNfse.GerarException( FSubNfse.Msg );
  end;
end;

function TWebServices.TestaEnvio(ALote: String): Boolean;
begin

  FTesteEnvioLoteRPS.FNumeroLote := ALote;
  Result := FTesteEnvioLoteRPS.Executar;

  if not (Result) then
    FTesteEnvioLoteRPS.GerarException( FTesteEnvioLoteRPS.Msg );

  FConsSitLoteRPS.FProtocolo  := FTesteEnvioLoteRPS.Protocolo;
  FConsSitLoteRPS.FNumeroLote := FTesteEnvioLoteRPS.NumeroLote;

  FConsLote.FProtocolo := FTesteEnvioLoteRPS.Protocolo;
  FConsLote.FNumeroLote := FTesteEnvioLoteRPS.NumeroLote;

  if (TACBrNFSe(FACBrNFSe).Configuracoes.Geral.ConsultaLoteAposEnvio) and (Result) then
  begin
    if ProvedorToVersaoNFSe(TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor) = ve100 then
    begin
      if TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor in [proGoverna] then
        Result := True
      else
        Result := FConsSitLoteRPS.Executar;

      if not (Result) then
        FConsSitLoteRPS.GerarException( FConsSitLoteRPS.Msg );
    end;

    case TACBrNFSe(FACBrNFSe).Configuracoes.Geral.Provedor of
      proEL,
      proGoverna,
      proInfisc,
      proInfiscv11: Result := True
    else
      Result := FConsLote.Executar;
    end;

    if not (Result) then
      FConsLote.GerarException( FConsLote.Msg );
  end;
end;

end.
