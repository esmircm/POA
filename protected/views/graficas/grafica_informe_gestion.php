
<?php
// MENU DE LA GRAFICA
$opc = (isset($_REQUEST['opc'])) ? $_REQUEST['opc'] : '';
if (!$opc) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año',
        ),
        'homeLink' => false,
    ));
    ?>

    <div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Mes, haga CLICK en el Año!</h4>
    </div>
    <?php
} else if ($opc == 2) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año' => $this->createUrl('/graficas/graficagestion'),
            'Ayudas por Meses',
        ),
        'homeLink' => false,
    ));
   ?> 
<div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Recepción, haga CLICK en el Mes!</h4>
    </div>
<?php
} else if ($opc == 3) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año' => $this->createUrl('/graficas/graficagestion'),
            'Ayudas por Meses' => $this->createUrl('/graficas/graficagestion',array('anual' => $_GET['anio'], 'opc' => 2)),
            'Tipo de Recepción',
        ),
        'homeLink' => false,
    ));

//GRAFICA
?>


<div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Estado, haga CLICK en una Recepción!</h4>
    </div>
<?php
} else if ($opc == 4) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año' => $this->createUrl('/graficas/graficagestion'),
            'Ayudas por Meses' => $this->createUrl('/graficas/graficagestion',array('anual' => $_GET['anio'], 'opc' => 2)),
            'Tipo de Recepción' => $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'], 'opc' => 3)),
            'Recepción por Estado',
        ),
        'homeLink' => false,
    ));

//GRAFICA
?>

<div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Ayuda, haga CLICK en un Estado!</h4>
    </div>
<?php
} else if ($opc == 5) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año' => $this->createUrl('/graficas/graficagestion'),
            'Ayudas por Meses' => $this->createUrl('/graficas/graficagestion',array('anual' => $_GET['anio'], 'opc' => 2)),
            'Tipo de Recepción' => $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'], 'opc' => 3)),
            'Recepción por Estado'=> $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'],'recepcion' => $_GET['recepcion'], 'opc' => 4)),
            'Tipos de Ayudas',
        ),
        'homeLink' => false,
    ));

//GRAFICA
?>

<div class="alert alert-info" style="text-align:center; ">
        <h4> Si desea ver en detalle la información por Genero, haga CLICK en una Ayuda!</h4>
    </div>
<?php
}else if ($opc == 6) {
    $this->widget('booster.widgets.TbBreadcrumbs', array(
        'links' => array(
            'Ayudas por Año' => $this->createUrl('/graficas/graficagestion'),
            'Ayudas por Meses' => $this->createUrl('/graficas/graficagestion',array('anual' => $_GET['anio'], 'opc' => 2)),
            'Tipo de Recepción' => $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'], 'opc' => 3)),
            'Recepción por Estado'=> $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'],'recepcion' => $_GET['recepcion'], 'opc' => 4)),
            'Tipos de Ayudas'=> $this->createUrl('/graficas/graficagestion',array('anio' => $_GET['anio'],'meses' => $_GET['meses'],'recepcion' => $_GET['recepcion'],'estado' => $_GET['estado'], 'opc' => 5)),
            'Ayudas por Género',
        ),
        'homeLink' => false,
    ));
}
//GRAFICA
?>




<?php
$this->widget(
        'ext.highcharts.HighchartsWidget', array(
    'options' => array(
        'colors' => $colores,
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
            'type' => $tipo,
            
//            'type' =>  'area',
            'zoomType' => 'x',
            'plotShadow' => false,
            //'width' => 1998,
        ),
        'title' => array('text' => 'Tipo de Solicitudes', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array(
            'text' => $subtitulo,
            'style' => array(
                'fontSize' => '15px',
                'font-weight' => 'bold'
            )
        ),
        'yAxis' => array(
            'min' => '0',
             'allowDecimals' => false,
            'title' => array(
                'text' => 'Cantidades'
            ),
           'labels' => array('style' => array('color' => 'black', 'font' => '12px Trebuchet MS, Verdana, sans-serif'))
        ),
        'xAxis' => array(
            'categories' => $datos_leyenda,
            'useHTML' => true,
            'reversed' => $reversed,
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
                        'textShadow' => '1 1 5px white, 0 0 3px black'
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
            array('name' => array('Total de Recepción: ' . $total_final),
                'color' => '#14e087',
                'data' => $datos,
                'colorByPoint' => true,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px', 'color' => 'black'))),
        )
    )
));

//$this->Widget('ext.highcharts.HighchartsWidget', array(     ));
//  var_dump($enero);
?>

<!--<div class='row'>-->
<div id="estadistica_anual" style="min-width: 3%; height: auto; margin: 0 auto" class='ColumLeft1'>
    Por Favor Espere Se Esta Cargando La Información...
</div>
<div style="clear:both; margin-bottom: 3%"></div>
<!--</div-->