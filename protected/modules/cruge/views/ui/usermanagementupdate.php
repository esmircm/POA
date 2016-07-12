<?php
/*
  $model:
  es una instancia que implementa a ICrugeStoredUser, y debe traer ya los campos extra 	accesibles desde $model->getFields()

  $boolIsUserManagement:
  true o false.  si es true indica que esta operandose bajo el action de adminstracion de usuarios, si es false indica que se esta operando bajo 'editar tu perfil'
 */
     $rbac = Yii::app()->user->rbac;
       $ui = Yii::app()->user->ui;
       Yii::app()->clientScript->registerCoreScript('jquery');
       $loaderSrc = Yii::app()->user->ui->getResource('loading.gif');
       $loaderImg = "<img src='{$loaderSrc}'>";

       $selectedUserGetter = 'userdescription';
         $rol = Yii::app()->db->createCommand('select itemname from cruge_authassignment where userid = ' . Yii::app()->user->id)->queryAll();
         $rol = (object) $rol[0];
         $roll = $rol->itemname;
?>
<h1><?php
    echo ucwords(CrugeTranslator::t(
                    $boolIsUserManagement ? "editando usuario" : "editando tu perfil"
    ));
    ?></h1>
<?php 

    $this->widget('booster.widgets.TbTabs', array(
        'type' => 'tabs',
        'tabs' => array(
            array('label' => 'Usuarios', 'url' => 'usermanagementadmin'),
            array('label' => 'Crear Usuario', 'url' => 'usermanagementcreate'),
            array('label' => 'Editar mi perfil', 'url' => 'editprofile', 'active' => TRUE),
            ))
    );?>
<div class="form">
    <?php
    $form = $this->beginWidget('booster.widgets.TbActiveForm', array(
        'id' => 'crugestoreduser-form',
        'enableAjaxValidation' => false,
        'enableClientValidation' => false,
    ));
    ?>
    <div class="row form-group">
        <h6><?php echo ucfirst(CrugeTranslator::t("datos de la cuenta")); ?></h6>
        <div class="row">
            <div class="col-md-6">
                <?php echo $form->textFieldGroup($model, 'username', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readonly' => 'readonly')))); ?>
            </div>
            <div class="col-md-6">
                <?php echo $form->textFieldGroup($model, 'email', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <?php echo $form->textFieldGroup($model, 'newPassword', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
            </div>
            <div class="col-md-6">
                <script>
                    function fnSuccess(data) {
                        $('#CrugeStoredUser_newPassword').val(data);
                    }
                    function fnError(e) {
                        alert("error: " + e.responseText);
                    }
                </script>
                <?php
                echo CHtml::ajaxbutton(
                        CrugeTranslator::t("Generar una nueva clave")
                        , Yii::app()->user->ui->ajaxGenerateNewPasswordUrl
                        , array('success' => new CJavaScriptExpression('fnSuccess'),
                    'error' => new CJavaScriptExpression('fnError'))
                );
                ?>
            </div>
        </div>


        <div class="row">
            <div class="col-md-4">
                <?php echo $form->textFieldGroup($model, 'regdate', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readonly' => 'readonly', 'value' => Yii::app()->user->ui->formatDate($model->regdate),)))); ?>
            </div>
            <div class="col-md-4">
                <?php echo $form->textFieldGroup($model, 'actdate', array('widgetOptions' => array('htmlOptions' => array('readonly' => 'readonly', 'value' => Yii::app()->user->ui->formatDate($model->actdate),)))); ?>
            </div>
            <div class="col-md-4">
                <?php echo $form->textFieldGroup($model, 'logondate', array('widgetOptions' => array('htmlOptions' => array('readonly' => 'readonly', 'value' => Yii::app()->user->ui->formatDate($model->logondate),)))); ?>
            </div>
        </div>
    </div>

    <!-- inicio de campos extra definidos por el administrador del sistema -->
    <?php
    if (count($model->getFields()) > 0) {
        echo "<div class='row form-group'>";
        echo "<h6>" . ucfirst(CrugeTranslator::t("perfil")) . "</h6>";
        foreach ($model->getFields() as $f) {
            // aqui $f es una instancia que implementa a: ICrugeField
            echo "<div class='col'>";
            echo Yii::app()->user->um->getLabelField($f);
            echo Yii::app()->user->um->getInputField($model, $f);
            echo $form->error($model, $f->fieldname);
            echo "</div>";
        }
        echo "</div>";
    }
    ?>
    <!-- fin de campos extra definidos por el administrador del sistema -->


    <!-- inicio de opciones avanazadas, solo accesible bajo el rol 'admin' -->

    <?php
    $loader = "<span class='loader'></span>";
//    condicionales que permite cambiar de estatus activo e inactivo del usuario 'admin' 
//    if ($boolIsUserManagement)
//        if (Yii::app()->user->checkAccess('edit-advanced-profile-features', __FILE__ . " linea " . __LINE__))
    if (Yii::app()->user->checkAccess('administrador')||($roll=='administrador_mrl')||($roll=='administrador_actualizacion')){
        $this->renderPartial('_edit-advanced-profile-features', array('model' => $model, 'form' => $form), false);
              
   }
    
       ?>   
            
 

    <!-- fin de opciones avanazadas, solo accesible bajo el rol 'admin' -->



    <div class="row buttons">
        <?php Yii::app()->user->ui->tbutton("Guardar Cambios"); ?>

    </div>
    <?php echo $form->errorSummary($model); ?>
    <?php $this->endWidget(); ?>
</div>
