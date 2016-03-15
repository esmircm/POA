<?php

/**
 * This is the model class for table "evaluacion.preguntas".
 *
 * The followings are the available columns in table 'evaluacion.preguntas':
 * @property integer $id_pregunta
 * @property string $pregunta
 * @property integer $fk_tipo_clase
 * @property string $pregunta_padre
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property PreguntasObrero[] $preguntasObreros
 * @property Maestro $fkEstatus
 * @property Maestro $fkTipoClase
 * @property PreguntasColectivas[] $preguntasColectivases
 */
class Preguntas extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.preguntas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_estatus, created_date, modified_date, created_by', 'required'),
			array('fk_tipo_clase, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('pregunta', 'length', 'max'=>300),
			array('pregunta_padre, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_pregunta, pregunta, fk_tipo_clase, pregunta_padre, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on'=>'search'),
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
			'preguntasObreros' => array(self::HAS_MANY, 'PreguntasObrero', 'fk_pregunta'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkTipoClase' => array(self::BELONGS_TO, 'Maestro', 'fk_tipo_clase'),
			'preguntasColectivases' => array(self::HAS_MANY, 'PreguntasColectivas', 'fk_pregunta'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_pregunta' => 'Id Pregunta',
			'pregunta' => 'Pregunta',
			'fk_tipo_clase' => 'Fk Tipo Clase',
			'pregunta_padre' => 'Pregunta Padre',
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

		$criteria->compare('id_pregunta',$this->id_pregunta);
		$criteria->compare('pregunta',$this->pregunta,true);
		$criteria->compare('fk_tipo_clase',$this->fk_tipo_clase);
		$criteria->compare('pregunta_padre',$this->pregunta_padre,true);
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
	 * @return Preguntas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
