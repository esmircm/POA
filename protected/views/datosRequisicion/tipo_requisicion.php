

<?php //echo $form->errorSummary($model); ?>
    
<script type="text/javascript">

    function Solicitud() {

        if ($('.solicitud').is(":checked")) {
            $('.soli').show('fade');
            $('.anula').hide('fade');
        } else {
            $('.soli').hide('fade');
            $('.anula').show('fade');
        }
    }

    function Especial() {

        if ($('.especial').is(":checked")) {
            $('.espe').show('fade');
            $('.ordi').hide('fade');
        } else {
            $('.espe').hide('fade');
            $('.ordi').show('fade');
        }
    }


</script>

<!--<script>
    function Anulacion() {
        if ($('.anulacion').is(":checked")) {
            $('.anula').show('fade');
            $('.anula').hide('fade');
        } else {
            $('.anula').hide('fade');
            $('.anula').show('fade');
        }
    }
</script>-->



<div class="row">
    <div class="col-md-3" >
        <b>Tipo de Requisición <br></b> 
        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'solicitud',
            'options' => array(
                'size' => 'large',
                'onText' => 'SOLICITUD',
                'offText' => 'ANULACIÓN',
                'offColor' => 'danger',
            ),
            'htmlOptions' => array(
                'buttonType' => 'reset',
                'onclick' => 'telfCheck(this.id,codigo);',
                'class' => 'solicitud lim',
                'onChange' => 'Solicitud()',
                'onclick' => 'document.location.href ="' . $this->createUrl('/datosRequisicion/create') . '"',
            )
                )
        );
        ?>  
    </div>
    <div class='soli'  style="display: none">
        <div class="col-md-3" >
            <b><br></b> 
            <?php
            $this->widget(
                    'booster.widgets.TbSwitch', array(
                'name' => 'especial',
                'options' => array(
                    'size' => 'large',
                    'onText' => 'ESPECIAL',
                    'offText' => 'ORDINARIO',
                    'offColor' => 'danger',
                ),
                'htmlOptions' => array(
                    'onclick' => 'telfCheck(this.id,codigo);',
                    'class' => 'especial',
                    'onChange' => 'Especial()',
//                'onclick' => 'document.location.href ="' . $this->createUrl('/datosRequisicion/create') . '"',
                )
                    )
            );
            ?>  

        </div>
    </div>
    <div class='anula'>
        <div class="col-md-2" >
            <?php echo $form->textFieldGroup($numero, 'numero'); ?>
        </div>
    </div>



</div> 












<?php // echo $form->checkBoxGroup($model,'es_anulacion');   ?>

<?php //  echo $form->checkBoxGroup($model,'es_activo');   ?>

<?php // echo $form->textFieldGroup($model,'fk_estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));   ?>

<?php // echo $form->textFieldGroup($model,'created_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));   ?>

<?php // echo $form->textFieldGroup($model,'created_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));   ?>

<?php // echo $form->textFieldGroup($model,'modified_by',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));    ?>

<?php // echo $form->textFieldGroup($model,'modified_date',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));   ?> 


