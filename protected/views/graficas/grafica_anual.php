
<?php
// MENU DE LA GRAFICA
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if (!$opc) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas',
        ),
        'homeLink' => false,
    ));
    ?>

    <div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Mes, haga CLICK en el Año!</h4>
    </div>
<?php } else if ($opc == 2) {
  
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Años' => $this->createUrl('/graficas/graficaanual'),
            'Meses',
        ),
        'homeLink' => false,
    )); ?>

 <div class="alert alert-info" style="text-align:center; ">
        <h4> Haga CLICK en el Mes, si desea ver en detalle el Estatus de las Solicitudes realizadas !</h4>
    </div>
<?php } else if ($opc == 3) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Años' => $this->createUrl('/graficas/graficaanual'),
            'Meses'=> $this->createUrl('/graficas/graficaanual', array('anual' => $_REQUEST['anual'],'meses' => $_GET['meses'], 'opc' => 2)),
            'Estatus',
        ),
        'homeLink' => false,
    )); ?>

 <div class="alert alert-info" style="text-align:center; ">
        <h4> Estatus y cuadro de la Solicitudes Realizadas!</h4>
    </div>
  
<?php }
?>
 



<?php
$this->widget(
        'ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'lang' => array(
            'decimalPoint' => ',',
            'resetZoomTitle' => 'Restaurar zoom',
            'printChart' => 'Imprimir el gráfico',
            'downloadPNG' => "Descargar en formato imágen PNG",
            'downloadJPEG' => "Descargar en formato imágen JPEG",
            'downloadPDF' => "Descargar en formato documento PDF",
            'downloadSVG' => "Descargar en formato vector imágen SVG",
            'contextButtonTitle' => "Exportar imágen o documento",
            'loading' => "Cargando...",

        ),
        'theme' => 'white',
        'chart' => array(
            'renderTo' => 'estadistica_anual',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 500,
            'width' => NULL,
            'type' => isset($_GET['opc']) ? 'line' : 'bar',
//            'type' =>  'area',
            'zoomType' => 'x',
            'plotShadow' => false,
        ),
        'title' => array('text' => 'Cantidad de Solicitudes', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array(
            'text' => $subtitulo,
            'style' => array(
                'fontSize' => '15px',
                'font-weight' => 'bold'
            )
        ),
        'yAxis' => array('min' => '0', 'allowDecimals' => false, 'title' => array('text' => 'Cantidades'),
            'labels' => array('style' => array('color' => 'black', 'font' => '12px Trebuchet MS, Verdana, sans-serif'))
        ),
        'xAxis' => array(
            'categories' => $datos_leyenda,
            'useHTML' => true,
            'reversed' => false,
            'labels' => array(
                'style' => array(
                    'color' => 'black',
                    'fontSize' => '12px',
                    'fontFamily' => 'Verdana, sans-serif'
                )
            )
        ),
        'plotOptions' => array(
            'column' => array(
                'dataLabels' => array(
                    'enabled' => false,
                    'color' => 'js:(Highcharts.theme && Highcharts.theme.textColor) || \'black\'',
                    'style' => array(
                        'textShadow' => '1 1 5px black, 0 0 3px black'
                    )
                )
            )
        ),
        'credits' => array(
            'enabled' => true,
            'href' => 'http://www.minmujer.gob.ve',
            'text' => 'minmujer.gob.ve',
        ),
        'tooltip' => array(
            'formatter' => 'js:function(){
                return "<b>"+ this.series.name +"</b><br/><b>" +" </b><br/>"+"Cantidad de "+
                this.point.category +": "+ Highcharts.numberFormat(Math.abs(this.point.y), 0) +" "; }'
        ),
        'series' => array(
            array('name' => array('Total de Solicitudes: ' . $total_final),
                'color' => '#14e087',
                'data' => $datos,
                'colorByPoint' => true,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px','color' => 'black',))),
        )
    )
));
?>

<div>
    <div id="estadistica_anual" style="min-width: 60%; height: auto; margin: 0 auto">
        Espere Se Esta Cargando La Información..!
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
</div>


<?php
function consulta($id) {
    $consulta = Solicitud::model()->findByAttributes(array('fk_tipo_solicitud' => $id ));
    if ($id==72) {
        return $consulta->fkTipoAyudaEconomica->descripcion;
    } else if($id==153 || $id == 73){
        return $consulta->fkTipoAyudaTecnica->descripcion;       
    }
    
}



if (isset($_GET['meses'])) {

    $this->widget(
            'booster.widgets.TbExtendedGridView', array(
        'type' => 'striped bordered',
        'responsiveTable' => true,
        'dataProvider' => new CActiveDataProvider('Solicitud', array(
            'criteria' => array(
                'condition' => "date_part('month', created_date) =" . $_GET['meses'] . " AND date_part('year', created_date) = " . $_GET['anual'],
            )
                )),
        'columns' => array(
            'id_solicitud' => array(
                'header' => 'N° Solicitud',
                'name' => 'id_solicitud',
                'value' => '$data->id_solicitud',
            ),
            'fk_beneficiario' => array(
                'header' => 'Nombre',
                'name' => 'fk_beneficiario',
                'value' => '$data->fkBeneficiario->fkPersona->nombre',
            ),
            'fk_tipo_solicitud' => array(
                'header' => 'Tipo de Solicitud',
                'name' => 'fk_tipo_solicitud',
                'value' => '$data->fkTipoSolicitud->descripcion',
            ),
            'fk_tipo_ayuda_economica' => array(
                'header' => 'Tipo de Ayuda',
                'name' => 'fk_tipo_ayuda_economica',
                'value' => 'consulta($data->fk_tipo_solicitud)',
              
            ),
            'created_date' => array(
                'header' => 'Fecha de Solicitud',
                'name' => 'created_date',
                'value' => 'Yii::app()->dateFormatter->format("d/M/yyyy",strtotime($data->created_date))',
            ),
        )
            )
    );
}
?>

