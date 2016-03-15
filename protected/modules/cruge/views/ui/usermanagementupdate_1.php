<?php
/*
  $model:
  es una instancia que implementa a ICrugeStoredUser, y debe traer ya los campos extra 	accesibles desde $model->getFields()

  $boolIsUserManagement:
  true o false.  si es true indica que esta operandose bajo el action de adminstracion de usuarios, si es false indica que se esta operando bajo 'editar tu perfil'
 */
?>
<h1><?php
    echo ucwords(CrugeTranslator::t(
                    $boolIsUserManagement ? "Cambiar Contraseña" : "editando tu perfil"
    ));
    ?></h1>
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
                <?php echo $form->textFieldGroup($model, 'email', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5','readonly' => 'readonly')))); ?>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <?php echo $form->textFieldGroup($model, 'newPassword', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5')))); ?>
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
    <div class="row buttons">
        <?php Yii::app()->user->ui->tbutton("Guardar Cambios"); ?>
    </div>
    <?php echo $form->errorSummary($model); ?>
    <?php $this->endWidget(); ?>
</div>
