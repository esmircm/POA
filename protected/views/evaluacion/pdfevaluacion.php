<?php
$pdf = Yii::createComponent('application.extensions.MPDF53.mpdf');
//echo '<pre>';var_dump($objetivo);die();

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
//$n = dirname(dirname(dirname(__DIR__))) . '/img/banner.png';
//$html.= '<center><img src="' . $n . '"/></center>';

$sqlnom = ' SELECT  fk_tipo_clase FROM evaluacion.vsw_pdf_competencias WHERE id_evaluacion = '. $vswpdfinal->id_evaluacion . 'limit 1';
$connectionom = Yii::app()->db;
$commandnom = $connectionom->createCommand($sqlnom);
$rownom = $commandnom->queryAll();
$valnom = count($rownom);

if ($rownom[0]['fk_tipo_clase']=="13"){
    $nivel= "NIVEL ADMINISTRATIVO Y DE APOYO" ;
}
if ($rownom[0]['fk_tipo_clase']=="12"){
    $nivel= "NIVEL PROFESIONAL"; 
}
if ($rownom[0]['fk_tipo_clase']=="14"){
    $nivel = "NIVEL SUPERVISORIO";
}
$html.="    <br><br><br>";
$html.="<div style='text-align:center; font-size:15 px;  margin-top:50px; border: solid 0px #000;'>";
$html.="    <b>EVALUACIÓN DEL DESEMPEÑO - " . $nivel . "</b>"; 

$html.="    <br>
        </div>";

$html.="<br><h6>PERIODO EVALUADO(A): $vswpdfinal->periodo_evaluacion &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;N° DE VECES QUE HA SIDO EVALUADO: $vswpdfinal->n_veces</h6> "; 
$html.="<h6>SECCIÓN (A): DATOS DE IDENTIFICACIÓN</h6>";
$html.="<h6>DATOS DEL EVALUADO(A)</h6>";

$html.='<div id="table"><table width="100%" style= "border: 1px solid;">';
$html.=' <tr>
                    <td><strong><font style= "font-size:10px;">APELLIDOS Y NOMBRES:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->apellidos_evaluado . '&nbsp;' . $vswpdfinal->nombres_evaluado . '</font></td>
                    <td colspan="2"><strong><font style= "font-size:10px;">CÉDULA DE IDENTIDAD:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cedula_evaluado .'</font></td>
         </tr>
         <tr>
                    <td><strong><font style= "font-size:10px;">CÓDIGO DE NÓMINA:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cod_nomina_evaluado .'</font></td>
                    <td colspan="2"><strong><font style= "font-size:10px;">TÍTULO DEL CARGO:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cargo_evaluado .'</font></td>
         </tr>
         <tr>
                    <td width="33%"><strong><font style= "font-size:10px;">GRADO: ' .$vswpdfinal->grado_evaluado. '</font></strong><font style= "font-size:10px; font-weight: normal;"></font></td>
                    <td width="33%"><strong><font style= "font-size:10px;">CÓDIGO DE CLASE:</font></strong><font style= "font-size:10px; font-weight: normal;"></font></td>
                    <td width="34%"><strong><font style= "font-size:10px;">UBICACIÓN ADMINISTRATIVA:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->oficina_evaluado .'</font></td>
         </tr>
  </table>
  </div>';



$html.="<h6>DATOS DEL EVALUADOR(A)</h6>";

$html.='<div id="table"><table width="100%" style= "border: 1px solid;">';
$html.=' <tr>
                    <td ><strong><font style= "font-size:10px;">APELLIDOS Y NOMBRES:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->apellidos_evaluador . '&nbsp;' . $vswpdfinal->nombres_evaluador . '</font></td>
                    <td colspan="2"><strong><font style= "font-size:10px;">CÉDULA DE IDENTIDAD:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cedula_evaluador .'</font></td>
         </tr>
         <tr>
                    <td><strong><font style= "font-size:10px;">CÓDIGO DE NÓMINA:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cod_nomina_evaluador .'</font></td>
                    <td colspan="2"><strong><font style= "font-size:10px;">TÍTULO DEL CARGO:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cargo_evaluador .'</font></td>
         </tr>
         <tr>
                    <td width="33%"><strong><font style= "font-size:10px;">GRADO: ' .$vswpdfinal->grado_evaluador. '</font></strong><font style= "font-size:10px; font-weight: normal;"></font></td>
                    <td width="33%"><strong><font style= "font-size:10px;">CÓDIGO DE CLASE:</font></strong><font style= "font-size:10px; font-weight: normal;"></font></td>
                    <td width="34%"><strong><font style= "font-size:10px;">UBICACIÓN ADMINISTRATIVA:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->oficina_evaluador .'</font></td>
         </tr>
  </table>
  </div>';

