
<?php
$baseUrl = Yii::app()->baseUrl;
$numeros = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/js_jquery.numeric.js');
$Validaciones = Yii::app()->getClientScript()->registerScriptFile($baseUrl . '/js/validacion.js');

$form = $this->beginWidget('booster.widgets.TbActiveForm', array(
    'id' => 'datos-requisicion-form',
    'enableAjaxValidation' => false,
    'enableClientValidation' => true,
    'clientOptions' => array(
        'validateOnSubmit' => true,
        'validateOnChange' => true,
        'validateOnType' => true,
    ),
        ));
?>

<?php
$this->breadcrumbs = array(
    'Datos Requisicions' => array('index'),
    'Create',
);

$this->menu = array(
    array('label' => 'List DatosRequisicion', 'url' => array('index')),
    array('label' => 'Manage DatosRequisicion', 'url' => array('admin')),
);
?>



<div class="span-20">
    <?php
    $this->widget(
            'booster.widgets.TbPanel', array(
        'title' => 'Tipo Requisición',
        'context' => 'danger',
        'headerIcon' => 'th-list',
        'content' => $this->renderPartial('tipo_requisicion', array('form' => $form, 'numero' => $numero), TRUE),
            )
    );
    ?>

</div>

<div class='soli'  style="display: none">
    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Requisición',
            'context' => 'primary',
            'headerIcon' => 'th-list',
            'content' => $this->renderPartial('_requisicion', array('form' => $form, 'model' => $model), TRUE),
                )
        );
//        $this->widget(
//                'booster.widgets.TbPanel', array(
//            'title' => 'Requisición',
//            'context' => 'primary',
//            'headerIcon' => 'th-list',
//            'content' => $this->renderPartial('_requisicion', array('form' => $form, 'model' => $model), TRUE),
//                )
//        );
        ?>

    </div>

    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Lugar Entrega',
            'context' => 'primary',
            'headerIcon' => 'th-list',
            'content' => $this->renderPartial('lugar_entrega', array('lugar' => $lugar, 'form' => $form), TRUE),
                )
        );
        ?>

    </div>
    <div class='ordi'>
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Ordinario',
            'context' => 'primary',
            'headerIcon' => 'th-list',
            'content' => $this->renderPartial('pedido', array('pedido' => $pedido, 'form' => $form), TRUE),
                )
        );
        ?>

    </div>    

    <div class='espe'  style="display: none">

        <div class="span-20">
            <?php
            $this->widget(
                    'booster.widgets.TbPanel', array(
                'title' => 'Especial',
                'context' => 'primary',
                'headerIcon' => 'th-list',
                'content' => $this->renderPartial('pedido_especial', array('pedido_especial' => $pedido_especial, 'form' => $form), TRUE),
                    )
            );
            ?>

        </div>
    </div>


    <div class="span-20">
        <?php
        $this->widget(
                'booster.widgets.TbPanel', array(
            'title' => 'Observacion',
            'context' => 'primary',
            'headerIcon' => 'th-list',
            'content' => $this->renderPartial('observacion', array('observacion' => $observacion, 'form' => $form), TRUE),
                )
        );
        ?>

    </div>



    <div class="well">
        <div class="row">

            <div class="pull-right">


                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'reset',
                    'context' => 'success',
                    'size' => 'large',
                    'label' => 'Limpiar',
                    'htmlOptions' => array(
                        'onclick' => 'telfCheck(this.id,codigo);',
                    ),
                ));
                ?>
            </div>

            <div class="pull-right">
                <?php
                $this->widget('booster.widgets.TbButton', array(
                    'buttonType' => 'submit',
                    'icon' => 'glyphicon glyphicon-remove',
                    'context' => 'primary',
                    'size' => 'large',
                    //'label' => $model->isNewRecord ? 'Siguiente' : 'Guardar Actualización',
                    'label' => $model->isNewRecord ? 'Siguiente' : 'Guardar Actualización',
                ));
                ?>
            </div>
        </div>
    </div>

</div>


<?php $this->endWidget(); ?>