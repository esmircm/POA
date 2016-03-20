
//URL
var http = location.protocol;
var slashes = http.concat("//");
var baseUrl = slashes.concat(window.location.hostname);
if (baseUrl.indexOf('.minmujer.gob.ve') == -1) {
    var pathArray = window.location.pathname.split('/');
    var ruta = '/' + pathArray[1]; // 
    baseUrl = $(location).attr('href').replace($(location).attr('pathname'), ruta);
}
/*
 * FUNCION QUE BUSCA EN SAIME POR NUMERO DE CEDULA 
 */
function buscarPersonaRrhh(cedula) {

    //alert (cedula); return false; 
//    if (cedula == '') {
//        bootbox.alert('Verifique que la cédula no esten vacios');
//        return false;
//        
//    }
    $.ajax({
        url: baseUrl + "/ValidacionJs/buscarRrhh",
        async: true,
        type: 'POST',
        data: 'cedula=' + cedula,
        dataType: 'json',
        success: function(datos) {
            //  alert(datos['strprimer_nombre']);
//            if (!datos) {
//                bootbox.alert('Debe Completar el campo Cédula');
//                $('.limpiar').val('');
//                $('#Personas_sexo').val('');
//            } else {
//                if (datos['intcedula'] == null) {
//                    bootbox.alert('El número de Cédula no existe');
//                    $('#Personas_sexo').val('');
//                    $('.limpiar').val('');
//                } else {
            $('#Personal_id_personal').val(datos['id_personal']);
            $('#Personal_cedula').val(datos['cedula']);
            $('#Personal_primer_nombre').val(datos['primer_nombre']);
            $('#Personal_segundo_nombre').val(datos['segundo_nombre']);
            $('#Personal_primer_apellido').val(datos['primer_apellido']);
            $('#Personal_segundo_apellido').val(datos['segundo_apellido']);
            $('#Personal_sexo').val(datos['sexo']);
            $('#Personal_estado_civil').val(datos['estado_civil']);
            $('#Personal_madre_padre').val(datos['madre_padre']);
            $('#Personal_discapacidad').val(datos['discapacidad']);
            $('#Personal_tipodiscapacidad').val(datos['tipodiscapacidad']);
            $('#Personal_puebloindigena').val(datos['puebloindigena']);

            $('#Personal_fecha_nacimiento').val(datos['fecha_nacimiento']);
            $('#Personal_nacionalidad').val(datos['nacionalidad']);
            $('#Personal_id_pais_nacionalidad').val(datos['id_pais_nacionalidad']);
            $('#Personal_id_ciudad_nacimiento').val(datos['id_ciudad_nacimiento']);
            $('#Personal_id_ciudad_nacimiento').val(datos['id_ciudad_nacimiento']);
            $('#Personal_fecha_fallecimiento').val(datos['fecha_fallecimiento']);
            $('#Personal_doble_nacionalidad').val(datos['doble_nacionalidad']);
            $('#Personal_otra_normativa_nac').val(datos['otra_normativa_nac']);
            $('#Personal_fecha_nacimiento').val(datos['fecha_nacimiento']);
            $('#Personal_gaceta_nacionalizacion').val(datos['gaceta_nacionalizacion']);
            $('#Personal_fecha_nacionalizacion').val(datos['fecha_nacionalizacion']);
            $('#Personal_otra_normativa_nac').val(datos['otra_normativa_nac']);

            $('#Personal_direccion_residencia').val(datos['direccion_residencia']);
            $('#Personal_zona_postal_residencia').val(datos['zona_postal_residencia']);
            $('#Personal_id_ciudad_nacimiento').val(datos['id_ciudad_nacimiento']);
            $('#Personal_id_ciudad_residencia').val(datos['id_ciudad_residencia']);
            $('#Personal_id_ciudad_residencia').val(datos['id_ciudad_residencia']);
            $('#Personal_id_parroquia').val(datos['id_parroquia']);
            $('#Personal_telefono_residencia').val(datos['telefono_residencia']);
            $('#Personal_telefono_celular').val(datos['telefono_celular']);
            $('#Personal_telefono_oficina').val(datos['telefono_oficina']);
            $('#Personal_tenencia_vivienda').val(datos['tenencia_vivienda']);
            $('#Personal_email').val(datos['email']);

            $('#Personal_tipo_vivienda').val(datos['tipo_vivienda']);
            $('#Personal_tiene_vehiculo').val(datos['tiene_vehiculo']);
            $('#Personal_modelo_vehiculo').val(datos['modelo_vehiculo']);
            $('#Personal_marca_vehiculo').val(datos['marca_vehiculo']);
            $('#Personal_placa_vehiculo').val(datos['placa_vehiculo']);
            $('#Personal_numero_sso').val(datos['numero_sso']);
            $('#Personal_numero_rif').val(datos['numero_rif']);
            $('#Personal_numero_libreta_militar').val(datos['numero_libreta_militar']);

//                }
//            }
        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');
        }
    })
}
function buscarPersonaListar(cedula, nacionalidad, nombres, apellidos, descargo, coor, dirg, dirl, desp, id_persona) {

    $.ajax({
        url: baseUrl + "/ValidacionJs/buscarListar",
        async: true,
        type: 'POST',
        data: 'cedula_evaluado=' + cedula + '&nacionalidad =' + nacionalidad + '&nombres =' + nombres + '&apellidos =' + apellidos + '&descargo =' + descargo + '&coor=' + coor + '&dirg=' + dirg + '&dirl=' + dirl + '&desp=' + desp + '&id_persona=' + id_persona,
        dataType: 'json',
        success: function(datos) {

            $('#id_persona').val(datos['id_persona']);
            $('#nacionalidad').val(datos['nacionalidad']);
            $('#cedula').val(datos['cedula']);
            $('#nombres_evaluado').val(datos['nombres']);
            $('#apellidos_evaluado').val(datos['apellidos']);
            $('#cargo_evaluado').val(datos['cargo_evaluado']);
            $('#oficina_evaluado').val(datos['oficina_evaluado']);


        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');
        }
    })
}

function buscarPersonaSupervisor(cedula, nacionalidad, nombres, apellidos, codnomina, descargo, depnombre, id_persona) {

    $.ajax({
        url: baseUrl + "/ValidacionJs/buscarSupervisor",
        async: true,
        type: 'POST',
        data: 'cedula=' + cedula + '&nacionalidad =' + nacionalidad + '&nombres =' + nombres + '&apellidos =' + apellidos + '&codnomina =' + codnomina + '&descargo =' + descargo + '&depnombre =' + depnombre + '&id_persona=' + id_persona,
        dataType: 'json',
        success: function(datos) {

            $('#VswEvaluacion_nacionalidad').val(datos['nacionalidad']);
            $('#VswEvaluacion_cedula').val(datos['cedula']);
            $('#VswEvaluacion_nombres').val(datos['nombres']);
            $('#VswEvaluacion_apellidos').val(datos['apellidos']);
            $('#VswEvaluacion_codigo_nomina').val(datos['codnomina']);
            $('#VswEvaluacion_descripcion_cargo').val(datos['descargo']);
            $('#VswEvaluacion_dependencia').val(datos['depnombre']);
            $('#VswEvaluacion_id_persona').val(datos['id_persona']);

        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');
        }
    })
}

