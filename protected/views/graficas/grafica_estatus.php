<?php
$this->widget(
        'booster.widgets.TbHighCharts', array(
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
            'renderTo' => 'estadistica_mensual',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 500,
            'width' => NULL,
            'type' => 'column',
            'zoomType' => 'x',
            'plotShadow' => false,
            'width' => NULL,
            'type' => 'column',
        ),
        'title' => array('text' => 'Cantidad de Solicitudes', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
        'subtitle' => array(
            'text' => 'Por Estatus',
            'style' => array(
                'fontSize' => '15px',
                'font-weight' => 'bold'
            )
        ),
        'yAxis' => array(
            'min' => '0',
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
        'xAxis' => array(
            'categories' => $leyenda,
            'useHTML' => true,
            'reversed' => false,
            'labels' => array(
                'rotation' => -30,
                'style' => array(
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
            array('name' => array('Total de Estatus: ' . $datos),
                'color' => '#14e087',
                'data' => $total,
                 'colorByPoint' => true,
                'dataLabels' => array('enabled' => 'true',
                    'style' => array('fontSize' => '11px'))),
        )
    )
));

//$this->Widget('ext.highcharts.HighchartsWidget', array(     ));
//  var_dump($enero);
?>

<div class='fromulario_gradica_cc'>
    <div id="estadistica_mensual" style="min-width: 60%; height: auto; margin: 0 auto" class='ColumLeft1'>
        Espere Se Esta Cargando La Información..! 
    </div>
    <div style="clear:both; margin-bottom: 3%"></div>
</div>

