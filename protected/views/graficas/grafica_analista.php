<?php
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if (!$opc) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Analistas',
        ),
        'homeLink' => false,
    ));
    ?>
    <div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle los estatus de las solicitudes correpondiente al Analista, haga CLICK sobre el nombre!</h4>
    </div>
<?php
} else if ($opc == 2) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Analistas' => $this->createUrl('/graficas/graficaanalista'),
            'Casos',
        ),
        'homeLink' => false,
    ));
}

$this->widget(
        'ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'theme' => 'white',
        'chart' => array(
            'renderTo' => 'estadistica_poranalista',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 500,
            'width' => NULL,
            'type' => 'bar',
        ),
        'title' => array('text' => $titulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array('text' => $subtitulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'yAxis' => array('min' => '0', 'allowDecimals' => false, 'title' => array('text' => 'Cantidades'),
            'labels' => array('style' => array('color' => 'black', 'font' => '11px Trebuchet MS, Verdana, sans-serif'))
        ),
        'xAxis' => array(
            'categories' => $datos_leyenda,
            'useHTML' => true,
            'reversed' => false,
            'labels' => array(
                'style' => array(
                    'fontSize' => '12px',
                    'fontFamily' => 'Verdana, sans-serif',
                    'color' => 'black',
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
            array('name' => array('Total de Casos: ' . $datos),
                'colorByPoint' => true,
                'data' => $total,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px'))),
        )
    )
));
?>


<div class='fromulario_gradica_cc'>
    <div id="estadistica_poranalista" style="min-width: 60%; height: auto; margin: 0 auto" class='ColumLeft1'>
        Espere Se Esta Cargando La Información..!
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
</div>

<?php
if (isset($_GET['fk_usuario_asiganado'])) {

    $this->widget(
            'booster.widgets.TbExtendedGridView', array(
        'type' => 'striped bordered',
        'responsiveTable' => true,
        'dataProvider' => new CActiveDataProvider('VswSolicitudesAsignadas', array(
            'criteria' => array(
                'condition' => 'usuario_asignado=' . $_GET['fk_usuario_asiganado'] . '',
            )
                )),
        'columns' => array(
            'id_solicitud' => array(
                'name' => 'id_solicitud',
                'value' => '$data->id_solicitud',
            ),
            'cedula' => array(
                'name' => 'cedula',
                'value' => '$data->cedula',
            ),
            'nombre' => array(
                'name' => 'nombre',
                'value' => '$data->nombre',
            ),
            'apellido' => array(
                'name' => 'apellido',
                'value' => '$data->apellido',
            ),
            'fk_tipo_solicitud' => array(
                'header' => 'Tipo Solicitud',
                'name' => 'fk_tipo_solicitud',
                'value' => '$data->tipo_solicitud',
                'filter' => Maestro::FindMaestrosByPadreSelect(71),
            ),
            'tipo_ayuda_tecnica' => array(
                'header' => 'Sub-Tipo Solicitud',
                'name' => 'tipo_ayuda_tecnica',
                'value' => '$data->tipo_ayuda_tecnica',
            ),
            'fk_mecanismo_recepcion' => array(
                'header' => 'Mecanismo de Recepción',
                'name' => 'fk_mecanismo_recepcion',
                'value' => '$data->mecanismo_recepcion',
                'filter' => Maestro::FindMaestrosByPadreSelect(65),
            ),
            'fk_status_solicitud' => array(
                'header' => 'Estatus de la Solicitud',
                'name' => 'fk_status_solicitud',
                'value' => '$data->status_solicitud',
                'filter' => Maestro::FindMaestrosByPadreSelect(10),
            ),
            'usuario_asignado' => array(
                'header' => 'Analista asignado',
                'name' => 'usuario_asignado',
                'value' => '$data->usuario->username',
                'filter' => CHtml::listData(CrugeStoredUser::model()->findall(), 'iduser', 'username'),
            ),
        )
            )
    );
}
?>