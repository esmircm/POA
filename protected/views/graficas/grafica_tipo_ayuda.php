
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
   <h4> Si desea ver en detalle la información por Tipo de ayuda, haga CLICK en la ayuda!</h4>
    </div>
<?php } else if ($opc == 2) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas' => $this->createUrl('/graficas/graficatipoayuda'),
            'Tipo de Ayudas',
        ),
        'homeLink' => false,
    ));
}


//GRAFICA
?>

<?php
$this->widget('ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'theme' => 'white',
        'chart' => array(
            'renderTo' => 'estadistica',
            'plotBackgroundColor' => null,
            'height' => 500,
             'width' => NULL,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'type' => 'pie'
        ),
        'title' => array('text' => $titulo_grafica, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array('text' => $subtitulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'credits' => array(
            'enabled' => true,
            'href' => 'http://www.minmujer.gob.ve',
            'text' => 'minmujer.gob.ve'
        ),
        'plotOptions' => array(
            'pie' => array(
                'allowPointSelect' => true,
                'cursor' => 'pointer',
                'dataLabels' => array(
                    'enabled' => true,               
                    'color' => 'js:(Highcharts.theme && Highcharts.theme.textColor) || \'black\'',
                    'style' => array(
                        'textShadow' => '1 1 5px black, 0 0 3px black'
                    )
                ),
                'showInLegend' => true
            )
        ),
        'tooltip' => array(
            'formatter' => 'js:function(){
                    return "<b>"+ this.series.name +"</b><br/>"+
                        "Solicitudes por ayuda: "+ Highcharts.numberFormat(Math.abs(this.point.y), 0) +" "; }'
        ),
        'series' => array(
            array('name' => 'Total de Solicitudes: ' . "$total_final", 'data' => $datos,
                'dataLabels' => array('enabled' => 'true', 'style' => array('fontSize' => '11px'))
            ),
        )
    )
));
?>
<?php
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if ($opc == 2) {
  
    $this->widget('ext.highcharts.HighchartsWidget', array(
        'options' => array(
            'theme' => 'white',
            'chart' => array(
                'renderTo' => 'estadistica',
                'plotBackgroundColor' => null,
                'height' => 500,
                'plotBorderWidth' => 1,
                'plotShadow' => false,
                'type' => 'bar'
            ),
            'title' => array('text' => $titulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
             'subtitle' => array('text' => $subtitulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
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
            'yAxis' => array('min' => '0', 'allowDecimals' => false, 'title' => array('text' => 'Cantidades'),
                'labels' => array('style' => array('color' => 'black', 'font' => '11px Trebuchet MS, Verdana, sans-serif'))
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
                array('name' => 'Total de Solicitudes: ' . "$total_final", 'data' => $datos, 'colorByPoint' => true,
                    'dataLabels' => array('enabled' => 'true', 'style' => array('fontSize' => '11px'))
                ),
            )
        )
    ));
}
?>



<!--<div class='row'>-->
    <div id="estadistica" style="min-width: 3%; height: auto; margin: 0 auto" class='ColumLeft1'>
        Por Favor Espere Se Esta Cargando La Información...
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
<!--</div-->