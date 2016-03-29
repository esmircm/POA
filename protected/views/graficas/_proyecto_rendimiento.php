    <tr style="border-bottom: 1px solid rgba(152, 152, 152, 1);">
        <td style="text-align: left"><?php echo $i . ".-" . $acciones['nombre_accion'] ; ?></td>
        <td style="text-align: center"><?php echo $acciones['unidad_medida'] ; ?></td>
        <td style="text-align: center"><?php echo $acciones['cantidad'] ; ?></td>
        <td style="text-align: center"><?php echo Acciones::model()->suma_rendimiento($acciones['id_accion']) ; ?></td>
        <td style="text-align: center"><?php echo ((Acciones::model()->suma_rendimiento($acciones['id_accion']) * 100)/$acciones['cantidad']) . "%" ; ?></td>
    </tr>


