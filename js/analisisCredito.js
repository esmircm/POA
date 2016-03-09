//URL
var http = location.protocol;
var slashes = http.concat("//");
var baseUrl = slashes.concat(window.location.hostname);

if (baseUrl.indexOf('.banavih.gob.ve') == -1) {
    var pathArray = window.location.pathname.split('/');
    var ruta = '/' + pathArray[1];
    baseUrl = $(location).attr('href').replace($(location).attr('pathname'), ruta);

}

function conMayusculas(field) {
    field.value = field.value.toUpperCase()
}

//$(document).ready(function () {
////    var SalarioGrupoFamiliar = $('#opciones_2').val();
//    var ingresoo = $('#CreditoBene_ingreso_familiar').val();
//    
//    $.ajax({
//        url: baseUrl + "/CalculoAnalisisCredito/Ajax/TipoInterresAplicable",
//        async: true,
//        type: 'POST',
//        data: 'ingresoo=' + ingresoo,
//        dataType: 'json',
//        success: function (datos) {
//            $('#CreditoBene_tasa_interes_id').val(datos);
//        },
//        error: function (datos) {
//            bootbox.alert('Ocurrio un error');
//        }
//    })
//});


/*
 * FUNCTION QUE RECALCULA LA TAZA DE INTERE4S APLICABLE SEGUN TABLA DEL SUELDO
 */


//function RecalculoDeInteres() {
//    if ($('#opciones_2').is(':checked')) {
//        var valorSalario = $('#opciones_2').val();
//    }
//    if ($('#opciones_1').is(':checked')) {
//        var valorSalario = $('#opciones_1').val();
//    }
//    $.ajax({
//        url: baseUrl + "/CalculoAnalisisCredito/Ajax/TipoInterresAplicable",
//        async: true,
//        type: 'POST',
//        data: 'SalarioFamiliar=' + valorSalario,
//        dataType: 'json',
//        success: function (datos) {
//            $('#CreditoBene_fk_tasa_interes').val(datos);
//        },
//        error: function (datos) {
//            bootbox.alert('Ocurrio un error');
//        }
//    })
//}

function CalcularAnalisis() {

//    var fuenteFinanciamineto = $('#Desarrollo_fuente_financiamiento_id').val();
//    var programa = $('#Desarrollo_programa_id').val();
//    var idUnidadFamiliar = $('#AnalisisCredito_unidad_familiar_id').val();
    var ingreso = $('#CreditoBene_ingreso_familiar').val();
    var montoInical = $('#CreditoBene_inicial').val();
    var montoVivienda = $('#CreditoBene_precio_vivienda').val();
    var tasaInteres = $('#CreditoBene_tasa_interes_id').val();
    var plazoCredito = $('#CreditoBene_plazo_mes').val();
    

    if (plazoCredito == '') {
        bootbox.alert('Indique el Plazo');
        return false;
    }
    
    if (plazoCredito == '0') {
        bootbox.alert('Indique el Plazo');
        return false;
    }
    
    if (ingreso == '') {
        bootbox.alert('Indique un Ingreso');
        return false;
    }


    $.ajax({
        url: baseUrl + "/CalculoAnalisisCredito/Ajax/CalculoTasaAmortizacion",
        async: true,
        type: 'POST',

        data: 'montoInical=' + montoInical + '&montoVivienda=' + montoVivienda + '&ingreso=' + ingreso + '&tasaInteres=' + tasaInteres + '&plazoCredito=' + plazoCredito, 
        dataType: 'json',
        success: function (datos) {

                $('.montorestante').hide();
                $('.subsidiomax').hide();
                $('.reconocimiento').hide();
                $('.subsidiocorre').hide();
                $('.comision').show();
                $('#CreditoBene_max_cuota_finan').val(datos.coutaFinanciamientoMaxima);
                $('#plazomeses').val(datos.plazoMeses);
                $('#CreditoBene_max_cap_pago_cuota_mes').val(datos.capacidadPago);
                $('#diferenciapago').val(datos.diferenciaPago);
                $('#CreditoBene_monto_credito_otorgar').val(datos.creditoRequerido);
                $('#CreditoBene_cuota_inicial_fongar').val(datos.coutaInicialFongar);
                $('#CreditoBene_monto_cuota_financiera').val(datos.montoCoutaFinaciera);
//                $('#tasafongar').val(datos.tasaFongar);
                $('#CreditoBene_fongar').val(datos.fondoGarantiaMensual);
                $('#CreditoBene_cuota_mensual_pagar').val(datos.coutaMensualPagar);
                $('#CreditoBene_por_cuota_financiera').val(datos.maxCoutaFinan);
                $('#CreditoBene_comision_flat_pagar').val(datos.comisionFlat);
                $('#CreditoBene_tasa_interes_id').val(datos.Aa);
//            }
        },
        error: function (datos) {
            bootbox.alert('Ocurrio un error');
        }
    })
}



