<div hidden>
    <?php echo $form->textFieldGroup($periodo, 'id_maestro', array('type'=>"hidden"));?>
</div>
<div class="row"> 
    <div class='col-md-4'>
 
      <?php
        if(date("n")<=06){
            $condicion='81';
        }
        else {
            $condicion='82';
        }
        

        
//        echo $form->textFieldGroup($periodo, 'id_maestro', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true))));
        
        
        
        echo $form->textFieldGroup($periodo, 'descripcion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span2', 'readOnly' => true))));

//        echo $form->dropDownListGroup($evaluados, 'fk_periodo', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
//            'widgetOptions' => array(
//                'data' => CHtml::listData(MaestroEvaluacion::model()->find('padre=:padre', array(':padre' => '80')), 'id_maestro', 'descripcion'),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE','onchange' => "Limpiar()"
//                ),
//            )
//                )
//        );
        ?>
    
    </div>

<!--    <div class='col-md-4'>
        <?php // echo $form->textFieldGroup($evaluados, 'n_veces', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 limpiar', 'maxlength' => 100)))); ?>
    </div>-->

</div>



