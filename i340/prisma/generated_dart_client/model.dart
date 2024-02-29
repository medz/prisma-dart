library prisma.namespace.model; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:orm/orm.dart' as _i1;

import 'model.dart' as _i2;
import 'prisma.dart' as _i3;

enum TipoSoggetto implements _i1.PrismaEnum {
  consumer._('CONSUMER'),
  business._('BUSINESS');

  const TipoSoggetto._(this.name);

  @override
  final String name;
}

class IndirizzoEmail {
  const IndirizzoEmail({
    this.uuid,
    this.indirizzo,
    this.etichetta,
    this.soggettoUuid,
    this.legaleRappresentanteUuid,
    this.referenteUuid,
    this.soggetto,
    this.referente,
    this.legaleRappresentante,
  });

  factory IndirizzoEmail.fromJson(Map json) => IndirizzoEmail(
        uuid: json['uuid'],
        indirizzo: json['indirizzo'],
        etichetta: json['etichetta'],
        soggettoUuid: json['soggettoUuid'],
        legaleRappresentanteUuid: json['legaleRappresentanteUuid'],
        referenteUuid: json['referenteUuid'],
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        referente: json['referente'] is Map
            ? _i2.Referente.fromJson(json['referente'])
            : null,
        legaleRappresentante: json['legaleRappresentante'] is Map
            ? _i2.LegaleRappresentante.fromJson(json['legaleRappresentante'])
            : null,
      );

  final String? uuid;

  final String? indirizzo;

  final String? etichetta;

  final String? soggettoUuid;

  final String? legaleRappresentanteUuid;

  final String? referenteUuid;

  final _i2.Soggetto? soggetto;

  final _i2.Referente? referente;

  final _i2.LegaleRappresentante? legaleRappresentante;
}

class Referente {
  const Referente({
    this.uuid,
    this.nome,
    this.cognome,
    this.soggettoBusinessInfoUuid,
    this.numeroTelefono,
    this.indirizzoEmail,
    this.soggettoBusinessInfo,
  });

  factory Referente.fromJson(Map json) => Referente(
        uuid: json['uuid'],
        nome: json['nome'],
        cognome: json['cognome'],
        soggettoBusinessInfoUuid: json['soggettoBusinessInfoUuid'],
        numeroTelefono: json['numeroTelefono'] is Map
            ? _i2.NumeroTelefono.fromJson(json['numeroTelefono'])
            : null,
        indirizzoEmail: json['indirizzoEmail'] is Map
            ? _i2.IndirizzoEmail.fromJson(json['indirizzoEmail'])
            : null,
        soggettoBusinessInfo: json['soggettoBusinessInfo'] is Map
            ? _i2.SoggettoBusinessInfo.fromJson(json['soggettoBusinessInfo'])
            : null,
      );

  final String? uuid;

  final String? nome;

  final String? cognome;

  final String? soggettoBusinessInfoUuid;

  final _i2.NumeroTelefono? numeroTelefono;

  final _i2.IndirizzoEmail? indirizzoEmail;

  final _i2.SoggettoBusinessInfo? soggettoBusinessInfo;
}

class NumeroTelefono {
  const NumeroTelefono({
    this.uuid,
    this.numero,
    this.etichetta,
    this.soggettoUuid,
    this.legaleRappresentateUuid,
    this.referenteUuid,
    this.soggetto,
    this.legaleRappresentate,
    this.referente,
  });

  factory NumeroTelefono.fromJson(Map json) => NumeroTelefono(
        uuid: json['uuid'],
        numero: json['numero'],
        etichetta: json['etichetta'],
        soggettoUuid: json['soggettoUuid'],
        legaleRappresentateUuid: json['legaleRappresentateUuid'],
        referenteUuid: json['referenteUuid'],
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        legaleRappresentate: json['legaleRappresentate'] is Map
            ? _i2.LegaleRappresentante.fromJson(json['legaleRappresentate'])
            : null,
        referente: json['referente'] is Map
            ? _i2.Referente.fromJson(json['referente'])
            : null,
      );

  final String? uuid;

  final String? numero;

  final String? etichetta;

  final String? soggettoUuid;

  final String? legaleRappresentateUuid;

  final String? referenteUuid;

  final _i2.Soggetto? soggetto;

  final _i2.LegaleRappresentante? legaleRappresentate;

  final _i2.Referente? referente;
}

class LegaleRappresentante {
  const LegaleRappresentante({
    this.uuid,
    this.nome,
    this.cognome,
    this.soggettoBusinessInfoUuid,
    this.numeroTelefono,
    this.indirizzoEmail,
    this.soggettoBusinessInfo,
  });

  factory LegaleRappresentante.fromJson(Map json) => LegaleRappresentante(
        uuid: json['uuid'],
        nome: json['nome'],
        cognome: json['cognome'],
        soggettoBusinessInfoUuid: json['soggettoBusinessInfoUuid'],
        numeroTelefono: json['numeroTelefono'] is Map
            ? _i2.NumeroTelefono.fromJson(json['numeroTelefono'])
            : null,
        indirizzoEmail: json['indirizzoEmail'] is Map
            ? _i2.IndirizzoEmail.fromJson(json['indirizzoEmail'])
            : null,
        soggettoBusinessInfo: json['soggettoBusinessInfo'] is Map
            ? _i2.SoggettoBusinessInfo.fromJson(json['soggettoBusinessInfo'])
            : null,
      );

  final String? uuid;

  final String? nome;

  final String? cognome;

  final String? soggettoBusinessInfoUuid;

  final _i2.NumeroTelefono? numeroTelefono;

  final _i2.IndirizzoEmail? indirizzoEmail;

  final _i2.SoggettoBusinessInfo? soggettoBusinessInfo;
}

class SoggettoBusinessInfo {
  const SoggettoBusinessInfo({
    this.uuid,
    this.rea,
    this.partitaIVA,
    this.sdi,
    this.soggettoUuid,
    this.legaleRappresentante,
    this.referente,
    this.soggetto,
  });

  factory SoggettoBusinessInfo.fromJson(Map json) => SoggettoBusinessInfo(
        uuid: json['uuid'],
        rea: json['rea'],
        partitaIVA: json['partitaIVA'],
        sdi: json['sdi'],
        soggettoUuid: json['soggettoUuid'],
        legaleRappresentante: json['legaleRappresentante'] is Map
            ? _i2.LegaleRappresentante.fromJson(json['legaleRappresentante'])
            : null,
        referente: json['referente'] is Map
            ? _i2.Referente.fromJson(json['referente'])
            : null,
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
      );

  final String? uuid;

  final String? rea;

  final String? partitaIVA;

  final String? sdi;

  final String? soggettoUuid;

  final _i2.LegaleRappresentante? legaleRappresentante;

  final _i2.Referente? referente;

  final _i2.Soggetto? soggetto;
}

class ConsumoAnnuoLuce {
  const ConsumoAnnuoLuce({
    this.uuid,
    this.consumo,
    this.meseRiferimentoConsumoAnnuo,
    this.fornituraLuceUuid,
    this.fornituraLuce,
  });

  factory ConsumoAnnuoLuce.fromJson(Map json) => ConsumoAnnuoLuce(
        uuid: json['uuid'],
        consumo: json['consumo'],
        meseRiferimentoConsumoAnnuo: json['meseRiferimentoConsumoAnnuo'],
        fornituraLuceUuid: json['fornituraLuceUuid'],
        fornituraLuce: json['fornituraLuce'] is Map
            ? _i2.FornituraLuce.fromJson(json['fornituraLuce'])
            : null,
      );

  final String? uuid;

  final double? consumo;

  final DateTime? meseRiferimentoConsumoAnnuo;

  final String? fornituraLuceUuid;

  final _i2.FornituraLuce? fornituraLuce;
}

enum TipoServizioEwo implements _i1.PrismaEnum {
  fornitura._('FORNITURA'),
  domicilio._('DOMICILIO');

  const TipoServizioEwo._(this.name);

  @override
  final String name;
}

enum Canale implements _i1.PrismaEnum {
  sep._('SEP'),
  neve._('NEVE'),
  corporate._('CORPORATE');

  const Canale._(this.name);

  @override
  final String name;
}

