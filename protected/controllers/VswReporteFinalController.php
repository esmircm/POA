<?php

class VswReporteFinalController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
public $layout='//layouts/column2';

/**
* @return array action filters
*/
public function filters()
{
return array(
'accessControl', // perform access control for CRUD operations
);
}

/**
* Specifies the access control rules.
* This method is used by the 'accessControl' filter.
* @return array access control rules
*/
public function accessRules()
{
return array(
array('allow',  // allow all users to perform 'index' and 'view' actions
'actions'=>array('index','view',),
'users'=>array('*'),
),
array('allow', // allow authenticated user to perform 'create' and 'update' actions
'actions'=>array('create','update','reporte','certificado', 'exel'),
'users'=>array('@'),
),
array('allow', // allow admin user to perform 'admin' and 'delete' actions
'actions'=>array('admin','delete'),
'users'=>array('admin'),
),
array('deny',  // deny all users
'users'=>array('*'),
),
);
}

/**
* Displays a particular model.
* @param integer $id the ID of the model to be displayed
*/
public function actionView($id)
{
$this->render('view',array(
'model'=>$this->loadModel($id),
));
}

/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/

public function actionReporte()
{
$model=new VswReporteFinal;

// Uncomment the following line if AJAX validation is needed
// $this->performAjaxValidation($model);

if(isset($_POST['VswReporteFinal']))
{
$model->attributes=$_POST['VswReporteFinal'];
if($model->save())
$this->redirect(array('view','id'=>$model->id_persona_evaluado));
}

$this->render('reporte',array(
'model'=>$model,
));
}

public function actionCertificado() {
        $sql = 'select sec.* from evaluacion.vsw_reporte_final sec limit 611';
        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();

        $html='<table class = "tg">
        <tr class = "principal">
        <td class = "principal" width = "1%">&nbsp;
        Cedula</td>
        <td class = "principal" width = "1%">&nbsp;
        Nombres</td>
        <td class = "principal" width = "1%">&nbsp;
        Apellidos</td>
        <td class = "principal" width = "1%">&nbsp;
        Cargo</td>       
        <td class = "principal" width = "1%">&nbsp;
        Oficina</td> 
        <td class = "principal" width = "1%">&nbsp;
        Estatus</td>
        </tr>';
        $i = 0;
        $val = count($row);

        while ($i < $val) {
            //var_dump($row[$i]["id_persona_evaluado"]);
            $html.='
            <tr class="tg">
                <td class="tg" width="1%">&nbsp;' . $row[$i]["cedula"] . '</td>
                <td class="tg" width="1%">&nbsp;' . $row[$i]["apellidos"] . '</td>
                <td class="tg" width="1%">&nbsp;' . $row[$i]["nombres"] . '</td>
                <td class="tg" width="1%">&nbsp;' . $row[$i]["descripcion_cargo"] . '</td>
                <td class="tg" width="1%">&nbsp;' . $row[$i]["dependencia"] . '</td>
                <td class="tg" width="2%">&nbsp;' . $row[$i]["estatus"] . '</td>
          
            ';
            $html.='</tr>';
            $i++;
        }

        $html.='</table>';

//        echo '<pre>';
//        var_dump($row);die;


        $this->render('certificado', array('html1' => $html));
    }

    
    
    public function actionExel() {
        Yii::import('ext.phpexcel.XPHPExcel');
        $objPHPExcel = XPHPExcel::createPHPExcel();
        //$objPHPExcel = new PHPExcel;


        $objDrawingPType = new PHPExcel_Worksheet_Drawing();
        $objDrawingPType->setWorksheet($objPHPExcel->setActiveSheetIndex(0));
        $objDrawingPType->setName("Pareto By Type");
        $objDrawingPType->setPath(Yii::app()->basePath . DIRECTORY_SEPARATOR . "../img/minmujer.png");

        $objDrawingPType->setHeight(350);
        $objDrawingPType->setWidth(100);

        $objDrawingPType->setCoordinates('A1');
        $objDrawingPType->setOffsetX(10);
        $objDrawingPType->setOffsetY(5);
        //$objDrawingPType->setResizeProportional(true);


        $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
                ->setLastModifiedBy("Maarten Balliauw")
                ->setTitle("Office 2007 XLSX Test Document")
                ->setSubject("Office 2007 XLSX Test Document")
                ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Test result file");

        $sql = " select sec.* from evaluacion.vsw_pdf_reporte sec ";

        $connection = Yii::app()->db;
        $command = $connection->createCommand($sql);
        $row = $command->queryAll();

        $tituloStyle1 = new PHPExcel_Style();
        $tituloStyle1->applyFromArray(
                array(
                    'font' => array(
                        'bold' => true,
                    ),
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    ),
        ));

        $objPHPExcel->getActiveSheet()->SetCellValue("A2", 'Sistema de Calificación Laboral');
        $objPHPExcel->getActiveSheet()->mergeCells('A2:L2');
        $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A2:L2");

        $objPHPExcel->getActiveSheet()->SetCellValue("A3", 'listado del Resumen de los Evaluados');
        $objPHPExcel->getActiveSheet()->mergeCells('A3:L3');
        $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A3:L3");


        $objPHPExcel->getActiveSheet()->SetCellValue("A4", 'Generado el día: ' . date('d-m-Y') . ' a las ' . date('h:i') . ' por el usuario "' . Yii::app()->user->name . '"');
        $objPHPExcel->getActiveSheet()->mergeCells('A4:L4');
        $objPHPExcel->getActiveSheet()->setSharedStyle($tituloStyle1, "A4:L4");

        $objPHPExcel->getActiveSheet()->mergeCells('A1:L1');

        $objPHPExcel->getActiveSheet()->mergeCells('A5:L5');

        $sharedStyle1 = new PHPExcel_Style();
        $sharedStyle1->applyFromArray(
                array('fill' => array(
                        'type' => PHPExcel_Style_Fill::FILL_SOLID,
                        'color' => array('rgb' => '00BFFF')
                    ),
                    'font' => array(
                        'bold' => true,
                    ),
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    ),
                    'borders' => array(
                        'allborders' => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN,
                        ),
                    )
        ));
        $sharedStyle2 = new PHPExcel_Style();
        $sharedStyle2->applyFromArray(
                array('alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                    ),
                    'borders' => array(
                        'allborders' => array(
                            'style' => PHPExcel_Style_Border::BORDER_THIN,
                        ),
                    )
        ));

        $objPHPExcel->getActiveSheet()->setSharedStyle($sharedStyle1, "A6:I6");

        $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue('A6', 'Cedula')
                    ->setCellValue('B6', 'Nombres')
                    ->setCellValue('C6', 'Apellidos')
                    ->setCellValue('D6', 'Cargo')
                    ->setCellValue('E6', 'Oficina')
                    ->setCellValue('F6', 'Periodo')
                    ->setCellValue('G6', 'Objetivos')
                    ->setCellValue('H6', 'Peso')
                    ->setCellValue('I6', 'Estatus');

        $posicion = 7;
        $celdas = array("A", "B", "C", "D", "E", "F", "G", "H", "I");
        foreach ($row as $fila) {

        // Miscellaneous glyphs, UTF-8
            $objPHPExcel->setActiveSheetIndex(0)           
                        ->setCellValue('A' . $posicion, $fila['cedula_evaluado'])
                        ->setCellValue('B' . $posicion, $fila['nombres_evaluado'])
                        ->setCellValue('C' . $posicion, $fila['apellidos_evaluado'])
                        ->setCellValue('D' . $posicion, $fila['cargo_evaluado'])
                        ->setCellValue('E' . $posicion, $fila['oficina_evaluado'])
                        ->setCellValue('F' . $posicion, $fila['periodo_evaluacion'])
                        ->setCellValue('G' . $posicion, $fila['cant_objetivos'])
                        ->setCellValue('H' . $posicion, $fila['peso_total'])
                        ->setCellValue('I' . $posicion, $fila['estatus']);  
            $posicion ++;
        }

        $objPHPExcel->getActiveSheet()->getColumnDimension('A');
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setAutoSize(true);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setAutoSize(true);


