<style type="text/css">
    /* body{background: #eee url(http://subtlepatterns.com/patterns/sativa.png);}*/
    /*html,body{
        position: relative;
        height: 100%;
    }*/

    .login-container{
        position: relative;
        width: 300px;
        margin: 80px auto;
        padding: 20px 40px 40px;
        text-align: center;
        background: #fff;
        border: 1px solid #ccc;
    }

    #output{
        position: absolute;
        width: 300px;
        top: -75px;
        left: 0;
        color: #fff;
    }

    #output.alert-success{
        background: rgb(25, 204, 25);
    }

    #output.alert-danger{
        background: rgb(228, 105, 105);
    }


    .login-container::before,.login-container::after{
        content: "";
        position: absolute;
        width: 100%;height: 100%;
        top: 3.5px;left: 0;
        background: #fff;
        z-index: -1;
        -webkit-transform: rotateZ(4deg);
        -moz-transform: rotateZ(4deg);
        -ms-transform: rotateZ(4deg);
        border: 1px solid #ccc;

    }

    .login-container::after{
        top: 5px;
        z-index: -2;
        -webkit-transform: rotateZ(-2deg);
        -moz-transform: rotateZ(-2deg);
        -ms-transform: rotateZ(-2deg);

    }

    .avatar{
        width: 100px;height: 100px;
        margin: 10px auto 30px;
        border-radius: 100%;
        border: 2px solid #aaa;
        background-size: cover;
    }

    .form-box input{
        width: 100%;
        padding: 10px;
        text-align: center;
        height:40px;
        border: 1px solid #ccc;;
        background: #fafafa;
        transition:0.2s ease-in-out;

    }

    .form-box input:focus{
        outline: 0;
        background: #eee;
    }

    .form-box input[type="text"]{
        border-radius: 5px 5px 0 0;
        text-transform: lowercase;
    }

    .form-box input[type="password"]{
        border-radius: 0 0 5px 5px;
        border-top: 0;
    }

    .form-box button.login{
        margin-top:15px;
        padding: 10px 20px;
    }

    .animated {
        -webkit-animation-duration: 1s;
        animation-duration: 1s;
        -webkit-animation-fill-mode: both;
        animation-fill-mode: both;
    }

    @-webkit-keyframes fadeInUp {
        0% {
            opacity: 0;
            -webkit-transform: translateY(20px);
            transform: translateY(20px);
        }

        100% {
            opacity: 1;
            -webkit-transform: translateY(0);
            transform: translateY(0);
        }
    }

    @keyframes fadeInUp {
        0% {
            opacity: 0;
            -webkit-transform: translateY(20px);
            -ms-transform: translateY(20px);
            transform: translateY(20px);
        }

        100% {
            opacity: 1;
            -webkit-transform: translateY(0);
            -ms-transform: translateY(0);
            transform: translateY(0);
        }
    }

    .fadeInUp {
        -webkit-animation-name: fadeInUp;
        animation-name: fadeInUp;
    }


    .error {
        margin: 10px 0px;
        padding:12px;
        color: #D8000C;
        background-color: #FFBABA;

    }


</style>



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


 <div class="header-content-inner text-center" style="margin-top: 1%">
<!--    <h1 style="margin-top:auto;margin-bottom: 0;text-transform: uppercase;font-weight: 700;">Bienvenida al Registro Nacional de Mujeres <span style="color: #10429B;">UNAMUJER.</span></h1>-->
    <p style="color: white " ><b><font size="7">Sistema de Gestión de Proyectos y Acción Centralizada del <span style="color: #F6CEEC;">MinMujer.</span></font></b></p>
    
    <hr class="text-center" style="max-width: 100%;border-color: #F6CEEC;border-width: 3px">
</div>
    
    
   

<div class="container">
    <div class="login-container">
        <?php echo $form->error($model, 'username'); ?>
        <?php echo $form->error($model, 'password'); ?>
        <div id="output"></div>
        <!--<div class="avatar"></div>-->
        <div align="center"><img class="img-responsive" src="<?php echo Yii:: app()->baseUrl . '/img/icono-lapatriaesunamujer1.png' ?> " width="100" height="100"></div><br>
        <div class="form-box">
            <form action="" method="">
         
                
                <input id="CrugeLogon_username" type="text" maxlength="8" name="CrugeLogon[username]" placeholder="Cédula">
              
         
                <input id="CrugeLogon_password"  type="password" maxlength="10" name="CrugeLogon[password]" placeholder="Contraseña">
              
         
                <button class="btn btn-info btn-block login" type="submit">Ingresar</button>
            </form>
        </div>

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
<?php // endif; ?>