class TipoModuloContratto {
  const TipoModuloContratto({
    this.id,
    this.nome,
    this.numeroOfferteCollegabili,
    this.moduloContratto,
    this.$count,
  });

  factory TipoModuloContratto.fromJson(Map json) => TipoModuloContratto(
        id: json['id'],
        nome: json['nome'],
        numeroOfferteCollegabili: json['numeroOfferteCollegabili'],
        moduloContratto: (json['ModuloContratto'] as Iterable?)
            ?.map((json) => _i2.ModuloContratto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.TipoModuloContrattoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final int? numeroOfferteCollegabili;

  final Iterable<_i2.ModuloContratto>? moduloContratto;

  final _i3.TipoModuloContrattoCountOutputType? $count;
}

class ModuloContratto {
  const ModuloContratto({
    this.id,
    this.nome,
    this.fornitoreId,
    this.clienteTarget,
    this.canale,
    this.tipoModuloContrattoId,
    this.serviziEwoCollegabili,
    this.contratti,
    this.fornitore,
    this.tipoModulo,
    this.$count,
  });

  factory ModuloContratto.fromJson(Map json) => ModuloContratto(
        id: json['id'],
        nome: json['nome'],
        fornitoreId: json['fornitoreId'],
        clienteTarget: json['clienteTarget'] != null
            ? _i2.TipoSoggetto.values
                .firstWhere((e) => e.name == json['clienteTarget'])
            : null,
        canale: json['canale'] != null
            ? _i2.Canale.values.firstWhere((e) => e.name == json['canale'])
            : null,
        tipoModuloContrattoId: json['tipoModuloContrattoId'],
        serviziEwoCollegabili: (json['serviziEwoCollegabili'] as Iterable?)
            ?.map((json) => _i2.ServizioEwo.fromJson(json)),
        contratti: (json['contratti'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        fornitore: json['fornitore'] is Map
            ? _i2.Fornitore.fromJson(json['fornitore'])
            : null,
        tipoModulo: json['tipoModulo'] is Map
            ? _i2.TipoModuloContratto.fromJson(json['tipoModulo'])
            : null,
        $count: json['_count'] is Map
            ? _i3.ModuloContrattoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final String? fornitoreId;

  final _i2.TipoSoggetto? clienteTarget;

  final _i2.Canale? canale;

  final String? tipoModuloContrattoId;

  final Iterable<_i2.ServizioEwo>? serviziEwoCollegabili;

  final Iterable<_i2.Contratto>? contratti;

  final _i2.Fornitore? fornitore;

  final _i2.TipoModuloContratto? tipoModulo;

  final _i3.ModuloContrattoCountOutputType? $count;
}

class Produttore {
  const Produttore({
    this.id,
    this.nome,
    this.prodotti,
    this.$count,
  });

  factory Produttore.fromJson(Map json) => Produttore(
        id: json['id'],
        nome: json['nome'],
        prodotti: (json['prodotti'] as Iterable?)
            ?.map((json) => _i2.Prodotto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.ProduttoreCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.Prodotto>? prodotti;

  final _i3.ProduttoreCountOutputType? $count;
}

enum TipoStato implements _i1.PrismaEnum {
  daFare._('DA_FARE'),
  inCorso._('IN_CORSO'),
  completato._('COMPLETATO'),
  cancellato._('CANCELLATO');

  const TipoStato._(this.name);

  @override
  final String name;
}

class StatoOrdine {
  const StatoOrdine({
    this.id,
    this.nome,
    this.tipoStato,
    this.ordine,
    this.colore,
    this.ordini,
    this.$count,
  });

  factory StatoOrdine.fromJson(Map json) => StatoOrdine(
        id: json['id'],
        nome: json['nome'],
        tipoStato: json['tipoStato'] != null
            ? _i2.TipoStato.values
                .firstWhere((e) => e.name == json['tipoStato'])
            : null,
        ordine: json['ordine'],
        colore: json['colore'],
        ordini: (json['ordini'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.StatoOrdineCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final _i2.TipoStato? tipoStato;

  final int? ordine;

  final String? colore;

  final Iterable<_i2.Ordine>? ordini;

  final _i3.StatoOrdineCountOutputType? $count;
}

enum RuoloUtente implements _i1.PrismaEnum {
  consulente._('CONSULENTE'),
  agente._('AGENTE'),
  operatore._('OPERATORE'),
  responsabile._('RESPONSABILE'),
  amministratore._('AMMINISTRATORE'),
  developer._('DEVELOPER');

  const RuoloUtente._(this.name);

  @override
  final String name;
}

class TipoPratica {
  const TipoPratica({
    this.id,
    this.nome,
    this.serviziEwo,
    this.pratiche,
    this.$count,
  });

  factory TipoPratica.fromJson(Map json) => TipoPratica(
        id: json['id'],
        nome: json['nome'],
        serviziEwo: (json['serviziEwo'] as Iterable?)
            ?.map((json) => _i2.ServizioEwo.fromJson(json)),
        pratiche: (json['pratiche'] as Iterable?)
            ?.map((json) => _i2.Pratica.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.TipoPraticaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.ServizioEwo>? serviziEwo;

  final Iterable<_i2.Pratica>? pratiche;

  final _i3.TipoPraticaCountOutputType? $count;
}

class StatoPratica {
  const StatoPratica({
    this.id,
    this.nome,
    this.pratiche,
    this.serviziEwo,
    this.$count,
  });

  factory StatoPratica.fromJson(Map json) => StatoPratica(
        id: json['id'],
        nome: json['nome'],
        pratiche: (json['pratiche'] as Iterable?)
            ?.map((json) => _i2.Pratica.fromJson(json)),
        serviziEwo: (json['serviziEwo'] as Iterable?)
            ?.map((json) => _i2.ServizioEwo.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.StatoPraticaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.Pratica>? pratiche;

  final Iterable<_i2.ServizioEwo>? serviziEwo;

  final _i3.StatoPraticaCountOutputType? $count;
}

class Pratica {
  const Pratica({
    this.uuid,
    this.codice,
    this.dataInserimento,
    this.tipoPraticaId,
    this.soggettoUuid,
    this.utenteUuid,
    this.negozioCodice,
    this.statoPraticaId,
    this.ultimoAggiornamentoStato,
    this.tipoPratica,
    this.soggetto,
    this.utente,
    this.negozio,
    this.stato,
    this.contratto,
    this.$count,
  });

  factory Pratica.fromJson(Map json) => Pratica(
        uuid: json['uuid'],
        codice: json['codice'],
        dataInserimento: json['dataInserimento'],
        tipoPraticaId: json['tipoPraticaId'],
        soggettoUuid: json['soggettoUuid'],
        utenteUuid: json['utenteUuid'],
        negozioCodice: json['negozioCodice'],
        statoPraticaId: json['statoPraticaId'],
        ultimoAggiornamentoStato: json['ultimoAggiornamentoStato'],
        tipoPratica: json['tipoPratica'] is Map
            ? _i2.TipoPratica.fromJson(json['tipoPratica'])
            : null,
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        utente:
            json['utente'] is Map ? _i2.Utente.fromJson(json['utente']) : null,
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
        stato: json['stato'] is Map
            ? _i2.StatoPratica.fromJson(json['stato'])
            : null,
        contratto: (json['contratto'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.PraticaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? codice;

  final DateTime? dataInserimento;

  final String? tipoPraticaId;

  final String? soggettoUuid;

  final String? utenteUuid;

  final String? negozioCodice;

  final String? statoPraticaId;

  final DateTime? ultimoAggiornamentoStato;

  final _i2.TipoPratica? tipoPratica;

  final _i2.Soggetto? soggetto;

  final _i2.Utente? utente;

  final _i2.Negozio? negozio;

  final _i2.StatoPratica? stato;

  final Iterable<_i2.Contratto>? contratto;

  final _i3.PraticaCountOutputType? $count;
}

class ZonaNegozio {
  const ZonaNegozio({
    this.id,
    this.nome,
    this.negozi,
    this.$count,
  });

  factory ZonaNegozio.fromJson(Map json) => ZonaNegozio(
        id: json['id'],
        nome: json['nome'],
        negozi: (json['negozi'] as Iterable?)
            ?.map((json) => _i2.Negozio.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.ZonaNegozioCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.Negozio>? negozi;

  final _i3.ZonaNegozioCountOutputType? $count;
}

class Ingressi {
  const Ingressi({
    this.uuid,
    this.data,
    this.clienti,
    this.nonClienti,
    this.utenteUuid,
    this.negozioCodice,
    this.utente,
    this.negozio,
  });

  factory Ingressi.fromJson(Map json) => Ingressi(
        uuid: json['uuid'],
        data: json['data'],
        clienti: json['clienti'],
        nonClienti: json['nonClienti'],
        utenteUuid: json['utenteUuid'],
        negozioCodice: json['negozioCodice'],
        utente:
            json['utente'] is Map ? _i2.Utente.fromJson(json['utente']) : null,
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
      );

  final String? uuid;

  final DateTime? data;

  final int? clienti;

  final int? nonClienti;

  final String? utenteUuid;

  final String? negozioCodice;

  final _i2.Utente? utente;

  final _i2.Negozio? negozio;
}

class Negozio {
  const Negozio({
    this.codice,
    this.nome,
    this.zonaNegozioId,
    this.pratiche,
    this.utenti,
    this.contratti,
    this.soggetti,
    this.zonaNegozio,
    this.ingressi,
    this.leads,
    this.ordine,
    this.$count,
  });

  factory Negozio.fromJson(Map json) => Negozio(
        codice: json['codice'],
        nome: json['nome'],
        zonaNegozioId: json['zonaNegozioId'],
        pratiche: (json['pratiche'] as Iterable?)
            ?.map((json) => _i2.Pratica.fromJson(json)),
        utenti: (json['utenti'] as Iterable?)
            ?.map((json) => _i2.Utente.fromJson(json)),
        contratti: (json['contratti'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        soggetti: (json['soggetti'] as Iterable?)
            ?.map((json) => _i2.Soggetto.fromJson(json)),
        zonaNegozio: json['zonaNegozio'] is Map
            ? _i2.ZonaNegozio.fromJson(json['zonaNegozio'])
            : null,
        ingressi: (json['ingressi'] as Iterable?)
            ?.map((json) => _i2.Ingressi.fromJson(json)),
        leads: (json['leads'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        ordine: (json['Ordine'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.NegozioCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? codice;

  final String? nome;

  final String? zonaNegozioId;

  final Iterable<_i2.Pratica>? pratiche;

  final Iterable<_i2.Utente>? utenti;

  final Iterable<_i2.Contratto>? contratti;

  final Iterable<_i2.Soggetto>? soggetti;

  final _i2.ZonaNegozio? zonaNegozio;

  final Iterable<_i2.Ingressi>? ingressi;

  final Iterable<_i2.Lead>? leads;

  final Iterable<_i2.Ordine>? ordine;

  final _i3.NegozioCountOutputType? $count;
}

class HistoryComment {
  const HistoryComment({
    this.comment,
    this.historyUuid,
    this.history,
  });

  factory HistoryComment.fromJson(Map json) => HistoryComment(
        comment: json['comment'],
        historyUuid: json['historyUuid'],
        history: json['History'] is Map
            ? _i2.History.fromJson(json['History'])
            : null,
      );

  final String? comment;

  final String? historyUuid;

  final _i2.History? history;
}

class HistoryAttachment {
  const HistoryAttachment({
    this.url,
    this.name,
    this.historyUuid,
    this.history,
  });

  factory HistoryAttachment.fromJson(Map json) => HistoryAttachment(
        url: json['url'],
        name: json['name'],
        historyUuid: json['historyUuid'],
        history: json['History'] is Map
            ? _i2.History.fromJson(json['History'])
            : null,
      );

  final String? url;

  final String? name;

  final String? historyUuid;

  final _i2.History? history;
}

class History {
  const History({
    this.uuid,
    this.timestamp,
    this.event,
    this.utenteUuid,
    this.leadUuid,
    this.comment,
    this.attachment,
    this.utente,
    this.lead,
  });

  factory History.fromJson(Map json) => History(
        uuid: json['uuid'],
        timestamp: json['timestamp'],
        event: json['event'],
        utenteUuid: json['utenteUuid'],
        leadUuid: json['leadUuid'],
        comment: json['comment'] is Map
            ? _i2.HistoryComment.fromJson(json['comment'])
            : null,
        attachment: json['attachment'] is Map
            ? _i2.HistoryAttachment.fromJson(json['attachment'])
            : null,
        utente:
            json['Utente'] is Map ? _i2.Utente.fromJson(json['Utente']) : null,
        lead: json['Lead'] is Map ? _i2.Lead.fromJson(json['Lead']) : null,
      );

  final String? uuid;

  final DateTime? timestamp;

  final String? event;

  final String? utenteUuid;

  final String? leadUuid;

  final _i2.HistoryComment? comment;

  final _i2.HistoryAttachment? attachment;

  final _i2.Utente? utente;

  final _i2.Lead? lead;
}

class Utente {
  const Utente({
    this.uuid,
    this.firebaseUid,
    this.email,
    this.ruolo,
    this.photoUrl,
    this.negozioCodice,
    this.nomeVisualizzato,
    this.negozio,
    this.contratti,
    this.pratiche,
    this.ingressi,
    this.leadsGestiti,
    this.leadsAssegnati,
    this.opportunitaGestite,
    this.opportunitaAssegnate,
    this.ordini,
    this.history,
    this.$count,
  });

  factory Utente.fromJson(Map json) => Utente(
        uuid: json['uuid'],
        firebaseUid: json['firebaseUid'],
        email: json['email'],
        ruolo: json['ruolo'] != null
            ? _i2.RuoloUtente.values.firstWhere((e) => e.name == json['ruolo'])
            : null,
        photoUrl: json['photoUrl'],
        negozioCodice: json['negozioCodice'],
        nomeVisualizzato: json['nomeVisualizzato'],
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
        contratti: (json['contratti'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        pratiche: (json['pratiche'] as Iterable?)
            ?.map((json) => _i2.Pratica.fromJson(json)),
        ingressi: (json['ingressi'] as Iterable?)
            ?.map((json) => _i2.Ingressi.fromJson(json)),
        leadsGestiti: (json['leadsGestiti'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        leadsAssegnati: (json['leadsAssegnati'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        opportunitaGestite: (json['opportunitaGestite'] as Iterable?)
            ?.map((json) => _i2.Opportunita.fromJson(json)),
        opportunitaAssegnate: (json['opportunitaAssegnate'] as Iterable?)
            ?.map((json) => _i2.Opportunita.fromJson(json)),
        ordini: (json['ordini'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        history: (json['history'] as Iterable?)
            ?.map((json) => _i2.History.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.UtenteCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? firebaseUid;

  final String? email;

  final _i2.RuoloUtente? ruolo;

  final String? photoUrl;

  final String? negozioCodice;

  final String? nomeVisualizzato;

  final _i2.Negozio? negozio;

  final Iterable<_i2.Contratto>? contratti;

  final Iterable<_i2.Pratica>? pratiche;

  final Iterable<_i2.Ingressi>? ingressi;

  final Iterable<_i2.Lead>? leadsGestiti;

  final Iterable<_i2.Lead>? leadsAssegnati;

  final Iterable<_i2.Opportunita>? opportunitaGestite;

  final Iterable<_i2.Opportunita>? opportunitaAssegnate;

  final Iterable<_i2.Ordine>? ordini;

  final Iterable<_i2.History>? history;

  final _i3.UtenteCountOutputType? $count;
}

class Opportunita {
  const Opportunita({
    this.uuid,
    this.nome,
    this.dataInizio,
    this.dataFine,
    this.form,
    this.leads,
    this.gestoriLead,
    this.agenti,
    this.$count,
  });

  factory Opportunita.fromJson(Map json) => Opportunita(
        uuid: json['uuid'],
        nome: json['nome'],
        dataInizio: json['dataInizio'],
        dataFine: json['dataFine'],
        form: json['form'],
        leads: (json['leads'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        gestoriLead: (json['gestoriLead'] as Iterable?)
            ?.map((json) => _i2.Utente.fromJson(json)),
        agenti: (json['agenti'] as Iterable?)
            ?.map((json) => _i2.Utente.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.OpportunitaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? nome;

  final DateTime? dataInizio;

  final DateTime? dataFine;

  final String? form;

  final Iterable<_i2.Lead>? leads;

  final Iterable<_i2.Utente>? gestoriLead;

  final Iterable<_i2.Utente>? agenti;

  final _i3.OpportunitaCountOutputType? $count;
}

class StatoOpportunita {
  const StatoOpportunita({
    this.uuid,
    this.nome,
    this.tipoStato,
    this.ordine,
    this.colore,
    this.opportunitaUuid,
    this.leads,
    this.$count,
  });

  factory StatoOpportunita.fromJson(Map json) => StatoOpportunita(
        uuid: json['uuid'],
        nome: json['nome'],
        tipoStato: json['tipoStato'] != null
            ? _i2.TipoStato.values
                .firstWhere((e) => e.name == json['tipoStato'])
            : null,
        ordine: json['ordine'],
        colore: json['colore'],
        opportunitaUuid: json['opportunitaUuid'],
        leads: (json['leads'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.StatoOpportunitaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? nome;

  final _i2.TipoStato? tipoStato;

  final int? ordine;

  final String? colore;

  final String? opportunitaUuid;

  final Iterable<_i2.Lead>? leads;

  final _i3.StatoOpportunitaCountOutputType? $count;
}

class Lead {
  const Lead({
    this.uuid,
    this.opportunitaUuid,
    this.soggettoUuid,
    this.domicilioUuid,
    this.statoOpportunitaUuid,
    this.utenteUuid,
    this.negozioCodice,
    this.agenteUuid,
    this.appuntamenti,
    this.form,
    this.dataInserimento,
    this.dataScadenza,
    this.dataAppuntamento,
    this.nota,
    this.opportunita,
    this.soggetto,
    this.domicilio,
    this.statoOpportunita,
    this.utente,
    this.negozio,
    this.agente,
    this.ordine,
    this.history,
    this.$count,
  });

  factory Lead.fromJson(Map json) => Lead(
        uuid: json['uuid'],
        opportunitaUuid: json['opportunitaUuid'],
        soggettoUuid: json['soggettoUuid'],
        domicilioUuid: json['domicilioUuid'],
        statoOpportunitaUuid: json['statoOpportunitaUuid'],
        utenteUuid: json['utenteUuid'],
        negozioCodice: json['negozioCodice'],
        agenteUuid: json['agenteUuid'],
        appuntamenti: json['appuntamenti'],
        form: json['form'],
        dataInserimento: json['dataInserimento'],
        dataScadenza: json['dataScadenza'],
        dataAppuntamento: json['dataAppuntamento'],
        nota: json['nota'],
        opportunita: json['opportunita'] is Map
            ? _i2.Opportunita.fromJson(json['opportunita'])
            : null,
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        domicilio: json['domicilio'] is Map
            ? _i2.Domicilio.fromJson(json['domicilio'])
            : null,
        statoOpportunita: json['statoOpportunita'] is Map
            ? _i2.StatoOpportunita.fromJson(json['statoOpportunita'])
            : null,
        utente:
            json['utente'] is Map ? _i2.Utente.fromJson(json['utente']) : null,
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
        agente:
            json['agente'] is Map ? _i2.Utente.fromJson(json['agente']) : null,
        ordine: (json['ordine'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        history: (json['history'] as Iterable?)
            ?.map((json) => _i2.History.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.LeadCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? opportunitaUuid;

  final String? soggettoUuid;

  final String? domicilioUuid;

  final String? statoOpportunitaUuid;

  final String? utenteUuid;

  final String? negozioCodice;

  final String? agenteUuid;

  final String? appuntamenti;

  final String? form;

  final DateTime? dataInserimento;

  final DateTime? dataScadenza;

  final DateTime? dataAppuntamento;

  final String? nota;

  final _i2.Opportunita? opportunita;

  final _i2.Soggetto? soggetto;

  final _i2.Domicilio? domicilio;

  final _i2.StatoOpportunita? statoOpportunita;

  final _i2.Utente? utente;

  final _i2.Negozio? negozio;

  final _i2.Utente? agente;

  final Iterable<_i2.Ordine>? ordine;

  final Iterable<_i2.History>? history;

  final _i3.LeadCountOutputType? $count;
}

class Ordine {
  const Ordine({
    this.uuid,
    this.codice,
    this.dataInserimento,
    this.valore,
    this.soggettoUuid,
    this.domicilioUuid,
    this.statoOrdineId,
    this.leadUuid,
    this.utenteUuid,
    this.negozioCodice,
    this.prodotti,
    this.soggetto,
    this.domicilio,
    this.statoOrdine,
    this.lead,
    this.utente,
    this.negozio,
    this.$count,
  });

  factory Ordine.fromJson(Map json) => Ordine(
        uuid: json['uuid'],
        codice: json['codice'],
        dataInserimento: json['dataInserimento'],
        valore: json['valore'],
        soggettoUuid: json['soggettoUuid'],
        domicilioUuid: json['domicilioUuid'],
        statoOrdineId: json['statoOrdineId'],
        leadUuid: json['leadUuid'],
        utenteUuid: json['utenteUuid'],
        negozioCodice: json['negozioCodice'],
        prodotti: (json['prodotti'] as Iterable?)
            ?.map((json) => _i2.Prodotto.fromJson(json)),
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        domicilio: json['domicilio'] is Map
            ? _i2.Domicilio.fromJson(json['domicilio'])
            : null,
        statoOrdine: json['statoOrdine'] is Map
            ? _i2.StatoOrdine.fromJson(json['statoOrdine'])
            : null,
        lead: json['lead'] is Map ? _i2.Lead.fromJson(json['lead']) : null,
        utente:
            json['utente'] is Map ? _i2.Utente.fromJson(json['utente']) : null,
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
        $count: json['_count'] is Map
            ? _i3.OrdineCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? codice;

  final DateTime? dataInserimento;

  final double? valore;

  final String? soggettoUuid;

  final String? domicilioUuid;

  final String? statoOrdineId;

  final String? leadUuid;

  final String? utenteUuid;

  final String? negozioCodice;

  final Iterable<_i2.Prodotto>? prodotti;

  final _i2.Soggetto? soggetto;

  final _i2.Domicilio? domicilio;

  final _i2.StatoOrdine? statoOrdine;

  final _i2.Lead? lead;

  final _i2.Utente? utente;

  final _i2.Negozio? negozio;

  final _i3.OrdineCountOutputType? $count;
}

class TipoProdotto {
  const TipoProdotto({
    this.id,
    this.nome,
    this.prodotti,
    this.$count,
  });

  factory TipoProdotto.fromJson(Map json) => TipoProdotto(
        id: json['id'],
        nome: json['nome'],
        prodotti: (json['prodotti'] as Iterable?)
            ?.map((json) => _i2.Prodotto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.TipoProdottoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.Prodotto>? prodotti;

  final _i3.TipoProdottoCountOutputType? $count;
}

class Prodotto {
  const Prodotto({
    this.uuid,
    this.modello,
    this.prezzo,
    this.vendibileDal,
    this.vendibileAl,
    this.produttoreId,
    this.fornitoreId,
    this.tipoProdottoId,
    this.produttore,
    this.prodottiOrdinati,
    this.fornitore,
    this.tipoProdotto,
    this.$count,
  });

  factory Prodotto.fromJson(Map json) => Prodotto(
        uuid: json['uuid'],
        modello: json['modello'],
        prezzo: json['prezzo'],
        vendibileDal: json['vendibileDal'],
        vendibileAl: json['vendibileAl'],
        produttoreId: json['produttoreId'],
        fornitoreId: json['fornitoreId'],
        tipoProdottoId: json['tipoProdottoId'],
        produttore: json['produttore'] is Map
            ? _i2.Produttore.fromJson(json['produttore'])
            : null,
        prodottiOrdinati: (json['prodottiOrdinati'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        fornitore: json['fornitore'] is Map
            ? _i2.Fornitore.fromJson(json['fornitore'])
            : null,
        tipoProdotto: json['tipoProdotto'] is Map
            ? _i2.TipoProdotto.fromJson(json['tipoProdotto'])
            : null,
        $count: json['_count'] is Map
            ? _i3.ProdottoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? modello;

  final double? prezzo;

  final DateTime? vendibileDal;

  final DateTime? vendibileAl;

  final String? produttoreId;

  final String? fornitoreId;

  final String? tipoProdottoId;

  final _i2.Produttore? produttore;

  final Iterable<_i2.Ordine>? prodottiOrdinati;

  final _i2.Fornitore? fornitore;

  final _i2.TipoProdotto? tipoProdotto;

  final _i3.ProdottoCountOutputType? $count;
}

class Fornitore {
  const Fornitore({
    this.id,
    this.nome,
    this.serviziEwo,
    this.moduliContratto,
    this.prodotti,
    this.$count,
  });

  factory Fornitore.fromJson(Map json) => Fornitore(
        id: json['id'],
        nome: json['nome'],
        serviziEwo: (json['serviziEwo'] as Iterable?)
            ?.map((json) => _i2.ServizioEwo.fromJson(json)),
        moduliContratto: (json['moduliContratto'] as Iterable?)
            ?.map((json) => _i2.ModuloContratto.fromJson(json)),
        prodotti: (json['prodotti'] as Iterable?)
            ?.map((json) => _i2.Prodotto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.FornitoreCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.ServizioEwo>? serviziEwo;

  final Iterable<_i2.ModuloContratto>? moduliContratto;

  final Iterable<_i2.Prodotto>? prodotti;

  final _i3.FornitoreCountOutputType? $count;
}

class ClasseMisuratoreGas {
  const ClasseMisuratoreGas({
    this.portataMin,
    this.portataNominale,
    this.portataMax,
    this.id,
    this.classe,
    this.fornituraGas,
    this.$count,
  });

  factory ClasseMisuratoreGas.fromJson(Map json) => ClasseMisuratoreGas(
        portataMin: json['portataMin'],
        portataNominale: json['portataNominale'],
        portataMax: json['portataMax'],
        id: json['id'],
        classe: json['classe'],
        fornituraGas: (json['fornituraGas'] as Iterable?)
            ?.map((json) => _i2.FornituraGas.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.ClasseMisuratoreGasCountOutputType.fromJson(json['_count'])
            : null,
      );

  final double? portataMin;

  final double? portataNominale;

  final double? portataMax;

  final String? id;

  final String? classe;

  final Iterable<_i2.FornituraGas>? fornituraGas;

  final _i3.ClasseMisuratoreGasCountOutputType? $count;
}

class ConsumoAnnuoGas {
  const ConsumoAnnuoGas({
    this.uuid,
    this.consumo,
    this.meseRiferimentoConsumoAnnuo,
    this.fornituraGasUuid,
    this.fornituraGas,
  });

  factory ConsumoAnnuoGas.fromJson(Map json) => ConsumoAnnuoGas(
        uuid: json['uuid'],
        consumo: json['consumo'],
        meseRiferimentoConsumoAnnuo: json['meseRiferimentoConsumoAnnuo'],
        fornituraGasUuid: json['fornituraGasUuid'],
        fornituraGas: json['fornituraGas'] is Map
            ? _i2.FornituraGas.fromJson(json['fornituraGas'])
            : null,
      );

  final String? uuid;

  final double? consumo;

  final DateTime? meseRiferimentoConsumoAnnuo;

  final String? fornituraGasUuid;

  final _i2.FornituraGas? fornituraGas;
}

class FornituraGas {
  const FornituraGas({
    this.uuid,
    this.pdr,
    this.fornituraUuid,
    this.classeMisuratoreGasId,
    this.matricolaContatore,
    this.remi,
    this.classeMisuratore,
    this.consumoAnnuoGas,
    this.contrattiEnelGas,
    this.fornitura,
    this.$count,
  });

  factory FornituraGas.fromJson(Map json) => FornituraGas(
        uuid: json['uuid'],
        pdr: json['pdr'],
        fornituraUuid: json['fornituraUuid'],
        classeMisuratoreGasId: json['classeMisuratoreGasId'],
        matricolaContatore: json['matricolaContatore'],
        remi: json['remi'],
        classeMisuratore: json['classeMisuratore'] is Map
            ? _i2.ClasseMisuratoreGas.fromJson(json['classeMisuratore'])
            : null,
        consumoAnnuoGas: json['consumoAnnuoGas'] is Map
            ? _i2.ConsumoAnnuoGas.fromJson(json['consumoAnnuoGas'])
            : null,
        contrattiEnelGas: (json['contrattiEnelGas'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelGas.fromJson(json)),
        fornitura: json['fornitura'] is Map
            ? _i2.Fornitura.fromJson(json['fornitura'])
            : null,
        $count: json['_count'] is Map
            ? _i3.FornituraGasCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? pdr;

  final String? fornituraUuid;

  final String? classeMisuratoreGasId;

  final String? matricolaContatore;

  final String? remi;

  final _i2.ClasseMisuratoreGas? classeMisuratore;

  final _i2.ConsumoAnnuoGas? consumoAnnuoGas;

  final Iterable<_i2.ContrattoEnelGas>? contrattiEnelGas;

  final _i2.Fornitura? fornitura;

  final _i3.FornituraGasCountOutputType? $count;
}

class ContrattoEnelGas {
  const ContrattoEnelGas({
    this.uuid,
    this.statoContrattoId,
    this.fornituraGasUuid,
    this.contrattoUuid,
    this.offertaUuid,
    this.stato,
    this.fornituraGas,
    this.contratto,
    this.offerta,
  });

  factory ContrattoEnelGas.fromJson(Map json) => ContrattoEnelGas(
        uuid: json['uuid'],
        statoContrattoId: json['statoContrattoId'],
        fornituraGasUuid: json['fornituraGasUuid'],
        contrattoUuid: json['contrattoUuid'],
        offertaUuid: json['offertaUuid'],
        stato: json['stato'] is Map
            ? _i2.StatoContratto.fromJson(json['stato'])
            : null,
        fornituraGas: json['fornituraGas'] is Map
            ? _i2.FornituraGas.fromJson(json['fornituraGas'])
            : null,
        contratto: json['contratto'] is Map
            ? _i2.Contratto.fromJson(json['contratto'])
            : null,
        offerta: json['offerta'] is Map
            ? _i2.Offerta.fromJson(json['offerta'])
            : null,
      );

  final String? uuid;

  final String? statoContrattoId;

  final String? fornituraGasUuid;

  final String? contrattoUuid;

  final String? offertaUuid;

  final _i2.StatoContratto? stato;

  final _i2.FornituraGas? fornituraGas;

  final _i2.Contratto? contratto;

  final _i2.Offerta? offerta;
}

enum ServizioContrattoEnelFibra implements _i1.PrismaEnum {
  dati._('DATI'),
  datiVoce._('DATI_VOCE');

  const ServizioContrattoEnelFibra._(this.name);

  @override
  final String name;
}

enum TipoContrattoEnelFibra implements _i1.PrismaEnum {
  nuovaAttivazione._('NUOVA_ATTIVAZIONE'),
  migrazione._('MIGRAZIONE');

  const TipoContrattoEnelFibra._(this.name);

  @override
  final String name;
}

enum TecnologiaContrattoEnelFibra implements _i1.PrismaEnum {
  ftth._('FTTH'),
  fttc._('FTTC');

  const TecnologiaContrattoEnelFibra._(this.name);

  @override
  final String name;
}

class ContrattoEnelFibra {
  const ContrattoEnelFibra({
    this.uuid,
    this.statoContrattoId,
    this.contrattoUuid,
    this.servizioContrattoEnelFibra,
    this.tipoContrattoEnelFibra,
    this.tecnologiaContrattoEnelFibra,
    this.domicilioUuid,
    this.offertaUuid,
    this.stato,
    this.contratto,
    this.offerta,
    this.domicilio,
  });

  factory ContrattoEnelFibra.fromJson(Map json) => ContrattoEnelFibra(
        uuid: json['uuid'],
        statoContrattoId: json['statoContrattoId'],
        contrattoUuid: json['contrattoUuid'],
        servizioContrattoEnelFibra: json['servizioContrattoEnelFibra'] != null
            ? _i2.ServizioContrattoEnelFibra.values
                .firstWhere((e) => e.name == json['servizioContrattoEnelFibra'])
            : null,
        tipoContrattoEnelFibra: json['tipoContrattoEnelFibra'] != null
            ? _i2.TipoContrattoEnelFibra.values
                .firstWhere((e) => e.name == json['tipoContrattoEnelFibra'])
            : null,
        tecnologiaContrattoEnelFibra:
            json['tecnologiaContrattoEnelFibra'] != null
                ? _i2.TecnologiaContrattoEnelFibra.values.firstWhere(
                    (e) => e.name == json['tecnologiaContrattoEnelFibra'])
                : null,
        domicilioUuid: json['domicilioUuid'],
        offertaUuid: json['offertaUuid'],
        stato: json['stato'] is Map
            ? _i2.StatoContratto.fromJson(json['stato'])
            : null,
        contratto: json['contratto'] is Map
            ? _i2.Contratto.fromJson(json['contratto'])
            : null,
        offerta: json['offerta'] is Map
            ? _i2.Offerta.fromJson(json['offerta'])
            : null,
        domicilio: json['domicilio'] is Map
            ? _i2.Domicilio.fromJson(json['domicilio'])
            : null,
      );

  final String? uuid;

  final String? statoContrattoId;

  final String? contrattoUuid;

  final _i2.ServizioContrattoEnelFibra? servizioContrattoEnelFibra;

  final _i2.TipoContrattoEnelFibra? tipoContrattoEnelFibra;

  final _i2.TecnologiaContrattoEnelFibra? tecnologiaContrattoEnelFibra;

  final String? domicilioUuid;

  final String? offertaUuid;

  final _i2.StatoContratto? stato;

  final _i2.Contratto? contratto;

  final _i2.Offerta? offerta;

  final _i2.Domicilio? domicilio;
}

class Offerta {
  const Offerta({
    this.uuid,
    this.nome,
    this.dataFineOfferta,
    this.dataInizioOfferta,
    this.servizioEwoId,
    this.servizioEwo,
    this.contrattiEnelLuce,
    this.contrattiEnelGas,
    this.contrattiEnelFibra,
    this.contrattiEnelXAssicurazione,
    this.offerteIncluse,
    this.inclusaInOfferte,
    this.$count,
  });

  factory Offerta.fromJson(Map json) => Offerta(
        uuid: json['uuid'],
        nome: json['nome'],
        dataFineOfferta: json['dataFineOfferta'],
        dataInizioOfferta: json['dataInizioOfferta'],
        servizioEwoId: json['servizioEwoId'],
        servizioEwo: json['servizioEwo'] is Map
            ? _i2.ServizioEwo.fromJson(json['servizioEwo'])
            : null,
        contrattiEnelLuce: (json['contrattiEnelLuce'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelLuce.fromJson(json)),
        contrattiEnelGas: (json['contrattiEnelGas'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelGas.fromJson(json)),
        contrattiEnelFibra: (json['contrattiEnelFibra'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelFibra.fromJson(json)),
        contrattiEnelXAssicurazione:
            (json['contrattiEnelXAssicurazione'] as Iterable?)
                ?.map((json) => _i2.ContrattoEnelXAssicurazione.fromJson(json)),
        offerteIncluse: (json['offerteIncluse'] as Iterable?)
            ?.map((json) => _i2.Offerta.fromJson(json)),
        inclusaInOfferte: (json['inclusaInOfferte'] as Iterable?)
            ?.map((json) => _i2.Offerta.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.OffertaCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? nome;

  final DateTime? dataFineOfferta;

  final DateTime? dataInizioOfferta;

  final String? servizioEwoId;

  final _i2.ServizioEwo? servizioEwo;

  final Iterable<_i2.ContrattoEnelLuce>? contrattiEnelLuce;

  final Iterable<_i2.ContrattoEnelGas>? contrattiEnelGas;

  final Iterable<_i2.ContrattoEnelFibra>? contrattiEnelFibra;

  final Iterable<_i2.ContrattoEnelXAssicurazione>? contrattiEnelXAssicurazione;

  final Iterable<_i2.Offerta>? offerteIncluse;

  final Iterable<_i2.Offerta>? inclusaInOfferte;

  final _i3.OffertaCountOutputType? $count;
}

class ServizioEwo {
  const ServizioEwo({
    this.id,
    this.nome,
    this.fornitoreId,
    this.tipoServizioEwo,
    this.colore,
    this.icona,
    this.fornitore,
    this.tipiPratiche,
    this.forniture,
    this.statiPossibiliPratiche,
    this.statiPossibiliContratti,
    this.offerte,
    this.moduliContratto,
    this.$count,
  });

  factory ServizioEwo.fromJson(Map json) => ServizioEwo(
        id: json['id'],
        nome: json['nome'],
        fornitoreId: json['fornitoreId'],
        tipoServizioEwo: json['tipoServizioEwo'] != null
            ? _i2.TipoServizioEwo.values
                .firstWhere((e) => e.name == json['tipoServizioEwo'])
            : null,
        colore: json['colore'],
        icona: json['icona'],
        fornitore: json['fornitore'] is Map
            ? _i2.Fornitore.fromJson(json['fornitore'])
            : null,
        tipiPratiche: (json['tipiPratiche'] as Iterable?)
            ?.map((json) => _i2.TipoPratica.fromJson(json)),
        forniture: (json['forniture'] as Iterable?)
            ?.map((json) => _i2.Fornitura.fromJson(json)),
        statiPossibiliPratiche: (json['statiPossibiliPratiche'] as Iterable?)
            ?.map((json) => _i2.StatoPratica.fromJson(json)),
        statiPossibiliContratti: (json['statiPossibiliContratti'] as Iterable?)
            ?.map((json) => _i2.StatoContratto.fromJson(json)),
        offerte: (json['offerte'] as Iterable?)
            ?.map((json) => _i2.Offerta.fromJson(json)),
        moduliContratto: (json['moduliContratto'] as Iterable?)
            ?.map((json) => _i2.ModuloContratto.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.ServizioEwoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final String? fornitoreId;

  final _i2.TipoServizioEwo? tipoServizioEwo;

  final String? colore;

  final String? icona;

  final _i2.Fornitore? fornitore;

  final Iterable<_i2.TipoPratica>? tipiPratiche;

  final Iterable<_i2.Fornitura>? forniture;

  final Iterable<_i2.StatoPratica>? statiPossibiliPratiche;

  final Iterable<_i2.StatoContratto>? statiPossibiliContratti;

  final Iterable<_i2.Offerta>? offerte;

  final Iterable<_i2.ModuloContratto>? moduliContratto;

  final _i3.ServizioEwoCountOutputType? $count;
}

class Fornitura {
  const Fornitura({
    this.uuid,
    this.etichetta,
    this.domicilioUuid,
    this.servizioEwoId,
    this.domicilio,
    this.servizioEwo,
    this.fornituraLuce,
    this.fornituraGas,
  });

  factory Fornitura.fromJson(Map json) => Fornitura(
        uuid: json['uuid'],
        etichetta: json['etichetta'],
        domicilioUuid: json['domicilioUuid'],
        servizioEwoId: json['servizioEwoId'],
        domicilio: json['domicilio'] is Map
            ? _i2.Domicilio.fromJson(json['domicilio'])
            : null,
        servizioEwo: json['servizioEwo'] is Map
            ? _i2.ServizioEwo.fromJson(json['servizioEwo'])
            : null,
        fornituraLuce: json['fornituraLuce'] is Map
            ? _i2.FornituraLuce.fromJson(json['fornituraLuce'])
            : null,
        fornituraGas: json['fornituraGas'] is Map
            ? _i2.FornituraGas.fromJson(json['fornituraGas'])
            : null,
      );

  final String? uuid;

  final String? etichetta;

  final String? domicilioUuid;

  final String? servizioEwoId;

  final _i2.Domicilio? domicilio;

  final _i2.ServizioEwo? servizioEwo;

  final _i2.FornituraLuce? fornituraLuce;

  final _i2.FornituraGas? fornituraGas;
}

class FornituraLuce {
  const FornituraLuce({
    this.uuid,
    this.pod,
    this.fornituraUuid,
    this.potenza,
    this.tensione,
    this.consumoAnnuoLuce,
    this.contrattiEnelLuce,
    this.fornitura,
    this.$count,
  });

  factory FornituraLuce.fromJson(Map json) => FornituraLuce(
        uuid: json['uuid'],
        pod: json['pod'],
        fornituraUuid: json['fornituraUuid'],
        potenza: json['potenza'],
        tensione: json['tensione'],
        consumoAnnuoLuce: json['consumoAnnuoLuce'] is Map
            ? _i2.ConsumoAnnuoLuce.fromJson(json['consumoAnnuoLuce'])
            : null,
        contrattiEnelLuce: (json['contrattiEnelLuce'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelLuce.fromJson(json)),
        fornitura: json['fornitura'] is Map
            ? _i2.Fornitura.fromJson(json['fornitura'])
            : null,
        $count: json['_count'] is Map
            ? _i3.FornituraLuceCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? pod;

  final String? fornituraUuid;

  final double? potenza;

  final double? tensione;

  final _i2.ConsumoAnnuoLuce? consumoAnnuoLuce;

  final Iterable<_i2.ContrattoEnelLuce>? contrattiEnelLuce;

  final _i2.Fornitura? fornitura;

  final _i3.FornituraLuceCountOutputType? $count;
}

class ContrattoEnelLuce {
  const ContrattoEnelLuce({
    this.uuid,
    this.statoContrattoId,
    this.fornituraLuceUuid,
    this.contrattoUuid,
    this.offertaUuid,
    this.stato,
    this.fornituraLuce,
    this.contratto,
    this.offerta,
  });

  factory ContrattoEnelLuce.fromJson(Map json) => ContrattoEnelLuce(
        uuid: json['uuid'],
        statoContrattoId: json['statoContrattoId'],
        fornituraLuceUuid: json['fornituraLuceUuid'],
        contrattoUuid: json['contrattoUuid'],
        offertaUuid: json['offertaUuid'],
        stato: json['stato'] is Map
            ? _i2.StatoContratto.fromJson(json['stato'])
            : null,
        fornituraLuce: json['fornituraLuce'] is Map
            ? _i2.FornituraLuce.fromJson(json['fornituraLuce'])
            : null,
        contratto: json['contratto'] is Map
            ? _i2.Contratto.fromJson(json['contratto'])
            : null,
        offerta: json['offerta'] is Map
            ? _i2.Offerta.fromJson(json['offerta'])
            : null,
      );

  final String? uuid;

  final String? statoContrattoId;

  final String? fornituraLuceUuid;

  final String? contrattoUuid;

  final String? offertaUuid;

  final _i2.StatoContratto? stato;

  final _i2.FornituraLuce? fornituraLuce;

  final _i2.Contratto? contratto;

  final _i2.Offerta? offerta;
}

class Contratto {
  const Contratto({
    this.uuid,
    this.codice,
    this.dataInserimento,
    this.dataAttivazione,
    this.ultimoAggiornamentoStato,
    this.trend,
    this.nota,
    this.marketingEnelEnergia,
    this.marketingGruppoEnel,
    this.profilazioneEnelEnergia,
    this.bollettaWeb,
    this.rid,
    this.dataCessazione,
    this.mesiDurata,
    this.offertaUuid,
    this.statoContrattoId,
    this.soggettoUuid,
    this.utenteUuid,
    this.negozioCodice,
    this.praticaUuid,
    this.moduloContrattoId,
    this.contrattiEnelLuce,
    this.contrattiEnelGas,
    this.contrattiEnelFibra,
    this.contrattiEnelXAssicurazione,
    this.stato,
    this.soggetto,
    this.utente,
    this.negozio,
    this.pratica,
    this.modulo,
    this.$count,
  });

  factory Contratto.fromJson(Map json) => Contratto(
        uuid: json['uuid'],
        codice: json['codice'],
        dataInserimento: json['dataInserimento'],
        dataAttivazione: json['dataAttivazione'],
        ultimoAggiornamentoStato: json['ultimoAggiornamentoStato'],
        trend: json['trend'],
        nota: json['nota'],
        marketingEnelEnergia: json['marketingEnelEnergia'],
        marketingGruppoEnel: json['marketingGruppoEnel'],
        profilazioneEnelEnergia: json['profilazioneEnelEnergia'],
        bollettaWeb: json['bollettaWeb'],
        rid: json['rid'],
        dataCessazione: json['dataCessazione'],
        mesiDurata: json['mesiDurata'],
        offertaUuid: json['offertaUuid'],
        statoContrattoId: json['statoContrattoId'],
        soggettoUuid: json['soggettoUuid'],
        utenteUuid: json['utenteUuid'],
        negozioCodice: json['negozioCodice'],
        praticaUuid: json['praticaUuid'],
        moduloContrattoId: json['moduloContrattoId'],
        contrattiEnelLuce: (json['contrattiEnelLuce'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelLuce.fromJson(json)),
        contrattiEnelGas: (json['contrattiEnelGas'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelGas.fromJson(json)),
        contrattiEnelFibra: (json['contrattiEnelFibra'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelFibra.fromJson(json)),
        contrattiEnelXAssicurazione:
            (json['contrattiEnelXAssicurazione'] as Iterable?)
                ?.map((json) => _i2.ContrattoEnelXAssicurazione.fromJson(json)),
        stato: json['stato'] is Map
            ? _i2.StatoContratto.fromJson(json['stato'])
            : null,
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        utente:
            json['utente'] is Map ? _i2.Utente.fromJson(json['utente']) : null,
        negozio: json['negozio'] is Map
            ? _i2.Negozio.fromJson(json['negozio'])
            : null,
        pratica: json['pratica'] is Map
            ? _i2.Pratica.fromJson(json['pratica'])
            : null,
        modulo: json['modulo'] is Map
            ? _i2.ModuloContratto.fromJson(json['modulo'])
            : null,
        $count: json['_count'] is Map
            ? _i3.ContrattoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? codice;

  final DateTime? dataInserimento;

  final DateTime? dataAttivazione;

  final DateTime? ultimoAggiornamentoStato;

  final bool? trend;

  final String? nota;

  final bool? marketingEnelEnergia;

  final bool? marketingGruppoEnel;

  final bool? profilazioneEnelEnergia;

  final bool? bollettaWeb;

  final bool? rid;

  final DateTime? dataCessazione;

  final int? mesiDurata;

  final String? offertaUuid;

  final String? statoContrattoId;

  final String? soggettoUuid;

  final String? utenteUuid;

  final String? negozioCodice;

  final String? praticaUuid;

  final String? moduloContrattoId;

  final Iterable<_i2.ContrattoEnelLuce>? contrattiEnelLuce;

  final Iterable<_i2.ContrattoEnelGas>? contrattiEnelGas;

  final Iterable<_i2.ContrattoEnelFibra>? contrattiEnelFibra;

  final Iterable<_i2.ContrattoEnelXAssicurazione>? contrattiEnelXAssicurazione;

  final _i2.StatoContratto? stato;

  final _i2.Soggetto? soggetto;

  final _i2.Utente? utente;

  final _i2.Negozio? negozio;

  final _i2.Pratica? pratica;

  final _i2.ModuloContratto? modulo;

  final _i3.ContrattoCountOutputType? $count;
}

class StatoContratto {
  const StatoContratto({
    this.id,
    this.nome,
    this.contratti,
    this.serviziEwo,
    this.contrattiEnelLuce,
    this.contrattiEnelGas,
    this.contrattiEnelFibra,
    this.contrattiEnelXAssicurazione,
    this.$count,
  });

  factory StatoContratto.fromJson(Map json) => StatoContratto(
        id: json['id'],
        nome: json['nome'],
        contratti: (json['contratti'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        serviziEwo: (json['serviziEwo'] as Iterable?)
            ?.map((json) => _i2.ServizioEwo.fromJson(json)),
        contrattiEnelLuce: (json['contrattiEnelLuce'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelLuce.fromJson(json)),
        contrattiEnelGas: (json['contrattiEnelGas'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelGas.fromJson(json)),
        contrattiEnelFibra: (json['contrattiEnelFibra'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelFibra.fromJson(json)),
        contrattiEnelXAssicurazione:
            (json['contrattiEnelXAssicurazione'] as Iterable?)
                ?.map((json) => _i2.ContrattoEnelXAssicurazione.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.StatoContrattoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? id;

  final String? nome;

  final Iterable<_i2.Contratto>? contratti;

  final Iterable<_i2.ServizioEwo>? serviziEwo;

  final Iterable<_i2.ContrattoEnelLuce>? contrattiEnelLuce;

  final Iterable<_i2.ContrattoEnelGas>? contrattiEnelGas;

  final Iterable<_i2.ContrattoEnelFibra>? contrattiEnelFibra;

  final Iterable<_i2.ContrattoEnelXAssicurazione>? contrattiEnelXAssicurazione;

  final _i3.StatoContrattoCountOutputType? $count;
}

class ContrattoEnelXAssicurazione {
  const ContrattoEnelXAssicurazione({
    this.uuid,
    this.statoContrattoId,
    this.contrattoUuid,
    this.domicilioUuid,
    this.offertaUuid,
    this.stato,
    this.contratto,
    this.domicilio,
    this.offerta,
  });

  factory ContrattoEnelXAssicurazione.fromJson(Map json) =>
      ContrattoEnelXAssicurazione(
        uuid: json['uuid'],
        statoContrattoId: json['statoContrattoId'],
        contrattoUuid: json['contrattoUuid'],
        domicilioUuid: json['domicilioUuid'],
        offertaUuid: json['offertaUuid'],
        stato: json['stato'] is Map
            ? _i2.StatoContratto.fromJson(json['stato'])
            : null,
        contratto: json['contratto'] is Map
            ? _i2.Contratto.fromJson(json['contratto'])
            : null,
        domicilio: json['domicilio'] is Map
            ? _i2.Domicilio.fromJson(json['domicilio'])
            : null,
        offerta: json['offerta'] is Map
            ? _i2.Offerta.fromJson(json['offerta'])
            : null,
      );

  final String? uuid;

  final String? statoContrattoId;

  final String? contrattoUuid;

  final String? domicilioUuid;

  final String? offertaUuid;

  final _i2.StatoContratto? stato;

  final _i2.Contratto? contratto;

  final _i2.Domicilio? domicilio;

  final _i2.Offerta? offerta;
}

class Domicilio {
  const Domicilio({
    this.uuid,
    this.etichetta,
    this.indirizzo,
    this.numeroCivico,
    this.citta,
    this.cap,
    this.provincia,
    this.soggettoUuid,
    this.soggetto,
    this.contrattiEnelXAssicurazione,
    this.forniture,
    this.contrattiEnelFibra,
    this.prodottiOrdinati,
    this.leads,
    this.$count,
  });

  factory Domicilio.fromJson(Map json) => Domicilio(
        uuid: json['uuid'],
        etichetta: json['etichetta'],
        indirizzo: json['indirizzo'],
        numeroCivico: json['numeroCivico'],
        citta: json['citta'],
        cap: json['cap'],
        provincia: json['provincia'],
        soggettoUuid: json['soggettoUuid'],
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
        contrattiEnelXAssicurazione:
            (json['contrattiEnelXAssicurazione'] as Iterable?)
                ?.map((json) => _i2.ContrattoEnelXAssicurazione.fromJson(json)),
        forniture: (json['forniture'] as Iterable?)
            ?.map((json) => _i2.Fornitura.fromJson(json)),
        contrattiEnelFibra: (json['contrattiEnelFibra'] as Iterable?)
            ?.map((json) => _i2.ContrattoEnelFibra.fromJson(json)),
        prodottiOrdinati: (json['prodottiOrdinati'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        leads: (json['leads'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        $count: json['_count'] is Map
            ? _i3.DomicilioCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? etichetta;

  final String? indirizzo;

  final String? numeroCivico;

  final String? citta;

  final String? cap;

  final String? provincia;

  final String? soggettoUuid;

  final _i2.Soggetto? soggetto;

  final Iterable<_i2.ContrattoEnelXAssicurazione>? contrattiEnelXAssicurazione;

  final Iterable<_i2.Fornitura>? forniture;

  final Iterable<_i2.ContrattoEnelFibra>? contrattiEnelFibra;

  final Iterable<_i2.Ordine>? prodottiOrdinati;

  final Iterable<_i2.Lead>? leads;

  final _i3.DomicilioCountOutputType? $count;
}

class Privacy {
  const Privacy({
    this.uuid,
    this.trattamento,
    this.comunicazione,
    this.profilazione,
    this.soggettoUuid,
    this.soggetto,
  });

  factory Privacy.fromJson(Map json) => Privacy(
        uuid: json['uuid'],
        trattamento: json['trattamento'],
        comunicazione: json['comunicazione'],
        profilazione: json['profilazione'],
        soggettoUuid: json['soggettoUuid'],
        soggetto: json['soggetto'] is Map
            ? _i2.Soggetto.fromJson(json['soggetto'])
            : null,
      );

  final String? uuid;

  final bool? trattamento;

  final bool? comunicazione;

  final bool? profilazione;

  final String? soggettoUuid;

  final _i2.Soggetto? soggetto;
}

class Soggetto {
  const Soggetto({
    this.uuid,
    this.ragioneSociale,
    this.iban,
    this.tipo,
    this.negozioPreferitoUuid,
    this.codiceFiscale,
    this.note,
    this.soggettoBusinessInfo,
    this.domicili,
    this.praticheIntestate,
    this.contratti,
    this.indirizziEmail,
    this.numeriTelefono,
    this.negozioPreferito,
    this.prodottiOrdinati,
    this.leads,
    this.privacy,
    this.$count,
  });

  factory Soggetto.fromJson(Map json) => Soggetto(
        uuid: json['uuid'],
        ragioneSociale: json['ragioneSociale'],
        iban: json['iban'],
        tipo: json['tipo'] != null
            ? _i2.TipoSoggetto.values.firstWhere((e) => e.name == json['tipo'])
            : null,
        negozioPreferitoUuid: json['negozioPreferitoUuid'],
        codiceFiscale: json['codiceFiscale'],
        note: json['note'],
        soggettoBusinessInfo: json['soggettoBusinessInfo'] is Map
            ? _i2.SoggettoBusinessInfo.fromJson(json['soggettoBusinessInfo'])
            : null,
        domicili: (json['domicili'] as Iterable?)
            ?.map((json) => _i2.Domicilio.fromJson(json)),
        praticheIntestate: (json['praticheIntestate'] as Iterable?)
            ?.map((json) => _i2.Pratica.fromJson(json)),
        contratti: (json['contratti'] as Iterable?)
            ?.map((json) => _i2.Contratto.fromJson(json)),
        indirizziEmail: (json['indirizziEmail'] as Iterable?)
            ?.map((json) => _i2.IndirizzoEmail.fromJson(json)),
        numeriTelefono: (json['numeriTelefono'] as Iterable?)
            ?.map((json) => _i2.NumeroTelefono.fromJson(json)),
        negozioPreferito: json['negozioPreferito'] is Map
            ? _i2.Negozio.fromJson(json['negozioPreferito'])
            : null,
        prodottiOrdinati: (json['prodottiOrdinati'] as Iterable?)
            ?.map((json) => _i2.Ordine.fromJson(json)),
        leads: (json['leads'] as Iterable?)
            ?.map((json) => _i2.Lead.fromJson(json)),
        privacy: json['privacy'] is Map
            ? _i2.Privacy.fromJson(json['privacy'])
            : null,
        $count: json['_count'] is Map
            ? _i3.SoggettoCountOutputType.fromJson(json['_count'])
            : null,
      );

  final String? uuid;

  final String? ragioneSociale;

  final String? iban;

  final _i2.TipoSoggetto? tipo;

  final String? negozioPreferitoUuid;

  final String? codiceFiscale;

  final String? note;

  final _i2.SoggettoBusinessInfo? soggettoBusinessInfo;

  final Iterable<_i2.Domicilio>? domicili;

  final Iterable<_i2.Pratica>? praticheIntestate;

  final Iterable<_i2.Contratto>? contratti;

  final Iterable<_i2.IndirizzoEmail>? indirizziEmail;

  final Iterable<_i2.NumeroTelefono>? numeriTelefono;

  final _i2.Negozio? negozioPreferito;

  final Iterable<_i2.Ordine>? prodottiOrdinati;

  final Iterable<_i2.Lead>? leads;

  final _i2.Privacy? privacy;

  final _i3.SoggettoCountOutputType? $count;
}
