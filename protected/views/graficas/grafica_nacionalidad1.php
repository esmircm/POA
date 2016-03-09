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
            'type' => 'pie',
        ),
        'title' => array('text' => 'Cantidad de Beneficiarios por Nacionalidad', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
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
                'showInLegend' => true,
            )
        ),
        'tooltip' => array(
            'formatter' => 'js:function(){
                    return "<b>"+ this.series.name +"</b><br/>"+
                        "Cantidad: "+ Highcharts.numberFormat(Math.abs(this.point.y), 0) +" "; }'
        ),
        'series' => array(
            array('name' => array('Total de Beneficiarios: ' . $datos),
               
                'data' => $total,
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



