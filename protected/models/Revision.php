<?php

/**
 * This is the model class for table "evaluacion.revision".
 *
 * The followings are the available columns in table 'evaluacion.revision':
 * @property integer $id_revision
 * @property integer $fk_revision
 * @property integer $fk_evaluador
 * @property integer $fk_evaluacion
 * @property string $fecha_revision
 * @property string $comentario
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Maestro $fkEstatus
 * @property Maestro $fkRevision
 * @property Persona $fkEvaluador
 * @property Evaluacion $fkEvaluacion
 */
class Revision extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'evaluacion.revision';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('fk_evaluacion, fecha_revision, created_date, modified_date, created_by', 'required'),
            array('fk_revision, fk_evaluador, fk_evaluacion, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('comentario', 'length', 'max' => 500),
            array('es_activo', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_revision, fk_revision, fk_evaluador, fk_evaluacion, fecha_revision, comentario, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
            'fkRevision' => array(self::BELONGS_TO, 'Maestro', 'fk_revision'),
            'fkEvaluador' => array(self::BELONGS_TO, 'Persona', 'fk_evaluador'),
            'fkEvaluacion' => array(self::BELONGS_TO, 'Evaluacion', 'fk_evaluacion'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_revision' => 'Id Revision',
            'fk_revision' => 'Periodo De Revision',
            'fk_evaluador' => 'clave foranea con referencia a persona, se almacena el id_persona',
            'fk_evaluacion' => 'Fk Evaluacion',
            'fecha_revision' => 'Fecha De Revision',
            'comentario' => 'Comentario',
            'fk_estatus' => 'Fk Estatus',
            'created_date' => 'Created Date',
            'modified_date' => 'Modified Date',
            'created_by' => 'Created By',
            'modified_by' => 'Modified By',
            'es_activo' => 'Es Activo',
        );
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     *
     * Typical usecase:
     * - Initialize the model fields with values from filter form.
     * - Execute this method to get CActiveDataProvider instance which will filter
     * models according to data in model fields.
     * - Pass data provider to CGridView, CListView or any similar widget.
     *
     * @return CActiveDataProvider the data provider that can return the models
     * based on the search/filter conditions.
     */
    public function search() {
        // @todo Please modify the following code to remove attributes that should not be searched.

        $criteria = new CDbCriteria;

       //$criteria->order = "modified_date ASC";
        $criteria->compare('id_revision', $this->id_revision);
        $criteria->compare('fk_revision', $this->fk_revision);
        $criteria->compare('fk_evaluador', $this->fk_evaluador);
        $criteria->compare('fk_evaluacion', $this->fk_evaluacion);
        $criteria->compare('fecha_revision', $this->fecha_revision, true);
        $criteria->compare('comentario', $this->comentario, true);
        $criteria->compare('fk_estatus', $this->fk_estatus);
        $criteria->compare('created_date', $this->created_date, true);
        $criteria->compare('modified_date', $this->modified_date, true);
        $criteria->compare('created_by', $this->created_by);
        $criteria->compare('modified_by', $this->modified_by);
        $criteria->compare('es_activo', $this->es_activo);
        $criteria->order = 'fecha_revision ASC';

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }
    
    //Validación en el Admin para verificar cantidad de revisiones por evaluacion//
    public static function validacion_revisiones1($cadena) {
        $validacion_revision = '';
        
        $existencia_revision = Yii::app()->db->createCommand()
                ->select('COUNT(fk_evaluacion)')
                ->from('evaluacion.revision')
                ->where('fk_evaluacion =' . $cadena)
                ->queryRow();
        
        if($existencia_revision['count']==1 || $existencia_revision['count']==2){
            $fecha_evaluacion = Yii::app()->db->createCommand()
                ->select('MAX(created_date)')
                ->from('evaluacion.revision')
                ->where('fk_evaluacion =' . $cadena )
                ->queryRow();

            $fecha_creado_evaluacion = explode("-", $fecha_evaluacion['max']);
            $fecha = date_create($fecha_evaluacion['max']);
            $fecha_tope = date_create(date('Y') . "-" . date('m') . "-" . date('d'));
//            $fecha_tope = date_create("2016-02-10");
//            $fecha_tope = date_create("2016-04-10");
            
            $validacion_fecha = date_diff($fecha_tope, $fecha);
            $validacion_dias = $validacion_fecha->format('%a');
            
//            var_dump($fecha);
//            var_dump($fecha_tope);
//            var_dump($validacion_dias);die;
            
            if($validacion_dias >= 60) {
                $validacion_revision = 1;
            }
            else {
                $validacion_revision = 0;
            }
        }
        
        if($existencia_revision['count']==0){
            $fecha_evaluacion = Yii::app()->db->createCommand()
                ->select('MAX(created_date)')
                ->from('evaluacion.estatus_evaluacion')
                ->where('fk_evaluacion =' . $cadena . ' AND fk_estatus_evaluacion = 49 OR fk_estatus_evaluacion = 51')
                ->queryRow();

            $fecha_creado_evaluacion = explode("-", $fecha_evaluacion['max']);
            $fecha = date_create($fecha_evaluacion['max']);
            $fecha_tope = date_create(date('Y') . "-" . date('m') . "-" . date('d'));
//            $fecha_tope = date_create("2016-02-10");
//            $fecha_tope = date_create("2016-04-10");
            
            $validacion_fecha = date_diff($fecha_tope, $fecha);
            $validacion_dias = $validacion_fecha->format('%a');
            
//            var_dump($fecha);
//            var_dump($fecha_tope);
//            var_dump($validacion_dias);die;
            
            if($validacion_dias >= 60) {
                $validacion_revision = 1;
            }
            else {
                $validacion_revision = 0;
            }
        }
        
        if($existencia_revision['count']==3){
            $validacion_revision = 1;
        }
        
        return $validacion_revision;
        }
        
    public static function validacion_revisiones2($cadena) {
        
        $validacion_revision = '';
        
        $existencia_revision = Yii::app()->db->createCommand()
                ->select('COUNT(fk_evaluacion)')
                ->from('evaluacion.revision')
                ->where('fk_evaluacion =' . $cadena)
                ->queryRow();
        
        if(($existencia_revision['count']==1) || ($existencia_revision['count']==2)){
            $fecha_evaluacion = Yii::app()->db->createCommand()
                ->select('MAX(created_date)')
                ->from('evaluacion.revision')
                ->where('fk_evaluacion =' . $cadena )
                ->queryRow();
            
            $fecha_creado_evaluacion = explode("-", $fecha_evaluacion['max']);
            $fecha = date_create($fecha_evaluacion['max']);
            $fecha_tope = date_create(date('Y') . "-" . date('m') . "-" . date('d'));
//            $fecha_tope = date_create("2016-02-10");
//            $fecha_tope = date_create("2016-04-10");
            
            $validacion_fecha = date_diff($fecha_tope, $fecha);
            $validacion_dias = $validacion_fecha->format('%a');
            
//            var_dump($fecha);
//            var_dump($fecha_tope);
//            var_dump($validacion_dias);die;
            
            if($validacion_dias >= 60) {
                $validacion_revision = 1;
            }
            else {
                $validacion_revision = 0;
            }
        }
        
        if($existencia_revision['count']==0){
            $fecha_evaluacion = Yii::app()->db->createCommand()
                ->select('MAX(created_date)')
                ->from('evaluacion.estatus_evaluacion')
                ->where('fk_evaluacion =' . $cadena . ' AND fk_estatus_evaluacion = 49 OR fk_estatus_evaluacion = 51')
                ->queryRow();

            $fecha_creado_evaluacion = explode("-", $fecha_evaluacion['max']);
            $fecha = date_create($fecha_evaluacion['max']);
            $fecha_tope = date_create(date('Y') . "-" . date('m') . "-" . date('d'));
//            $fecha_tope = date_create("2016-02-10");
//            $fecha_tope = date_create("2016-04-10");
            
            $validacion_fecha = date_diff($fecha_tope, $fecha);
            $validacion_dias = $validacion_fecha->format('%a');
            
//            var_dump($fecha);
//            var_dump($fecha_tope);
//            var_dump($validacion_dias);die;
            
            if($validacion_dias >= 60) {
                $validacion_revision = 1;
            }
            else {
                $validacion_revision = 0;
            }
        }
        
        if($existencia_revision['count']==3){
            $validacion_revision = 0;
        }
        
        return $validacion_revision;
        }
    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Revision the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

    //BUSQUEDA DE REGISTRO POR ID DE ORGANIZACION
    public function byConsulta_revision($idrevision) {
        $criteria = new CDbCriteria;
        $criteria->addColumnCondition(array('id_revision' => $idrevision));
        $criteria->order = 'fecha_revision ASC';
        $data = self::model()->findAll($criteria);
        return $data;
    }

}

