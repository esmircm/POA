<div class="row">
    <div class='col-md-12'>
        <?php
        $this->widget(
                'booster.widgets.TbExtendedGridView', array(
            'type' => 'striped bordered',
            'responsiveTable' => true,
            'id' => 'listado_familiar',
            'dataProvider' => new CActiveDataProvider('Familiar', array(
                'criteria' => array(
                         'condition' => 'id_personal=144',  
                )
                    )),
//            'template' => "{items}",
            'columns' => array(
                array(
                    'name' => 'fk_accion_centralizada',
                    'header' => 'Acción Centralizada',
                   
                ),
                array(
                    'name' => 'descripcion',
                    'header' => 'Descripción',
                    
                ),
                array(
                    'name' => 'fk_unidad_medida',
                    'header' => 'Unidad Medida',
                ),
                array(
                    'name' => 'cantidad',
                    'header' => 'Cantidad',
                ),
                
                array(
                    'class' => 'booster.widgets.TbButtonColumn',
                    'header' => 'Acción',
                    'htmlOptions' => array('width' => '85',  'style' => 'text-align: center;'),
                    'template' => '{update}',
                    'buttons' => array(
                        'update' => array(
                   'url' => '$this->grid->controller->createUrl("datosRequisicion/update", array("id"=>$data->id_familiar))',
                        ),
                    ),
                ),
            )
                )
        );
        ?>
    </div>
</div>