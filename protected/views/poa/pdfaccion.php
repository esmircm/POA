<?php
$pdf = Yii::createComponent('application.extensions.MPDF53.mpdf');

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

$html.="<div style='text-align:center; font-size:13px;  margin-top:50px; border: solid 0px #000;'>";
$html.='<br><br><br><br><b>Plan Operativo Anual '.date('Y').'</b>';
$html.='<br><font style=" text-align:center; font-size:11px;">Formulación del Plan</font><br><br>'; 


$html.='<div><table width="100%"  cellspacing=0 cellpadding=0 style="text-align:center; margin: 0 auto;">';
$html.='<tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff; border-collapse: collapse;"><strong><font style= "font-size:9px;"> 1. DIRECTRIZ ESTRATÉGICA</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->nombre_proyecto.'</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;"> 2. OBJETIVO</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->objetivo_general.'</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;">3.UNIDAD EJECUTORA</font></strong></td>
            <td style=" height: 2%; border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;"><font style= " text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->unidad_ejecutora.'</font></td>
        </tr>
 </table>
</div>';

$html.='<br>';
        
$html.='<div><table width="100%" cellspacing=0 cellpadding=0 style="text-align:center; margin: 0 auto; border: 1px solid; ">';

$html.='<tr>
    
            <td rowspan="2" width="20%" style="  background-color: rgba(167,10,10,1); color: #fff; height: 3%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">ACCIÓN</font></td>
            <td rowspan="2" width="10%" style="  background-color: rgba(167,10,10,1); color: #fff; height: 3%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">BIEN O SERVICIO</font></td>
           
            <td colspan="2" width="20%" style="background-color: rgba(167,10,10,1); color: #fff; height: 3%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">META TOTAL</font></td>
            <td colspan="5" width="40%" style="background-color: rgba(167,10,10,1); color: #fff; height: 2%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">PROGRAMACION FISCAL AÑO '.date('Y').' </font></td>
            </tr>
            

        <tr>
                <td width="10%" style= "height: 1%; border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">UNIDAD DE MEDIDA</font></td>
                <td width="10%" style= "height: 1%; border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">CANTIDAD</font></td>
     
     
                <td width="8%" height: 1%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">I TRIM.</font></td>
                <td width="8%" height: 1%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">II TRIM.</font></td>
                <td width="8%" height: 1%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">III TRIM.</font></td>
                <td width="8%" height: 1%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">IV TRIM.</font></td>
                <td width="8%" height: 1%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">TOTAL.</font></td>
                
        </tr>';

     foreach ($vswaccion as $data){
       $html.= '<tr>
    
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:9px;">'.$data->nombre_accion.'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; text-transform: uppercase; font-size:9px;">'.$data->bien_servicio.'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; text-transform: uppercase; font-size:9px;">'.$data->unidad_medida.'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; font-size:9px;">'.$data->cantidad.'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; font-size:9px;">'. Acciones::model()->suma_programado($data->id_accion, ' AND fk_meses in(57, 58, 59) ') .'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; font-size:9px;">'. Acciones::model()->suma_programado($data->id_accion, ' AND fk_meses in(60, 61, 62) ') .'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; font-size:9px;">'. Acciones::model()->suma_programado($data->id_accion, ' AND fk_meses in(63, 64, 65) ') .'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "height: 2%; font-size:9px;">'. Acciones::model()->suma_programado($data->id_accion, ' AND fk_meses in(66, 67, 68) ') .'</font></td>
            <td style= "height: 2%; border-bottom: 1px solid;"><font style= "height: 2%; font-size:9px;">'.$data->cantidad.'</font></td>
            
            </tr>';

        }
$html.='</table>
</div>';


$html.='<br><br>';
$html.='<div>';
$html.='<div style= "width:50%; display:inline-block; float: left;"><table width="80%"  cellspacing=0 cellpadding=0 style="margin-right: auto;">';
$html.='<tr>
            <td colspan="2" style=" height: 2%; text-align:center; background-color: rgba(186,178,178,1); border-collapse: collapse;"><font style= "text-align: center; font-weight: normal; font-size:9px;">FUNCIONARIO RESPONSABLE DE EMITIR LA INFORMACIÓN</font></td>
        </tr>
        
<tr>        
            <td style= "width:20%; height: 2%; border-left: 1px solid;"><font style= "font-size:8px;">APELLIDOS Y NOMBRES:</font></td>
            <td rowspan="3" style= "height: 2%; width:20%; border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid;"><font style= "font-size:8px;"><br><br><br><br><br><br>SELLO DE LA UNIDAD</font></td>
            
</tr>   

