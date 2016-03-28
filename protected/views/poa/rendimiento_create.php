<?php
$this->breadcrumbs = array(
    'Poas' => array('index'),
    $model->id_poa,
);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'personal-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
?>

<div class="span-20 poa_content">

    <?php
    $consulta1 = Poa::model()->findByAttributes(array('id_poa' => $model->id_poa));
    $nombreProyecto = $consulta1['nombre'];
    ?>

    <h2 style="text-align: center; font-size: 20px;"><b>Proyecto:</b> <?php echo $nombreProyecto ?> </h2>
    <br>


    <div class="col-lg-12">

        <div class="panel panel-primary">
            <div class="panel-heading"></div>
            <div class="panel-body">
                <?php
                $consulta1 = Poa::model()->findByAttributes(array('id_poa' => $model->id_poa));
                $nombreProyecto = $consulta1['nombre'];
                $this->widget(
                        'booster.widgets.TbBadge', array(
                    'context' => 'success',
                    'htmlOptions' => array(
                        'style' => 'font-size:17px;',
                    ),
                    // 'default', 'success', 'info', 'warning', 'danger'
                    'label' => ' ' . $nombreProyecto,
                        )
                );
                ?>


                <?php
                $this->widget('booster.widgets.TbExtendedGridView', array(
                    'type' => 'striped bordered',
                    'htmlOptions' => array('style' => 'margin-bottom: 40px;;'),
                    'dataProvider' => $accion->searchAccion($id_poa),
                    'template' => "{items}",
                    'columns' => array_merge(array(
                        array(
                            'name' => 'nombre_accion',
                            'header' => 'Acción',
                            'value' => '$data->nombre_accion',
                        ),
                        'bien_servicio' => array(
                            'name' => 'bien_servicio',
                            'header' => 'Bien o Servicio',
                            'value' => '$data->bien_servicio'
                        ),
//                        'id_accion' => array(
//                            'name' => 'id_accion',
//                            'header' => 'id',
//                            'value' => '$data->id_accion'
//                        ),
                        'fk_unidad_medida' => array(
                            'name' => 'fk_unidad_medida',
                            'header' => 'Unidad de Medida',
                            'value' => '$data->search_unidad_medida($data->id_accion)'
                        ),
                        'cantidad' => array(
                            'name' => 'cantidad',
                            'header' => 'Cantidad',
                            'value' => '$data->cantidad'
                        ),
                        array(
                            'class' => 'booster.widgets.TbButtonColumn',
//                    'htmlOptions' => array('style' => 'width: 11%'),
                            'header' => 'Desplegar Acciones',
                            'template' => '{accion}',
                            'buttons' => array(
                                'accion' => array(
                                    'label' => 'Acciones',
//                            'options' => array('style' => 'margin-left:17px;'),
                                    'icon' => 'chevron-down',
                                    'size' => 'medium',
                                    'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_accion"=>$data->id_accion, "nombre_accion"=>$data->nombre_accion,  "id_poa"=>' . $id_poa . '))',
                                ),
                            ),
                        ),
                    )),
                ));
                ?>
            </div>
        </div>
