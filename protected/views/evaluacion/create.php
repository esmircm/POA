<?php
$this->breadcrumbs = array(
    'Personas' => array('index'),
    'Create',
);
//
//$this->menu=array(
//array('label'=>'List Persona','url'=>array('index')),
//array('label'=>'Manage Persona','url'=>array('admin')),
//);

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion1.js');
//$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion_evaluacion.js');
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
<?php
    if(isset($competencia_vista)) { } else {
    if(isset($evaluacion_vista)) { } else {
?>
<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Periodo Evaluado',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_periodo_consultado', array('form' => $form, 'vista' => $vista), TRUE),
            )
    );
    ?>
    </div>
    
    <h3 class="text-danger text-center">Sección "A": Datos de Identificación</h3>
    <div class="span-20">
    <?php

    $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Evaluador(a) / Supervisor(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_odi_supervisor', array('evaluador' => $evaluador, 'vista' => $vista, 'supeva' => $supeva, 'model' => $model, 'evaluacion' => $evaluacion, 'form' => $form), TRUE),
                )
        );

        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Datos del Supervisado(a)',
            'context' => 'primary',
            'headerIcon' => 'user',
            'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
            'content' => $this->renderPartial('_create_supervisado', array('vista' => $vista, 'model' => $model, 'form' => $form), TRUE),
                )
        );
    
        ?>
</div>
<div class="pull-right">
    <input type="hidden" name="evaluacion_vista" value="evaluacion_vista">
        <?php
       
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'submit',
            'icon' => 'glyphicon glyphicon glyphicon-arrow-right',
            'size' => 'large',
            'id' => 'guardar',
            'context' => 'primary',
            'label' => $model->isNewRecord ? 'Siguiente' : 'Save',
        ));
        
        ?>
    
</div>
    <?php
        
 }
    if(isset($evaluacion_vista)){
    ?>
    <!-- Script que valida la Seccion B  -->
    
    <input type="hidden" id="validacion_1" value="<?php echo $script ?>">
    <div id="seccionB">   
<h3 class="text-danger text-center">Sección "B": Establecimiento y Evaluación de Objetivos de Desempeño Individual</h3>
<div class="span-20">
    <?php
//        var_dump($fk_tipo_clase);die;
    
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Objetivos',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_objetivos', array('preind' => $preind, 'form' => $form, 'id_evaluacion' => $id_evaluacion, 'id_persona_evaluado' => $id_persona_evaluado), TRUE),
            )
    );
    
    ?>
</div>
<div id="seccionB_button" class="pull-right">
    
    <?php
   
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'button',
        'icon' => 'glyphicon glyphicon glyphicon-arrow-right',
        'size' => 'large',
        'context' => 'primary',
        'htmlOptions' => array('onclick' => 'EditarObjetivos()'),
        'label' => $model->isNewRecord ? 'Siguiente' : 'Save',
    ));
    ?>
</div>
    </div>
 
<div id="seccionC" style="display: none">
<h3 class="text-danger text-center">Sección "C": Competencias a Evaluar</h3>
<div class="span-20">
    <?php
//        var_dump($fk_tipo_clase);die;
    
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Objetivos',
        'context' => 'primary',
        'headerIcon' => 'user',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_competencias', array('form' => $form, 'id_evaluacion' => $id_evaluacion, 'fk_tipo_clase' => $fk_tipo_clase, 'pre_status' => $pre_status), TRUE),
            )
    );
    
    ?>
</div>
<div class="pull-right">
    <?php
   
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'button',
        'icon' => 'glyphicon glyphicon glyphicon-arrow-right',
        'size' => 'large',
        'context' => 'primary',
        'htmlOptions' => array('onclick' => 'GuardarCompetencias()'),
        'label' => $model->isNewRecord ? 'Siguiente' : 'Save',
    ));
    ?>
</div>
</div>
    <?php }
          }
          if(isset($competencia_vista)){
    ?>
<div>
<h3 class="text-danger text-center">Sección "D": CALIFICACIÓN</h3>
<div class="span-20">
    <?php
//        var_dump($fk_tipo_clase);die;
    
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Calificación Final',
        'context' => 'primary',
        'headerIcon' => 'glyphicon glyphicon-ok',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_create_calificacion', array('form' => $form, 'id_evaluacion' => $id_evaluacion, 'fk_tipo_clase' => $fk_tipo_clase, 'cali' => $cali), TRUE),
            )
    );
    
    ?>
</div>
</div>
<div>
<h3 class="text-danger text-center">Sección "E": COMENTARIOS</h3>
<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Comentarios del Evaluador',
        'context' => 'primary',
        'headerIcon' => 'glyphicon glyphicon-bookmark',
        'headerHtmlOptions' => array('style' => 'background-color: #B2D4F1 !important;color: #000000 !important;'),
        'content' => $this->renderPartial('_create_comentarios', array('form' => $form, 'id_evaluacion' => $id_evaluacion, 'fk_tipo_clase' => $fk_tipo_clase), TRUE),
            )
    );
    
    ?>
</div>
<div style="text-align: center">
    <?php
   
    $this->widget('booster.widgets.TbButton', array(
        'buttonType' => 'submit',
        'icon' => 'glyphicon glyphicon-floppy-disk',
        'size' => 'large',
        'context' => 'danger',
        'label' => $model->isNewRecord ? 'Guardar' : 'Save',
    ));
    ?>
</div>
</div>
<?php 
          }
$this->endWidget(); ?>
