<?php

/**
 * This is the model class for table "evaluacion.persona".
 *
 * The followings are the available columns in table 'evaluacion.persona':
 * @property integer $id_persona
 * @property integer $cedula
 * @property string $apellido
 * @property string $nombres
 * @property string $fecha_nacimiento
 * @property string $sexo
 * @property integer $fk_nacionalidad
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Supervisor[] $supervisors
 * @property Maestro $fkNacionalidad
 * @property Maestro $fkEstatus
 */
class Persona extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.persona';
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
			array('cedula, fk_nacionalidad, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('apellido, nombres', 'length', 'max'=>50),
			array('fecha_nacimiento, sexo, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona, cedula, apellido, nombres, fecha_nacimiento, sexo, fk_nacionalidad, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on'=>'search'),
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
			'supervisors' => array(self::HAS_MANY, 'Supervisor', 'fk_persona'),
			'fkNacionalidad' => array(self::BELONGS_TO, 'Maestro', 'fk_nacionalidad'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_persona' => 'Id Persona',
			'cedula' => 'Cedula',
			'apellido' => 'Apellido',
			'nombres' => 'Nombres',
			'fecha_nacimiento' => 'Fecha Nacimiento',
			'sexo' => 'Sexo',
			'fk_nacionalidad' => 'Fk Nacionalidad',
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

		$criteria->compare('id_persona',$this->id_persona);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('apellido',$this->apellido,true);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('fecha_nacimiento',$this->fecha_nacimiento,true);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('fk_nacionalidad',$this->fk_nacionalidad);
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
	 * @return Persona the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
