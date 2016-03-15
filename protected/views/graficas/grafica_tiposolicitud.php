<?php
$this->widget(
    'booster.widgets.TbHighCharts',
    array(
    'options' => array(
        'chart' => array(
            'renderTo' => 'estadistica_mensual',
            'plotBackgroundColor' => null,
            'plotBorderWidth' => 1,
            'plotShadow' => false,
            'height' => 500,
            'width' => NULL,
            'type'=>'pie',
        ),
        'title' => array('text' => 'Solicitudes por Tipo de Ayuda', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),

        'subtitle' => array('text' => 'General', 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),

        'yAxis' => array('min' => '0', 'title' => array('text' => 'Cantidades'),
            'minorTickInterval' => 'auto', 'lineColor' => '#000', 'lineWidth' => 1, 'tickWidth' => 1, 'tickColor' => '#000',
            'labels' => array('style' => array('color' => '#990000', 'font' => '11px Trebuchet MS, Verdana, sans-serif'))
        ),

        'xAxis' => array('labels' => array('rotation' => '-45', 'align' => 'right', 'style' => array('fontSize' => '11px')),
            'categories' => $leyenda, 'gridLineWidth' => 1, 'tickColor' => '#000'),
        'credits' => array(
            'enabled' => true,
            'href'=> 'http://www.minmujer.gob.ve',
            'text'=> 'minmujer.gob.ve'
        ),
        'series' => array(
            array('name' => array('Total de Solicitudes: '. $datos),
                'color' => '#1977f6',
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



