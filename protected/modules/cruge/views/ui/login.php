<style type="text/css">
    .modal-dialog{
        text-align: justify;
    }
    .login-logo{
        text-align: center;
        padding: 15px 0 10px;
    }
    .login-box{
        position: relative;
        max-width:480px;	
        background: transparent url(../img/login-bg.png) repeat; 
        -webkit-border-radius: 8px;
        -moz-border-radius: 8px;
        border-radius:8px;
        padding-bottom: 20px;
        -webkit-box-shadow: 2px 2px 5px #333;
        -moz-box-shadow: 2px 2px 5px #333;
        box-shadow: 2px 2px 5px #333;
        margin-top: 80px;
    }    

    .login-box hr{
        margin:10px auto 20px;
        width:70%;
        border-top:1px solid #dddbda;
        border-bottom:1px solid #FFF;
    }

    .login-form form p{
        width:80%;
        margin: 5px auto 10px;
        text-align: center;
    }

    .btn.btn-login {
        width: 120px;
        display:block;
        margin: 20px auto 20px;
        color: white;
        text-transform:uppercase ;	
        text-shadow: 1px 2px 2px #c44c4c;
        background: #48c7d5; 
        border: 1px solid #42a3ae;
        -webkit-box-shadow: inset 0 1px 2px #73e2ed;
        -moz-box-shadow: inset 0 1px 2px #73e2ed;
        box-shadow: inset 0 1px 2px #73e2ed;
        -webkit-transition: background .5s ease-in-out;
        -moz-transition: background .5s ease-in-out;
        -o-transition: background .5s ease-in-out;
        transition: background .5s ease-in-out;
    }

    .page-icon{
        width: 125px;
        height: 125px;
        -webkit-border-radius: 125px;
        -moz-border-radius: 125px;
        border-radius: 125px;
        background: transparent url(../img/login-bg.png) repeat; 
        border:8px solid #f9f9fa;
        text-align: center;
        -webkit-box-shadow: inset 1px 3px 8px #999;
        -moz-box-shadow: inset 1px 3px 8px #999;
        box-shadow: inset 1px 3px 8px #9999;
        margin: -80px auto 0;

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
    // Set up several flashes
    // (this should be done somewhere in controller, of course).
    if (isset($error) && !empty($error)) {
        $user = Yii::app()->getComponent('user');
        $user->setFlash(
                'danger', "<strong>Número de cuenta no encontrado.</strong> Comuníquese con la Oficina de Recursos Humanos para verificar sus datos."
        );
        // Render them all with single `TbAlert`
        $this->widget('booster.widgets.TbAlert', array(
            'fade' => true,
            'closeText' => '&times;', // false equals no close link
            'events' => array(),
            'htmlOptions' => array(),
            'userComponentId' => 'user',
            'alerts' => array(// configurations per alert type
                // success, info, warning, error or danger
                'danger' => array('closeText' => false),
            //'info', // you don't need to specify full config
//                'warning' => array('closeText' => false),
//            'error' => array('closeText' => 'AAARGHH!!')
            ),
        ));
}

    ?>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4">
            <div class="login-box clearfix" style="background: gainsboro">
                <div class="page-icon animated bounceInDown" style="background: #ec3a93">
                    <img class="img-responsive" alt="MinMujer" src="<?= Yii::app()->getBaseUrl() . '/img/login-key-icon.png' ?>">
                </div>
                <div class="login-logo">
                    <a href="http://www.minmujer.gob.ve/" target="_blank">
                        <img alt="Company Logo" src="<?= Yii::app()->getBaseUrl() . '/img/logo.png' ?>" width="150px">
                    </a>
                </div>
                <hr>
                <div class="login-form">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <?php echo $form->textFieldGroup($model, 'username', array('prepend' => '<i class="glyphicon glyphicon-user"></i>')); 
                                ?>
                        
                                
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <?php
                                echo $form->passwordFieldGroup($model, 'password', array('widgetOptions' =>
                                    array(
                                        'htmlOptions' => array(
//                                            'rel' => 'tooltip',
                                            'title' => 'Los ultimos seis digitos es la de la cuenta nomina del Banco de Venezuela',
                                            'data-toggle' => 'tooltip', 'data-placement' => 'right',
                                        ),
                                    ),
                                    'prepend' => '<i class="glyphicon glyphicon-lock"></i>',
                                        )
                                );
                                ?>


                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <?php echo $form->checkboxGroup($model, 'rememberMe'); ?>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <button class="btn btn-login" type="submit">Ingresar</button>
                            </div>
                        </div>
                    </div>
                    <?php //echo Yii::app()->user->ui->passwordRecoveryLink;   ?>
                    <?php //Yii::app()->user->ui->tbutton(CrugeTranslator::t('logon', "Login"));   ?>
                </div>     
            </div>
        </div>
    </div>

    <?php
    //	si el componente CrugeConnector existe lo usa:
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
    <?php $this->endWidget(); ?>
<?php endif; ?>

<?php
Yii::app()->clientScript->registerScript('LOGIN', "
    $(document).ready(function(){
    header= '<p><h2><i><center><b>¡AVISO IMPORTANTE!<b></center></i></h2></p>';    
    
    texto = '<b><h3>\"Esta información es confidencial y únicamente de uso exclusivo de la Oficina de Gestión Humana, todos los datos podrán ser verificados por esta oficina y de encontrarse referencia que no correspondan con la trabajadora o trabajador, se podrán iniciar los procedimientos legales correspondientes.\"</h3></b><br/>';
    image = '<div class=\"text-center\"><img src=\'".Yii::app()->baseUrl ."/img/ALERT.png\'  style=\'width:auto;height:auto;\'></div>';
        bootbox.alert(header + ''+ texto +''+image );
    });
");
?>