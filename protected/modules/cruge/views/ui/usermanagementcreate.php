<style>
    .col{padding-left: 60px;}
</style>

<script>
    $(document).ready(function () {
        $('#inst').click(function () {
            var inst = $('#inst').val();
            if (inst != '' || inst != null) {
                $.ajax({
                    url: '<?php echo Yii::app()->createAbsoluteUrl("/cruge/ui/LIstDir"); ?>',
                    async: true,
                    type: 'POST',
                    data: 'inst=' + inst,
                    success: function (data) {
                        if (data) {
                            $('#dir').html(data);
                        }

                    },
                });
            }
        });
        $('#dir').change(function () {
            var dir = $('#dir').val();
            if (dir != '' || dir != null) {
                $.ajax({
                    url: '<?php echo Yii::app()->createAbsoluteUrl("/cruge/ui/LIstCoor"); ?>',
                    async: true,
                    type: 'POST',
                    data: 'dir=' + dir,
                    success: function (data) {
                        if (data) {
                            $('#coor').html(data);
                        }

                    },
                });
            }
        });
        $('#coor').change(function () {
            var coor = $('#coor').val();
            if (coor != '' || coor != null) {
                $.ajax({
                    url: '<?php echo Yii::app()->createAbsoluteUrl("/cruge/ui/LIstCar"); ?>',
                    async: true,
                    type: 'POST',
                    data: 'coor=' + coor,
                    success: function (data) {
                        if (data) {
                            $('#car').html(data);
                        }

                    },
                });
            }
        });

    });
</script>

