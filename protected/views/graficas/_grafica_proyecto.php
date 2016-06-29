<?php

$this->widget(
            'ext.highcharts.HighchartsWidget', array(
        'options' => array(
            'theme' => 'white',
            'chart' => array(
                'renderTo' => $graficas->nombre_accion,
                'plotBackgroundColor' => null,
                'plotBorderWidth' => 1,
                'plotShadow' => false,
                'height' => 400,
                'width' => NULL,
                'type' => 'column',
            ),
            'title' => array('text' => $graficas->nombre_accion, 'style' => array('font-size' => '15px', 'font-weight' => 'bold')),
            'subtitle' => array('text' => $graficas->unidad_medida, 'style' => array('fontSize' => '15px', 'font-weight' => 'bold')),
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
                        'colors' => array('#000000', '#FFFFFF'),
                        'style' => array(
                            'textShadow' => '1 1 5px black, 0 0 3px black'
                        )
                    )
                )
            ),
            'series' => array(
                array(               
                    'data' => $total,
                    'colorByPoint' => true,
                    'dataLabels' => array('enabled' => 'true',
                        'style' => array('fontSize' => '10px'))),
            )
        )
    ));

?>

