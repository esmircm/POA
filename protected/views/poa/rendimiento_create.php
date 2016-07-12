<?php
$this->breadcrumbs = array(
    'Poas' => array('index'),
    $model->id_poa,
);
$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'rendimiento-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));

?>
<div class='animatedParent' data-sequence='500' >
<div class="span-20 poa_content" style="width: 99%;">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -100px;">
        <div class="animated fadeInDownShort" data-id='1'> 
        <span style="font-size: 200px; opacity: 0.2;"><?php echo $model->tipo_poa; ?></span>
    </div>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%; font-size: 20px; margin-top: 40px; text-align: center">
    <?php
        echo $form->textAreaGroup($model, 'nombre', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; text-align: center; font-size: 20px; margin-top: 50px;', 'readOnly' => true)), 'label' => false));
    ?>
    </div>
</div>
</div>

<div class="span-20 poa_content" style="width: 99%;">
    <div class="col-lg-12">
        <?php

//        #########################      GRID VIEW DE ACCIONES   ##########################
        $this->widget('booster.widgets.TbExtendedGridView', array(
            'type' => 'striped bordered',
            'htmlOptions' => array('style' => 'margin-bottom: 20px;'),
            'dataProvider' => $acciones->searchAccion($id_poa),
            'template' => "{items}",
            'columns' => array(
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
                    'header' => 'Acciones',
                    'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                    'template' => '{rendir_accion}{ver_actividades}',
                    'buttons' => array(
                        'rendir_accion' => array(
                            'label' => 'Rendir Acción',
                            'icon' => 'glyphicon glyphicon-calendar',
                            'size' => 'medium',
                            'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_poa"=>' . $id_poa . ', "id_accion"=>$data->id_accion, "rendimiento_accion"=>1))',
                            'visible' => 'Rendimiento::model()->rendimiento_accion($data->id_accion) != "0"',
                        ),
                        
                        'ver_actividades' => array(
                            'label' => 'Ver Actividades',
                            'icon' => 'eye-open',
                            'size' => 'medium',
                            'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_poa"=>' . $id_poa . ', "id_accion"=>$data->id_accion, "ver_actividad"=>1))',
                        ),
                    ),
                ),
            ),
        ));
        
        
        ?>
    </div>
    
    <?php
    if (isset($_GET['rendimiento_accion'])) {
        $rendimiento = new Rendimiento;
        $entidad = VswAcciones::model()->findByAttributes(array('id_accion' => $_GET['id_accion']));
        $criteria=new CDbCriteria;
        $criteria->order='fk_meses';
        $rendimiento_entidad = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $_GET['id_accion'], 'fk_tipo_entidad' => 73, 'es_activo' => TRUE), $criteria);
            
        ?>
   <div class='animatedParent' data-sequence='500' > 
       <div class="animated fadeInDownShort" data-id='1'> 
   <div class='col-md-12'>
        <div class="panel panel-default">
            <div class="panel-body">
                <!--<blockquote>-->
                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">
                    <!--<div class='animatedParent' data-sequence='500' >-->
                    <!--<div class="animated pulse" data-id='2'>--> 
                    <div class='col-md-4'>
                        Nombre Acción: <b> <?php echo $entidad->nombre_accion; ?> </b>
                    </div>            
                    <!--</div>-->            
                    
                    <!--<div class="animated pulse" data-id='3'>--> 
                    <div class='col-md-4'>
                        Unidad de Medida:<b> <?php echo $entidad->unidad_medida; ?> </b>
                    </div> 
                    <!--</div>--> 
                    
