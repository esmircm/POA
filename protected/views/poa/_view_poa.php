<h3 class="text-danger text-center">Plan Operativo Anual</h3>
<hr style="width: 100%; height: 1px; background-color: #000;">
<div class='row'>
    <div class="panel panel-default responsive">
        <div class="panel-body responsive">

            <!--<blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">-->

            <div class="aparecer">
                <div class='col-md-12' style="text-align: center">
                    Nombre: <b> <?php echo $model->nombre; ?> </b> 
                </div>
                    
                <div style="display:none">
                <?php echo $form->textAreaGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => '')))); ?>
                </div>

                <!--</blockquote>-->
            </div>
        </div>
    </div>
</div>
<?php
if ($model->fk_tipo_poa == 70) {
    ?>
    <div class='row'>
        <div class="panel panel-default responsive">
            <div class="panel-body responsive">
                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">

                    <div class="aparecer">        
                        <div class='col-md-6' style="text-align: center">
                            Fecha Inicio: <b> <?php echo $model->fecha_inicio; ?> </b>    
                        </div>
                        
                <div style="display:none">
                        <?php echo $form->textFieldGroup($model,'fecha_inicio',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
                    </div>
                    </div>
                    <div class="aparecer">
                        <div class='col-md-6' style="text-align: center">
                            Fecha Final: <b> <?php echo $model->fecha_final; ?> </b>    
                        </div>
                <div style="display:none">
                        <?php echo $form->textFieldGroup($model,'fecha_final',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
                    </div>
                    </div>

                </blockquote>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class="panel panel-default responsive">
            <div class="panel-body responsive">

                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">        
                    <div class="aparecer">    
                        <div class='col-md-12' style="text-align: center; height: 35px;  " >
                            <b> Objetivo Historico</b>  
                        </div>
                    </div>
                        

                    <div class="aparecer">    
                        <div class='col-md-12' style="text-align: justify; height: 100px;">
                            <?php echo $model->obj_historico; ?>    
                        </div>
                        <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'obj_historico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                    <div class="aparecer">    
                        <div class='col-md-12' style="text-align: center; height: 35px; " >
                            <b> Objetivo Nacional</b>  
                        </div>
                    </div>
                        

                    <div class="aparecer">    
                        <div class='col-md-12' style="text-align: justify; height: 100px;">
                            <?php echo $model->obj_nacional; ?>    
                        </div>
                        <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'obj_nacional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                    <div class="aparecer">    
                        <div class='col-md-12' style="text-align: center; height: 35px; " >
                            <b> Objetivo Estrategico</b>  
                        </div>
                    </div>
                        

                    <div class="aparecer">
                        <div class='col-md-12' style="text-align: justify; height: 100px;">
                            <?php echo $model->obj_estrategico; ?>    
                        </div>
                        <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'obj_estrategico',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                    <div class="aparecer">
                        <div class='col-md-12' style="text-align: center; height: 35px; " >
                            <b> Objetivo General</b>  
                        </div>
                    </div>
                        

                    <div class="aparecer">
                        <div class='col-md-12' style="text-align: justify; height: 100px;">
                            <?php echo $model->obj_general; ?>    
                        </div>
                        <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'obj_general',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                    <div class="aparecer">
                        <div class='col-md-12' style="text-align: center; height: 35px; " >
                            <b> Objetivo Institucional</b>  
                        </div>
                        
                    </div>

                    <div class="aparecer">
                        <div class='col-md-12' style="text-align: justify; height: 100px;">
                            <?php echo $model->obj_institucional; ?>    
                        </div>
                        <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'obj_institucional',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                </blockquote>
            </div>
        </div>
    </div>
    <div class='row'>
        <div class="panel panel-default responsive">
            <div class="panel-body responsive">

                <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">

                    <div class="aparecer">
                        <div class='col-md-6'>
                            Unidad Medida: <b> <?php echo $model->unidad_medida; ?> </b>  
                        </div>
                        <div style="display:none">
                        <?php echo $form->textFieldGroup($model, 'unidad_medida', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));?>
                    </div>
                    </div>

                    <div class="aparecer">
                        <div class='col-md-6'>
                            Cantidad: <b> <?php echo $model->cantidad; ?> </b>  
                        </div>
                        <div style="display:none">
                        <?php 
        echo $form->textFieldGroup($model, 'cantidad', array('widgetOptions' => array('htmlOptions' => array('class' => 'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center'))));
        ?>
                    </div>
                    </div>


                </blockquote>        
            </div>
        </div>
    </div>
    <?php
}
?>
<div class='row'>
    <div class="panel panel-default responsive">
        <div class="panel-body responsive">

            <blockquote style="border-left: 5px solid #1fb5ad !important;font-size: 15px;">

                <div class="aparecer"data-move-y="200px" data-move-x="-100px">  
                    <div class='col-md-12'>
                        Descripcion: <b> <?php echo $model->descripcion; ?> </b>  
                    </div>
                    <div style="display:none">
                        <?php echo $form->textAreaGroup($model,'descripcion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5', 'readOnly' => true, 'style' => 'background: transparent; border: none; box-shadow: none; text-align: center')))); ?>
                    </div>
                </div>

            </blockquote>
        </div>
    </div>
</div>