<?php
//Validacion solo números y no permitir el copiado de palabras
$baseUrl = Yii::app()->baseUrl;
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
$funciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');
Yii::app()->clientScript->registerScript('usuario', "
    $('#cedula').focusout(function(){
    $('#cedula').val(parseInt($('#cedula').val()));
        $('.cargar').show();
        var nacionalidad = $('#nacionalidad').val();
        var nacionalidad = $('#nacionalidad').children(':selected').text();
        var cedula = $('#cedula').val();
        $('#nombre').val(''); 
        $('#apellido').val('');
         if(cedula==''){ bootbox.alert ('Debe ingresar la cédula de Identidad');
                                     $('#cedula').val('');return false;}
          
                            $.ajax({
                                url: '" . CController::createUrl('/ValidacionJs/buscarListar') . "',
                                async: true,
                                type: 'POST',
                                data: 'cedula='+$('#cedula').val()+'&nacionalidad='+$('#nacionalidad').val(),
                                dataType:'json',
                                success: function(datos){
                                    if(!datos){
                                        bootbox.alert ('El número de Cédula no existe');
                                         $('#cedula').val('')
                                        $('.cargar').hide();
                                    }else if (datos == 'noEncontro') {
                                     bootbox.alert ('Este Usuario ya se encuentra Registrado');
                                      $('#cedula').val('');return false;
                                    }else if (datos['cedula'] == 'problema') {
                                        bootbox.alert('Esta cédula de identidad <b>presenta una objeción</b> por lo que no podrá ser registrado como Solicitante.<br><br><b>Objeción:</b> ' + datos['strobjecion'] + '<br><b>Institución donde debe solventar la objeción:</b> '+ datos['mensaje']+'.');
                                      $('#cedula').val('');return false;
                                    } else{
                                        if(datos['cedula'] == 'noencuentra'){
                                        bootbox.alert ('El número de Cédula no existe');
                                        $('.cargar').hide();
                                        $('#cedula').val(''); return false;
                                        }else{
                                            $('#nombres_evaluado').val(datos['nombres_evaluado']);
                                            $('#apellidos_evaluado').val(datos['apellidos_evaluado']);   
                                            $('#cargo_evaluado').val(datos['cargo_evaluado']);
                                            $('#dirg').val(datos['dirg']);
                                            $('#oficina_evaluado').val(datos['oficina_evaluado']);
                                            $('#dirl').val(datos['dirl']);
                                            $('#desp').val(datos['desp']);  
                                            $('#id_persona_evaluado').val(datos['id_persona_evaluado']);   
                                            
                                        }
                                    }
                                },
                            })                                                   
    });
");
?>

<?php if (Yii::app()->user->hasFlash('error')): ?>
    <div class="info">
        <?php
        $this->widget('booster.widgets.TbAlert', array(
            'block' => true, // display a larger alert block?
            'fade' => true, // use transitions?
            'closeText' => '&times;', // close link text - if set to false, no close link is displayed
            'alerts' => array(// configurations per alert type
                'error' => array('block' => true, 'fade' => true, 'closeText' => '&times;'), // success, info, warning, error or danger
            ),
        ));
        ?>
    </div>
<?php endif; ?>

<div style="margin-left: auto;margin-right: auto;table-layout: auto;display: table;width: 100%;">

    <div style="text-align: left; vertical-align: top;display: table-cell;float:left;">

        <h3><?php echo ucwords(CrugeTranslator::t("crear nuevo usuario")); ?></h3>
    </div>

</div>

<?php
$this->widget('booster.widgets.TbBreadcrumbs', array(
    'links' => array(
        'Inicio' => $this->createUrl('/site/Bienvenido'),
        'Listados Usuarios' => $this->createUrl('/cruge/ui/DesactivarUsuarios'),
        'Crear Usuario', //=> $this->createUrl('create'),
    ),
    'homeLink' => false,
));
//$cs = Yii::app()->clientScript;
//$cs->registerScriptFile( $theme->getBaseUrl() . '/js/highlight.js' );
?>

<div class="form">
    <?php
    $form = $this->beginWidget('CActiveForm', array(
        'id' => 'crugestoreduser-form',
        'enableAjaxValidation' => false,
        'enableClientValidation' => false,
    ));
    ?>
     
    <input  type="hidden" required="required" class="numeros" id="id_persona_evaluado"  name="id_persona"  maxlength="3"  readonly="readonly"  >

    <div class="row form-group">
        <div class="col" >
            <?php echo $form->labelEx($model, 'username'); ?>
            <?php echo $form->textField($model, 'username', array('required' => 'required')); ?>
            <?php echo $form->error($model, 'username'); ?>
        </div>
        <div class="col">
            <?php echo $form->labelEx($model, 'email'); ?>
            <?php echo $form->textField($model, 'email', array('required' => 'required')); ?>
            <?php echo $form->error($model, 'email'); ?>
        </div>
        <?php  
         $rol = Yii::app()->db->createCommand('select itemname from cruge_authassignment where userid = ' . Yii::app()->user->id)->queryAll();
            $rol = (object) $rol[0];
            $roll = $rol->itemname;
        
        if ($roll == 'administrador_tecnologia' ||$roll == 'administrador_sistema' || $roll == 'administrador_mrl' ) { ?>

            <div class="col">

                <label class="required">Roles<span class="required">*</span></label>
                <?php
                $rbac = Yii::app()->user->rbac;

                $listaRolesAsignados = $rbac->roles;
                ?>

                <select name="rol_name" id="rol_name">

                    
                    <?php foreach ($listaRolesAsignados as $dato) { 
                      if (($roll != 'administrador_tecnologia') && (($dato->name == 'administrador_tecnologia')|| ($dato->name == 'usuario_general')|| ($dato->name == 'super_administrador') || ($dato->name == 'administrador_actualizacion')|| ($dato->name == 'administrador_tecnologia')||($dato->name == 'administrador_sistema'))) {
                     
                          ?>                       
                                    
                                   
                                    <?php
                                }else{?>

                        <option value='<?php echo $dato->name; ?>'><?php echo $dato->name; ?></option>

                    <?php } } ?>

                </select>

            </div>
        <?php } else { ?>

            <div class="col">

                <label class="required">Roles<span class="required">*</span></label>
                <?php
                $rbac = Yii::app()->user->rbac;

                $listaRolesAsignados = $rbac->getAuthAssignments(Yii::app()->user->id);
                ?>

                <select name="rol_name" id="rol_name">

                    <?php
                    foreach ($rbac->roles as $rol) {
                        foreach ($listaRolesAsignados as $ra) {
                            if ($ra->itemName === $rol->name) {
                                if ($rol->name == 'Coordinador') {
                                    ?>                       
                                    <option value='Coordinador'>Coordinador</option>
                                    <option value='Coordinador'>Coordinador</option>
                                    <?php
                                }
                            }
                        }
                    }
                    ?>

                </select>

            </div>   

        <?php } ?>   



        <div class="col numeric">

            <label class="required">Cédula<span class="required">*</span></label>
        <select id="nacionalidad"  name="nacionalidad" style="width: 50px;"> 
                <option selected="selected" value="2">V</option>
                <option value="3">E</option>
            </select>
            <input type="text" required="required" class="numeros" id="cedula" name="cedula" maxlength="8" style="width: 100px;">
        </div>

        <div class="col">
            <label class="required">Nombre(s)<span class="required">*</span></label>
            <input type="text" required="required" class="numeros" id="nombres_evaluado" name="nombres_evaluado" maxlength="50" readonly="readonly"  style="width: 130%;">
        
       

        
        
        </div>

        <div class="col">
            <label class="required">Apellido(s)<span class="required">*</span></label>
            <input type="text" required="required" class="numeros" id="apellidos_evaluado" name="apellidos_evaluado" maxlength="50" readonly="readonly" style="width: 130%;">
        </div>

        <div class="col">
            <label class="">Cargo</label>
            <input type="text" required="required" class="numeros" id="cargo_evaluado" name="cargo_evaluado" readonly="readonly" style="width: 500px;">
        </div>        <!--        <div class="col">
                    <label class="required">Institución<span class="required">*</span></label>
                    <select type="text" required="true" class="numeros" id="inst" name="institucion" >
        <?php // foreach ($list as $dato) { ?>
                            <option value='<?php // echo $dato['idmain'];    ?>'><?php // echo $dato['detail'];    ?></option>
        <?php // } ?>
                    </select>
                </div>-->
<!--        <div class="col">
            <label class="">Viceministerio o Despacho</label>
            <input type="text" required="required" class="numeros" id="desp" name="direccion" readonly="readonly" style="width: 700px;">
        </div>
        
        <div class="col">
            <label class="">Dirección de General</label>
            <input type="text" required="required" class="numeros" id="dirg" name="direccion" readonly="readonly" style="width: 700px;">
        </div>
        
        <div class="col">
            <label class="">Dirección de Linea</label>
            <input type="text" required="required" class="numeros" id="dirl" name="direccion" readonly="readonly" style="width: 700px;">
        </div>-->

        <div class="col">
            <label class="">Coordinación o Área</label>
            <input type="text" required="required" class="numeros" id="oficina_evaluado" name="oficina_evaluado" readonly="readonly" style="width: 700px;">
        </div>
        
        <div class="col">
            <?php echo $form->labelEx($model, 'newPassword'); ?>
            <?php echo $form->textField($model, 'newPassword', array('required' => 'required')); ?>
            <?php echo $form->error($model, 'newPassword'); ?>

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
                    CrugeTranslator::t("Generar clave")
                    , Yii::app()->user->ui->ajaxGenerateNewPasswordUrl
                    , array('success' => 'js:fnSuccess', 'error' => 'js:fnError'), array('class' => 'btn btn-small btn-danger'));
            ?>

        </div>