function buscarSupervisado(cedula) {
//alert (id_persona);
    cedula_supervisor = $('#cedula_spervisor').val();
    cedula = $('#vista_busqueda').val();
//    alert($('#vista_busqueda').val());
//    alert($('#cedula_spervisor').val());
    if (cedula_supervisor == cedula) {
        bootbox.alert("La cédula del Supervisado no puede ser la misma del Supervisor.");
        $('#vista_busqueda').val('');
    }
    else {
        $.ajax({
            url: baseUrl + "/ValidacionJs/buscarSupervisado",
            async: true,
            type: 'POST',
            data: 'cedula=' + cedula,
            dataType: 'json',
            success: function(datos) {

                if (datos['respuesta'] == 5) {
                    bootbox.alert('El Evaluado no cumple el tiempo laboral necesario para realizarle una Evaluación.');
                    $('#vista_busqueda').val('');
                }

                if (datos['respuesta'] == 4) {
                    bootbox.alert('No se puede realizar la MRL debido a que la prorroga de los 120 días para agregar Objetivos de Desempeño Individual ha finalizado.');
                    $('#vista_busqueda').val('');
                }

                if (datos['respuesta'] == 3) {
                    bootbox.alert('Los Trabajadores y Trabajadoras se les evalua después de haber transcurrido 120 días del Actual Semestre.');
                    $('#vista_busqueda').val('');
                }

                if (datos['respuesta'] == 1) {
                    bootbox.alert('El Evaluado posee actualmente una evaluación realizada por ' + datos['nombres_evaluador'] + ' ' + datos['apellidos_evaluador'] + ' perteneciente a la ' + datos['direccion'] + '.');
                    $('#vista_busqueda').val('');
                }

                if (datos['respuesta'] == 2) {
                    bootbox.alert('El número de Cedula no está registrado en el Ministerio');
                    $('#vista_busqueda').val('');
                }
                else {
                    $('#vista_busqueda').val(datos['cedula']);
                    $('#vista_fk_tipo_clase').val(datos['fk_tipo_clase']);
                    $('#vista_id_persona').val(datos['id_persona']);
                    $('#vista_nacionalidad').val(datos['nacionalidad']);
                    $('#vista_nombre').val(datos['nombres']);
                    $('#vista_apellidos').val(datos['apellidos']);
                    $('#vista_codigo_nomina').val(datos['codigo_nomina']);
                    $('#vista_descripcion_cargo').val(datos['descripcion_cargo']);
                    $('#vista_dependencia').val(datos['dependencia']);
                }

            },
            error: function(datos) {
                bootbox.alert('Problema con la consulta');

            }
        })
    }
}


/*
 * FUNCION PARA LIMPIAR TODOS AQUELLOS CON CLASE limpiar
 */
function Limpiar() {
    $('.limpiar').val('');


}

function LimpiarDatos(clase) {
    $('.' + clase).val('');
}
function eliminareva() {
    if (confirm("¿Se encuentra seguro de Eliminar esta Evaluación?")) {
        document.getElementById("eliminareva-form").submit();
    }
//    $('eliminareva-form').submit();
// prueba
}

function GuardarFamiliar(cedulaFamiliar, primerNombre, segundoNombre, primerApellido, segundoApellido, estadoCivil, sexo, fechaNacimiento, parentesco, mismoOrganismo, nivelEducativo, grado, promedioNota, gozaUtiles, grupoSanguineo, ninoExcepcional, alergico, alergias, tallaFranela, tallaPantalon, tallaGorra) {
    if ($('#Familiar_cedula_familiar').val() == '') {
        bootbox.alert('Por favor ingrese un numero de cédula.');
        return false;
    }
    if ($('#Familiar_estado_civil').val() == '') {
        bootbox.alert('Seleccione un estado civil.');
        return false;
    }
    if ($('#Familiar_sexo').val() == '') {
        bootbox.alert('Seleccione el sexo.');
        return false;
    }
    if ($('#Familiar_nivel_educativo').val() == '') {
        bootbox.alert('Seleccione el nivel educativo.');
        return false;
    }
    if ($('#Familiar_grupo_sanguineo').val() == '') {
        bootbox.alert('Seleccione el grupo sanguineo.');
        return false;
    }

    if (mismoOrganismo) {
        valorOrganismo = "S";
    } else {
        valorOrganismo = "N";
    }
    if (gozaUtiles) {
        valorUtiles = "S";
    } else {
        valorUtiles = "N";
    }
    if (ninoExcepcional) {
        valorExcepcional = "S";
    } else {
        valorExcepcional = "N";
    }
    if (alergico) {
        valorAlergico = "S";

    } else {
        valorAlergico = "N";

    }
    $.ajax({
        url: baseUrl + "/ValidacionJs/GuardarFamiliar",
        async: true,
        type: 'POST',
        data: 'cedulaFamiliar=' + cedulaFamiliar + '&primerNombre=' + primerNombre + '&segundoNombre=' + segundoNombre + '&primerApellido=' + primerApellido + '&segundoApellido=' + segundoApellido + '&estadoCivil=' + estadoCivil + '&sexo=' + sexo + '&fechaNacimiento=' + fechaNacimiento + '&parentesco=' + parentesco + '&mismoOrganismo=' + valorOrganismo + '&nivelEducativo=' + nivelEducativo + '&grado=' + grado + '&promedioNota=' + promedioNota + '&gozaUtiles=' + valorUtiles + '&grupoSanguineo=' + grupoSanguineo + '&ninoExcepcional=' + valorExcepcional + '&alergico=' + valorAlergico + '&alergias=' + alergias + '&tallaFranela=' + tallaFranela + '&tallaPantalon=' + tallaPantalon + '&tallaGorra=' + tallaGorra,
        dataType: 'json',
        success: function(datos) {

            if (datos == 1) {
                $.fn.yiiGridView.update('listado_familiar');
                $('#Familiar_estado_civil').val('');
                $('#Familiar_sexo').val('');
                $('#Familiar_parentesco').val('');
                $('#Familiar_fecha_nacimiento').val('');
                $('#Familiar_grupo_sanguineo').val('');
                bootbox.alert('Su registro fue guardado con éxito! Si desea agregrar otra información complete el formulario nuevamente.');
                $('.limpiar').val('');

            } else if (datos == 2) {
//                 Limpiar();   
                bootbox.alert('Verifique los datos!.');
                $('.limpiar').val('');
            }

        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');

        }
    });
}

function GuardarPersonal1(madrePadre) {

    if (madrePadre) {
        valormadrePadre = "S";
    } else {
        valormadrePadre = "N";
    }

    if (discapacidad) {
        valorDiscapacidad = "S";
    } else {
        valorDiscapacidad = "N";
    }

    if (maneja) {
        valorManeja = "S";
    } else {
        valorManeja = "N";
    }







}


