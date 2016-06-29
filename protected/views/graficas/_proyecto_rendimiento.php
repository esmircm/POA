<table style="width: 90%; border-collapse: collapse; text-align: center; margin: 0 auto; margin-bottom: 50px;">
    <tr style="border-bottom: 1px solid rgba(152, 152, 152, 1); background-color: rgba(133, 133, 133, 1); color: #FFF;">
        <td style="text-align: center">Acción Específica</td>
        <td style="text-align: center">Unidad de Medida</td>
        <td style="text-align: center">Total Anual</td>
        <td style="text-align: center">Ejecutado <?php if(isset($_POST['MaestroPoa'])){ $descripcion = MaestroPoa::model()->findByAttributes(array('id_maestro' => $_POST['MaestroPoa2_id_maestro'])); echo "para " . $descripcion->descripcion; } else { ?>hasta la Fecha<?php } ?></td>
        <td style="text-align: center">% de Ejecución</td>
    </tr>
<?php
echo $html;
?>
</table>