<!--                    <div class="animated pulse" data-id='4'> -->
                    <div class='col-md-4'>
                        Cantidad:<b> <?php echo $entidad->cantidad; ?> </b>
                    </div> 
                    <!--</div>--> 
                    <!--</div>--> 

                </blockquote>
            </div>
        </div>
    </div>
    </div>
    </div>
   
    <div class="col-lg-12" style="margin-bottom: 40px; background-color: #6fa4cd; color: #FFF;">
        <span style="width: 90%; display: block; margin: 0 auto; text-align: center; border-bottom: solid 1px rgba(255,255,255,1); margin-bottom: 20px; margin-top: 20px; font-size: 20px;"> Rendimiento de la Acción</span>

        <?php
            echo $this->renderPartial('_rendimiento', array('entidad' => $entidad, 'rendimiento_entidad' => $rendimiento_entidad, 'rendimiento' => $rendimiento, 'form' => $form), TRUE);
        ?>   
        
    </div>
    <div class="col-lg-12" style="margin: 0 auto; text-align: center">
            <input type="hidden" value="<?php echo $_GET['id_accion']; ?>" name="Accion">
                    <?php

                    $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'icon' => 'glyphicon glyphicon-save',
                    'context' => 'primary',
                    'size' => 'large',
                    'htmlOptions' => array(
                      'style' => 'font-size: 40px; padding: 10px 50px; border: none;'  
                    ),