function ActualizarFamiliar(cedulaFamiliar, primerNombre, segundoNombre, primerApellido, segundoApellido, estadoCivil, sexo, fechaNacimiento, parentesco, mismoOrganismo, nivelEducativo, grado, promedioNota, gozaUtiles, grupoSanguineo, ninoExcepcional, alergico, alergias, tallaFranela, tallaPantalon, tallaGorra) {
//   alert(cedulaFamiliar + '-' + primerNombre + '-' + segundoNombre + '-' + primerApellido + '-' + segundoApellido + '-' + estadoCivil + '-' + sexo + '-' + fechaNacimiento + '-' + parentesco + '-'+ mismoOrganismo + '-' + nivelEducativo + '-' + grado + '-'+ promedioNota + '-' +gozaUtiles + '-' + alergias + '-' + alergico + '-' + grupoSanguineo + '-'  + ninoExcepcional + '-' + tallaFranela + '-' + tallaGorra + '-' + tallaPantalon);
//    alert(codigo);
//    return false;
    if (mismoOrganismo) {
        valorOrganismo = "S";
    } else {
        valorOrganismo = "N";
    }
    if (gozaUtiles) {
        valorUtiles = "S";
    } else {
        valorUtiles = "N";
    }
    if (ninoExcepcional) {
        valorExcepcional = "S";
    } else {
        valorExcepcional = "N";
    }
    if (alergico) {
        valorAlergico = "S";
    } else {
        valorAlergico = "N";
    }

    if ($('#Familiar_nivel_educativo').val() == '') {
        bootbox.alert('Seleccione el nivel educativo.');
        return false;
    }
    if ($('#Familiar_grupo_sanguineo').val() == '') {
        bootbox.alert('Seleccione el grupo sanguineo.');
        return false;
    }

    id = $('#Familiar_id_familiar').val();

// alert(mismoOrganismo);
// return false;
    $.ajax({
        url: baseUrl + "/ValidacionJs/ActualizarFamiliar",
        async: true,
        type: 'POST',
        data: 'cedulaFamiliar=' + cedulaFamiliar + '&primerNombre=' + primerNombre + '&segundoNombre=' + segundoNombre + '&primerApellido=' + primerApellido + '&segundoApellido=' + segundoApellido + '&estadoCivil=' + estadoCivil + '&sexo=' + sexo + '&fechaNacimiento=' + fechaNacimiento + '&parentesco=' + parentesco + '&mismoOrganismo=' + valorOrganismo + '&nivelEducativo=' + nivelEducativo + '&grado=' + grado + '&promedioNota=' + promedioNota + '&gozaUtiles=' + valorUtiles + '&grupoSanguineo=' + grupoSanguineo + '&ninoExcepcional=' + valorExcepcional + '&alergico=' + valorAlergico + '&alergias=' + alergias + '&tallaFranela=' + tallaFranela + '&tallaPantalon=' + tallaPantalon + '&tallaGorra=' + tallaGorra + '&id=' + id,
        dataType: 'json',
        success: function(datos) {
// alert (datos);
// return false;
            if (datos == 1) {
                bootbox.alert('Su actualización fue guardado con éxito.');
                $(location).attr('href', "familiar/create")
                Limpiar();
            } else if (datos == 2) {
                bootbox.alert('Verifique los datos!.');
            }

        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');

        }
    });
}
/*
 * FUNCION QUE BUSCA EN SAIME POR NUMERO DE CEDULA Y NACIONALIDAD
 */
function buscarPersonaSaime(nacionalidad, cedula) {

    if (nacionalidad == 'SELECCIONE') {
        bootbox.alert('Verifique que la nacionalidad no esten vacios');
        return false;
    }
    if (cedula == '') {
        bootbox.alert('Verifique que la cédula no esten vacios');
        return false;
    }
    $.ajax({
        url: baseUrl + "/ValidacionJs/BuscarSaime",
        async: true,
        type: 'POST',
        data: 'nacionalidad=' + nacionalidad + '&cedula=' + cedula,
        dataType: 'json',
        success: function(datos) {


//            alert(datos['dtmnacimiento']);
            if (!datos) {
                bootbox.alert('Debe Completar el campo Cédula');
                $('.limpiar').val('');

            } else {
                if (datos['intcedula'] == null) {
                    $('#Familiar_primer_nombre').val('');
                    $('#Familiar_segundo_nombre').val('');
                    $('#Familiar_primer_apellido').val('');
                    $('#Familiar_segundo_apellido').val('');
                    $('#Familiar_fecha_nacimiento').val('');
                } else {
                    $('#Familiar_primer_nombre').val(datos['strnombre_primer']).attr('readonly', 'readonly');
                    $('#Familiar_segundo_nombre').val(datos['strnombre_segundo']).attr('readonly', 'readonly');
                    $('#Familiar_primer_apellido').val(datos['strapellido_primer']).attr('readonly', 'readonly');
                    $('#Familiar_segundo_apellido').val(datos['strapellido_segundo']).attr('readonly', 'readonly');
                    $('#Familiar_fecha_nacimiento').val(datos['dtmnacimiento']).attr('readonly', 'readonly');
                }
            }
        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');
        }
    });
}

function Alergia() {
    if ($('.alergico').is(":checked")) {
        $('.datoSalud').show('fade');
    } else {
        $('.datoSalud').hide('fade');
        $('#Familiar_alergias').val('');
    }
}
function Organismo() {
    if ($('.mismo_organismo').is(":checked")) {
        $('.datoOrganismo').show('fade');
    } else {
        $('.datoOrganismo').hide('fade');
    }
}
function Excepcional() {
    if ($('.nino_excepcional').is(":checked")) {
        $('.datoExcepcional').show('fade');
    } else {
        $('.datoExcepcional').hide('fade');
    }
}


function Discapacidad() {
    if ($('.discapacidad').is(":checked")) {
        $('.datoDiscapacidad').show('fade');
    } else {
        $('.datoDiscapacidad').hide('fade');
        $('#tipodiscapacidad').val('');
    }
}


function Vehiculo() {
    if ($('.tiene_vehiculo').is(":checked")) {
        $('.datoVehiculo').show('fade');
    } else {
        $('.datoVehiculo').hide('fade');
        $('#Personal_marca_vehiculo').val('');
        $('#Personal_modelo_vehiculo').val('');
        $('#Personal_placa_vehiculo').val('');
    }
}



/*
 * FUNCION QUE BUSCA AL FAMILIAR Y7 VERIFICA SI YA SE ENCUENTRA REGISTRADO 
 */
