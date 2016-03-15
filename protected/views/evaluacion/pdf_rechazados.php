<?php
$pdf = Yii::createComponent('application.extensions.MPDF53.mpdf');
$html.='<style>'
        . '.titulo{width: 100%; font-weight: 700; text-align: center;}'
        . '#table td{height:40px;}'
        . '</style>';

$html.= '<br><br><br><h1 class="titulo">Reporte de Metas de Rendimiento Laboral<br>
    Estatus Rechazado más de tres veces</h1><div style="margin: 0 auto; width: 100%; display: block;">
<table id="table" style="border: solid 1px #dddddd; margin: 0 auto; width: 100%;">
    <tr>
        <td style="width: 40px;"><strong>
            N°
        </strong></td>
        <td><strong>
            Evaluador
        </strong></td>
        <td><strong>
            Oficina del Evaluador
        </strong></td>
        <td><strong>
            Evaluado
        </strong></td>
        <td><strong>
            N° de Rechazos
        </strong></td>
    </tr>';

$numero = 1;
foreach($row as $tuplas){
    $html.= '<tr style="border: solid 1px #000000;">';
    $html.= '<td style="text-align: center;"><strong>' . $numero . '</strong></td>';
    $html.= '<td>' . $tuplas['evaluador'] . '</td>';
    $html.= '<td>' . $tuplas['oficina'] . '</td>';
    $html.= '<td>' . $tuplas['evaluado'] . '</td>';
    $html.= '<td style="text-align: center">' . $tuplas['rechazos'] . '</td>';
    $html.= '</tr>';
    
    $numero++;
}
$html.= '</table>';
$html.= '</div>';
//var_dump($html);die;

$mpdf = new mPDF('utf-8', 'LEGAL-L');
$mpdf->WriteHTML($html);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1); 
$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO'); 
$mpdf->SetFooter('Sistema SIMCLA |Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"|Página {PAGENO}/{nbpg}');
$mpdf->Output('Reporte Rechazados.pdf', 'D');
exit;
?>