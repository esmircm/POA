<?php

$pdf = Yii::createComponent('application.extensions.MPDF53.mpdf');
//echo '<pre>';var_dump($evaluados);die();
$html.= "<style>
            #prueba{
               border:2px solid;
               border-radius:10px;
            } 
            #prueba1{
               border:2px solid;
               border-radius:10px;
            } 
            .negrillas{
               font-weight: bold;
            }
                     
        </style>";


$html.="<br>";
$html.="<div style='text-align:center; font-size:15 px;  margin-top:50px; border: solid 0px #000;'>";
$html.="<b>EVALUACIÓN DE EFICIENCIA DEL PERSONAL OBRERO(A)</b>
        </div>";

$html.='<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style= "text-align: left; font-size:11px; font-weight: normal;">FECHA DE EVALUACIÓN: ' . $vswpdfobrero->fecha_evaluacion . '</font>';
$html.='<br><br><font style= "font-size:12px; font-weight: bold;">DATOS DEL EVALUADO(A)</font>';

$html.='<div id="table"><br><table width="100%" cellspacing=0 cellpadding=0 border="1" style="margin: 0 auto; border-collapse: collapse;">';
$html.=' <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">APELLIDOS Y NOMBRES:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->apellidos_evaluado . '&nbsp;' . $vswpdfobrero->nombres_evaluado . '</font></td>
         </tr>
         <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">CÉDULA DE IDENTIDAD:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->cedula_evaluado . '</font></td>
         </tr>
         <tr>
                    <td style="height: 5%;"><strong><font style= "font-size:12px;">CARGO:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->cargo_evaluado . '</font></td>cargo_evaluado
                    <td style="height: 5%;"><strong><font style= "font-size:12px;">CÓDIGO:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->cod_nomina_evaluado . '</font></td>
         </tr>
         <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">UBICACIÓN ADMINISTRATIVA:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->oficina_evaluado . '</font></td>
         </tr>          
         <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">PERIODO A EVALUAR:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->periodo_evaluacion . '</font></td>
         </tr>
  </table>
  </div>';


$html.='<br><br><font style= "font-size:12px; font-weight: bold;">DATOS DEL EVALUADOR(A)</font>';

$html.='<div id="table"><br><table width="100%" cellspacing=0 cellpadding=0 border="1" style="margin: 0 auto; border-collapse: collapse;">';
$html.=' <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">APELLIDOS Y NOMBRES:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->apellidos_evaluador . '&nbsp;' . $vswpdfobrero->nombres_evaluador . '</font></td>
         </tr>
         <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">DENOMINACIÓN DEL CARGO:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->cargo_evaluador . '</font></td>
         </tr> 
         <tr>
                    <td colspan="2" style="height: 5%;"><strong><font style= "font-size:12px;">UBICACIÓN ADMINISTRATIVA:</font></strong><font style= "font-size:12px; font-weight: normal;">  ' . $vswpdfobrero->oficina_evaluador . '</font></td>
        </tr>
        </table>
        </div>';
$html.='<br><br>';

$peso = 0;
$sqlobre = "SELECT * FROM evaluacion.preguntas WHERE fk_tipo_clase=11 ORDER BY id_pregunta";
$connection = Yii::app()->db;
$command = $connection->createCommand($sqlobre);
$rowobre = $command->queryAll();
$valobre = count($rowobre);


$sqlobre2 = ' SELECT * FROM evaluacion.vsw_pdf_competencias WHERE id_evaluacion = ' . $vswpdfobrero->id_evaluacion;
$connection = Yii::app()->db;
$command = $connection->createCommand($sqlobre2);
$rowcomobre = $command->queryAll();
$valcompobre = count($rowcomobre);


$html2.="<br>";


$html2.='<font style= "font-size:12px; font-weight: bold;">FACTORES EVALUADOS</font>';
$html2.='<div id="table"><br><table width="100%" cellspacing=0 cellpadding=0 border="1" style="text-align:center; margin: 0 auto; border-collapse: collapse;">
        ';


for ($i = 0; $i < $valobre; $i+=5) {

    $padre = $rowobre[$i]["pregunta_padre"];

    $html2.='<tr>
            <td colspan="3" style="height: 4%; text-align:center; font-size:12px;"><font style="font-size:11px; font-weight:bold;">' . $rowobre[$i]["orden"] . '.' . $rowobre[$i]["pregunta_padre"] . ' </td>
            ';


    for ($pre = 0; $pre < $valobre; $pre++) {

        if ($padre == $rowobre[$pre]["pregunta_padre"]) {
            $html2.='<tr>';
       
                $html2.=' <td width="5%">' . $rowobre[$pre]["orden"] . ' </td>
               <td style="height: 4%; text-align:justify; font-size:12px;"><font style="font-size:11px; font-weight:normal;"> ' . $rowobre[$pre]["pregunta"] . '
                        </td>;
                    <td width="5%" style="height: 4%; text-align:center; font-size:12px;"> ';

            for ($x = 0; $x < $valcompobre; $x++) {
                if ($rowobre[$pre]["id_pregunta"] == $rowcomobre[$x]["id_pregunta"]) {
                    $html2.='X';
                }
            }
            $html2.='</td>  ';
        }
    }
}

$html2.='</tr>
        </table>
        </div>';

$valor = $vswpdfobrero->total_final;
        
if ( $valor >= 20 && $valor <= 36 ){
    $rango = 'Deficiente'; 
}

if ( $valor >= 37 && $valor <= 52 ){
    $rango = 'Regular'; 
}

if ( $valor >= 53 && $valor <= 69){
    $rango = 'Bueno'; 
}

if ( $valor >=  70 && $valor <= 85){
    $rango = 'Muy Bueno'; 
}

if ( $valor >=  86 && $valor <= 100){
    $rango = 'Excelente'; 
}


$html2.='<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style= " text-align:center; font-size:13px; font-weight:normal;">Total Puntuación: ' . $vswpdfobrero->total_final . ' </font>';
$html2.='<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style= "text-align: left; font-size:13px; font-weight: normal;"> Rango de Actuación: '.$rango.'</font>';
$html2.='<br><br><br><br><font style= " text-align: left; font-size:12px; font-weight: bold;">Firmas:</font>';


$html2.='<div id="table"><table width="100%" table style= "margin:0 auto;">';
$html2.='<tr>
        <td><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> _________________________</font></td>
        <td><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> _________________________</font></td>
        <td><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> _________________________</font></td>
        </tr>
        <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> EVALUADOR(A)</font></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> FECHA </font></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="text-align:center; font-size: 12px;"> EVALUADO(A)</font></td>
        </tr>
</table>
</div>';

//echo '<pre>';var_dump('objetivo');die;
//$html.='<div style="text-align:right; margin-top:208px; font-size:10px"><b>' . $NameQr . '</b></div>';
$mpdf = new mPDF('win-1252', 'LETTER', '', '', 15, 15, 25, 15, 1, 7);
$mpdf->WriteHTML($html);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);
$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO');
$mpdf->SetFooter('Sistema SIMCLA |Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"|Página {PAGENO}/{nbpg}');
$mpdf->AddPage();
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);
$mpdf->WriteHTML($html2);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);
$mpdf->Output('Certificado.pdf', 'D');
exit;
?>