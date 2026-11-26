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
 
