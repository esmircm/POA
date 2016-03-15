<?php
       
        $sql1 = "SELECT * FROM evaluacion.preguntas_individuales WHERE fk_evaluacion=$id_evaluacion ORDER BY id_preguntas_ind ASC";
        $connection1 = Yii::app()->db;
        $command1 = $connection1->createCommand($sql1);
        $row1 = $command1->queryAll();
        $filas = count($row1);
        ?>
        <table id="table_objetivos" style="width:100%; border: 1px solid #b5b5b5; border-radius: 50%; ">
            <tr style="color: #1154dc; font-weight: 700; border: 1px solid #b5b5b5;">
                <td widht="89%" style="border-left: 1px solid #b5b5b5; ">Objetivo de Desempeño Individual</td>
                <td widht="2%" style="border-left: 1px solid #b5b5b5; ">Peso</td>
                <td widht="2%" style="border-left: 1px solid #b5b5b5; ">Rango</td>
                <td widht="5%" style="border-left: 1px solid #b5b5b5; ">Peso x Rango</td>
            </tr>
            <?php
            $i = 0;
            echo '<input type="hidden" id="ciclo" value="' . $filas . '">' . '<input type="hidden" id="id_evaluacion" value="' . $id_evaluacion . '">';
            while ($i < $filas) {
                ?>
                <tr id="tr_objetivos">

                    <td style="border-left: 1px solid #b5b5b5; "><input id="id_<?php echo $i; ?>" type="hidden" readonly value="<?php echo $row1[$i]['id_preguntas_ind']; ?>"><strong><?php echo $i + 1; ?></strong><input id="objetivo_<?php echo $i; ?>" type="text" readonly value="<?php echo $row1[$i]['objetivo']; ?>" style="background-color: transparent; border: none; margin-left: 2%; width: 90%;"></td>
                    <td style="border-left: 1px solid #b5b5b5; text-align: center;"><input class="peso_calc" id="peso_<?php echo $i; ?>" type="text" readonly value="<?php echo $row1[$i]['peso']; ?>" style="background-color: transparent; border: none; text-align: center;"></td>
                    <td style="border-left: 1px solid #b5b5b5; text-align: center;"><select class="rango_calc" id="rango_<?php echo $i; ?>" style="text-align: center;">
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
                        <td style="border-left: 1px solid #b5b5b5; text-align: center;"><input class="subPeso_calc" id="subPeso_<?php echo $i; ?>" type="text" style="background-color: transparent; border: none; width: 50%; text-align: center;" readonly></td>
                </tr>            
                <?php
                $i++;
            }
            ?>
            <tr style="font-weight: 700; border: 1px solid #b5b5b5;">
           
                <td colspan="3" style="font-weight: 700; text-align: right;">Total de Peso x Rango</td>
                <td style="font-weight: 700; text-align: center;"><input class="total_calc" id="totalsubPeso" type="text" style="background-color: transparent; border: none; width: 50%; text-align: center;" readonly></td>
            </tr>
        </table>
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


