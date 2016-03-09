<?php
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if (!$opc) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Odis',
        ),
        'homeLink' => false,
    )); ?>

 <div class="alert alert-info" style="text-align:center; ">
     <h4> Si desea ver en detalle la información de ODIS CARGADAS, haga CLICK sobre el nombre!</h4>
    </div>
<?php } else if ($opc == 2) {
    
    
    //echo '<pre>'; var_dump($_GET['descripcion']); exit();
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Odis' => $this->createUrl('/graficas/graficaodis'),
            'Oficinas',
        ),
        'homeLink' => false,
    ));
}

$this->widget(
        'ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'theme' => 'white',
        'chart' => array(
            'renderTo' => 'estadistica_citasporcafim',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 800,
            'width' => NULL,
            'type' => 'bar',
        ),
        'title' => array('text' => $titulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array('text' => $subtitulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'yAxis' => array('min' => '0',  'allowDecimals' => false, 'title' => array('text' => 'Cantidades por Descripción'),
            'labels' => array('style' => array('color' => 'black', 'font' => '12px Trebuchet MS, Verdana, sans-serif'))
        ),
        'xAxis' => array(
            'categories' => $datos_leyenda,
            'useHTML' => true,
            'reversed' => false,
            'labels' => array(
                'style' => array(
                    'color' => 'black',
                    'width' => '250%',
                    'fontSize' => '12px', 
                    'fontFamily' => 'Verdana, sans-serif'
                )
           )
        ),
        'tooltip' => array(
            'formatter' => 'js:function(){
                return "<b>"+ this.series.name +"</b><br/><b>" +" "+ this.point.category +"</b><br/>"+
               "Cantidad: "+ Highcharts.numberFormat(Math.abs(this.point.y), 0) +" "; }'
        ),
        'plotOptions' => array(
            'bar' => array(
                'dataLabels' => array(
                    'enabled' => false,
                    'color' => 'js:(Highcharts.theme && Highcharts.theme.textColor) || \'black\'',
                    'style' => array(
                        'textShadow' => '1 1 5px black, 0 0 3px black'
                    )
                )
            )
        ),
        'series' => array(
            array('name' => array('Total de Evaluaciones: ' . $datos),
               
                'data' => $total,
                'colorByPoint' => true,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px'))),
        )
    )
));


?>

<div class='fromulario_gradica_cc'>
    <div id="estadistica_citasporcafim" style="min-width: 60%; height: auto; margin: 0 auto" class='ColumLeft1'>
        Espere Se Esta Cargando La Información..!
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
</div>

<?php
if (isset($_GET['id_maestro'])) {
       //     var_dump($_GET['id_maestro']);die;
    $this->widget(
            'booster.widgets.TbExtendedGridView', array(
        'type' => 'striped bordered',
        'responsiveTable' => true,
        'dataProvider' => new CActiveDataProvider('VswAdmin', array(
            'criteria' => array(
                'condition' => 'fk_estatus_evaluacion=' . $_GET['id_maestro'] . '',

            )
                ))
                ,
        'columns' => array(
            'Cédula' => array(
                'name' => 'cedula',
                'value' => '$data->cedula',
            ),
            'Nombres' => array(
                'name' => 'nombres',
                'value' => '$data->nombres',
            ),
            'Apellidos' => array(
                'name' => 'apellidos',
                'value' => '$data->apellidos',
            ),
            'Cargo' => array(
                'header' => 'Cargo',
                'name' => 'descripcion_cargo',
                'value' => '$data->descripcion_cargo',
            ),
            'Oficina' => array(
                'header' => 'Oficina',
                'name' => 'dependencia',
                'value' => '$data->dependencia',
            ),
            'Estatus' => array(
                'header' => 'Estatus',
                'name' => 'estatus',
                'value' => '$data->estatus',

            ),
//            'fk_status_solicitud' => array(
//                'header' => 'Estatus de la Solicitud',
//                'name' => 'fk_status_solicitud',
//                'value' => '$data->status_solicitud',
//                'filter' => Maestro::FindMaestrosByPadreSelect(10),
//            ),
//            'usuario_asignado' => array(
//                'header' => 'Analista asignado',
//                'name' => 'usuario_asignado',
//                'value' => '$data->usuario->username',
//                'filter' => CHtml::listData(CrugeStoredUser::model()->findall(), 'iduser', 'username'),
//            ),
     )
            )
    );
}
?>



