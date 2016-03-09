<div class="row">
    <div class='col-md-12'>
        <?php
        
        
// $sql = "select id_evaluacion from evaluacion.vsw_pdf_objetivos where fk_estatus_evaluacion = 48";


//        $connection = Yii::app()->db;
//        $command = $connection->createCommand($sql);
//        $row = $command->queryAll();
//        
//        $idevaluacion = $row[0]["id_evaluacion"];
//        $idestatus = $row[0]["fk_estatus_evaluacion"];
//        var_dump($id_evaluacion);die;
//        $obj = VswPdfObjetivos::model()->findByAttributes(array('fk_estatus_evaluacion' => $idestatus));
  
        
      //  var_dump($obj);die;
        $this->widget(
            'booster.widgets.TbExtendedGridView', array(
            'type' => 'striped bordered',
            'responsiveTable' => false,
            'id' => 'objetivos',
           'dataProvider' => new CActiveDataProvider('VswPdfObjetivos', array(
        'criteria' => array(
            'condition' => 'id_evaluacion = '.$id_evaluacion, 
        ),
        'pagination' => false,
            )),
            'columns' => array(
                array(
                    'name' => 'objetivo',
                    'value' => '$data->objetivo',
                ),
                array(
                    'name' => 'peso',
                    'value' => '$data->peso',
                ),
            ),
            'extendedSummary' => array(
                'title' => 'Total',
// 'id' => 'total',
// 'class' => 'suma_peso',
                'columns' => array(
                    'peso' => array('label' => 'Peso', 'class' => 'TbSumOperation')
                )
            ),
            'extendedSummaryOptions' => array(
                'class' => 'well pull-right',
                'style' => 'width:300px'
            ),
                )
        );
        ?>
    </div>
</div>
</div>