<?php 
	if(count($model->getFields()) > 0){
		echo "<div class='row form-group'>";
		echo "<h6>".ucfirst(CrugeTranslator::t("perfil"))."</h6>";
		foreach($model->getFields() as $f){
			// aqui $f es una instancia que implementa a: ICrugeField
			echo "<div class='col'>";
			echo Yii::app()->user->um->getLabelField($f);
			echo Yii::app()->user->um->getInputField($model,$f);
			echo $form->error($model,$f->fieldname);
			echo "</div>";
		}
		echo "</div>";
	}
?>
    </div>


    <div class="row form-group">
        <div class="row buttons">
            <div style="float:right">
                <?php //Yii::app()->user->ui->tbutton("Crear Usuario");    ?>
                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'context' => 'primary',
                    'label' => 'Crear Usuario',
                    'icon' => 'icon-ok-sign icon-white',
                    'size' => 'medium',
                ));
                ?>

                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'reset',
                    'context' => 'success',
                    'label' => 'Limpiar',
                    'size' => 'medium',
                    'icon' => 'icon-remove',
                        //'id' => 'GuardarForm'
                ));
                ?>
                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'context' => 'danger',
                    'label' => 'Cancelar',
                    'size' => 'medium',
                    'id' => 'CancelarForm',
                    'icon' => 'icon-ban-circle',
                    'htmlOptions' => array(
                        'onclick' => 'window.history.back();'
                    )
                ));
                ?>
            </div>
        </div>

    </div>


    <?php $this->endWidget(); ?>
</div>

<?php echo $form->errorSummary($model); ?>
<?php // $this->endWidget();    ?>
</div>