//                    'label' => 'Guardar Rendimiento',
                        ));
                    ?>
        </div>
    <?php
    }
    ?>
    <div class="col-lg-12" style="margin-bottom: 20px;">
    <?php
    if (isset($_GET['ver_actividad'])) {
        ?>
            <?php
            $consulta_accion = VswAcciones::model()->findByAttributes(array('id_accion' => $_GET['id_accion']));
            echo $form->textFieldGroup($consulta_accion, 'nombre_accion', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5 ', 'style' => 'background: transparent; border: none; border-bottom: 1px solid;', 'readOnly' => true))));
            ?>
         <div class='animatedParent' data-sequence='500' > 
       <div class="animated fadeInDownShort" data-id='1'> 
   <div class='col-md-12'>
        <div class="panel panel-default">
            <div class="panel-body">
                <!--<blockquote>-->
                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">
                    <!--<div class='animatedParent' data-sequence='500' >-->
                    <!--<div class="animated pulse" data-id='2'>--> 
                    <div class='col-md-4'>
                        Nombre Acción: <b> <?php echo $consulta_accion->nombre_accion; ?> </b>
                    </div>            
                    <!--</div>-->            
                    
                    <!--<div class="animated pulse" data-id='3'>--> 
                    <div class='col-md-4'>
                        Unidad de Medida:<b> <?php echo $consulta_accion->unidad_medida; ?> </b>
                    </div> 
                    <!--</div>-->   
                    
<!--                    <div class="animated pulse" data-id='4'> -->
                    <div class='col-md-4'>
                        Cantidad:<b> <?php echo $consulta_accion->cantidad; ?> </b>
                    </div> 
                    <!--</div>--> 
                    <!--</div>--> 

                </blockquote>
            </div>
        </div>
    </div>
    </div>
    </div>
        <?php
        $this->widget('booster.widgets.TbExtendedGridView', array(
            'type' => 'striped bordered condensed',
            'id' => 'ActividadesGrid',
            'dataProvider' => new CActiveDataProvider('VswActividades', array(
                'criteria' => array(
                    'order' => 'id_actividades ASC',
                    'condition' => 'fk_accion=' . $_GET['id_accion'],
                ))
            ),
            'columns' => array(
                array(
                    'name' => 'actividad',
                    'header' => 'Nombre Actividad',
                    
                ),
                array(
                    'name' => 'fk_unidad_medida',
                    'header' => 'Unidad de Medida',
                    'value' => '$data->unidad_medida',
                    
                ),
                array(
                    'name' => 'cantidad',
                    'header' => 'Cantidad',
                    
                ),
                array(
                    'class' => 'booster.widgets.TbButtonColumn',
                    'header' => 'Acciones',
                    'htmlOptions' => array('width' => '100', 'style' => 'text-align: center; font-size: 20px; letter-spacing: 5px;'),
                    'template' => '{rendir_actividad}',
                    'buttons' => array(
                        'rendir_actividad' => array(
                            'label' => 'Rendir Actividad',
                            'icon' => 'glyphicon glyphicon-calendar',
                            'size' => 'medium',
                            'url' => 'Yii::app()->createUrl("/poa/Rendimiento", array("id_poa"=>' . $id_poa . ', "id_accion"=>' . $_GET['id_accion'] . ', "id_actividad"=>$data->id_actividades, "ver_actividad"=>1))',
                            'visible' => 'Rendimiento::model()->rendimiento_actividad($data->id_actividades) != "0"',
                        ),
                    ),
                ),
            ),
        ));
        ?>
    </div>    
        <?php
        if (isset($_GET['id_actividad'])) {
            $rendimiento = new Rendimiento;
            $entidad = VswActividades::model()->findByAttributes(array('id_actividades' => $_GET['id_actividad']));
            $criteria=new CDbCriteria;
            $criteria->order='fk_meses';
            $rendimiento_entidad = Rendimiento::model()->findAllByAttributes(array('id_entidad' => $_GET['id_actividad'], 'fk_tipo_entidad' => 74, 'es_activo' => TRUE), $criteria);
            
            ?>
      
    <!--<div class='animatedParent' data-sequence='500' >--> 
       <!--<div class="animated fadeInDownShort" data-id='2'>--> 
   <div class='col-md-12'>
        <div class="panel panel-default">
            <div class="panel-body">
                <!--<blockquote>-->
                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">
                    <!--<div class='animatedParent' data-sequence='500' >-->
                    <!--<div class="animated pulse" data-id='2'>--> 
                    <div class='col-md-4'>
                        Nombre Actividad: <b> <?php echo $entidad->actividad; ?> </b>
                    </div>            
                    <!--</div>-->            
                    
                    <!--<div class="animated pulse" data-id='3'>--> 
                    <div class='col-md-4'>
                        Unidad de Medida:<b> <?php echo $entidad->unidad_medida; ?> </b>
                    </div> 
                    <!--</div>-->   
                    
<!--                    <div class="animated pulse" data-id='4'> -->
                    <div class='col-md-4'>
                        Cantidad:<b> <?php echo $entidad->cantidad; ?> </b>
                    </div> 
                    <!--</div>--> 
                    <!--</div>--> 

                </blockquote>
            </div>
        </div>
    </div>
    <!--</div>-->
    <!--</div>-->
    
        <div class="col-lg-12" style="margin-bottom: 40px; background-color: #6fa4cd; color: #FFF;">
            <span style="width: 90%; display: block; margin: 0 auto; text-align: center; border-bottom: solid 1px rgba(255,255,255,1); margin-bottom: 20px; margin-top: 20px; font-size: 20px;"> Rendimiento de la Actividad</span>

            <?php
                echo $this->renderPartial('_rendimiento', array('entidad' => $entidad, 'rendimiento_entidad' => $rendimiento_entidad, 'rendimiento' => $rendimiento, 'form' => $form), TRUE);
            ?>        
        </div>
            <div class="col-lg-12" style="margin: 0 auto; text-align: center; margin-bottom: 20px;">
                <input type="hidden" value="<?php echo $_GET['id_actividad']; ?>" name="Actividad">
                    <?php

                    $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'icon' => 'glyphicon glyphicon-save',
                    'context' => 'primary',
                    'size' => 'large',
                    'htmlOptions' => array(
                      'style' => 'font-size: 40px; padding: 10px 50px; border: none;'  
                    ),
//                    'label' => 'Guardar Rendimiento',
                        ));
                    ?>
            </div>
        <?php
        }
    }
       
?>
    
</div>

<?php
    


