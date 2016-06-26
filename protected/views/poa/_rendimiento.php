
<?php
$meses = MaestroPoa::model()->findAllByAttributes(array('padre' => 56));
$i=0;
?>
<?php
//echo '<pre>';var_dump($rendimiento_entidad);die;
foreach ($rendimiento_entidad as $data) {
    ?>
    <div class="col-md-1" style="text-align: center;">
        <div class="row" style="border-bottom: solid 1px; margin-bottom: 10px;">
        <?php
        echo $meses[$i]['descripcion'];
        ?>
        </div>
        <div class="row">
        <?php
        if($meses[$i]['descripcion2'] <= date('n')){  
            echo '<div style="width: 45%; margin: 0 auto; display:inline-block;">' . $form->textFieldGroup($data, 'cantidad_programada', array('widgetOptions' => array('htmlOptions' => array('class' => 'numeric', 'style' => 'width: 100%; border: none; text-align:center;  background-color: rgba(194,194,194,1);', 'readonly' => TRUE)), 'label' => FALSE)) . '</div>';
            if($data->cantidad_cumplida == '0') {
                $validacion = 1;
            } else {
                $validacion = $data->cantidad_cumplida;
            }
            if(empty($validacion) || $validacion == ''){
                echo '<div style="width: 50%; display:inline-block;">' . $form->textFieldGroup($rendimiento, 'cantidad_cumplida', array('widgetOptions' => array('htmlOptions' => array('class' => 'numeric', 'placeholder' => FALSE, 'style' => 'width: 100%; color: #FFF; border: solid 1px #FFF; background-color: transparent;', 'required' => TRUE, 'name' => 'Cumplido[' . $data->id_rendimiento . ']')), 'label' => FALSE)) . '</div>';                
            } else {
                echo '<div style="width: 50%; display:inline-block;">' . $form->textFieldGroup($data, 'cantidad_cumplida', array('widgetOptions' => array('htmlOptions' => array('style' => 'width: 100%; text-align: center;', 'name' => 'Cumplido[' . $data->id_rendimiento . ']', 'readonly' => TRUE)), 'label' => FALSE)) . '</div>';                
            }
        } else {
            echo '<div style="width: 90%;  margin: 0 auto; display:block;">' . $form->textFieldGroup($data, 'cantidad_programada', array('widgetOptions' => array('htmlOptions' => array('class' => 'numeric', 'style' => 'width: 100%;  background-color: rgba(194,194,194,1);; border: none; text-align:center; ', 'readonly' => TRUE)), 'label' => FALSE)) . '</div>';
        }
        ?>
        </div> 
    </div>
    <?php
    $i++;
}
?>
