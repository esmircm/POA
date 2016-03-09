<?php

/**
 * This is the model class for table "evaluacion.estatus_evaluacion".
 *
 * The followings are the available columns in table 'evaluacion.estatus_evaluacion':
 * @property integer $id_estatus_evaluacion
 * @property integer $fk_evaluacion
 * @property integer $fk_tipo_entidad
 * @property integer $fk_entidad
 * @property integer $fk_estatus_evaluacion
 * @property string $fecha_estatus
 * @property integer $created_by
 * @property integer $modified_by
 * @property string $created_date
 * @property string $modified_date
 * @property integer $fk_estatus
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Maestro $fkEstatus
 * @property Maestro $fkEstatusEvaluacion
 * @property Evaluacion $fkEvaluacion
 * @property Maestro $fkTipoEntidad
 * @property Persona $fkEntidad
 */
class EstatusEvaluacion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.estatus_evaluacion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fecha_estatus, fk_estatus_evaluacion, created_by, created_date, fk_estatus', 'required'),
			array('fk_evaluacion, fk_tipo_entidad, fk_entidad, fk_estatus_evaluacion, created_by, modified_by, fk_estatus', 'numerical', 'integerOnly'=>true),
			array('modified_date, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_estatus_evaluacion, fk_evaluacion, fk_tipo_entidad, fk_entidad, fk_estatus_evaluacion, fecha_estatus, created_by, modified_by, created_date, modified_date, fk_estatus, es_activo', 'safe', 'on'=>'search'),
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
			'fkEstatusEvaluacion' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus_evaluacion'),
			'fkEvaluacion' => array(self::BELONGS_TO, 'Evaluacion', 'fk_evaluacion'),
			'fkTipoEntidad' => array(self::BELONGS_TO, 'Maestro', 'fk_tipo_entidad'),
			'fkEntidad' => array(self::BELONGS_TO, 'Persona', 'fk_entidad'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_estatus_evaluacion' => 'Id Estatus Evaluacion',
			'fk_evaluacion' => 'Fk Evaluacion',
			'fk_tipo_entidad' => 'Fk Tipo Entidad',
			'fk_entidad' => 'Fk Entidad',
			'fk_estatus_evaluacion' => 'Estatus de la Evaluacion',
			'fecha_estatus' => 'Fecha Estatus',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'fk_estatus' => 'Fk Estatus',
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

		$criteria->compare('id_estatus_evaluacion',$this->id_estatus_evaluacion);
		$criteria->compare('fk_evaluacion',$this->fk_evaluacion);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);
		$criteria->compare('fk_entidad',$this->fk_entidad);
		$criteria->compare('fk_estatus_evaluacion',$this->fk_estatus_evaluacion);
		$criteria->compare('fecha_estatus',$this->fecha_estatus,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('es_activo',$this->es_activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return EstatusEvaluacion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
