<?php
$this->breadcrumbs=array(
	'Proyectos',
);

$sql = "select iduser, id_persona from cruge_user where iduser =" . Yii::app()->user->id;
$connection = Yii::app()->db;
$command = $connection->createCommand($sql);
$row = $command->queryAll();
$idUser = $row[0]["iduser"];
$idPersona = $row[0]["id_persona"];
$dependencia = VswPersonal::model()->findByAttributes(array('id_persona' => $idPersona));
?>

<div class="span-proyecto">
    <h1 style="border-bottom: 1px solid #dddddd; margin-bottom: 20px;"><?php echo $dependencia->dependencia; ?></h1>
    <div class="button-proyecto" id="button-proyecto" onclick="window.location='<?php echo Yii::app()->createUrl("proyecto/create"); ?>';">
    <div class="button-img" style="background-image: url('<?php echo Yii::app()->request->baseUrl;?>/img/button2.jpg');">
    </div>
    <div style="display: block;">
        <h6>Crear Proyecto Operativo Anual</h6>
        <h1><?php echo date('Y') + 1;?></h1>
    </div>
</div>

<?php
// $this->widget('booster.widgets.TbListView',array(
//'dataProvider'=>$dataProvider,
//'itemView'=>'_view',
//)); 
?>
</div>