$html.="<h6>DATOS DEL SUPERVISOR(A) DEL EVALUADOR(A)</h6>";

$html.='<div id="table"><table width="100%" style= "border: 1px solid;">';
$html.=' <tr>
                    <td><strong><font style= "font-size:10px;">APELLIDOS Y NOMBRES:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->apellidos_supervisor . '&nbsp;' . $vswpdfinal->nombres_supervisor . '</font></td>
                    <td><strong><font style= "font-size:10px;">CÉDULA DE IDENTIDAD:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cedula_supervisor .'</font></td>
         </tr>
         <tr>
                    <td colspan="2"><strong><font style= "font-size:10px;">CARGO:</font></strong><font style= "font-size:10px; font-weight: normal;">  ' . $vswpdfinal->cargo_supervisor .'</font></td>
         </tr>
  </table>
  </div>';





//$mPDF->AddPage(); 

//$n = dirname(dirname(dirname(__DIR__))) . '/img/banner.png';
//$htmlP2.= '<center><img src="' . $n . '"/></center>';


//$html.="    <br><br><br>";

//$objetivo = VswPdfObjetivos::model()->findByAttributes(array('id_evaluacion' => $vswpdfinal->id_evaluacion ));
$i = 0;
$peso=0;
$sqlodi = 'SELECT id_evaluacion, id_preguntas_ind, objetivo, peso,  rango, subtotal_peso FROM evaluacion.vsw_pdf_objetivos
WHERE id_evaluacion =' . $vswpdfinal->id_evaluacion;
$connection = Yii::app()->db;
$command = $connection->createCommand($sqlodi);
$rowpersonal = $command->queryAll();

$valpersonal = count($rowpersonal);



//echo '<pre>';var_dump($objetivo);die();

$htmlP2.="    <br><br><br><br><br>";
$htmlP2.='<font style= "font-size:11px; font-weight: bold;">SECCIÓN "B": ESTABLECIMIENTO Y EVALUACIÓN DE OBJETIVOS DE DESEMPEÑO INDIVIDUAL</font>';
$htmlP2.='<br><font style= "font-size:11px; font-weight: normal;">En esta sección se establecen los Objetivos del Desempeño Individual (ODI) que el funcionario debe cumplir en el periodo a evaluar.</font>';
$htmlP2.="    <br><br><br>";

$htmlP2.='<div id="table"><table width="75%" cellspacing=0 cellpadding=0 border="1" style="text-align:center; margin: 0 auto; border-collapse: collapse;">';
$htmlP2.=' <tr>
              <td><strong><font style="font-size:11px; font-weight:bold;">OBJETIVOS DE DESEMPEÑO INDIVIDUAL</strong></td>
              

           <td><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">PESO</strong></td> 

           
           <td><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">RANGOS</strong></td>
           <td><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">PESO <br> X <br> RANGO</strong></td> 
          
    
            <tr>';
    
$totalpeso=0;
$totalpr=0;
    while ($i < $valpersonal) {
    $htmlP2.='  <tr class = "prueba" >
                <td style="height: 4%; text-align:justify; font-size:12px;">' . $rowpersonal[$i]["objetivo"] . ' </td>
                <td style="height: 4%; text-align:center; font-size:12px;">' . $rowpersonal[$i]["peso"] . '</td>  
                <td style="height: 4%; text-align:center; font-size:12px;">' . $rowpersonal[$i]["rango"] . '</td>
                <td style="height: 4%; text-align:center; font-size:12px;">' . $rowpersonal[$i]["subtotal_peso"] . '</td>  
                 
              
              
                   ';
    
    if ($i == $valpersonal - 1) {
//        $html.='<td style="text-align:center"> <oberline>Firma del Evaluador Firma del Supervisor</oberline></td>';
    } else {
       $htmlP2.=''; 
    }
$totalpeso=$totalpeso+$rowpersonal[$i]["peso"];
$totalpr=$totalpr+$rowpersonal[$i]["subtotal_peso"];
    $i++;
    
    
    
    
}

$htmlP2.='
</tr>
      <tr>
      <td style="height: 2%; border-left: hidden; border-bottom: hidden; text-align:center; font-size:12px; "></td>
<td style="text-align:center; font-size:12px; ">'.$totalpeso.'</td>
<td style="text-align:center; font-size:12px; ">TOTAL</td>

<td style="text-align:center; font-size:12px; ">'.$totalpr.'</td>
</tr> 


 
    </table>
    </div>';





