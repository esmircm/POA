<div class="row">
    <div class='col-md-12'>
           <table id='ActividadesPOA' class="table table-bordered" style="text-align:center;">
            <tr>  
                <td> Actividad  </td>
                <td> Unidad de Medida </td>
                <td> Cantidad </td>
                <td>  </td>
            </tr>
            <?php
//            if(isset($lista_actividad)){
                foreach ($lista_actividad as $data){
                    $html = '<tr>';
                    $html .= '<td style="text-align: center">' . $data->actividad . '</td>';
                    $html .= '<td style="text-align: center">' . $data->unidad_medida . '</td>';
                    $html .= '<td style="text-align: center">' . $data->cantidad . '</td>';
                    $html .= '<td style="text-align: center"><span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-trash" onclick="eliminar_actividad(this,' . $data->id_actividades . ')" /></span></td>';
                    $html .= '</tr>';
                    echo $html;
                }
//            }
            ?>
        </table>
        </table>
    </div>
</div>


