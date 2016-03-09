<?php Yii::app()->clientScript->registerScript('site', "
    
    $(document).ready(function(){
        setTimeout(function(){
            url = '../site/index';
            $(location).attr('href',url);
        },60000);
    });
"); ?>
<div>
    <div class="row">
        <div class="col-lg-12">
            <div class="alert alert-success text-center" role="alert"><h3><b>Su actualización fue Realizado con Éxito. 
                        <p>Gracias por Completar el Proceso.</b></p>
                    <p>Ministerio del Poder Popular para la Mujer y la Igualdad de Género.</b></p>
                </h3>
            </div>
            <div class="alert alert-info text-center" role="alert">
                <h4>
                    <p><b>AVISO</b></p>
                    <p>  "Esta Información es confidencial y unicamente de uso exclusivo de la Oficina de Gestión Humano,</p>
                    <p>todos los datos podrán ser verificados por esta oficina y de encontrarse referencias </p>
                    <p>que no corresponda con la trabajadora o trabajador,</p>
                    <p>se podrán iniciar los procedimientos legales correspondientes."</p>
                </h4>

            </div>
        </div>
    </div>