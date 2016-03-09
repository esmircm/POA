<style type="text/css">
    /* Credit to bootsnipp.com for the css for the color graph */
    .colorgraph {
        height: 5px;
        max-width: 100% !important;
        border-top: 0;
        background: #c4e17f;
        border-radius: 5px;
        background-image: -webkit-linear-gradient(left,   #fecf71 20%, #2E2EFE 50%, #FA5858 100%);
        background-image: -moz-linear-gradient(left,   #fecf71 20%, #2E2EFE 50%, #FA5858 100%);
        background-image: -o-linear-gradient(left,   #fecf71 20%, #2E2EFE 50%, #FA5858 100%);
        background-image: linear-gradient(to right,   #fecf71 20%, #2E2EFE 50%, #FA5858 100%);
    }


    /* body {
         background-image: url("<?php //echo Yii::app()->baseUrl;     ?>/images/azul2.png") !important;
         height: 100% !important;
         width: 100% !important;
         background-size: cover !important;
         background-position: center center !important;
     }*/

    body {
        /* background-image: url("<?php //echo Yii::app()->baseUrl;     ?>/images/azul2.png") !important;*/
        background-color: LightCyan !important;
        height: 100% !important;
        width: 100% !important;
        background-size: cover !important;
        /*background-position: right bottom  !important;*/
        background-attachment:fixed !important;
    }
    .navbar-default .nav > li>a, .navbar-default .nav>li>a:focus {
        color: rgba(255,255,255,.7) !important;
    }
    .navbar-default .navbar-nav>li>a {
        color: Black !important;
    }
    .navbar-default.affix .nav > li>a, .navbar-default.affix .nav>li>a:focus {
        color: #222 !important;
    }
    .navbar-default {
        background-color: rgba(255,255,255,.3) !important; 
        border-color: LightSkyBlue !important;
    }
    .navbar-default.affix {
        border-color: rgba(34,34,34,.05) !important;
        background-color: #fff !important;
    }


    hrr { 
        border: 5px solid #4bceb4; 
        border-radius: 200px /8px; 
        height: 0px; 
        text-align: center; 
    } 


    .well {
        height: 350px ;
        width: 555px ;
        min-height: 20px;
        padding: 19px;
        margin-bottom: 20px;
        background-color: rgba(255, 255, 255, 0.73);
        border: 1px solid #e3e3e3;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
        box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    }

</style>




<?php if (Yii::app()->user->hasFlash('loginflash')): ?>
    <div class="flash-error">
        <?php echo Yii::app()->user->getFlash('loginflash'); ?>
    </div>
<?php else: ?>

    <?php
    $form = $this->beginWidget('booster.widgets.TbActiveForm', array(
        'id' => 'logon-form',
        'enableAjaxValidation' => false,
        'enableClientValidation' => true,
        'clientOptions' => array(
            'validateOnSubmit' => true,
            'validateOnChange' => true,
            'validateOnType' => true,
        ),
    ));
    ?>



    <div class="container">
        <div class="row" style="margin-top:20px">
            <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
                <form role="form">
                    <fieldset>


                        <div align="center"><img src="<?php echo Yii:: app()->baseUrl . '/images/hh.png' ?> " width="500" height="350"></div>

                                <!--<center>holas</center>-->
                        <hr class="colorgraph">
                        <div class="form-group">
                            <?php echo $form->textFieldGroup($model, 'username', array('prepend' => '<i class="glyphicon glyphicon-user"></i>', 'style' => 'color:red')); ?>
                        </div>
                        <div class="form-group">
                            <?php echo $form->passwordFieldGroup($model, 'password', array('prepend' => '<i class="glyphicon glyphicon-lock"></i>')); ?>
                        </div>

                        <hr class="colorgraph">
                        <div class="row text-center">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <input type="submit" class="btn btn-lg btn-danger btn-block" value="Ingresar">
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>


                                                    <!--<input type="submit" class="btn btn-lg btn-success btn-block" value="Ingresar">-->



            <!--            <div id="login" class="span3 well well-small  text-center">
                            <h1><?php // echo CrugeTranslator::t('Inicio de Sesion', "Inicio de Sesion");                         ?></h1>
                            <div class="row">
            <?php // echo $form->labelEx($model, 'username'); ?>
            <?php // echo $form->textField($model, 'username'); ?>
            <?php // echo $form->error($model, 'username'); ?>
                            </div>
            
                            <div class="row">
            <?php // echo $form->labelEx($model, 'password'); ?>
            <?php // echo $form->passwordField($model, 'password'); ?>
            <?php // echo $form->error($model, 'password'); ?>
                            </div>
            
                            <div class="row rememberMe">
            <?php // echo $form->checkBox($model, 'rememberMe'); ?>
            <?php // echo $form->label($model, 'rememberMe'); ?>
            <?php // echo $form->error($model, 'rememberMe'); ?>
                            </div>
            
                            <div class="row buttons">
            <?php // Yii::app()->user->ui->tbutton(CrugeTranslator::t('logon', "Login")); ?>
            <?php // echo Yii::app()->user->ui->passwordRecoveryLink; ?>
            <?php
//                if (Yii::app()->user->um->getDefaultSystem()->getn('registrationonlogin') === 1)
//                    echo Yii::app()->user->ui->registrationLink;
            ?>
                            </div>-->

            <?php
            //  si el componente CrugeConnector existe lo usa:
            //
        if (Yii::app()->getComponent('crugeconnector') != null) {
                if (Yii::app()->crugeconnector->hasEnabledClients) {
                    ?>
                    <div class='crugeconnector'>
                        <span><?php echo CrugeTranslator::t('logon', 'You also can login with'); ?>:</span>
                        <ul>
                            <?php
                            $cc = Yii::app()->crugeconnector;
                            foreach ($cc->enabledClients as $key => $config) {
                                $image = CHtml::image($cc->getClientDefaultImage($key));
                                echo "<li>" . CHtml::link($image, $cc->getClientLoginUrl($key)) . "</li>";
                            }
                            ?>
                        </ul>
                    </div>
                    <?php
                }
            }
            ?>
        </div>


        <?php $this->endWidget(); ?>
    </div>
<?php endif; ?>
