/*  ==========================================================================
    SISTEMA EXPERTO PARA DIAGNÓSTICO DE FALLAS DE COMPUTADORA
    Paradigma: Programación Lógica (Prolog / SWI-Prolog)
 
    Uso:   ?- [diagnostico_pc].
           ?- iniciar.
    ========================================================================== */
 
:- use_module(library(readutil)).
:- use_module(library(apply)).
:- use_module(library(lists)).
 
% Base de datos dinámica: respuestas del usuario (metaprogramación)
:- dynamic si/1, no/1.
 
/* ==========================================================================
   1. BASE DE CONOCIMIENTO
   ========================================================================== */
 
% sintoma(Id, Pregunta)  -- el orden de las cláusulas es el orden de las preguntas
sintoma(no_enciende,          '¿La PC no enciende en absoluto (sin luces ni ventiladores)?').
sintoma(enciende_sin_video,   '¿Enciende y los ventiladores giran, pero no hay imagen?').
sintoma(pitidos,              '¿Emite pitidos al encender?').
sintoma(olor_quemado,         '¿Percibes olor a quemado o ves componentes dañados?').
sintoma(se_apaga_sola,        '¿Se apaga sola de forma repentina?').
sintoma(reinicios_aleatorios, '¿Se reinicia sola sin previo aviso?').
sintoma(pantalla_azul,        '¿Aparecen pantallas azules de error?').
sintoma(artefactos_video,     '¿Ves rayas, parpadeos o colores extraños en pantalla?').
sintoma(bajo_carga,           '¿Falla sobre todo en tareas pesadas (juegos, edición, etc.)?').
sintoma(temperatura_alta,     '¿El equipo se siente muy caliente al tacto?').
sintoma(ventilador_ruidoso,   '¿Los ventiladores suenan muy fuerte o giran al máximo?').
sintoma(ruidos_disco,         '¿Escuchas clics o ruidos raros provenientes del disco duro?').
sintoma(lentitud_extrema,     '¿El equipo está extremadamente lento?').
sintoma(no_arranca_so,        '¿Muestra "no boot device" o el sistema operativo no carga?').
sintoma(archivos_corruptos,   '¿Hay archivos que desaparecen o se corrompen?').
sintoma(programas_se_cierran, '¿Los programas se cierran solos o se congelan?').
sintoma(publicidad_emergente, '¿Aparece publicidad emergente o programas que no instalaste?').
sintoma(actualizacion_reciente,'¿Los problemas empezaron tras instalar una actualización o programa?').
 
 % falla(Id, Nombre, PuntajeBase, SintomasAsociados)
falla(fuente_poder,       'Falla de la fuente de poder', 60,
      [no_enciende, se_apaga_sola, olor_quemado, bajo_carga]).
falla(ram,                'Memoria RAM defectuosa o mal conectada', 55,
      [pitidos, pantalla_azul, reinicios_aleatorios, enciende_sin_video, programas_se_cierran]).
falla(tarjeta_video,      'Falla de la tarjeta de video', 55,
      [enciende_sin_video, artefactos_video, pantalla_azul, bajo_carga]).
falla(sobrecalentamiento, 'Sobrecalentamiento', 50,
      [temperatura_alta, ventilador_ruidoso, se_apaga_sola, bajo_carga, lentitud_extrema]).
falla(disco_duro,         'Falla del disco duro', 55,
      [ruidos_disco, lentitud_extrema, no_arranca_so, archivos_corruptos, pantalla_azul]).
falla(sistema_operativo,  'Sistema operativo dañado', 45,
      [no_arranca_so, pantalla_azul, archivos_corruptos, actualizacion_reciente]).
falla(software,           'Problemas de software o malware', 40,
      [programas_se_cierran, lentitud_extrema, publicidad_emergente, actualizacion_reciente]).

% requisito(Falla, Sintoma): síntoma necesario; si el usuario dice "no", se descarta.
requisito(sobrecalentamiento, temperatura_alta).

% incompatible(Falla, Sintoma): si el síntoma está presente, la falla es imposible.
incompatible(sistema_operativo, no_enciende).
incompatible(software,          no_enciende).
incompatible(disco_duro,        no_enciende).
incompatible(tarjeta_video,     no_enciende).
incompatible(software,          enciende_sin_video).
incompatible(software,          pitidos).
incompatible(sistema_operativo, pitidos).
incompatible(sistema_operativo, enciende_sin_video).

% solucion(Falla, PlanDeAccion)
solucion(fuente_poder, [
    'Verifica el cable de alimentación, la regleta y el interruptor trasero.',
    'Prueba la fuente con otra compatible o con un probador de fuentes.',
    'Reemplaza la fuente de poder si no entrega voltajes estables.']).
solucion(ram, [
    'Apaga y desconecta la PC; retira los módulos de RAM.',
    'Limpia los contactos dorados con alcohol isopropílico y reinsértalos.',
    'Prueba cada módulo por separado (o ejecuta MemTest86) y reemplaza el defectuoso.']).
solucion(tarjeta_video, [
    'Reasienta la tarjeta de video y revisa los cables de alimentación PCIe.',
    'Actualiza o reinstala los drivers de video (usa DDU en modo seguro).',
    'Prueba con otro monitor/cable o con otra tarjeta; reemplázala si persiste.']).
solucion(sobrecalentamiento, [
    'Limpia el polvo de ventiladores y disipadores con aire comprimido.',
    'Reemplaza la pasta térmica del procesador (y GPU si aplica).',
    'Verifica que los ventiladores giren y mejora el flujo de aire del gabinete.']).
solucion(disco_duro, [
    'Respalda de inmediato tus datos importantes.',
    'Revisa el estado SMART con CrystalDiskInfo o smartctl.',
    'Reemplaza el disco (idealmente por un SSD) y reinstala el sistema.']).
solucion(sistema_operativo, [
    'Arranca desde un medio de instalación y usa la reparación de inicio.',
    'Ejecuta "sfc /scannow" y "DISM /RestoreHealth" si puedes entrar.',
    'Como último recurso, respalda tus datos y reinstala el sistema operativo.']).
solucion(software, [
    'Desinstala programas sospechosos o recientes.',
    'Analiza el equipo con un antivirus/antimalware actualizado.',
    'Restaura el sistema a un punto anterior o actualiza los programas afectados.']).