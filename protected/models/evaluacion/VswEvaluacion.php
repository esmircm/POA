<?php

/**
 * This is the model class for table "evaluacion.vsw_evaluacion".
 *
 * The followings are the available columns in table 'evaluacion.vsw_evaluacion':
 * @property integer $id_persona
 * @property string $nacionalidad
 * @property integer $cedula
 * @property integer $fk_cargo
 * @property string $apellidos
 * @property string $nombres
 * @property string $sexo
 * @property integer $id_cargo
 * @property string $descripcion_cargo
 * @property string $estatus
 * @property integer $codigo_nomina
 * @property integer $cod_dependencia
 * @property string $dependencia
 * @property string $telef_oficina
 * @property integer $grado
 * @property string $tipo_cargo
 * @property string $to_char
 */
class VswEvaluacion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_evaluacion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona, cedula, fk_cargo, id_cargo, codigo_nomina, cod_dependencia, grado', 'numerical', 'integerOnly'=>true),
			array('nacionalidad, sexo, estatus, tipo_cargo', 'length', 'max'=>1),
			array('descripcion_cargo', 'length', 'max'=>60),
			array('dependencia', 'length', 'max'=>90),
			array('telef_oficina', 'length', 'max'=>15),
			array('apellidos, nombres, to_char', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona, nacionalidad, cedula, fk_cargo, apellidos, nombres, sexo, id_cargo, descripcion_cargo, estatus, codigo_nomina, cod_dependencia, dependencia, telef_oficina, grado, tipo_cargo, to_char', 'safe', 'on'=>'search'),
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
			'fk_cargo' => 'Fk Cargo',
			'apellidos' => 'Apellidos',
			'nombres' => 'Nombres',
			'sexo' => 'Sexo',
			'id_cargo' => 'Id Cargo',
			'descripcion_cargo' => 'Descripcion Cargo',
			'estatus' => 'Estatus',
			'codigo_nomina' => 'Codigo Nomina',
			'cod_dependencia' => 'Cod Dependencia',
			'dependencia' => 'Dependencia',
			'telef_oficina' => 'Telef Oficina',
			'grado' => 'Grado',
			'tipo_cargo' => 'Tipo Cargo',
			'to_char' => 'To Char',
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
		$criteria->compare('fk_cargo',$this->fk_cargo);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('id_cargo',$this->id_cargo);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('codigo_nomina',$this->codigo_nomina);
		$criteria->compare('cod_dependencia',$this->cod_dependencia);
		$criteria->compare('dependencia',$this->dependencia,true);
		$criteria->compare('telef_oficina',$this->telef_oficina,true);
		$criteria->compare('grado',$this->grado);
		$criteria->compare('tipo_cargo',$this->tipo_cargo,true);
		$criteria->compare('to_char',$this->to_char,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswEvaluacion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