$htmlP2.='<br>';
$htmlP2.='<div id="table"><table width="25%"  cellspacing=0 cellpadding=0 border="1" style="text-align:center; margin: 0 auto; border-collapse: collapse;">';
$htmlP2.=' <tr>
              <td  width="2%" style=" height: 2%;"><strong><font style=" font-size:12px; height: 4%;">Rango</strong></td>
              <td  width="5%"style=" height: 2%;"><strong><font style=" text-align:center; font-size:12px;">Descripción</strong></td> 
            </tr>
         <tr>
              <td><strong><font style="font-size:12px; font-weight:normal;">1</strong></td>
              <td style="text-align:justify;"><strong><font style=" font-size:12px; font-weight:normal;">Muy por debajo de lo esperado</strong></td> 
         </tr>
          <tr>
              <td><strong><font style="font-size:12px; font-weight:normal;">2</strong></td>
              <td style="text-align:justify;"><strong><font style=" text-align:left; font-size:12px; font-weight:normal;">Por debajo de lo esperado</strong></td> 
         </tr>
          <tr>
              <td><strong><font style="font-size:12px; font-weight:normal;">3</strong></td>
              <td style="text-align:justify;"><strong><font style=" text-align:left; font-size:12px; font-weight:normal;">Dentro de lo esperado</strong></td> 
         </tr>
          <tr>
              <td><strong><font style="font-size:12px; font-weight:normal;">4   </strong></td>
              <td style="text-align:justify;"><strong><font style=" text-align:left; font-size:12px; font-weight:normal;">Sobre lo esperado</strong></td> 
         </tr>
          <tr>
              <td><strong><font style="font-size:12px; font-weight:normal;">5</strong></td>
              <td style="text-align:justify;"><strong><font style=" text-align:left; font-size:12px; font-weight:normal;">Excepcional</strong></td> 
         </tr>
         </table>
         </div>';



$competencia = 0;
$pesoc=0;
$sqlcompetencia = ' SELECT  * FROM evaluacion.vsw_pdf_competencias WHERE id_evaluacion = '. $vswpdfinal->id_evaluacion;
$connection = Yii::app()->db;
$command = $connection->createCommand($sqlcompetencia);
$rowcompetencia = $command->queryAll();
$valcompetencia = count($rowcompetencia);

$htmlP3.='<br><br><br><br><br>';
$htmlP3.='<h6>SECCIÓN "C": COMPETENCIAS A EVALUAR</h6>';

$htmlP3.='<br><div id="table"><table width="90%" cellspacing=0 cellpadding=0 border="1" style="text-align:center; margin: 0 auto; border-collapse: collapse;">';
$htmlP3.=' <tr>
              <td width="70%"><strong><font style="font-size:11px; font-weight:normal; font-weight:bold;">COMPETENCIAS</strong></td>
              

           <td width="7%"><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">PESO</strong></td> 

           
           <td width="6%"><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">RANGOS</strong></td>
           <td width="7%"><strong><font style=" text-align:center; font-size:11px; font-weight:bold;">PESO <br> X <br> RANGO</strong></td> 
          
<tr>';
$totalpcom=0;
$totalprcom=0;


    while ($competencia < $valcompetencia) {
    $htmlP3.='  <tr class = "prueba" >
                <td style="height:4%; text-align:justify; font-size:12px;"><font style="font-size:11px; font-weight:bold;"> '.($competencia + 1)  .'.- '.$rowcompetencia[$competencia]['pregunta_padre'].'. </font>   ' . $rowcompetencia[$competencia]["pregunta"] . ' </td>
                <td style="height:4%; text-align:center; font-size:12px;">' . $rowcompetencia[$competencia]["peso"] . '</td>  
                <td style="height:4%;  text-align:center; font-size:12px;">' . $rowcompetencia[$competencia]["rango"].'</td>
                <td style="height:4%;  text-align:center; font-size:12px;">' . $rowcompetencia[$competencia]["subtotal_peso"] .'</td>
                </tr>
   
                   ';
  
    if ($competencia == $valcompetencia - 1) {
//        $html.='<td style="text-align:center"> <oberline>Firma del Evaluador Firma del Supervisor</oberline></td>';
    } else {
       $htmlP3.=''; 
    }
$totalpcom=$totalpcom+$rowcompetencia[$competencia]["peso"];
$totalprcom=$totalprcom+$rowcompetencia[$competencia]["subtotal_peso"];

    $competencia++;
   
}


$htmlP3.='</tr>
    
     <tr>
     
         <td style="height: 2%; border-left: hidden; border-bottom: hidden; text-align:center; font-size:12px; "></td>
         <td style="text-align:center; font-size:12px; ">'.$totalpcom.'</td>
         <td style="text-align:center; font-size:12px; ">TOTAL</td>
         <td style="text-align:center; font-size:12px; ">'.$totalprcom.'</td>
            
     </tr> 
    </table>
    </div>';





