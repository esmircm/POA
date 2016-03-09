var http = location.protocol;
var slashes = http.concat("//");
var baseUrl = slashes.concat(window.location.hostname);
if (baseUrl.indexOf('.banavih.gob.ve') == -1) {
    var pathArray = window.location.pathname.split('/');
    var ruta = '/' + pathArray[1];
    baseUrl = $(location).attr('href').replace($(location).attr('pathname'), ruta);
}



function CambiarEstatus(codigo, actor, caso) {

  //alert(codigo + actor + caso);    return false;


    $.ajax({
        url: baseUrl + "/EstatusAdjudicado/BuscarActualizar",
        type: 'POST',
        data: 'codigo=' + codigo + '&actor=' + actor + '&caso=' + caso,
        async: true,
        dataType: 'json',
        success: function (data) {
            if (data == 1) {
                $('#EstatusAdjudicadoGrid').yiiGridView('update', {//Actualización automatica griewView
                    data: $(this).serialize()
                });  return false;
            }
            else if (data == 2) {

                bootbox.alert("Por favor indique una observación");
                return false;
            } else if (data == 3) {
                $('#PagoComisionFlag').yiiGridView('update', {//Actualización automatica griewView
                    data: $(this).serialize()
                });  return false;
            }     else if (data == 4) {

                bootbox.alert("Por favor indique la fecha de protocolización");
                return false;
            }
            else if (data == 0) {

                bootbox.alert("NO actualizó");
                return false;
            }
        },
        error: function (data) {
            alert('error');
        }
    })


}

function GuardarCredito(form, tasaI, tasaFon, tasaMora, plazoMes, eso, idEstatus, idAdj, fkCredito) {
//    alert(form);return false;
   if (tasaI == '') {
        bootbox.alert("Por favor indique la tasa de interés");
        return false;
    } else if (tasaFon == '') {
        bootbox.alert("Por favor indique la tasa fongar");
        return false;

    } else if (tasaMora == '') {
        bootbox.alert("Por favor indique la tasa de mora");
        return false;

    } else if (plazoMes == '') {
        bootbox.alert("Por favor indique el plazo mes");
        return false;

    } else if (eso == '') {
        bootbox.alert("Genere el Cálculo primero");
        return false;

    }

    $.ajax({
        url: baseUrl + "/CreditoBene/ActualizarCredito",
// url: "/CreditoBene/ActualizarCredito",
        type: 'POST',
        data: 'form=' + form + '&idEstatus=' + idEstatus + '&idAdj=' + idAdj + '&fkCredito=' + fkCredito,
        async: true,
        dataType: 'json',
        success: function (data) {
            if (data == 2) {
                $('#info').hide('fade');
               $('.datosGuardados').fadeIn('slow');
                          
                
            } else if (data == 0) {
                bootbox.alert("NO actualizó");
                return false;

            }
        },
        error: function (data) {
            alert('error');
        }
    })
}
