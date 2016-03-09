<?php
// $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
//	'id'=>'familiar-form',
//	'enableAjaxValidation'=>false,
//)); 
?>

<div class="row">

    <div class="col-md-2" >
        <label>Grupo Sanguineo<span class="required">*</span></label>
        <select id="Familiar_grupo_sanguineo" class="form-control" name="Familiar[grupo_sanguineo]" placeholder="grupo_sanguineo" >
            <option value="">SELECCIONE</option> 
            <option value = "O">O+</option>
            <option value = "O-">O-</option>
            <option value = "A-">A-</option>
            <option value = "A">A+</option>
            <option value = "B-">B-</option>
            <option value = "B">B+</option>
            <option value = "AB-">AB-</option>
            <option value = "AB">AB+</option>
        </select>
    </div>

    <div class="col-md-2" >
        <?php echo CHtml::activeLabel($model, 'nino_excepcional'); ?><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'nino_excepcional',
//                   'id'=>'',s
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'nino_excepcional',
//               'onChange' => 'Excepcional()'
            )
                )
        );
        ?>        
    </div>

    <div class="col-md-2" >
        <?php echo CHtml::activeLabel($model, 'alergico'); ?><br>
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'alergico',
            'options' => array(
                'size' => 'large',
                'onText' => 'SI',
                'offText' => 'NO',
            ),
            'htmlOptions' => array(
                'class' => 'alergico',
                'onChange' => 'Alergia()'
            )
                )
        );
        ?>        
    </div>

    <div class='col-md-4 datoSalud'  style="display: none; ">
        <?php
        echo $form->textAreaGroup(
                $model, 'alergias', array(
            'wrapperHtmlOptions' => array(
                'class' => 'col-sm-5',
            ),
            'widgetOptions' => array(
                'htmlOptions' => array('rows' => 5, 'onChange' => 'Alergico()'),
               
            )
                )
        );
        ?>
    </div>
</div>



<?php // $this->endWidget(); ?>