function BuscaPersona(nacionalidadFamiliar, cedulaFamiliar, nombreFamiliar, apellidoFamiliar) {
    //alert(nacionalidadFamiliar+'-'+cedulaFamiliar);

    if (nacionalidadFamiliar == 'SELECCIONE') {
        bootbox.alert('Verifique que la nacionalidad no esten vacios');
        return false;
    }

    nombreFamiliar = $('#Familiar_primer_nombre').val();
    apellidoFamiliar = $('#Familiar_primer_apellido').val();

    if (cedulaFamiliar == '') {
        $('#Familiar_primer_nombre').val('').attr("readonly", false);
        $('#Familiar_segundo_nombre').val('').attr("readonly", false);
        $('#Familiar_primer_apellido').val('').attr("readonly", false);
        $('#Familiar_segundo_apellido').val('').attr("readonly", false);
        $('#Familiar_fecha_nacimiento').val('').attr("readonly", false);
        bootbox.alert('Verifique que la cédula no esten vacios');
        return false;
    }
    //EN CASO QUE LA CEDULA SEA DIFERENTE A 0 
    if (cedulaFamiliar != 0) {
        $.ajax({
            url: baseUrl + "/ValidacionJs/BuscaPersona",
            async: true,
            type: 'POST',
            data: 'cedulaFamiliar=' + cedulaFamiliar + '&nacionalidadFamiliar=' + nacionalidadFamiliar + '&nombreFamiliar=' + nombreFamiliar + '&apellidoFamiliar=' + apellidoFamiliar,
            dataType: 'json',
            success: function(datos) {
                if (datos == 2) { //CONDICIONAL QUE NOS MUESTRA QUE EL REGISTRO NO ESTA EN BASE DE DATOS
//                    $('.limpiar').val('');
                    bootbox.alert('Esta persona ya fue registrada, verifique sus datos!');
                } else if (datos == 3) {
                    $('#Familiar_primer_nombre').val('').attr("readonly", false);
                    $('#Familiar_segundo_nombre').val('').attr("readonly", false);
                    $('#Familiar_primer_apellido').val('').attr("readonly", false);
                    $('#Familiar_segundo_apellido').val('').attr("readonly", false);
                    $('#Familiar_fecha_nacimiento').val('').attr("readonly", false);
                } else if (datos) {
                    $('#Familiar_primer_nombre').val(datos.strnombre_primer).attr('readonly', 'readonly');
                    $('#Familiar_segundo_nombre').val(datos.strnombre_segundo).attr('readonly', 'readonly');
                    $('#Familiar_primer_apellido').val(datos.strapellido_primer).attr('readonly', 'readonly');
                    $('#Familiar_segundo_apellido').val(datos.strapellido_segundo).attr('readonly', 'readonly');
                    $('#Familiar_fecha_nacimiento').val(datos.dtmnacimiento).attr('readonly', 'readonly');

                }
            },
            error: function(datos) {
                bootbox.alert('Ocurrio un error');
            }
        });
    } else {
        //VALIDACION QUE REMUEVE EL VALOR DE LOS INPUT Y LE QUITA EL READONLY
        $('#Familiar_primer_nombre').val('').attr("readonly", false);
        $('#Familiar_segundo_nombre').val('').attr("readonly", false);
        $('#Familiar_primer_apellido').val('').attr("readonly", false);
        $('#Familiar_segundo_apellido').val('').attr("readonly", false);
        $('#Familiar_fecha_nacimiento').val('').attr("readonly", false);
    }
}

function Maneja() {
    if ($('.maneja').is(":checked")) {
        $('.datoManeja').show('fade');
    } else {
        $('.datoManeja').hide('fade');
        $('#Personal_grado_licencia').val('');
    }
}
/*
 * FUNCTION QUE VALIDA CANTIDAD DE PERENTEZCO 
 */

function Parentesco(valor) {

    if ($('#Familiar_cedula_familiar').val() == '') {
        bootbox.alert('Ingrese un número de cédula!');
        $('#Familiar_parentesco').val('');
        return false;
    }

    contadorPadre = parseInt(0);
    contadorConyuge = parseInt(0);
    contadorMadre = parseInt(0);
    contadorSuegro = parseInt(0);
    contadorAbuelo = parseInt(0);
    $('#listado_familiar tr').each(function() {
        var parentesco = $(this).find('td:eq(6)').html();
        if (parentesco == 'PADRE') {
            contadorPadre++
        }
        if (parentesco == 'CONYUGE') {
            contadorConyuge++
        }
        if (parentesco == 'MADRE') {
            contadorMadre++
        }
        if (parentesco == 'SUEGRO(A)') {
            contadorSuegro++
        }
        if (parentesco == 'ABUELO(A)') {
            contadorAbuelo++
        }
    });


    if (valor == 'C') {
        if (contadorConyuge > 0) {
            bootbox.alert('Usted ya tiene registrado un Conyuge.');
            $('#Familiar_parentesco').val('');
            return false;
        }
    } else if (valor == 'M') {
        if (contadorMadre > 0) {
            bootbox.alert('Usted ya tiene registrado a su Madre.');
            $('#Familiar_parentesco').val('');
            return false;
        }
    } else if (valor == 'P') {
        if (contadorPadre > 0) {
            bootbox.alert('Usted ya tiene registrado a su Padre.');
            $('#Familiar_parentesco').val('');
            return false;
        }
    } else if (valor == 'S') {
        if (contadorSuegro >= 2) {
            bootbox.alert('Usted ya posee asociado dos Suegros.');
            $('#Familiar_parentesco').val('');
            return false;
        }
    } else if (valor == 'A') {
        if (contadorAbuelo >= 4) {
            bootbox.alert('Usted ya posee asociado cuatro Abuelos.');
            $('#Familiar_parentesco').val('');
            return false;
        }
    }

}

/* -------------  validacion Correo Electronico   ------------  */

