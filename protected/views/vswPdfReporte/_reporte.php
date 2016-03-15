<style>
    .todos .bootstrap-switch.bootstrap-switch-large {
        min-width: 200px;
    }
</style>

<div class="row">
    <div class="col-md-4 todos">
        <?php echo CHtml::activeLabel($model, 'todo'); ?><br>

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
    <div class="col-md-6 busqueda" style="display: none">
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'cod_dependencia_evaluado ASC';
        echo $form->dropDownListGroup($model, 'cod_dependencia_evaluado', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
            'widgetOptions' => array(
                'data' => Maestro::FindMaestrosByPadreSelect(71, 'descripcion DESC'),
                'htmlOptions' => array(
                    'empty' => 'SELECCIONE',
                ),
            )
                )
        );
        ?>
    </div>

    <div class="col-md-6 busqueda" style="display: none"> 
        <?php
        $criteria = new CDbCriteria;
        $criteria->order = 'strdescripcion ASC';
        echo $form->dropDownListGroup($model, 'fk_status_solicitud', array('wrapperHtmlOptions' => array('class' => 'col-sm-4',),
            'widgetOptions' => array(
                'data' => Maestro::FindMaestrosByPadreSelect(10, 'descripcion DESC'),
                'htmlOptions' => array(
                    'onChange' => 'ConsultasAyuda('
                    . '$("#Solicitud_fk_status_solicitud").val()'
                    . ')',
                    'empty' => 'SELECCIONE',
//                    'ajax' => array(
//                        'type' => 'POST',
//                        'url' => CController::createUrl('ValidacionJs/BuscarAyuda'),
//                        'update' => '#' . CHtml::activeId($model, 'fk_tipo_ayuda_tecnica'),
//                    ),
                ),
            )
                )
        );
        ?>
    </div>

</div>
