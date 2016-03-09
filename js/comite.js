var http = location.protocol;
var slashes = http.concat("//");
var baseUrl = slashes.concat(window.location.hostname);
if (baseUrl.indexOf('.banavih.gob.ve') == -1) {
    var pathArray = window.location.pathname.split('/');
    var ruta = '/' + pathArray[1];
   // baseUrl = $(location).attr('href').replace($(location).attr('pathname'), ruta);
}

$(document).ready(function() {
    $('#programar').click(function() {
        $('.mostrarPanel').fadeIn('slow');
        $('.ocultarBoton').fadeOut('slow');
    });
    $('#cancelar').click(function() {
        $('.mostrarPanel').fadeOut('slow');
        $('.ocultarBoton').fadeIn('slow');
        $(".limpiarCampo").val('');
    });


});

function GuardarComite(comite, fecha, hora, juntaD) {

    if (comite == '') {
        bootbox.alert("Por favor indique el codigo del comité");
        return false;
    } else if (fecha == '') {
        bootbox.alert("Por favor indique la fecha en la cual se efectuará el comité");
        return false;

    } else if (hora == '') {
        bootbox.alert("Por favor indique la hora en la cual se efectuará el comité");
        return false;

    } else if (juntaD == '') {
        bootbox.alert("Por favor indique la la Junta directiva que está presente en el comité");
        return false;

    }
    $.ajax({
        url: baseUrl + "/Comite/InsertComite",
        type: 'POST',
        data: 'comite=' + comite + '&fecha=' + fecha + '&hora=' + hora + '&juntaD=' + juntaD,
        async: true,
        dataType: 'json',
        success: function(data) {
            if (data == 1) {
                $('#comiteGrid').yiiGridView('update', {//Actualización automatica griewView
                    data: $(this).serialize()
                });

                return false;
            } else if (data == 2) {
                bootbox.alert("Disculpe, ha seleccionado una fecha que ya ha sido pautada para otro comité");
                return false;
            } else if (data == 0) {
                bootbox.alert("El número del comite que ha indicado ya se encuentra registrado");
                return false;
            }
        },
        error: function(data) {
            alert('error');
        }
    })



}
function ActivarDesactivar(asistente, es_activo) {


    $.ajax({
        url: baseUrl + "/comiteAsistentes/create",
        type: 'POST',
        data: 'asistente=' + asistente + '&es_activo=' + es_activo,
        async: true,
        dataType: 'json',
        success: function(data) {
            if (data == 1) {
                $('#asistentes').yiiGridView('update', {//Actualización automatica griewView
                    data: $(this).serialize()
                });
                return false;
            } else if (data == 2) {
                bootbox.alert("Disculpe, ha seleccionado una fecha que ya ha sido pautada para otro comité");
                return false;
            } else if (data == 0) {
                bootbox.alert("El número del comite que ha indicado ya se encuentra registrado");
                return false;
            }
        },
        error: function(data) {
            alert('error');
        }
    })



}