function emailCheck(emailStr, emailid) {
    var checkTLD = 1;
    var knownDomsPat = /^(com|net|org|edu|int|mil|gov|gob|arpa|biz|aero|name|coop|info|pro|museum|COM|NET|ORG|EDU|INT|MIL|GOV|GOB|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM)$/;
    var emailPat = /^(.+)@(.+)$/;
    var specialChars = "\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
    var validChars = "\[^\\s" + specialChars + "\]";
    var quotedUser = "(\"[^\"]*\")";
    var ipDomainPat = /^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
    var atom = validChars + '+';
    var word = "(" + atom + "|" + quotedUser + ")";
    var userPat = new RegExp("^" + word + "(\\." + word + ")*$");
    var domainPat = new RegExp("^" + atom + "(\\." + atom + ")*$");
    var matchArray = emailStr.match(emailPat);
    if (matchArray == null) {

        bootbox.alert("El Formato del Correo Electronico es Incorrecto.\n \n\
                        El formato Correcto es: Usuario@Servidor.Dominio");
        /* -***********    *************- */
        var datos = String($('#' + emailid).select2("val"));
        var arredato = datos.split(',');
        var dato_final = [];
        if (arredato.length - 1) {
            for (var cont = 0; cont < arredato.length - 1; cont++)
                dato_final[cont] = arredato[cont];
        } else
            dato_final = "";
        $('#' + emailid).select2("val", dato_final);
        /* -****************************- */


        return false;
    }
    var user = matchArray[1];
    var domain = matchArray[2];
    for (i = 0; i < user.length; i++) {
        if (user.charCodeAt(i) > 127) {
            bootbox.alert("El nombre de usuario contiene caracteres inv\u00e1lidos.");
            /* -***********    *************- */
            var datos = String($('#' + emailid).select2("val"));
            var arredato = datos.split(',');
            var dato_final = [];
            if (arredato.length - 1) {
                for (var cont = 0; cont < arredato.length - 1; cont++)
                    dato_final[cont] = arredato[cont];
            } else
                dato_final = "";
            $('#' + emailid).select2("val", dato_final);
            /* -****************************- */
            return false;
        }
    }
    for (i = 0; i < domain.length; i++) {
        if (domain.charCodeAt(i) > 127) {
            bootbox.alert("El nombre de dominio contiene caracteres inv\u00e1lidos.");
            /* -***********    *************- */
            var datos = String($('#' + emailid).select2("val"));
            var arredato = datos.split(',');
            var dato_final = [];
            if (arredato.length - 1) {
                for (var cont = 0; cont < arredato.length - 1; cont++)
                    dato_final[cont] = arredato[cont];
            } else
                dato_final = "";
            $('#' + emailid).select2("val", dato_final);
            /* -****************************- */
            return false;
        }
    }
    if (user.match(userPat) == null) {
        bootbox.alert("           El Formato del Correo Electronico es Incorrecto\n \n\
       El formato Correcto es Usuario@Servidor.Dominio");
        /* * -***********    *************- */
        var datos = String($('#' + emailid).select2("val"));
        var arredato = datos.split(',');
        var dato_final = [];
        if (arredato.length - 1) {
            for (var cont = 0; cont < arredato.length - 1; cont++)
                dato_final[cont] = arredato[cont];
        } else
            dato_final = "";
        $('#' + emailid).select2("val", dato_final);
        /* -****************************- */
        return false;
    }
    var IPArray = domain.match(ipDomainPat);
    if (IPArray != null) {
        for (var i = 1; i <= 4; i++) {
            if (IPArray[i] > 255) {
                bootbox.alert("La direcci\u00f3n IP es inv\u00e1lida!");
                /* -***********    *************- */
                var datos = String($('#' + emailid).select2("val"));
                var arredato = datos.split(',');
                var dato_final = [];
                if (arredato.length - 1) {
                    for (var cont = 0; cont < arredato.length - 1; cont++)
                        dato_final[cont] = arredato[cont];
                } else
                    dato_final = "";
                $('#' + emailid).select2("val", dato_final);
                /* -****************************- */
                return false;
            }
        }
        return true;
    }
    var atomPat = new RegExp("^" + atom + "$");
    var domArr = domain.split(".");
    var len = domArr.length;
    for (i = 0; i < len; i++) {
        if (domArr[i].search(atomPat) == -1) {
            alert("El nombre de dominio no parece ser v\u00e1lido.");
            /* -***********    *************- */
            var datos = String($('#' + emailid).select2("val"));
            var arredato = datos.split(',');
            var dato_final = [];
            if (arredato.length - 1) {
                for (var cont = 0; cont < arredato.length - 1; cont++)
                    dato_final[cont] = arredato[cont];
            } else
                dato_final = "";
            $('#' + emailid).select2("val", dato_final);
            /* -****************************- */

            return false;
        }
    }
    if (checkTLD && domArr[domArr.length - 1].length != 2 &&
            domArr[domArr.length - 1].search(knownDomsPat) == -1) {
        alert("La direcci\u00f3n debe terminar en un dominio conocido\no c\u00f3digo de pa\u00eds de dos letras.");
        /* -***********    *************- */
        var datos = String($('#' + emailid).select2("val"));
        var arredato = datos.split(',');
        var dato_final = [];
        if (arredato.length - 1) {
            for (var cont = 0; cont < arredato.length - 1; cont++)
                dato_final[cont] = arredato[cont];
        } else
            dato_final = "";
        $('#' + emailid).select2("val", dato_final);
        /* -****************************- */
        return false;
    }
    if (len < 2) {
        alert("Esta direcci\u00f3n no tiene un nombre de host!");
        /* -***********    *************- */
        var datos = String($('#' + emailid).select2("val"));
        var arredato = datos.split(',');
        var dato_final = [];
        if (arredato.length - 1) {
            for (var cont = 0; cont < arredato.length - 1; cont++)
                dato_final[cont] = arredato[cont];
        } else
            dato_final = "";
        $('#' + emailid).select2("val", dato_final);
        /* -****************************- */
        return false;
    }
    return true;
}


function GuardarObjetivo() {
//    return false;
//    alert('GuardarObjetivo');
    var objetivo = $('#PreguntasIndividuales_objetivo').val();
    var peso = parseInt($('#PreguntasIndividuales_peso').val());
    var idEvaluacion = $('#Evaluacion_id_evaluacion').val();
    var total_objetivos = parseInt($('#VswListarPersonas_total_objetivos').val());
    var total_peso = parseInt($('#VswListarPersonas_total_peso').val());
    total_objetivos = parseInt(total_objetivos) + 1;
    total_peso = parseInt(total_peso) + peso;
//    alert(objetivo + '-' + peso + '-' + idEvaluacion);
//    alert(total_objetivos

    //  var res_total = 0;
    var Rows = $('#objetivosMRL').find("tr").length - 1;
    suma_peso = $('#VswListarPersonas_total_peso').val();
//                Rows = +($('div#objetivos_odi tr:last').index() + 1);
//                suma_peso = $('#objetivos_odi-extended-summary').text();
//                alert (Rows);
//                var res = parseInt(suma_peso.substring(10, 13));
//                res_total = parseInt(res) + parseInt($("#PreguntasIndividuales_peso").val());

    if ($("#PreguntasIndividuales_peso").val() >= 50 && Rows < 3) {
        alert('Verifique el Peso y el Objetivo');
        return false;
    }

    if (total_peso > 50) {
        alert('Su peso no puede exceder a los 50');
        return false;
    }
    if (Rows >= 5) {
        alert('Ya cuentas con los 5 objetivos maximos requeridos');
        return false;
    }

    if ($("#PreguntasIndividuales_peso").val() > 25) {
        alert('Verifique el Peso no puede exceder de 25');
        return false;
    }
    if ($("#PreguntasIndividuales_objetivo").val() == '') {
        alert('El Objetivo No debe ser en Blanco');
        return false;
    }

    if ($("#PreguntasIndividuales_peso").val() < 5) {
        alert('Verifique el Peso no puede ser menor a 5');
        return false;

    }

    if (Rows == 1  ) {
        if( total_peso + peso == 75){
            alert('Recuerde que el mínimo de Objetivos son 3 y no puede exceder un peso total de 50 ');
        return false;
        }
       


    } else {
 
    }




    $.ajax({
        url: baseUrl + "/ValidacionJs/DibujarObjetivo",
        async: true,
        type: 'POST',
        data: 'objetivo=' + objetivo + '&peso=' + peso + '&total_objetivos=' + total_objetivos + '&idEvaluacion=' + idEvaluacion,
        dataType: 'json',
        success: function(datos) {
//           alert (data);
//                var htmlTitulo = '<div class=\'limpiaTbl\'><h1>Reporte de' + titulo + '</h1><br/></div>'
//                $('#titulo').append(data['titulo']);
//                $('#listarReporte').append(data['html']);
//                $('#mensaje').append(data['totalCC']);
//                $('#ConsultarDatos').fadeIn('slow');
//            }
            if (datos != '') {



                $('#objetivosMRL').append(datos['html']);
                $('#VswListarPersonas_total_objetivos').val(total_objetivos);
                $('#VswListarPersonas_total_peso').val(total_peso);

//                $.fn.yiiGridView.update('objetivos');
                bootbox.alert('El objetivo fue guardado con éxito.');
//              $('#SavePersonales').hide();
                Limpiar();
            } else {
                bootbox.alert('Verifique sus datos!.');
            }

        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');

        }
    });

}

