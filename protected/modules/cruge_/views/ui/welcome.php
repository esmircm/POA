<?php ?>

<?php if (Yii::app()->user->isGuest) { ?>
<br>
<br>
<br>
<br>

<center><h1><p style="color: white; font-size:15px;" ><b>SESIÓN EXPIRO</b></p></h1><br></center>
<div align="center"><img class="img-responsive" src="<?php echo Yii:: app()->baseUrl . '/img/lock.png' ?> " width="200" height="200"><br><br>
    
    
        <a class="btn btn-success btn-lg" href="<?php echo Yii::app()->baseUrl ?>/cruge/ui/login"><i class="glyphicon glyphicon-lock"></i> Iniciar Sesión</a>
    </div>
<?php } ?>


