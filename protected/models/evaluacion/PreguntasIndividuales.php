<?php

/**
 * This is the model class for table "evaluacion.preguntas_individuales".
 *
 * The followings are the available columns in table 'evaluacion.preguntas_individuales':
 * @property integer $id_preguntas_ind
 * @property string $objetivo
 * @property integer $peso
 * @property integer $fk_rango
 * @property integer $subtotal_peso
 * @property integer $fk_evaluacion
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Maestro $fkEstatus
 * @property Evaluacion $fkEvaluacion
 * @property Maestro $fkRango
 */
class PreguntasIndividuales extends CActiveRecord
{
    public $objetivos_0;
    public $objetivos_1;
    /**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.preguntas_individuales';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_rango, subtotal_peso, fk_evaluacion, created_date, modified_date, created_by, es_activo', 'required'),
			array('peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('objetivo, objetivos_0, objetivos_1', 'length', 'max'=>300),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_preguntas_ind, objetivo, objetivos_0, objetivos_1, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkEvaluacion' => array(self::BELONGS_TO, 'Evaluacion', 'fk_evaluacion'),
			'fkRango' => array(self::BELONGS_TO, 'Maestro', 'fk_rango'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_preguntas_ind' => 'Id Preguntas Ind',
			'objetivo' => 'Objetivo de Desempeño Indivivual',
			'peso' => 'Peso',
			'fk_rango' => 'Rangos',
			'subtotal_peso' => 'Peso x Rango',
			'fk_evaluacion' => 'Fk Evaluacion',
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
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_preguntas_ind',$this->id_preguntas_ind);
		$criteria->compare('objetivo',$this->objetivo,true);
		$criteria->compare('peso',$this->peso);
		$criteria->compare('fk_rango',$this->fk_rango);
		$criteria->compare('subtotal_peso',$this->subtotal_peso);
		$criteria->compare('fk_evaluacion',$this->fk_evaluacion);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('es_activo',$this->es_activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        //Validación en el Admin para verificar cantidad de objetivos por evaluacion//
        public static function cantidad_objetivos($cadena) {
        $consulta = Yii::app()->db->createCommand()
                ->select('COUNT(fk_evaluacion)')
                ->from('evaluacion.preguntas_individuales')
                ->where('fk_evaluacion =' . $cadena . ' AND es_activo = TRUE')
                ->queryRow();
        
        $resultado = $consulta['count'];
        return $resultado;
        }
        
        //Validación en el Admin para verificar total del peso por evaluacion//
        public static function suma_peso($cadena) {
        $consulta = Yii::app()->db->createCommand()
                ->select('SUM(peso)')
                ->from('evaluacion.preguntas_individuales')
                ->where('fk_evaluacion =' . $cadena . ' AND es_activo = TRUE')
                ->queryRow();
        $resultado = $consulta['sum'];
        return $resultado;
        }

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return PreguntasIndividuales the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
