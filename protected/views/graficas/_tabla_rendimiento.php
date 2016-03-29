<table style="width: 100%; border-collapse: collapse; text-align: center;">
    <tr style="border-bottom: 1px solid rgba(152, 152, 152, 1); background-color: rgba(133, 133, 133, 1); color: #FFF;">
        <td style="text-align: left"><?php echo "Acción " . $i . ": " . $acciones->nombre_accion ?></td>
        <td style="text-align: center">N°</td>
        <td style="text-align: center">Unidad de Medida</td>
        <td style="text-align: center">Total Anual</td>
        <td style="text-align: center">Ejecutado hasta la Fecha</td>
        <td style="text-align: center">% de Ejecución</td>
    </tr>
    <?php
        $actividades = VswActividades::model()->findAllByAttributes(array('fk_accion' => $acciones->id_accion));
        $o = 1;
        foreach ($actividades as $data) {
            ?>
    <tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
        <td style="text-align: left"><?php echo "Actividad " . $o . ": " . $data['actividad'] ; ?></td>
        <td style="text-align: center"><?php echo $o; ?></td>
        <td style="text-align: center"><?php echo $data['unidad_medida'] ; ?></td>
        <td style="text-align: center"><?php echo $data['cantidad'] ; ?></td>
        <td style="text-align: center"><?php echo Actividades::model()->suma_rendimiento($data['id_actividades']) ; ?></td>
        <td style="text-align: center"><?php echo ((Actividades::model()->suma_rendimiento($data['id_actividades']) * 100)/$data['cantidad']) . "%" ; ?></td>
    </tr>
            <?php
            $o++;
        }
    ?>
</table>

