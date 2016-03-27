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
    <h2 style="text-align: center; font-size: 20px;">RENDIMIENTO DE ACCIONES</h2>
    <div class="col-lg-12">

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
                'id_accion' => array(
                    'name' => 'id_accion',
                    'header' => 'id',
                    'value' => '$data->id_accion'
                ),
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
                    'header' => 'Acción',
                    'template' => '{accion}',
                    'buttons' => array(
                        'accion' => array(
                            'label' => 'Acciones',
//                            'options' => array('style' => 'margin-left:17px;'),
                            'icon' => 'chevron-down',
                            'size' => 'medium',
                            'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_accion"=>$data->id_accion,  "id_poa"=>' . $id_poa . '))',
                        ),
                    ),
                ),
            )),
        ));
//var_dump($_GET['des']);die;

        if (isset($_GET['id_accion'])) {
            ?>


            <?php
     
            $this->widget('booster.widgets.TbExtendedGridView', array(
                'type' => 'striped bordered condensed',
                'id' => 'RendimientoGrid',
     
                'dataProvider' => new CActiveDataProvider('Rendimiento', array(
                    'criteria' => array(
                        'order' => 'fk_meses ASC',
                        'condition' => 'id_entidad=' . $_GET['id_accion'] . ' AND fk_tipo_entidad = 73',
                    ),
                    'pagination' => array('pageSize' => Yii::app()->user->getState('pageSize', 12),),
                        )),
                'columns' => array(
     
//                    array(
//                        'name' => 'id_rendimiento',
//                        'header' => 'id',
//                        'htmlOptions' => array('width' => '95px'),
//                    ),
                    array(
                        'name' => 'fk_meses',
                        'header' => 'Mes',
                        'value' => '$data->fkMeses->descripcion',
//                        'data' => CHtml::listData(MaestroPoa::model()->findAll('padre=:padre', array(':padre' => '35')), 'id_maestro', 'descripcion'),
                        'htmlOptions' => array('width' => '95px'),
                    ),
                    array(
                        'name' => 'cantidad_programada',
                        'header' => 'Cantidad Programada',
                        'htmlOptions' => array('width' => '95px'),
//                        'visible' => '($data->cantidad_programada == "0")',
//                        'visible'=> $columnVisible
                        'visible' => '$data->cantidad_programada'
                    ),
//                    array(
//                        'name' => 'cantidad_cumplida',
//                        'header' => 'Cantidad Cumplida',
//                        'htmlOptions' => array('width' => '95px'),
//                    ),
                    array(
                        'class' => 'booster.widgets.TbEditableColumn',
                        'name' => 'cantidad_cumplida',
                        'header' => 'Cantidad Cumplida',
                        'htmlOptions' => array('style' => 'text-align:center', 'title' => 'Indique la cantidad cumplida', 'id' => 'editable'),
                        'headerHtmlOptions' => array('style' => 'width: 110px; text-align: center'),
//                        [b]'visible'=>Yii::app()->user->checkAccess("reader"),[/b]
                        'editable' => array(
                            'type' => 'text',
                            'emptytext' => 'Indique la cantidad cumplida',
                            //   'inputclass' => 'input-large',
                            'url' => $this->createUrl('Poa/ActualizarCantidadCumplida'),
                            'placement' => 'left',
//                            'success' => 'js: function(response, newValue) {
//                                if(!response.success) return response.msg;
//                             }',
//                            'options' => array(
//                                'ajaxOptions' => array('dataType' => 'json')
//                            )
//                            'validate' => 'function(value) {
//                                     if(!value) return "Disculpe, debe indicar la observaciÃ³n"
//                                 }'
                        )
                    ),
//                    array(
//                        'class' => 'booster.widgets.TbButtonColumn',
////                        'htmlOptions' => array('style' => 'width: 11%'),
//                        'header' => 'Acción',
//                        'template' => '{actividades}',
//                        'buttons' => array(
//                            'actividades' => array(
//                                'label' => 'Actividades',
////                                'options' => array('style' => 'margin-left:17px;'),
//                                'icon' => 'chevron-down',
//                                'size' => 'medium',
//                            ),
//                        ),
//                    ),
                ),
            ));
        }
        ?>
    </div>
</div>

<?php $this->endWidget(); ?>

