<div class="row">
    <div class="col-md-2">
    <?php
    if(Yii::app()->user->checkAccess('administrador_poa')){
        $criteria = new CDbCriteria;
        $criteria->addCondition('padre = 49 and id_maestro in(54,55)');
    }
    
    if(Yii::app()->user->checkAccess('evaluador_poa')){
        $criteria = new CDbCriteria;
        $criteria->addCondition('padre = 49 and id_maestro in(52,55)');
    }
    
    echo $form->dropDownListGroup($estatus_proyecto, 'fk_estatus_proyecto', array('wrapperHtmlOptions' => array('class' => 'span5 limpiar'),
        'widgetOptions' => array(
            'data' => CHtml::listData(MaestroPoa::model()->findAll($criteria), 'id_maestro', 'descripcion'),
            'htmlOptions' => array(
                'empty' => 'SELECCIONE', 'onchange' => "Limpiar()" ), ))); 

    ?>
    </div>

    <div class="col-md-10">
    <?php

    echo $form->textAreaGroup($comentarios, 'comentarios', array('wrapperHtmlOptions' => array('class' => 'col-sm-12 limpiar'),
            'widgetOptions' => array(
                'htmlOptions' => array('rows' => 1,
                    'title' => 'Por favor, indicar el aspecto a corregir en caso de que esté Rechazado.',
                    'data-toggle' => 'tooltip', 'data-placement' => 'bottom',
                ),
            )
        ));

    ?>
    </div>
</div>
