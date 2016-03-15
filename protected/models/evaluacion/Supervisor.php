<?php

/**
 * This is the model class for table "evaluacion.supervisor".
 *
 * The followings are the available columns in table 'evaluacion.supervisor':
 * @property integer $id_supervisor
 * @property integer $fk_persona
 * @property string $cargo
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Evaluador[] $evaluadors
 * @property Maestro $fkEstatus
 * @property Persona $fkPersona
 */
class Supervisor extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.supervisor';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_persona, cargo, fk_estatus, created_date, modified_date, created_by, es_activo', 'required'),
			array('fk_persona, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('cargo', 'length', 'max'=>100),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_supervisor, fk_persona, cargo, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on'=>'search'),
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
			'evaluadors' => array(self::HAS_MANY, 'Evaluador', 'fk_supervisor'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkPersona' => array(self::BELONGS_TO, 'Persona', 'fk_persona'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_supervisor' => 'Id Supervisor',
			'fk_persona' => 'Fk Persona',
			'cargo' => 'Cargo',
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

		$criteria->compare('id_supervisor',$this->id_supervisor);
		$criteria->compare('fk_persona',$this->fk_persona);
		$criteria->compare('cargo',$this->cargo,true);
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
	 * @return Supervisor the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
