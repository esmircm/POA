<?php

/**
 * This is the model class for table "evaluacion.vsw_cargos".
 *
 * The followings are the available columns in table 'evaluacion.vsw_cargos':
 * @property integer $id_persona
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $apellidos
 * @property string $nombres
 * @property string $sexo
 * @property integer $fk_cargo
 * @property string $cargo
 * @property integer $fk_coordinacion
 * @property string $coordinacion
 * @property integer $fk_direccion
 * @property string $direccion
 * @property integer $fk_dir_linea
 * @property string $direccion_linea
 * @property integer $fk_despacho
 * @property string $despacho
 */
class VswCargos extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_cargos';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona, cedula, fk_cargo, fk_coordinacion, fk_direccion, fk_dir_linea, fk_despacho', 'numerical', 'integerOnly'=>true),
			array('apellidos, nombres', 'length', 'max'=>50),
			array('cargo', 'length', 'max'=>100),
			array('coordinacion, direccion', 'length', 'max'=>200),
			array('direccion_linea', 'length', 'max'=>300),
			array('despacho', 'length', 'max'=>250),
			array('nacionalidad, sexo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona, nacionalidad, cedula, apellidos, nombres, sexo, fk_cargo, cargo, fk_coordinacion, coordinacion, fk_direccion, direccion, fk_dir_linea, direccion_linea, fk_despacho, despacho', 'safe', 'on'=>'search'),
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
			'fk_cargo' => 'Fk Cargo',
			'cargo' => 'Cargo',
			'fk_coordinacion' => 'Fk Coordinacion',
			'coordinacion' => 'Coordinacion',
			'fk_direccion' => 'Fk Direccion',
			'direccion' => 'Direccion',
			'fk_dir_linea' => 'Fk Dir Linea',
			'direccion_linea' => 'Direccion Linea',
			'fk_despacho' => 'Fk Despacho',
			'despacho' => 'Despacho',
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
		$criteria->compare('fk_cargo',$this->fk_cargo);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('fk_coordinacion',$this->fk_coordinacion);
		$criteria->compare('coordinacion',$this->coordinacion,true);
		$criteria->compare('fk_direccion',$this->fk_direccion);
		$criteria->compare('direccion',$this->direccion,true);
		$criteria->compare('fk_dir_linea',$this->fk_dir_linea);
		$criteria->compare('direccion_linea',$this->direccion_linea,true);
		$criteria->compare('fk_despacho',$this->fk_despacho);
		$criteria->compare('despacho',$this->despacho,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswCargos the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
