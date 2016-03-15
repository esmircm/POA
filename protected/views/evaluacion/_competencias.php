<?php
    
    $filas=count($pre_status);

    ?>
<form id="competencias">
<input type="hidden" id="filas_competencia" name="preguntas_filas" value="<?php echo $filas; ?>">
<table id="table_competencias" style="width:100%; border: 1px solid #b5b5b5; border-radius: 50%; ">
            <tr style="color: #1154dc; font-weight: 700; border: 1px solid #b5b5b5;">
                <td width="60%" style="border-left: 1px solid #b5b5b5; ">Competencias</td>
                <td width="5%" style="border-left: 1px solid #b5b5b5; ">Peso</td>
                <td width="10%" style="border-left: 1px solid #b5b5b5; ">Rango</td>
                <td width="5%" style="border-left: 1px solid #b5b5b5; ">Peso x Rango</td>
            </tr>
<?php
    echo '<input type="hidden" id="ciclo" value="' . $filas . '">'.'<input type="hidden" id="id_evaluacion" name="id_evaluacion" value="' . $id_evaluacion . '">'.'<input type="hidden" name="fk_tipo_clase" value="' . $fk_tipo_clase . '">';
    $i=0;
    while ($i < $filas) {
        ?>
    <tr id="tr_objetivos">
        <td><input name="id_<?php echo $i; ?>" type="hidden" value="<?php echo $pre_status[$i]['id_pregunta']; ?>"><?php echo "<strong>" . ($i + 1) . ".- " . $pre_status[$i]['pregunta_padre'] . ": </strong>" . $pre_status[$i]['pregunta']; ?></td>
        <td style="border-left: 1px solid #b5b5b5; text-align: center;"><input type="text" name="peso_compe_<?php echo $i; ?>" id="peso_calc<?php echo $i; ?>" class="peso_calc_compe numeric" value="<?php if(($i==0)||($i==1)) { echo "7"; } elseif($i==2) { echo "6"; } else { echo "0"; } ?>" style="width: 100%; text-align: center;" <?php if(($i==0)||($i==1)||($i==2)) { echo "readonly"; } else { } ?> maxlength="2" <?php if($i>=3){ echo "onclick='Limpiar_Compe(this)'"; } ?>></td>
        <td style="border-left: 1px solid #b5b5b5; text-align: center;">
            <select class="rango_calc_compe" name="rango_<?php echo $i; ?>" id="rango_calc_compe<?php echo $i; ?>" style="text-align: center;">
                <option disabled selected>Seleccionar</option>
                <?php
                    $sql2 = "SELECT * FROM evaluacion.maestro WHERE padre=83";
                    $connection2 = Yii::app()->db;
                    $command2 = $connection2->createCommand($sql2);
                    $row2 = $command2->queryAll();
                    $filas2 = count($row2);
                    $o = 0;
                        while ($o < $filas2) {
                            echo "<option value='" . $row2[$o]['id_maestro'] . "'>" . $row2[$o]['descripcion'] . "</option>";
                            $o++;
                        }
                            
                ?>
                        </select></td>
                        <td style="border-left: 1px solid #b5b5b5; text-align: center;"><input class="subPeso_calc_compe" name="subPeso_<?php echo $i; ?>" type="text" style="background-color: transparent; border: none; width: 100%; text-align: center;" readonly></td>
                </tr>            
    <?php
    $i++;
    }
?>
    <tr style="font-weight: 700; border: 1px solid #b5b5b5;">
        <td style="font-weight: 700; text-align: right;">Total de Peso</td>
        <td style="font-weight: 700; text-align: center;"><input class="total_peso_calc" name="total_peso_calc" type="text" style="background-color: transparent; border: none; width: 100%; text-align: center;" readonly></td>
        <td style="font-weight: 700; text-align: right;">Total de Peso x Rango</td>
        <td style="font-weight: 700; text-align: center;"><input class="total_calc_compe" name="total_calc_compe" type="text" style="background-color: transparent; border: none; width: 100%; text-align: center;" readonly></td>
    </tr>
</table>
</form>
<div id="caja_informacion" style="position: relative; display: block; margin: 0 auto; margin-top: 20px; margin-bottom: 20px; top: 0%; width: 30%; height: 10%; text-align: center; border-radius: 5px; box-shadow: 5px 5px 15px 5px rgba(0,0,0,0.75);">
            <?php
            $sql2 = "SELECT * FROM evaluacion.maestro WHERE padre=83";
            $connection2 = Yii::app()->db;
            $command2 = $connection2->createCommand($sql2);
            $row2 = $command2->queryAll();
            $filas2 = count($row2);
            $o = 0;
            ?>
            <center>
        <table>
            <tr><td><strong>Rango</strong></td><td><strong>Descripción</strong></td>
            <?php
            while ($o < $filas2) {
                echo "<tr><td style='text-align:center;'><strong>" . $row2[$o]['descripcion'] . "</strong></td><td>" . $row2[$o]['descripcion2'] . "</td></tr>";
                $o++;
            }
            ?>
        </table>
            </center>
</div>



