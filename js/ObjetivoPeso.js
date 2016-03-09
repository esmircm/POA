
//inicio de funcion de  boton agregar problematica  
function BtnAgregarP(objetivo) {
    var objetivo = $('.pregunta_uno').val(); //variable donde se pasa el objetivo
    
    

    contar = parseInt(0); //variable para indicar que solo sean 3 objetivos como minimo que el usuario debe ingresar 
    $('.contadorP1').each(function() {
        contar++
    });


    if (contar == 3) {
        bootbox.alert('Minimo debe Ingresar (3) Objetivos');
        return false;
    }else if (contar == 5) {
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


    var datos = $('#PreguntasIndividuales_objetivo').serialize() + '&' + $('#PreguntasIndividuales_peso').serialize() + '&' + $('#PreguntasIndividuales_fk_rango').serialize()+ '&' + $('#PreguntasIndividuales_subtotal_peso').serialize();
    $.ajax({
        type: 'POST',
        url: baseUrl + '/xx/xxx',
        data: datos,
        success: function(data) {
            if (data != 'no') {
                var url = '/CaracterizacionDiagnostico/delete/id/';
                var html = '<tr id=\'id_' + data + '\'>'
                        + '<th style=\'text-align:center;\' class=\'contadorP1\'>' + tipoaspecto + '<input type=\'hidden\' class=\'model\' value=\'' + $('#CaracterizacionDiagnostico_fk_respuesta').val() + '\' /></th>'
                        + '<th style=\'text-align:left;\' class=\'agregar_uno\'>' + diagnostico + '</th>'
                        + '<th style=\'text-align:center;\'><a class=\'icon-minus-sign\' onclick=\'Eliminardatos(' + data + ')\' ></a></td>'
                        + '</tr>';

                $('.diagnostico_uno').val('');
                $('.pregunta_uno').val('');
                $('#Listar').append(html);
            } else {
                bootbox.alert('Imposible guardar el registro.');
            }
        }

    })

}
//fin de funcion de boton agregar capacidades  


//Inicio de funcion de boton agregar capacidades 


/*function BtnCa(capacidades_dos, capacidades_dos_value, repuestas_dos, idcaracterizacion) {

    var capacidades_dos = $('.pregunta_dos').children(':selected').text();
    var capacidades_dos_value = $('.pregunta_dos').val();
    var repuestas_dos = $('.diagnostico_dos').val();
    var idcaracterizacion = $('.caracterizacion').val();

    contar = parseInt(0); //variable para indicar que solo sean 3 aspecto que el usuario debe ingresar 
    $('.contadorP2').each(function() {
        contar++
    });

    if (contar == 3) {
        bootbox.alert('Solo debe Indicar (3) Aspectos');
        return false;
    }

    if (capacidades_dos == 'Seleccione..') {
        bootbox.alert('Debe seleccionar un Aspecto');
        return false;
    } else if (repuestas_dos == '') {
        bootbox.alert('Debe indicar el diagnostico');
        return false;
    }



    diagnosticosss = parseInt(0);
    $('.contadorP2').each(function() {
        if ($(this).text() == capacidades_dos) {
            diagnosticosss++;

        }
    });
    if (diagnosticosss > 0) {
        bootbox.alert('El diagnostico ya se encuentra en la lista, verifique - Aspecto');
        return false;
    }

    diagnosticos = parseInt(0);
    $('.agregar_dos').each(function() {
        if ($(this).text() == repuestas_dos) {
            diagnosticos++;

        }
    });
    if (diagnosticos > 0) {
        bootbox.alert('El diagnostico ya se encuentra en la lista, verifique - Descripción');
        return false;
    }

    var datos1 = 'pregunta=' + capacidades_dos_value + '&respuesta=' + repuestas_dos + '&idcaracterizacion=' + idcaracterizacion;
    $.ajax({
        type: 'POST',
        url: baseUrl + '/CaracterizacionDiagnostico/DiagnosticoCapacidades',
        data: datos1,
        success: function(data) {
            if (data != 'no') {
                var url = '../CaracterizacionDiagnostico/delete/id/';
                var html = '<tr id=\'id_' + data + '\'>'
                        + '<th style=\'text-align:center;\'class=\'contadorP2\'>' + capacidades_dos + '<input type=\'hidden\' class=\'model\' value=\'' + $('#CaracterizacionDiagnostico_fk_respuesta').val() + '\' /></th>'
                        + '<th style=\'text-align:left;\' class=\'agregar_dos\'>' + repuestas_dos + '</th>'
                        + '<th style=\'text-align:center;\'><a class=\'icon-minus-sign\' onclick=\'Eliminardatos(' + data + ')\' ></a></th>'
                        + '</tr>';
                $('.diagnostico_dos').val('');
                $('.pregunta_dos').val('');
                $('#Listarcapacidades').append(html);
                contar++;


            } else {
                bootbox.alert('Imposible guardar el registro.');
            }
        }
    });

}
//fin de funcion de boton agregar capacidades 



//funcion que elimina los datos de la tabla y la base de datos
function Eliminardatos(valor) {
    if (confirm('¿Está seguro de eliminar el registro?') == true) {//pido una confirmacionn
        $.ajax({
            type: 'POST',
            url: baseUrl + '/CaracterizacionDiagnostico/Delete',
            data: 'val=' + valor, //envio al controller
            success: function(data) {
                if (data == 'eliminados') {
                    $('#id_' + valor).remove();//elimino la el registro de la vista
                    bootbox.alert('El registro fue eliminado con exito.');
                } else {
                    bootbox.alert('Imposible eliminar el registro.');
                }
            },
            error: function(data) { // if error occured
                bootbox.alert('Ha ocurrido un error');
            },
            dataType: 'html'
        });
    }
}



function BtonGuardar() {


    if ($('input:radio[name=problematica]:checked').val() == 'false') {//pido una confirmacionn

       } var n = $('#Listar tr').length;
        if (n < 2) {
            alert('Debe ingresar por lo menos un Registro');
            return false;
        }

        var n = $('#Listarcapacidades tr').length;
        if (n < 2) {
            alert('Debe ingresar por lo menos un Registo');
            return false;
        }

//    alert('exito eres inteligente porque entienedes los mensajes');return false;
//      
//      
//      
   }
}*/
