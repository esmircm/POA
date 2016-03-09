<?php
    $sql1="SELECT pregunta_padre, orden FROM evaluacion.preguntas WHERE fk_tipo_clase=$fk_tipo_clase GROUP BY pregunta_padre, orden ORDER BY orden";
    $pregunta_padre=Preguntas::model()->findAllBySql($sql1);
//    var_dump($pregunta_padre);die;
    $filas=count($pregunta_padre);
    ?>
<input type="hidden" name="id_evaluacion" value="<?php echo $evaluacion_vista; ?>">
<input type="hidden" id="filas" name="preguntas_obrero_filas" value="<?php echo $filas; ?>">
<div style="width: 90%; margin: 0 auto; margin-top: 20px;">
<span style="font-weight: 700; margin-top: 40px;">Debe seleccionar una opción para cada una de las Competencias</span>
</div>
<?php
    $o=0;
    while ($o < $filas) {
        $pre_obre=Preguntas::model()->findAllByAttributes(array('pregunta_padre' => $pregunta_padre[$o]['pregunta_padre']));
        $filasA=count($pre_obre);
?>

<table id="table_obreros" style="width: 90%; margin: auto; border: 1px solid #b5b5b5; border-radius: 10px; cursor: pointer; margin-top: 20px;">
    <tr>
        <td colspan="2" style="text-align: center; font-weight: 700; color: #1154dc;"><?php echo $pregunta_padre[$o]['orden'] . ". " . $pregunta_padre[$o]['pregunta_padre']; ?></td>
    </tr>
<?php
    $i=0;
    while($i < $filasA) {
        ?>
    <tr id="tr_objetivos" style="border-bottom: 1px solid #b5b5b5;">
        <td style="font-weight: 700;"><?php echo $pregunta_padre[$o]['orden'] . "." . ($i +1); ?></td>
        <td><?php echo $pre_obre[$i]['pregunta']; ?></td>
        <td style="width: 40px;"><input type="radio" name="id_pre_obre_<?php echo $o; ?>" value="<?php echo $pre_obre[$i]['id_pregunta']; ?>" style="visibility:hidden;" required><input type="radio" name="pre_obre_<?php echo $o; ?>" id="pre_obre_<?php echo $o; ?>" class="radio_peso" value="<?php echo $pre_obre[$i]['peso_fijo']; ?>" required></td>
    </tr>
        <?php
        $i++;
    }
    $o++;
    }
?>
    
</table>
<div style="margin-top:50px;">
    <table style="margin:0 auto;">
    <tr>
        <td><strong>Puntuación total</strong></td>
        <td><strong><input type="text" id="total_puntuacion" value="" name="total_puntuacion" style="background-color: transparent; border: none; width: 100%; text-align: center;" readonly></strong></td>
    </tr>
    </table>
</div>
    