function eliminar_obj(valor, id, peso) {
//    alert (id);
    var total_peso = parseInt($('#VswListarPersonas_total_peso').val());
    if (!confirm('\u00bfSe encuentra seguro de eliminar el objetivo de la lista?')) {
//no afecta el contador por lo tanto tampoco las filas visibles 
    } else {
        $.ajax({
            url: baseUrl + "/ValidacionJs/EliminarObjetivo",
            async: true,
            type: 'POST',
            data: 'id=' + id,
            dataType: 'json',
            success: function(datos) {
//           alert (datos);
//                var htmlTitulo = '<div class=\'limpiaTbl\'><h1>Reporte de' + titulo + '</h1><br/></div>'
//                $('#titulo').append(data['titulo']);
//                $('#listarReporte').append(data['html']);
//                $('#mensaje').append(data['totalCC']);
//                $('#ConsultarDatos').fadeIn('slow');
//            }
                if (datos == 1) {
                    bootbox.alert('Eliminado Con Exito!.');

                    total_peso = parseInt(total_peso) - peso;
                    $('#VswListarPersonas_total_peso').val(total_peso);
                } else {
                    bootbox.alert('Verifique sus datos!.');
                }

            },
            error: function(datos) {
                bootbox.alert('Ocurrio un error');

            }
        });
//          restamonto = $('#montoact_' + cont).val() 
        $(valor).parent().parent().remove();
//        mod_Proy_resta_presu_cronog(restamonto, 'txtsubtotal_crono'); 
    }
}

function ValidacionObjetivos() {


    res_total = 0;
    var Rows = $('#objetivosMRL').find("tr").length - 1;
    peso = $('#VswListarPersonas_total_peso').val();
    if (Rows < 3) {
        alert('Falta Objetivos por Registrar');
        return false;
    } else if (peso < 50) {
        alert('::. El Peso Total debe ser igual a 50 .::');
        return false;


    } else {
        $(location).attr('href', $('#redireccion_js').val());
//     $(location).attr('href',evaluacion/admin); 
//   document.location.href="/evaluacion/admin";
//    $.post('".CController::createUrl('AsignacionPromotor/BuscarParroquias')
//        location.href = "/evaluacion/admin";


    }

}
function ValidacionPeso() {

    if ($("#VswPdfObjetivos_peso").val() > 25) {
        alert('Verifique el Peso no puede exceder de 25');
        verificar = 1;
        return false;
    }else{
        verificar = 0;
    }
    if ($("#VswPdfObjetivos_peso").val() == '') {
        alert('El Peso No debe ser en Blanco');
        verificar = 1;
        return false;
    }else{
        verificar = 0;
    }

    if ($("#VswPdfObjetivos_peso").val() < 5) {
        alert('Verifique el Peso no puede ser menor a 5');
        verificar = 1;
        return false;

    }else{
        verificar = 0;
    }
    if(verificar == 1){
        
    }
    else {
        $('form').submit();
//     $(location).attr('href',evaluacion/admin); 
//   document.location.href="/evaluacion/admin";
//    $.post('".CController::createUrl('AsignacionPromotor/BuscarParroquias')
//        location.href = "/evaluacion/admin";


    }

}


$(document).ready(function() {

    ///Validacion para Comentarios
    $('#EstatusEvaluacion_fk_estatus_evaluacion').change(function() {
//        alert($('#EstatusEvaluacion_fk_estatus_evaluacion option:selected').html());
        if ($('#EstatusEvaluacion_fk_estatus_evaluacion option:selected').html() == 'RECHAZADO') {
            $('#Comentarios_comentario').prop('required', true);
        }
        else {
            $('#Comentarios_comentario').prop('required', false);
        }
    });


    $('#table_objetivos #tr_objetivos').hover(function() {
        $(this).css("background-color", "#d7dce8");
    }, function() {
        $(this).css("background-color", "transparent");
    });
    $('#table_competencias #tr_objetivos').hover(function() {
        $(this).css("background-color", "#d7dce8");
    }, function() {
        $(this).css("background-color", "transparent");
    });
    $('#table_obreros #tr_objetivos').hover(function() {
        $(this).css("background-color", "#d7dce8");
    }, function() {
        $(this).css("background-color", "transparent");
    });
    $('#table_obreros tr').click(function() {
        $(this).find('input:radio').prop('checked', true);
        $(this).find('input:radio').prop('checked', true);
        o = 0;
        total = 0;
        while (o < $('#filas').val()) {
            if ($('input:radio[name=pre_obre_' + o + ']').is(':checked')) {
                var peso_fijo = parseFloat($('input:radio[name=pre_obre_' + o + ']:checked').val());
            }
            else {
                var peso_fijo = 0;
            }
            total = total + peso_fijo;
            o++;
        }
        $('#total_puntuacion').val(total);
    });

    //Ocultamiento de la Seecion B si ya se creo la Evaluacion//
    if ($('#validacion_1').val() == 1) {
        $('#seccionC').show();
        $('#seccionB').hide();
        $('#seccionB_button').hide();
    }
    //Contador de Caracteres para Comentario Fase II

    var total_letras = 500;
    $('#limite_texto').html(500);
    $('#comentario_text').keyup(function() {
        var longitud = $(this).val().length;
        var resto = total_letras - longitud;
        $('#limite_texto').html(resto);
        if (resto <= 0) {
            $('#comentario_text').attr("maxlength", 500);
        }
    });



//  Calcular Peso x Rango Seccion B
    $(".rango_calc").change(function() {

        var tr = $(this).parent().parent();
        var peso = $(".peso_calc", tr).val();
//        var rango = $(".rango_calc option:selected", tr).html();
//        alert(rango);

        if (isNaN($(".rango_calc option:selected", tr).html() * peso)) {
            $(".subPeso_calc", tr).val(0);
        }
        else {
            $(".subPeso_calc", tr).val($(".rango_calc option:selected", tr).html() * peso);
            CalcularTotal();
        }



    });

//  Sumar cada uno de los Pesos de Seccion C    
    $(".peso_calc_compe").change(function() {
        subtotal = 0;
        i = 0;
        while (i < 8) {

            $("#peso_calc" + i).val();
            subtotal += eval($("#peso_calc" + i).val());
            i++;
            $(".total_peso_calc").val(subtotal);
        }
        if ($(".total_peso_calc").val() > 50) {
            alert("El Peso no puede exceder de los 50. Verifique el peso.");
        }
        if ($(".total_peso_calc").val() == 50) {
            o = 0;
            while (o < 8) {
                if ($("#peso_calc" + o).val() == 0) {
                    alert("El Peso " + (o + 1) + " no puede estar vacio.");
                }

                o++;

            }
        }
    });

//  Calcular Peso x Rango Seccion C
    $(".rango_calc_compe").change(function() {

        var tr = $(this).parent().parent();
        var peso = $(".peso_calc_compe", tr).val();
//        var rango = $(".rango_calc option:selected", tr).html();
//        alert(rango);

        if (isNaN($(".rango_calc_compe option:selected", tr).html() * peso)) {
            $(".subPeso_calc_compe", tr).val(0);
        }
        else {
            $(".subPeso_calc_compe", tr).val($(".rango_calc_compe option:selected", tr).html() * peso);
            CalcularSeccionC();
        }
    });

    $(".peso_calc_compe").change(function() {

        var tr = $(this).parent().parent();
        var peso = $(".rango_calc_compe option:selected", tr).html();
//        alert(peso);
//        var rango = $(".rango_calc option:selected", tr).html();
//        alert(rango);

        if (isNaN($(".peso_calc_compe", tr).val() * peso)) {
            $(".subPeso_calc_compe", tr).val(0);
        }
        else {
            $(".subPeso_calc_compe", tr).val($(".peso_calc_compe", tr).val() * peso);
            CalcularSeccionC();
        }
    });



    //Calcular total de la Evaluacion//
    totalb = eval($("#total_B").val());
    totalc = eval($("#total_C").val());
    $("#total_final").val(totalb + totalc);

    if ($("#total_final").val() <= 179) {
        $("#rango_actuacion").html("Muy por debajo de lo esperado");
    }
    if (($("#total_final").val() >= 180) && ($("#total_final").val() <= 259)) {
        $("#rango_actuacion").html("Por debajo de lo esperado");
    }
    if (($("#total_final").val() >= 260) && ($("#total_final").val() <= 339)) {
        $("#rango_actuacion").html("Dentro de lo esperado");
    }
    if (($("#total_final").val() >= 340) && ($("#total_final").val() <= 419)) {
        $("#rango_actuacion").html("Sobre lo esperado");
    }
    if (($("#total_final").val() >= 420) && ($("#total_final").val() <= 500)) {
        $("#rango_actuacion").html("Excepcional");
    }
});