/*
function FechaActual($id, $tiempo_hora) { // FUNCIÓN PARA PODER AÑADIR CANTIDADES CUMPLIDAS SEGUN LA FECHA ACTUAL
    $tiempo_hora2 = date('m'); // FECHA ACTUAL DEL SERVIDOR
    if ($tiempo_hora2 == 01) {
        $time = 57;
    }
    if ($tiempo_hora2 == 02) {
        $time = 58;
    }
    if ($tiempo_hora2 == 03) {
        $time = 59;
    }
    if ($tiempo_hora2 == 04) {
        $time = 60;
    }
    if ($tiempo_hora2 == 05) {
        $time = 61;
    }
    if ($tiempo_hora2 == 06) {
        $time = 62;
    }
    if ($tiempo_hora2 == 07) {
        $time = 63;
    }
    if ($tiempo_hora2 == 08) {
        $time = 64;
    }
    if ($tiempo_hora2 == 09) {
        $time = 65;
    }
    if ($tiempo_hora2 == 10) {
        $time = 66;
    }
    if ($tiempo_hora2 == 11) {
        $time = 67;
    }
    if ($tiempo_hora2 == 12) {
        $time = 68;
    }
    if ($tiempo_hora != $time) {
        $id = 'aprobado';
    }
    return $id;
}
?>

<style>
    .aprobado
    {
        visibility: hidden;
    }
</style>


    <div class="span-20 poa_content">

        <?php
        $consulta11 = Poa::model()->findByAttributes(array('id_poa' => $model->id_poa));
        $nombreProyectoo = $consulta11['nombre'];
        ?>
        <div class="progress right">
            <div class="progress-bar progress-bar-success" data-transitiongoal="100" style="width: 100%;" aria-valuenow="95"></div>
        </div>
        <h2 style="text-align: center; font-size: 20px;"><b>Proyecto:</b> <?php echo $nombreProyectoo ?> </h2>

        <br>


        <div class="col-lg-12">

            <div class="panel panel-primary">
                <div class="panel-heading"></div>
                <div class="panel-body">

                    <!--GRID VIEW DE ACCIONES DE PROYECTO-->

                    <?php
                    $consulta1 = Poa::model()->findByAttributes(array('id_poa' => $model->id_poa));
                    $nombreProyecto = $consulta1['nombre'];
                    $this->widget(
                            'booster.widgets.TbBadge', array(
                        'context' => 'success',
                        'htmlOptions' => array(
                            'style' => 'font-size:17px;',
                        ),
                        'label' => ' ' . $nombreProyecto,
                            )
                    );
                    ?>


                    <?php
//        #########################      GRID VIEW DE ACCIONES DE PROYECTO    ##########################
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
                                'header' => 'Desplegar Acciones',
                                'template' => '{accion}',
                                'buttons' => array(
                                    'accion' => array(
                                        'label' => 'Acciones',
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
                            'label' => ' ' . $nombreAccion,
                                )
                        );
                        ?>



                        <?php
                        //        #########################      GRID VIEW DE RENDIMIENTO DE ACCIONES DE PROYECTO  ##########################
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
                                    'cssClassExpression' => 'FechaActual($data["cantidad_cumplida"],$data->fk_meses)',
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
                                array(
                                    'header' => 'Cantidades Cumplidas',
                                    'name' => 'cantidad_cumplida',
                                    'headerHtmlOptions' => array('style' => 'width: 5%;'),
                                ),
                            ),
                        ));
                        ?>
                    </div>
                </div>
                <!--                <div class="progress right">
                                    <div class="progress-bar progress-bar-success" data-transitiongoal="100" style="width: 100%;" aria-valuenow="95"></div>
                                </div>-->
                <div class="progress right">
                    <div class="progress-bar progress-bar-success" data-transitiongoal="100" style="width: 100%;" aria-valuenow="50"></div>
                </div>
                <h2 style="text-align: center; font-size: 20px;"><b>ACTIVIDADES</b> </h2>


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
                            'label' => 'Actividades de la acción: ' . $nombreAccion,
                                )
                        );
//              ####################       GRID VIEW DE ACTIVIDADES DE PROYECTO          #####################
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
//        #########################      GRID VIEW DE RENDIMIENTO DE ACTIVIDADES DE PROYECTO  ##########################
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
                                    'cssClassExpression' => 'FechaActual($data["cantidad_cumplida"],$data->fk_meses)',
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
                                array(
                                    'header' => 'Cantidades Cumplidas',
                                    'name' => 'cantidad_cumplida',
                                    'headerHtmlOptions' => array('style' => 'width: 5%;'),
                                ),
                            ),
                        ));
                    }
                    ?>
                </div>
            </div>

        </div>
    </div>



*/
?>

<?php $this->endWidget(); ?>
