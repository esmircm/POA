
<div class="row"> 
    <div class='col-md-4'>
        <?php echo $form->textFieldGroup($consultaPersona, 'periodo_evaluacion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'maxlength' => 100, 'readOnly' => true)))); ?>
        <?php
//        echo $form->dateRangeGroup(
//                $consultaPersona, 'periodo_desde', array(
//            'widgetOptions' => array(
//                'options' => array(
//                    'format' => 'DD/MM/YYYY',
//                ),
//                'callback' => 'js:function(start, end){console.log(start.toString("dd/mm/yyyy") + " - " + end.toString("dd/mm/yyyy"));}'
//            ),
//            'wrapperHtmlOptions' => array(
//                'class' => 'col-sm-5',
//                'readonly' => true
//            ),
////            'hint' => 'Ingrese un rango de fecha a buscar.',
//            'prepend' => '<i class="glyphicon glyphicon-calendar"></i>',
//                    
//                     'beforeShowDay' => 'DisableDays',
//                )
//        ); ?>
        
        
    </div>

<!--    <div class='col-md-4'>
        <?php // echo $form->textFieldGroup($consultaPersona, 'n_veces', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100)))); ?>
    </div>-->
</div>