<tr> 
    <td style= "width:20%; border-left: 1px solid; border-bottom: 1px solid; height: 2%;"><font style= "font-size:8px;"></font></td> 
</tr>
<tr> 
    <td style= "width:20%; border-bottom: 1px solid; border-left: 1px solid; height: 2%;"><font style= "font-size:8px;">FIRMA</font></td> 
</tr>

</table>
</div>';


$html.='<div style= "width:50%; display:inline-block; text-align: right;"><table width="80%"  cellspacing=0 cellpadding=0 style="margin-left: auto;">';
$html.='<tr>
            <td colspan="2" style="height: 2%; text-align:center; background-color: rgba(186,178,178,1); border-collapse: collapse;"><font style= "font-weight: normal; font-size:9px; text-align: center; ">RESPONSABLES POR LA OFICINA  DE PLANIFICACIÓN Y PRESUPUESTO</font></td>
        </tr>
        <tr>
            <td colspan="2" style="border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid; height: 2%; text-align:center; "><font style= "font-weight: normal; font-size:9px; text-align: center; ">COORDINACION DE PLANIFICACIÓN</font></td>
        </tr>
        <tr>
            <td colspan="2" style="height: 50px; border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid; height: 2%; text-align:center; "><font style= "font-weight: normal; font-size:9px; text-align: center; "><br><br><br><br>FIRMA Y SELLO</font></td>
        </tr>2016


 </table>
</div>';

$html.='</div>';


foreach ($vswaccion as $dato){

$htmlP2[$dato->id_accion].="<div style='text-align:center; font-size:13px;  margin-top:50px; border: solid 0px #000;'>";
$htmlP2[$dato->id_accion].='<br><br><br><br><b>Plan Operativo Anual '.date('Y').'</b>';
$htmlP2[$dato->id_accion].='<br><font style=" text-align:center; font-size:11px;">Formulación del Plan</font><br><br>'; 


$htmlP2[$dato->id_accion].='<div><table width="100%"  cellspacing=0 cellpadding=0 style="text-align:center; margin: 0 auto;">';
$htmlP2[$dato->id_accion].='<tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff; border-collapse: collapse;"><strong><font style= "font-size:9px;"> 1. NOMBRE DE LA ACCIÓN</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:10px;">'.$dato->nombre_accion.'</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;">2.OBJETIVO GENERAL</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->objetivo_general.'</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;">2.OBJETIVO HISTORICO</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= "text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->objetivo_historico.'</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;">META</font></strong></td>
            <td style=" height: 2%; border-top: 1px solid; border-right: 1px solid;"><font style= " text-transform: uppercase; font-size:10px;">'.$dato->cantidad.' ' . $dato->unidad_medida . '</font></td>
        </tr>
        <tr>
            <td width="20%" style=" height: 1%; text-align:left; background-color: rgba(167,10,10,1); color: #fff;"><strong><font style= "font-size:9px;">3.UNIDAD EJECUTORA</font></strong></td>
            <td style=" height: 2%; border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;"><font style= " text-transform: uppercase; font-size:10px;">'.$vswpdfproyecto->unidad_ejecutora.'</font></td>
        </tr>
 </table>
</div>';


$htmlP2[$dato->id_accion].='<br>';
        
$htmlP2[$dato->id_accion].='<div><table width="100%" cellspacing=0 cellpadding=0 style="text-align:center; margin: 0 auto; border: 1px solid; ">';

$htmlP2[$dato->id_accion].='<tr>
            <td rowspan="2" width="17%" style=" background-color: rgba(167,10,10,1); color: #fff; height: 4%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">ACTIVIDADES</font></td>
            <td rowspan="2" width="3%" style="  background-color: rgba(167,10,10,1); color: #fff; height: 4%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">UNIDAD DE MEDIDA</font></td>
            <td rowspan="2" width="5%" style="  background-color: rgba(167,10,10,1); color: #fff; height: 4%; border-right: 1px solid;"><font style= "font-weight: bold; font-size:9px;">CANTIDAD</font></td>
                
                <td colspan="13" width="75%" valign="middle" style="background-color: rgba(167,10,10,1); color: #fff; text-align: center; height: 2%; border-right: 1px solid; border-bottom: 1px solid; vertical-align=middle;"><font style= "font-weight: bold; font-size:9px;">PROGRAMACIÓN MENSUAL DE LAS ACTIVIDADES</font>
                <tr>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Enero</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Febrero</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Marzo</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Abril</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Mayo</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Junio</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Julio</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Agosto</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Septiembre</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Octubre</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Noviembre</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Diciembre</font></td>
                   <td width="5%" height: 2%; style= "border-right: 1px solid; background-color: rgba(186,178,178,1);"><font style= "font-size:8px;">Total</font></td>
                   </tr>
                </td>
            
        </tr>';
    $vswactividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $dato->id_accion));
    foreach ($vswactividades as $data){
      $htmlP2[$dato->id_accion].= '<tr border=1px>
            <td width="17%" style="height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "font-size:9px;">'.$data->actividad.'</font></td>
            <td width="3%" style="height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "font-size:9px;">'.$data->unidad_medida.'</font></td>
            <td width="5%" style="height: 2%; border-bottom: 1px solid; border-right: 1px solid;"><font style= "font-size:9px;">'.$data->cantidad.'</font></td>';
                     
      
      
      
    foreach ($maestro as $meses){
        $htmlP2[$dato->id_accion].= '<td width="5%" style= "height: 2%; border-right: 1px solid; border-bottom: 1px solid;"><font style= "font-size:9px;">'. Actividades::model()->suma_programado($data->id_actividades, ' AND fk_meses in('. $meses->id_maestro .') ') .'</font></td>';
      }   
                   
                  $htmlP2[$dato->id_accion].= '<td width="5%" style= "height: 2%; border-right: 1px solid; border-bottom: 1px solid;"><font style= "font-size:9px;">'.$data->cantidad.'</font></td>
            
        </tr>';
        }
