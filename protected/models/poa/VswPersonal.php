<?php

/**
 * This is the model class for table "poa.vsw_personal".
 *
 * The followings are the available columns in table 'poa.vsw_personal':
 * @property integer $id_persona
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $apellidos
 * @property string $nombres
 * @property string $sexo
 * @property integer $id_cargo
 * @property string $descripcion_cargo
 * @property string $estatus
 * @property integer $cod_dependencia
 * @property string $dependencia
 * @property integer $grado
 */
class VswPersonal extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_personal';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona, cedula, id_cargo, cod_dependencia, grado', 'numerical', 'integerOnly'=>true),
			array('nacionalidad, sexo, estatus', 'length', 'max'=>1),
			array('descripcion_cargo', 'length', 'max'=>60),
			array('dependencia', 'length', 'max'=>90),
			array('apellidos, nombres', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona, nacionalidad, cedula, apellidos, nombres, sexo, id_cargo, descripcion_cargo, estatus, cod_dependencia, dependencia, grado', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_persona' => 'Id Persona',
			'nacionalidad' => 'Nacionalidad',
			'cedula' => 'Cedula',
			'apellidos' => 'Apellidos',
			'nombres' => 'Nombres',
			'sexo' => 'Sexo',
			'id_cargo' => 'Id Cargo',
			'descripcion_cargo' => 'Descripcion del Cargo',
			'estatus' => 'Estatus',
			'cod_dependencia' => 'Cod Dependencia',
			'dependencia' => 'Oficina',
			'grado' => 'Grado',
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
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('id_cargo',$this->id_cargo);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('cod_dependencia',$this->cod_dependencia);
		$criteria->compare('dependencia',$this->dependencia,true);
		$criteria->compare('grado',$this->grado);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswPersonal the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
