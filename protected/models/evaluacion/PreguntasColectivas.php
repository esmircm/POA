<?php

/**
 * This is the model class for table "evaluacion.preguntas_colectivas".
 *
 * The followings are the available columns in table 'evaluacion.preguntas_colectivas':
 * @property integer $id_preguntas_colect
 * @property integer $fk_pregunta
 * @property integer $fk_tipo_clase
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
 * @property Preguntas $fkPregunta
 * @property Maestro $fkRango
 * @property Maestro $fkTipoClase
 */
class PreguntasColectivas extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.preguntas_colectivas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_pregunta, fk_tipo_clase, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_date, modified_date, created_by', 'required'),
			array('fk_pregunta, fk_tipo_clase, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_preguntas_colect, fk_pregunta, fk_tipo_clase, peso, fk_rango, subtotal_peso, fk_evaluacion, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on'=>'search'),
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
			'fkPregunta' => array(self::BELONGS_TO, 'Preguntas', 'fk_pregunta'),
			'fkRango' => array(self::BELONGS_TO, 'Maestro', 'fk_rango'),
			'fkTipoClase' => array(self::BELONGS_TO, 'Maestro', 'fk_tipo_clase'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_preguntas_colect' => 'Id Preguntas Colect',
			'fk_pregunta' => 'Fk Pregunta',
			'fk_tipo_clase' => 'Fk Tipo Clase',
			'peso' => 'Peso',
			'fk_rango' => 'Fk Rango',
			'subtotal_peso' => 'Subtotal Peso',
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

		$criteria->compare('id_preguntas_colect',$this->id_preguntas_colect);
		$criteria->compare('fk_pregunta',$this->fk_pregunta);
		$criteria->compare('fk_tipo_clase',$this->fk_tipo_clase);
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

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return PreguntasColectivas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
