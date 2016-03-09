
<?php
// MENU DE LA GRAFICA
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if (!$opc) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Estado',
        ),
        'homeLink' => false,
    ));
    
    ?>
    <div class="alert alert-info" style="text-align:center; ">
   <h4> Si desea ver en detalle la información por Municipios, haga CLICK en el nombre del Estado!</h4>
    </div>
<?php }else if ($opc == 2) { ?> 

<?php 
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Estado' => $this->createUrl('/graficas/graficabeneficiarioestado'),
            'Municipio',
        ),
        'homeLink' => false,
    ));
?>
<div class="alert alert-info" style="text-align:center; ">
   <h4> Si desea ver en detalle la información por Parroquia, haga CLICK en el nombre del Municipio!</h4>
    </div
<?php } else if ($opc == 3) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Estado' => $this->createUrl('/graficas/graficabeneficiarioestado'),
            'Municipio' => $this->createUrl('/graficas/graficabeneficiarioestado', array('cod_estado' => $_GET['cod_estado'], 'opc' => 2)),
            'Parroquia',
        ),
        'homeLink' => false,
    ));
}

//GRAFICA
?>

<?php
// $this->widget('booster.widgets.TbHighCharts',array(
$this->widget('ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'theme' => 'white',
        'chart' => array(
            'renderTo' => 'estadistica',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 500,
            'width' => NULL,
            'type' => 'bar',
        ),
        'title' => array('text' => $titulo, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array('text' => $subtitulo, 'style' => array('fontSize' => '18px', 'font-weight' => 'bold')),
        'xAxis' => array(
            'categories' => $datos_leyenda,
            'useHTML' => true,
            'reversed' => true,
            'labels' => array(
                'style' => array(
                    'fontSize' => '12px',
                    'fontFamily' => 'Verdana, sans-serif',
                    'color' => 'black',
                )
            )
        ),
        'yAxis' => array(
            'min' => '0',
            'allowDecimals' => false,
            'title' => array(
                'text' => 'Cantidades'
            ),
            'labels' => array(
                'style' => array(
                    'color' => 'black',
                    'font' => '11px Trebuchet MS, Verdana, sans-serif'
                )
            )
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
        'tooltip' => array(
            'formatter' => 'js:function(){
                return "<b>"+ this.series.name +"</b><br/><b>" +"</b>"+
                this.point.category + ": "+ Highcharts.numberFormat(Math.abs(this.point.y), 0) +" "; }'
        ),
        'series' => array(
            array('name' => array('Cantidad de Beneficiarios: ' .$total_final),
                'colorByPoint' => true,
                'data' => $datos,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px'))),
        ),
    )
));
?>



<div class='fromulario_gradica_cc'>
    <div id="estadistica" style="min-width: 60%; height: auto; margin: 0 auto" class='ColumLeft1'>
        Espere Se Esta Cargando La Información..!
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
</div>