$htmlP2[$dato->id_accion].='</table>
</div>';


$htmlP2[$dato->id_accion].='<br><br>';
$htmlP2[$dato->id_accion].='<div>';
$htmlP2[$dato->id_accion].='<div style= "width:50%; display:inline-block; float: left;"><table width="80%"  cellspacing=0 cellpadding=0 style="margin-right: auto;">';
$htmlP2[$dato->id_accion].='<tr>
            <td colspan="2" style=" height: 2%; text-align:center; background-color: rgba(186,178,178,1); border-collapse: collapse;"><font style= "text-align: center; font-weight: normal; font-size:9px;">FUNCIONARIO RESPONSABLE DE EMITIR LA INFORMACIÓN</font></td>
        </tr>
        
<tr>        
            <td style= "width:20%; height: 2%; border-left: 1px solid;"><font style= "font-size:8px;">APELLIDOS Y NOMBRES:</font></td>
            <td rowspan="3" style= "height: 2%; width:20%; border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid;"><font style= "font-size:8px;"><br><br><br><br><br><br>SELLO DE LA UNIDAD</font></td>
            
</tr>   

<tr> 
    <td style= "width:20%; border-left: 1px solid; border-bottom: 1px solid; height: 2%;"><font style= "font-size:8px;"></font></td> 
</tr>
<tr> 
    <td style= "width:20%; border-bottom: 1px solid; border-left: 1px solid; height: 2%;"><font style= "font-size:8px;">FIRMA</font></td> 
</tr>

</table>
</div>';


$htmlP2[$dato->id_accion].='<div style= "width:50%; display:inline-block; text-align: right;"><table width="80%"  cellspacing=0 cellpadding=0 style="margin-left: auto;">';
$htmlP2[$dato->id_accion].='<tr>
            <td colspan="2" style="height: 2%; text-align:center; background-color: rgba(186,178,178,1); border-collapse: collapse;"><font style= "font-weight: normal; font-size:9px; text-align: center; ">RESPONSABLES POR LA OFICINA  DE PLANIFICACIÓN Y PRESUPUESTO</font></td>
        </tr>
        <tr>
            <td colspan="2" style="border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid; height: 2%; text-align:center; "><font style= "font-weight: normal; font-size:9px; text-align: center; ">COORDINACION DE PLANIFICACIÓN</font></td>
        </tr>
        <tr>
            <td colspan="2" style="height: 50px; border-left: 1px solid; border-right: 1px solid; border-bottom: 1px solid; height: 2%; text-align:center; "><font style= "font-weight: normal; font-size:9px; text-align: center; "><br><br><br><br>FIRMA Y SELLO</font></td>
        </tr>2016


 </table>
</div>';

$htmlP2[$dato->id_accion].='</div>';

}


$mpdf = new mPDF('utf-8', 'LEGAL-L');

$mpdf->WriteHTML($html);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1); 

$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO'); 
$mpdf->SetFooter('Sistema SIGEPOA |Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"|Página {PAGENO}/{nbpg}');
foreach ($htmlP2 as $data){
    $mpdf->AddPage();
    $mpdf->WriteHTML($data);
    $mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);  
}
$mpdf->Output('Certificado.pdf', 'D');
exit;
?>