$sqlcompetencia2 = ' SELECT  * FROM evaluacion.vsw_pdf_evaluacion WHERE id_evaluacion = '. $vswpdfinal->id_evaluacion;
$connection2 = Yii::app()->db;
$command2 = $connection2->createCommand($sqlcompetencia2);
$rowcompetencia2 = $command2->queryAll();
$valcompetencia2 = count($rowcompetencia2);


$htmlP4.='<br><br><br><h6>SECCIÓN "D": CALIFICACIÓN</h6>';


//  style="text-align:center; margin: 0 auto; border-collapse: collapse;">';


//$htmlP2.='<div id="table"><table width="75%" cellspacing=0 cellpadding=0 border="1" style="text-align:center; margin: 0 auto; border-collapse: collapse;">';
$htmlP4.='<div id="table"><table width="80%" table style= "border: 1px solid; margin:0 auto;">';
$htmlP4.='<tr>
            <td colspan="3"><font style="font-size:12px;">CALIFICACIÓN FINAL</td>  
          </tr>
          
        <tr>
        <td><br><font style="text-align:center; font-size: 14px;"> Total Sección "B": </font><font style="font-size: 14px; font-weight:bold;">'.$vswpdfinal ->total_b.' </font></td>
        <td><br><font style="text-align:center; font-size: 14px;">  Total Sección "C":</font><font style="font-size: 14px; font-weight:bold;"> '.$vswpdfinal ->total_c.'</font> </td>
        <td><br><font style="text-align:center; font-size: 14px; ">  Puntaje Final (B+C): </font> <font style="font-size: 14px; font-weight:bold;"> '.$vswpdfinal ->total_final.' </font></td>
        <tr>
        <td colspan="3"><br><font style="text-align:center; font-size: 13px;">RANGO DE ACTUACIÓN:</font><font style="font-size: 14px; font-weight:bold;">'.$vswpdfinal ->rango_actuacion.'</font></td>
        </tr>
        </tr>
</table>
</div>'; 


$htmlP4.='<br><br><font style="font-weight:bold; font-size:11px;">SECCIÓN "E"</font><br><font style="text-align:center; font-size: 11px;">En esta Sección, exprese comentarios con respecto a los resultados de la evaluación del funcionario(a), así como las acciones a seguir para mejorar el desempeño.</font>';

$htmlP4.='<div id="table"><br><table width="80%" table style= "border: 1px solid; margin:0 auto;">';
$htmlP4.='<tr>
            <td colspan="3"><font style="font-size:12px;">COMENTARIOS DEL EVALUADOR(A): '.$vswpdfinal ->comentario.'</td>  
            <br><br><br><br><br>
          </tr>
</table>
</div>'; 


$htmlP4.='<div id="table"><br><table width="80%" table style= "border: 1px solid; margin:0 auto;">';
$htmlP4.='<tr>
          <td><font style="text-align:center; font-size: 12px;"> FECHA EVALUACIÓN: '.$vswpdfinal ->fecha_evaluacion.' </font></td>
          <td colspan="2"><font style="text-align:center; font-size: 12px;">FIRMAS:</font></td>
          <tr>
          <td></td>
          <td><font style="text-align:center; font-size: 12px;">Supervisor(a) Inmediato(a):</font></td>
          <td><font style="text-align:center; font-size: 12px;">Jefe(a) Recursos Humanos:</font></td>
          </tr>
           <tr>
          <td><font style="text-align:center; font-size: 12px;">Esta Satifecho(a): '.$vswpdfinal ->esta_conforme.' </font></td>
          <td></td>
          <td></td>
          </tr>
          <tr>
          <td colspan="3"><font style="text-align:center; font-size: 12px;">FIRMA DEL EVALUADO(A):</font></td>
          </tr>
          <tr>
          <td colspan="3"><font style="text-align:center; font-size: 12px;">FECHA:'.date('d-m-Y').'</font></td>
          </tr>
      

        </tr>
</table>
</div>';






//echo '<pre>';var_dump('objetivo');die;

//$html.='<div style="text-align:right; margin-top:208px; font-size:10px"><b>' . $NameQr . '</b></div>';
$mpdf = new mPDF('utf-8', 'LEGAL-L');
//$mpdf = new mPDF('win-1252', 'LETTER', '', '', 15, 15, 25, 1, 1, 1);

$mpdf->WriteHTML($html);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1); 

$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO'); 
$mpdf->SetFooter('Sistema SIMCLA |Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"|Página {PAGENO}/{nbpg}');
$mpdf->AddPage();
$mpdf->WriteHTML($htmlP2);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);
$mpdf->AddPage();
$mpdf->WriteHTML($htmlP3);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);  
$mpdf->AddPage();
$mpdf->WriteHTML($htmlP4);
$mpdf->Image(dirname(dirname(dirname(__DIR__))) . '/img/banner.png', 15, 1);  
$mpdf->Output('Certificado.pdf', 'D');
exit;
?>


