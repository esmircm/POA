<?php

$pdf = Yii::createComponent('application.extensions.MPDF53.mpdf');
/**
 * 
 */
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
 * ESTILO DE LA TABLA
 */

$n = dirname(dirname(dirname(__DIR__))) . '/img/banner.png';
$html.= '<img src="' . $n . '"/>';
$html.="<div style='text-align:center; font-size:20px; margin-top:50px; border: solid 0px #000;'>";
$html.="<b></b>";
$html.="<br>";
$html.="<br/></div>";
$html.= '<table>        
        <tr>
        <td colspan="2" align="justify">
            Reporte del Simcla.
               </td>           
           </tr>
        </table>';

$html.='<div id="prueba">
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#26ADE4;}
.tg .tg-gyhc{background-color:#fd6864}
.tg .tg-rpj7{background-color:#fd6864}
</style>';

$html.=$html1;
$mpdf = new mPDF('utf-8', 'LEGAL-L');
$mpdf->WriteHTML($html);
$mpdf->Footer('MINISTERIO DEL PODER POPULAR PARA LA MUJER Y LA IGUALDAD DE GÉNERO');
$mpdf->Output('Simcla.pdf', 'D');
exit;
?>