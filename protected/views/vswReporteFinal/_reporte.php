<style>
    .todos .bootstrap-switch.bootstrap-switch-large {
        min-width: 200px;
    }
</style>

<div class="row">
    <div class="col-md-4 todos">
        
        
        <?php
        
//        $prue = VswEvaluacion::model()->findAllBySql("SELECT dependencia FROM evaluacion.vsw_evaluacion GROUP BY dependencia ORDER BY dependencia");
//        echo '<pre>';var_dump($prue);die;
       // echo CHtml::activeLabel($model, 'todo'); ?><br>

        <?php
        $this->widget(
                'booster.widgets.TbSwitch', array(
            'name' => 'todo',
            'options' => array(
                'size' => 'large',
                'onText' => 'MANUAL',
                'offText' => 'TODOS',
            ),
            'htmlOptions' => array(
                'class' => 'sac_todo',
                'onChange' => 'Todo()'
            )
                )
        );
        ?>        

    </div>
</div>

<div class="row">
<!--   <div class="col-md-3 busqueda" style="display: none">-->
        <?php
            //$CambioEstatus = EstatusEvaluacion::model()->findAllBySql('SELECT * FROM evaluacion.estatus_evaluacion WHERE fk_evaluacion = ' . $id . ' ORDER BY id_estatus_evaluacion DESC LIMIT 2');
        
      
       // $criteria = new CDbCriteria;
       // $criteria->order = 'dependencia';
//        echo $form->dropDownList($model, 'dependencia', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
//            'widgetOptions' => array(
//               // 'data' => Maestro::FindMaestrosByPadreSelect(71, 'descripcion DESC'),
//                
//                'data' => VswEvaluacion::model()->findAll("SELECT dependencia FROM evaluacion.vsw_evaluacion GROUP BY dependencia ORDER BY dependencia"),
//                'htmlOptions' => array(
//                    'empty' => 'SELECCIONE',
//                ),
//            )
//                )
//        );
        ?>
<!--    </div>-->

    <div class="col-md-3 busqueda" style="display: none"> 
        <?php
    echo CHtml::activeLabel($model, 'fk_nacionalidad');
            ?><br>
            <?php
            $this->widget(
                    'booster.widgets.TbSwitch', array(
                'name' => 'fk_nacionalidad',
                'options' => array(
                    'size' => 'large',
                    'onText' => 'SI',
                    'offText' => 'NO',
                ),
                'htmlOptions' => array(
                    'class' => 'swpersonal',
                )
                    )
            );
        ?>
    </div>
    
    <div class="col-md-3 busqueda" style="display: none">
            <?php echo CHtml::activeLabel($model, 'cedula'); ?><br>
            <?php
            $this->widget(
                    'booster.widgets.TbSwitch', array(
                'name' => 'cedula',
                'options' => array(
                    'size' => 'large',
                    'onText' => 'SI',
                    'offText' => 'NO',
                ),
                'htmlOptions' => array(
                    'class' => 'swpersonal',
                )
                    )
            );
            ?>  
        </div>
        <div class="col-md-3 busqueda" style="display: none">
            <?php echo CHtml::activeLabel($model, 'nombres'); ?><br>
            <?php
            $this->widget(
                    'booster.widgets.TbSwitch', array(
                'name' => 'nombres',
                'options' => array(
                    'size' => 'large',
                    'onText' => 'SI',
                    'offText' => 'NO',
                ),
                'htmlOptions' => array(
                    'class' => 'swpersonal',
                )
                    )
            );
            ?>  
        </div>       
        <div class="col-md-3 busqueda" style="display: none">
            <?php echo CHtml::activeLabel($model, 'apellidos'); ?><br>
            <?php
            $this->widget(
                    'booster.widgets.TbSwitch', array(
                'name' => 'apellidos',
                'options' => array(
                    'size' => 'large',
                    'onText' => 'SI',
                    'offText' => 'NO',
                ),
                'htmlOptions' => array(
                    'class' => 'swpersonal',
                )
                    )
            );
            ?>  
        </div>  

</div>