function Limpiar_Compe(caja_texto) {

    caja_texto.value = "";
}

function EditarObjetivos(id_peso, rango, peso, subpeso) {
    i = 0;
    total = 0;
    error_rango = 0;
//    alert(ciclo);
    while (i < $('#ciclo').val()) {
//        alert(i);

        id_peso = $('#id_' + i).val();

        rango = $('#rango_' + i).val();
//        alert("Rango " + i + ": " + rango);

        peso = $('#peso_' + i).val();
//        alert("Peso " + i + ": " + peso);

        subpeso = $("#subPeso_" + i).val();
//        alert("Peso por Rango " + i + ": " + subpeso);
//               total = total + resul;            

        if (rango == null) {
            alert("Por favor, indique el Rango " + (i + 1));
            error_rango = error_rango + 1;
        }
        else {

            $.ajax({
                url: baseUrl + "/ValidacionJs/EditarObjetivos",
                async: true,
                type: 'POST',
                data: 'id_peso=' + id_peso + '&rango=' + rango + '&subPeso=' + subpeso,
                dataType: 'json',
            });
        }
        i++;
    }

    if (error_rango == 0) {

        id_evaluacion = $("#id_evaluacion").val();
//    alert(id_evaluacion);
        total = $("#totalsubPeso").val();


        $.ajax({
            url: baseUrl + "/ValidacionJs/EditarEvaluacion",
            async: true,
            type: 'POST',
            data: 'total_subpeso=' + total + '&id_evaluacion=' + id_evaluacion,
            dataType: 'json',
            success: function(datos) {
                if (datos == 1) {
                    bootbox.alert('Los Rangos fueron guardados con éxito.');
                    $('#seccionC').show();
                    $('#seccionB').hide();
                    $('#seccionB_button').hide();
//                      $('#persona').show();
//                        $('#SaveDatosRequisicion').hide();
//                        $('#DatosRequisicion_fk_tipo_requisicion').attr("disabled", true), $('#DatosRequisicion_fk_unidad_ejecutora').attr("disabled", true), $('#DatosRequisicion_anio_requisicion').attr("disabled", true),
//                        $('#DatosRequisicion_ubicacion_geografica').attr("disabled", true), $('#DatosRequisicion_fk_parroquia').attr("disabled", true), $('#DatosRequisicion_ciudad').attr("disabled", true),
//                        $('#Tblestado_clvcodigo').attr("disabled", true), $('#Tblmunicipio_clvcodigo').attr("disabled", true);
                } else if (datos == 2) {
                    bootbox.alert('Verifique los Rangos.');
                }
            },
            error: function(datos) {
                bootbox.alert('Ocurrio un error');

            }
        });

    }
//    alert("Toal de Peso x Rango: " + total);

}

function CalcularTotal() {

    var total = 0;
    $('#table_objetivos tr:not(:last)').each(function() {

        var coltotal = parseInt($(".subPeso_calc", this).val());

        if (!isNaN(coltotal)) {
            total += coltotal;
        }


    });

    $('.total_calc').val(total);
}

function CalcularSeccionC() {

    var total = 0;
    $('#table_competencias tr:not(:last)').each(function() {
//        alert($(".subPeso_calc_compe", this).val());
        var coltotal = parseInt($(".subPeso_calc_compe", this).val());
//        alert(coltotal);
        if (!isNaN(coltotal)) {
            total += coltotal;
        }


    });

    $('.total_calc_compe').val(total);
}

function GuardarCompetencias() {
    i = 0;
    error_rango = 0;
    while (i < $('#filas_competencia').val()) {
        rango = $('#rango_calc_compe' + i).val();
//        alert(rango);
        if (rango == null) {
            alert("Por favor, indique el Rango " + (i + 1));
            error_rango = error_rango + 1;
        }
        i++;
    }
    if (($(".total_peso_calc").val() == 50)) {
        if ((error_rango == 0)) {
            $('form').submit();
        }
    }
    else {
        alert("El Peso Total debe ser de 50.");
    }
}

function numero() {
    $('#PreguntasIndividuales_objetivo').keydown(function(e) {
        if (e.shiftKey || e.ctrlKey || e.altKey) {
            e.preventDefault();
        } else {
            var key = e.keyCode;
            //alert(key)  
            if (!((key > 3) || (key < 5))) {
                e.preventDefault();
            }
        }
    });
}


function BtnAgregarP(objetivo) {
    var objetivo = $('.pregunta_uno').val(); //variable donde se pasa el objetivo



    contar = parseInt(0); //variable para indicar que solo sean 3 objetivos como minimo que el usuario debe ingresar 
    $('.contadorP1').each(function() {
        contar++
    });


    if (contar == 3) {
        bootbox.alert('Minimo debe Ingresar (3) Objetivos');
        return false;
    } else if (contar == 5) {
        bootbox.alert('Maximo debe Ingresar (5) Objetivos');
        return false;
    }

    if (objetivo == '') {
        bootbox.alert('Debe Ingresar un Objetivo');
        return false;
    }

    //verifica si hay diagnostico repetido en la tabla



    objetivo = parseInt(0);
    $('.contadorP1').each(function() {
        if ($(this).text() == objetivo) {
            objetivo++;

        }
    });
    if (objetivo > 0) {
        bootbox.alert('El Objetivo ya se Encuentra Registrado, verifique sus Datos!');
        return false;
    }
}