// Rename worksheet
        $objPHPExcel->getActiveSheet()->setTitle('Simple');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $objPHPExcel->setActiveSheetIndex(0);


// Redirect output to a clientâ€™s web browser (Excel5)
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="Simcla.xls"');
        header('Cache-Control: max-age=0');
// If you're serving to IE 9, then the following may be needed
        header('Cache-Control: max-age=1');

// If you're serving to IE over SSL, then the following may be needed
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // always modified
        header('Cache-Control: cache, must-revalidate'); // HTTP/1.1
        header('Pragma: public'); // HTTP/1.0

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output');
        Yii::app()->end();
    }
    



//public function actionCreate()
//{
//$model=new VswReporteFinal;
//
//// Uncomment the following line if AJAX validation is needed
//// $this->performAjaxValidation($model);
//
//if(isset($_POST['VswReporteFinal']))
//{
//$model->attributes=$_POST['VswReporteFinal'];
//if($model->save())
//$this->redirect(array('view','id'=>$model->id_persona_evaluado));
//}
//
//$this->render('create',array(
//'model'=>$model,
//));
//}

/**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
public function actionUpdate($id)
{
$model=$this->loadModel($id);

// Uncomment the following line if AJAX validation is needed
// $this->performAjaxValidation($model);

if(isset($_POST['VswReporteFinal']))
{
$model->attributes=$_POST['VswReporteFinal'];
if($model->save())
$this->redirect(array('view','id'=>$model->id_persona_evaluado));
}

$this->render('update',array(
'model'=>$model,
));
}

/**
* Deletes a particular model.
* If deletion is successful, the browser will be redirected to the 'admin' page.
* @param integer $id the ID of the model to be deleted
*/
public function actionDelete($id)
{
if(Yii::app()->request->isPostRequest)
{
// we only allow deletion via POST request
$this->loadModel($id)->delete();

// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
if(!isset($_GET['ajax']))
$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
}
else
throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
}

/**
* Lists all models.
*/
public function actionIndex()
{
$dataProvider=new CActiveDataProvider('VswReporteFinal');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
$model=new VswReporteFinal('search');
$model->unsetAttributes();  // clear any default values
if(isset($_GET['VswReporteFinal']))
$model->attributes=$_GET['VswReporteFinal'];

$this->render('admin',array(
'model'=>$model,
));
}

/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=VswReporteFinal::model()->findByPk($id);
if($model===null)
throw new CHttpException(404,'The requested page does not exist.');
return $model;
}

/**
* Performs the AJAX validation.
* @param CModel the model to be validated
*/
protected function performAjaxValidation($model)
{
if(isset($_POST['ajax']) && $_POST['ajax']==='vsw-reporte-final-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
