<div class="row">
    <div class='col-md-12'>
           <table id='ActividadesPOA' class="table table-bordered" style="text-align:center;">
               <tr style="font-weight: 700">  
                <td style="text-align: center;"> Actividad  </td>
                <td style="text-align: center;"> Unidad de Medida </td>
                <td style="text-align: center;"> Cantidad </td>
                <td colspan="12" style="text-align: center;"> Programación </td>
                <td style="text-align: center;"> </td>
            </tr>
            <?php
            $criteria=new CDbCriteria;
            $criteria->order='fk_meses';
//            if(isset($lista_actividad)){
                foreach ($lista_actividad as $data){
                    $html = '<tr>';
                    $html .= '<td style="text-align: center">' . $data->actividad . '</td>';
                    $html .= '<td style="text-align: center">' . $data->unidad_medida . '</td>';
                    $html .= '<td style="text-align: center">' . $data->cantidad . '</td>';
                    $lista_rendimiento = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $data->id_actividades, 'fk_tipo_entidad' => 74), $criteria);
                    foreach ($lista_rendimiento as $data_rendimiento) {
                        $html .= '<td style="text-align: center">' . $data_rendimiento->cantidad_programada . '</td>';
                    }
                    $html .= '<td style="text-align: center">'

                            . '<span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-pencil" data-toggle="tooltip" title="" rows="1" data-original-title="Editar Actividad" onclick="editar_actividad(this,' . $data->id_actividades . ')" /></span>'
                            . '<span style="font-size: 40px; color: #2282cd; cursor: pointer;" class="glyphicon glyphicon-trash" data-toggle="tooltip" title="" rows="1" data-original-title="Eliminar Actividad" onclick="eliminar_actividad(this,' . $data->id_actividades . ')" /></span></td>';

                    $html .= '</tr>';
                    echo $html;
                }
//            }
            ?>
        </table>
        </table>
    </div>
</div>