function GuardarDatosRequisicion(tipo_requisicion, unidad, anio, ubicacion, parroquia, ciudad) {

    $.ajax({
        url: baseUrl + "/ValidacionJs/GuardarDatosRequisicion",
        async: true,
        type: 'POST',
        data: 'tipo_requisicion=' + tipo_requisicion + '&unidad=' + unidad + '&anio=' + anio + '&ubicacion=' + ubicacion + '&parroquia=' + parroquia + '&ciudad=' + ciudad,
        dataType: 'json',
        success: function(datos) {
            if (datos == 1) {
                bootbox.alert('Su registro fue guardado con éxito.');
//                $('#persona').show();
                $('#SaveDatosRequisicion').hide();
                $('#DatosRequisicion_fk_tipo_requisicion').attr("disabled", true), $('#DatosRequisicion_fk_unidad_ejecutora').attr("disabled", true), $('#DatosRequisicion_anio_requisicion').attr("disabled", true),
                        $('#DatosRequisicion_ubicacion_geografica').attr("disabled", true), $('#DatosRequisicion_fk_parroquia').attr("disabled", true), $('#DatosRequisicion_ciudad').attr("disabled", true),
                        $('#Tblestado_clvcodigo').attr("disabled", true), $('#Tblmunicipio_clvcodigo').attr("disabled", true);
            } else if (datos == 2) {
                bootbox.alert('Verifique sus datos!.');
            }

        },
        error: function(datos) {
            bootbox.alert('Ocurrio un error');

        }
    });

}

function EditarObjetivo() {

    if ($('#footer_suma_total').html() != 50) {

        alert("El Peso Total debe ser de 50. Por favor verifique los pesos de sus Objetivos.");

    } else {
         $('form').submit();
//        alert($('#redireccion_js').val());
    //    $(location).attr('href', $('#redireccion_js').val());

    }
}

function ValidacionFecha() {
// alert('aqui'+$('#Revision_fecha_revision').val());
 
    if ($('#Revision_fecha_revision').val() == '') {

        alert("Debe Seleccionar Una Fecha de Revisión.");

    } else {
         $('#revision-form').submit();

    }
}

function Todo() {
    if ($('.sac_todo').is(":checked")) {
        $('.busqueda').show('fade');
    } else {
        $('.busqueda').hide('fade');
    }
}

function Personal() {
    if ($('.personal').is(":checked")) {
        $('.datoPersonal').show('fade');
        $('input[class="swpersonal"]').bootstrapSwitch('state', false);

    } else {
        $('.datoPersonal').hide('fade');
        $('#VswMujeresRegistradas_fk_nacionalidad').val('');
        $('input[class="swpersonal"]').bootstrapSwitch('state', false);
    }
}

function ExportarReportes(tipo) {

    if (tipo == 'CAL') {
        $('#exel').val('si');
    } else {
        $('#pdf').val('si');
    }
    $('#Rechazados_form').submit();
    $('#exel').val('');
    $('#pdf').val('');
}

///////////////////////////////////////////////////////
//////////////////PROYECTO/////////////////////////////
///////////////////////////////////////////////////////



function GuardarAccion() {
    validar = 0;
    if($("#Acciones_nombre_accion")==''){
        bootbox.alert('Verifique que la Accion no este vacia.');
        validar = 1;
    }
    if($("#Acciones_bien_servicio").val()==''){
        bootbox.alert('Debe indicar el Bien o Servicio de la Acción.');
        validar = 1;
    }
    if($("#Acciones_cantidad").val()==''){
        bootbox.alert('Por favor, indique la cantidad a cumplir para esta Accion.');
        validar = 1;
    }
    if(validar == 0){
        $('form').submit();
    }
}
function GuardarActividad() {

    if($("#Actividades_actividad").val()==''){
        bootbox.alert('Verifique que la Actividad no este vacia.');
    }
    if($("#Actividades_fk_unidad_medida").val()=='SELECCIONE'){
        bootbox.alert('Debe seleccionar un tipo de Unidad de Medida.');
    }
    if(($("#Actividades_actividad").val()!='')&&($("#Actividades_fk_unidad_medida").val()!='SELECCIONE')){
        
        $.ajax({
            url: baseUrl + "/ValidacionJs/DibujarActividad",
            async: true,
            type: 'POST',
            data: 'actividad=' + $("#Actividades_actividad").val() + '&fk_unidad_medida=' + $("#Actividades_fk_unidad_medida").val() + '&cantidad=' + $("#Actividades_cantidad").val() + '&fk_accion=' + $("#Actividades_fk_accion").val(),
            dataType: 'json',
            success: function(datos) {
                if (datos != '') {
                    $('#id_actividad').val(datos['id_actividad']);
                    $('#ActividadesPOA').append(datos['html']);
                    
                    //Guardado del Rendimiento de la Actividad
                    
                    i = 0;
                    fk_meses = 57;
                   
                    while (i < 12) {
                        id_actividad = $('#id_actividad').val();
                        programacion = $('#Rendimiento_' + fk_meses).val();
                        fk_mes = fk_meses;
              
                        $.ajax({
                            url: baseUrl + "/ValidacionJs/GuardarProgramadoActividad",
                            async: true,
                            type: 'POST',
                            data: 'id_actividad=' + id_actividad + '&fk_mes=' + fk_mes + '&programacion=' + programacion,
                            dataType: 'json',
                        });
                        fk_meses++;
                        i++;
                    }
                    
                    bootbox.alert('La Actividad fue guardada con éxito.');
                    Limpiar();
                } else {
                    bootbox.alert('Verifique sus datos!.');
                }

            },
            error: function(datos) {
                bootbox.alert('Ocurrio un error');

            }
        });
    }

}

function eliminar_actividad(valor, id) {

    if (!confirm('\u00bfEstá usted seguro de que desea eliminar está actividad?')) {

    } else {
        $.ajax({
            url: baseUrl + "/ValidacionJs/EliminarActividad",
            async: true,
            type: 'POST',
            data: 'id_actividad=' + id,
            dataType: 'json',
            success: function(datos) {

                if (datos == 1) {
                    bootbox.alert('Eliminado Con Exito!');
                } else {
                    bootbox.alert('Verifique sus datos!.');
                }

            },
            error: function(datos) {
                bootbox.alert('Ocurrio un error');

            }
        });
        $(valor).parent().parent().remove();
    }
}

function editar_accion(valor, fk_poa, id_accion, tipo) {
    $(location).attr('href', baseUrl + "/poa/create_actividad/id_poa/" + fk_poa + "/id_accion/" + id_accion + "/tipo/" + tipo);
}

$(document).ready(function() {
    $('#EstatusPoa_fk_estatus_poa').change(function() {
        if ($('#EstatusPoa_fk_estatus_poa option:selected').html() == 'RECHAZADO') {
            $('#Comentarios_comentarios').prop('required', true);
        }
        else {
            $('#Comentarios_comentarios').prop('required', false);
        }
    });
})