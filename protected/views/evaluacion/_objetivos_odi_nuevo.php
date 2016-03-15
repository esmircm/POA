

<div class="row">
    <div class='col-md-12'>
           <table id='objetivosMRL' class="table table-bordered" style="text-align:center;">
            <tr>  
                <td> Objetivos  </td>
                <td> Peso </td>
                <td> Acci&oacute;n </td>
            </tr>
            
        
        <?php 
//        echo '<pre>';var_dump($model);die;
        $peso=0;
        $objetivo=0;
        if (isset($id_evaluacion)){ 
            echo $form->hiddenField($evaluacion, 'id_evaluacion',array('value' =>$id_evaluacion )); 
            
            $i = 0;
$sql = 'SELECT id_evaluacion, id_preguntas_ind, objetivo, peso FROM evaluacion.vsw_pdf_objetivos
WHERE id_evaluacion =' . $id_evaluacion;

$connection = Yii::app()->db;
$command = $connection->createCommand($sql);
$preind = $command->queryAll();

$val = count($preind);

            while ($i < $val) {  
                ?>
            <tr>  
                <td style="text-align: center"> <?php  echo  $preind[$i]["objetivo"]  ?> </td>
                <td style="text-align: center"> <?php  echo  $preind[$i]["peso"]  ?> </td>
                 <td style="text-align: center"> <img src="<?= Yii::app()->request->baseUrl ?>/img/bmenoo.png" onclick="eliminar_obj(this, '<?php  echo $preind[$i]["id_preguntas_ind"] ?> ',' <?php  echo $preind[$i]["peso"] ?>')" /></td>
            </tr>
            
        
        <?php  $peso=$peso+$preind[$i]["peso"];
        $i++; 
        
            }
            
          $objetivo=$i;
        } else{
            echo $form->hiddenField($evaluacion, 'id_evaluacion'); 
        } 
//  var_dump($i);die;
        ?>
        </table>
        
    </div>
    <!--hiddenFiel-->
     <?php echo $form->hiddenField($vista, 'total_objetivos', array('value' =>$objetivo )); ?>
</div>


<div class="row">
    <div class='col-md-12' >
        <table>
            <tr>  
                <td> 
                    
                </td>
                <td> Total Peso
                    <?php echo $form->textField($vista, 'total_peso', array('style' => 'border:0', 'value' =>$peso, 'readOnly' => true)); 

                    echo 'La suma total del peso debe ser hasta 50';
                    ?>
        
                </td>
                <td>
                    
                </td>
                
   
            </tr>
            
        </table>
         
    </div>
    
</div>