<?php
if (isset($_GET['id_accion'])) {
    ?>

            <div class="panel panel-primary">
                <div class="panel-heading"></div>
                <div class="panel-body">
    <?php
    $consulta2 = Acciones::model()->findByAttributes(array('id_accion' => $_GET['id_accion']));
    $nombreAccion = $consulta2['nombre_accion'];

    $this->widget(
            'booster.widgets.TbBadge', array(
        'context' => 'success',
        'htmlOptions' => array(
            'style' => 'font-size:17px;',
        ),
        // 'default', 'success', 'info', 'warning', 'danger'
        'label' => ' ' . $nombreAccion,
            )
    );
//                    echo $nombreAccion;
    ?>

                        <!--<h2 style="text-align: center; font-size: 20px;">Rendimiento de la Acción: <b><?php // echo $nombreAccion ?></b> </h2>-->

    <?php
    $this->widget('booster.widgets.TbExtendedGridView', array(
        'type' => 'striped bordered condensed',
        'id' => 'RendimientoGrid',
        'dataProvider' => new CActiveDataProvider('Rendimiento', array(
            'criteria' => array(
                'order' => 'fk_meses ASC',
                'condition' => 'id_entidad=' . $_GET['id_accion'] . ' and fk_tipo_entidad = 73 ',
            ),
            'pagination' => array('pageSize' => Yii::app()->user->getState('pageSize', 12),),
                )),
        'columns' => array(
            array(
                'name' => 'fk_meses',
                'header' => 'Mes',
                'value' => '$data->fkMeses->descripcion',
                'htmlOptions' => array('width' => '95px'),
            ),
            array(
                'name' => 'cantidad_programada',
                'header' => 'Cantidad Programada',
                'htmlOptions' => array('width' => '95px'),
                'visible' => '$data->cantidad_programada'
            ),
            array(
                'class' => 'booster.widgets.TbEditableColumn',
                'name' => 'cantidad_cumplida',
                'header' => 'Cantidad Cumplida',
                'htmlOptions' => array('style' => 'text-align:center', 'title' => 'Indique la cantidad cumplida', 'id' => 'editable'),
                'headerHtmlOptions' => array('style' => 'width: 110px; text-align: center'),
                'editable' => array(
                    'type' => 'text',
                    'emptytext' => 'Indique la cantidad cumplida',
                    'url' => $this->createUrl('Poa/ActualizarCantidadCumplida'),
                    'placement' => 'left',
                )
            ),
        ),
    ));
    ?>
                </div>
            </div>

            <div class="panel panel-primary">
                <div class="panel-heading"></div>
                <div class="panel-body">



    <?php
    $this->widget(
            'booster.widgets.TbBadge', array(
        'context' => 'success',
        'htmlOptions' => array(
            'style' => 'font-size:17px;',
        ),
        // 'default', 'success', 'info', 'warning', 'danger'
        'label' => 'Actividades de la acción: ' . $nombreAccion,
            )
    );

    $this->widget('booster.widgets.TbExtendedGridView', array(
        'type' => 'striped bordered condensed',
        'id' => 'ActividadesGrid',
        'dataProvider' => new CActiveDataProvider('Actividades', array(
            'criteria' => array(
                'order' => 'id_actividades ASC',
                'condition' => 'fk_accion=' . $_GET['id_accion'],
            ),
            'pagination' => array('pageSize' => Yii::app()->user->getState('pageSize', 12),),
                )),
        'columns' => array(
            array(
                'name' => 'actividad',
                'header' => 'Nombre Actividad',
                'htmlOptions' => array('width' => '95px'),
            ),
            array(
                'name' => 'fk_unidad_medida',
                'header' => 'Unidad de Medida',
                'value' => '$data->fkUnidadMedida->descripcion',
                'htmlOptions' => array('width' => '95px'),
            ),
            array(
                'name' => 'cantidad',
                'header' => 'Cantidad',
                'htmlOptions' => array('width' => '95px'),
            ),
            array(
                'class' => 'booster.widgets.TbButtonColumn',
                'header' => 'Desplegar Actividades',
                'template' => '{actividad}',
                'buttons' => array(
                    'actividad' => array(
                        'label' => 'Actividades',
                        'icon' => 'chevron-down',
                        'size' => 'medium',
                        'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_actividades"=>$data->id_actividades, "id_accion"=>' . $_GET['id_accion'] . ',  "id_poa"=>' . $id_poa . '))',
                    ),
                ),
            ),
        ),
    ));
}
?>
            </div>
        </div>

                <?php
                if (isset($_GET['id_actividades'])) {
                    ?>
            <div class="panel panel-primary">
                <div class="panel-heading"></div>
                <div class="panel-body">

            <?php
            $consulta3 = Actividades::model()->findByAttributes(array('id_actividades' => $_GET['id_actividades']));
            $nombreActividad = $consulta3['actividad'];

            $this->widget(
                    'booster.widgets.TbBadge', array(
                'context' => 'success',
                'htmlOptions' => array(
                    'style' => 'font-size:17px;',
                ),
                'label' => '' . $nombreActividad,
                    )
            );
            ?>



                    <?php
                    $this->widget('booster.widgets.TbExtendedGridView', array(
                        'type' => 'striped bordered condensed',
                        'id' => 'RendimientoGrid',
                        'dataProvider' => new CActiveDataProvider('Rendimiento', array(
                            'criteria' => array(
                                'order' => 'fk_meses ASC',
                                'condition' => 'id_entidad=' . $_GET['id_actividades'] . ' and fk_tipo_entidad = 74 ',
                            ),
                            'pagination' => array('pageSize' => Yii::app()->user->getState('pageSize', 12),),
                                )),
                        'columns' => array(
                            array(
                                'name' => 'fk_meses',
                                'header' => 'Mes',
                                'value' => '$data->fkMeses->descripcion',
                                'htmlOptions' => array('width' => '95px'),
                            ),
                            array(
                                'name' => 'cantidad_programada',
                                'header' => 'Cantidad Programada',
                                'htmlOptions' => array('width' => '95px'),
                                'visible' => '$data->cantidad_programada'
                            ),
                            array(
                                'class' => 'booster.widgets.TbEditableColumn',
                                'name' => 'cantidad_cumplida',
                                'header' => 'Cantidad Cumplida',
                                'htmlOptions' => array('style' => 'text-align:center', 'title' => 'Indique la cantidad cumplida', 'id' => 'editable'),
                                'headerHtmlOptions' => array('style' => 'width: 110px; text-align: center'),
                                'editable' => array(
                                    'type' => 'text',
                                    'emptytext' => 'Indique la cantidad cumplida',
                                    'url' => $this->createUrl('Poa/ActualizarCantidadCumplida'),
                                    'placement' => 'left',
                                )
                            ),
                        ),
                    ));
                }
                ?>
            </div>
        </div>
    </div>
</div>

                <?php $this->endWidget(); ?>

