<div class="row">
    <div class='col-md-12'>
           <table id='AccionesPOA' class="table table-bordered" style="text-align:center;">
            <tr class="Acciones_tr">  
                <td rowspan="2"> Acción  </td>
                <td rowspan="2"> Bien o Servicio  </td>
                <td colspan="2"> Meta Total </td>
               
                <td rowspan="2" style="width: 20%;">  </td>
            </tr>
            <tr class="Acciones_tr">  
                
                
                <td> Unidad de Medida </td>
                <td> Cantidad </td>
                
            </tr>
            <?php
            foreach ($lista_accion as $data){
                $html = '<tr>';
                $html .= '<td style="text-align: center">' . $data->nombre_accion . '</td>';
                $html .= '<td style="text-align: center">' . $data->bien_servicio . '</td>';
                $html .= '<td style="text-align: center">' . $data->unidad_medida . '</td>';
                $html .= '<td style="text-align: center">' . $data->cantidad . '</td>';
                $html .= '<td style="text-align: center">'
                        . '<span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-eye-open" data-toggle="tooltip" title="" rows="1" data-original-title="Ver Acción" onclick="ver_accion(this,' . $data->fk_poa . ',' . $data->id_accion . ',' . $tipo . ')" /></span>'
                        . '<span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-pencil" data-toggle="tooltip" title="" rows="1" data-original-title="Editar Acción" onclick="editar_accion(this,' . $data->fk_poa . ',' . $data->id_accion . ',' . $tipo . ')" /></span>'
                        . '<span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-trash" data-toggle="tooltip" title="" rows="1" data-original-title="Editar Acción" onclick="eliminar_accion(this,' . $data->id_accion . ')" /></span>';
                $html .= '</tr>';
                echo $html;
            }
            ?>
        </table>
    </div>
    <!--hiddenFiel-->
    
</div>

