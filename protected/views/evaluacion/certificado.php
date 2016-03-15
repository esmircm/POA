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
/**
 * IMAGEN DE HEADER
 */
$html.="<div style='text-align:center; font-size:18px; margin-top:50px; border: solid 0px #000;'>";
$html.="    <b>Planilla MRL del Ministerio del Poder Popular para la Mujer y la Igualdad de Género</b>";
$html.="    <br>
            <br>
        </div>";


$html.="<p style='text-align:center'><b>Datos del Evaluador(a) / Supervisor(a):</b></p>";
$html.="<br />";
$html.='<div id="prueba"><table width="100%">';
$html.=' <tr>
                    <td width="35%"><strong>Nombres:</strong>  ' . $vswpdf->nombres . '</td>
                    <td width="35%"><strong>Apellidos:</strong>  ' . $vswpdf->apellidos . '</td>
                </tr>
         <tr>
                    <td width="35%"><strong>Cédula:</strong>  ' . $vswpdf->cedula . '</td>
                    <td width="35%"><strong>Código Nómina:</strong>  ' . $vswpdf->cod_nomina . '</td>
                </tr>
        <tr> 
                   <td width="100%"><strong>Cargo:</strong>  ' . $vswpdf->cargo . '</td>
                </tr>
        <tr>
                   <td width="110%"><strong>Ubicación Administrstiva:</strong> ' . $vswpdf->unidad_admtiva . '</td>
                   <td width="35%"><strong>Teléfono:</strong> ' . $vswpdf->telef_oficina . '</td>
                </tr>
        
  </table>
  </div>';
//        <tr>
//                    <td class="negrillas">Objetivo Funcional del Área que Supervisa:  ' . $vswpdf->obj_funcional . '</td>
//                </tr>


$html.="<p style='text-align:center'><b>Datos del Evaluado(a) / Supervisado(a):</b></p>";
$html.="<br />";
$html.='<div id="prueba"><table width="100%">';
$html.=' <tr>
                    <td width="35%"><strong>Nombres:</strong>  ' . $vswpdf->nombres_evaluado . '</td>
                    <td width="35%"><strong>Apellidos:</strong>  ' . $vswpdf->apellidos_evaluado . '</td>
                </tr>
         <tr>
                    <td width="35%"><strong>Cédula:</strong>  ' . $vswpdf->cedula_evaluado . '</td>
                    <td width="35%"><strong>Código Nómina:</strong>  ' . $vswpdf->cod_nomina_evaluado . '</td>
                </tr>
        <tr> 
                   <td width="100%"><strong>Cargo:</strong>  ' . $vswpdf->cargo_evaluado . '</td>
                </tr>
        <tr>
                   <td width="110%"><strong>Ubicación Administrstiva:</strong> ' . $vswpdf->oficina_evaluado . '</td>
                   <td width="35%"><strong>Teléfono:</strong> ' . $vswpdf->telefono_evaluado . '</td>
                </tr>
        
  </table>
  </div>';

$html.="<p style='text-align:center'><b>Establecimiento y Seguimiento de los Objetivos de las Metas de Rendimiento Laboral:</b></p>";


$html.='<div id="puntos" ><table width="100%" class = "prueba3">';
$html.=
        '<tr>
    <td scope="col"><strong>Objetivos de Desempeño Individual</strong></td>
    <td scope="col"><strong>  Peso</strong></td>
    <td class="tg-hpj3"></td>
    
  </tr>';

$i = 0;
$sql = 'SELECT id_evaluacion, id_preguntas_ind, objetivo, peso FROM evaluacion.vsw_pdf_objetivos
WHERE id_evaluacion =' . $vswpdf->id_evaluacion;

$connection = Yii::app()->db;
$command = $connection->createCommand($sql);
$preind = $command->queryAll();

$val = count($preind);

while ($i < $val) {
    $html.='  <tr class = "prueba" >
                <td>' . $preind[$i]["objetivo"] . ' </td>
                <td>' . $preind[$i]["peso"] . '</td>
            <td></td> <td></td>       ';
    if ($i == $val - 1) {
//        $html.='<td style="text-align:center"> <oberline>Firma del Evaluador Firma del Supervisor</oberline></td>';
    } else {
        $html.='<td></td> ';
    }

    $i++;
}
$html.='
            
</tr>
<tr>
<td>Total:</td>
<td>50</td>
<td></td><td></td><td></td>
</tr> 
</table>
</div>';

$sqlnom = 'SELECT fk_revision, fk_evaluacion, fecha_revision  FROM evaluacion.revision WHERE fk_evaluacion = ' . $_GET['id'] .'and es_activo=true' ;
$connectionom = Yii::app()->db;
$commandnom = $connectionom->createCommand($sqlnom);
$rownom = $commandnom->queryAll();
$valnom = count($rownom);

function cambiarFormatoFecha($fecha){
    list($anio,$mes,$dia)=explode("-",$fecha);
    return $dia."-".$mes."-".$anio;
}  

 
for ($i=0; $i<=$valnom; $i++){

    if ($i==0){
    $fecha0= $rownom[$i]['fecha_revision'];
    }
    if ($i==1){
    $fecha1= $rownom[$i]['fecha_revision'];
    }
    if ($i==2){
    $fecha2= $rownom[$i]['fecha_revision'];
    }
}

$html.="<br />";
$html.='<table style="border: 1px solid #000000;" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td rowspan="3"><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i>Fecha de Establecimiento de las ODI:</i></b></span></font><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i><br></i></b></span></font><div><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador(a):__________________</b></span></font><br></td>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Primera Revisión Fecha: '.cambiarFormatoFecha($fecha0).'</b></span></font></td>
    </tr>
    <tr>
        <td></td>
    </tr>
    <tr>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador Firma del Supervisor(a)</b></span></font></td>
    </tr>
    </table>
    ';
$html.="<br />";
$html.='<table style="border: 1px solid #000000;" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td rowspan="3"><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i>Fecha de Establecimiento de las ODI:</i></b></span></font><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i><br></i></b></span></font><div><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador(a):__________________</b></span></font><br></td>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Segunda Revisión Fecha: '.cambiarFormatoFecha($fecha1).'</b></span></font></td>
    </tr>
    <tr>
        <td></td>
    </tr>
    <tr>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador Firma del Supervisor(a)</b></span></font></td>
    </tr>
</table>
</div>';
$html.="<br />";
$html.='<table style="border: 1px solid #000000;" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td rowspan="3"><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i>Fecha de Establecimiento de las ODI:</i></b></span></font><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b><i><br></i></b></span></font><div><br><div><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador(a):__________________</b></span></font><br></td>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Tercera Revisión Fecha: '.cambiarFormatoFecha($fecha2).'</b></span></font></td>
    </tr>
    <tr>
        <td></td>
    </tr>
    <tr>
        <td><font color="#333333" face="arial, sans-serif"><span style="font-size: 10px; line-height: 18.2000007629395px;"><b>Firma del Evaluador Firma del Supervisor(a)</b></span></font></td>
    </tr>
</table>

</div>';

//echo '<pre>';var_dump('objetivo');die;

//$html.='<div style="text-align:right; margin-top:208px; font-size:10px"><b>' . $NameQr . '</b></div>';
$mpdf = new mPDF('win-1252', 'LETTER', '', '', 15, 15, 25, 1, 1, 1);
$mpdf->WriteHTML($html);
$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO');
$mpdf->SetFooter('Sistema SIMCLA |Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '|Página {PAGENO}/{nbpg}');
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);
$mpdf->Output('Certificado.pdf', 'D');
exit;
?>
