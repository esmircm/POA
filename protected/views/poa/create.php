<?php
$this->breadcrumbs=array(
	'Poas'=>array('index'),
	'Create',
);

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

$baseUrl = Yii::app()->baseUrl;
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');

$criteria=new CDbCriteria;
$criteria->order='id_poa DESC';
if($tipo_poa->id_maestro == 70){
    $verificacion_pro = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 70), $criteria);
    if($verificacion_pro){
        if($verificacion_pro->anio == (date('Y')+1)){
                ?>
            <script type="text/javascript">
                bootbox.alert("Se alcanzó el límite de Planes Operativos Anuales para la Oficina", function() {
                    document.location.href="<?php  echo Yii::app()->baseUrl; ?>/Poa/index";
                    });
            </script>
                    <?php
               
        } 
    } 
} else {
    $verificacion_acc = VswPoa::model()->findByAttributes(array('codigo_dependencia' => $cruge_dependencia->value, 'fk_tipo_poa' => 71), $criteria);
    if($verificacion_acc) {
        if($verificacion_acc->anio == (date('Y')+1)){
            ?>
            <script type="text/javascript">
                bootbox.alert("Se alcanzó el límite de Planes Operativos Anuales para la Oficina", function() {
                    document.location.href="<?php  echo Yii::app()->baseUrl; ?>/Poa/index";
                    });
            </script>
               <?php
        }
    } 
}
?>
<h3 class="text-danger text-center" style="margin-bottom: 20px;">FORMULACIÓN <?php echo $tipo_poa->descripcion; ?><br><?php echo $model->dependencia; ?></h3>
<div class='animatedParent' data-sequence='500' >
    <div class="animated fadeInDownShort" data-id='1'>  
<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -20px;">
        <span class="glyphicon glyphicon-user" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
        
            <?php
            echo $this->renderPartial('_responsable', array('model' => $model, 'form' => $form, 'model_dir' => $model_dir), TRUE);
            ?>
    </div>
</div>
</div>
</div>

<!--<div class="hola" data-rotate-y="50deg" data-move-x="150%">-->
<!--<div class='animatedParent' data-sequence='500' >
    <div class="animated lightSpeedInRight" data-id='1'>-->
<div class="span-20 poa_content">
    
    <div style="position: absolute; z-index: 1; bottom: 0%; margin-bottom: -50px;">
        <span class="glyphicon glyphicon-briefcase" style="font-size: 300px; opacity: 0.2;"></span>
    </div>
    <div style="z-index: 2; position: relative; margin: 0 auto; width: 90%;">
            <?php
            echo $this->renderPartial('_poa', array('poa' => $poa, 'tipo_poa' => $tipo_poa, 'anio_pro' => $anio_pro, 'form' => $form, 'maestro' => $maestro), TRUE);
       
            ?>
    </div>
<!--</div>
</div>-->
</div>
<div class="pull-right">
    <?php
    if($tipo_poa->id_maestro == 70){
        $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'button',
            'icon' => 'glyphicon glyphicon-chevron-right',
            'context' => 'primary',
            'size' => 'large',
            'label' => $poa->isNewRecord ? 'Siguiente' : 'Save',
            'htmlOptions' => array('onclick' => 'guardar_poa()'),
                ));
    } else {
         $this->widget('booster.widgets.TbButton', array(
            'buttonType' => 'submit',
            'icon' => 'glyphicon glyphicon-chevron-right',
            'context' => 'primary',
            'size' => 'large',
            'label' => $poa->isNewRecord ? 'Siguiente' : 'Save',
                ));
    }
    ?>
</div>
<?php 
 $this->endWidget();
?>
