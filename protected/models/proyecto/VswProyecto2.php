<?php

/**
 * This is the model class for table "poa.vsw_proyecto2".
 *
 * The followings are the available columns in table 'poa.vsw_proyecto2':
 * @property integer $id_proyecto
 * @property string $nombre_proyecto
 * @property string $objetivo_general
 * @property string $fecha_inicio
 * @property string $objetivo_historico
 * @property string $descripcion
 * @property integer $id_persona_responsable
 * @property string $nombres_responsable
 * @property string $apellidos_responsable
 * @property string $nacionalidad_responsable
 * @property integer $cedula_responsable
 * @property string $cargo_responsable
 * @property string $dependencia_responsable
 * @property integer $id_persona
 * @property string $nombres
 * @property string $apellidos
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $descripcion_cargo
 * @property string $dependencia
 */
class VswProyecto2 extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_proyecto2';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_proyecto, id_persona_responsable, cedula_responsable, id_persona, cedula', 'numerical', 'integerOnly'=>true),
			array('nombre_proyecto, objetivo_general, objetivo_historico', 'length', 'max'=>500),
			array('descripcion', 'length', 'max'=>1000),
			array('nacionalidad_responsable, nacionalidad', 'length', 'max'=>1),
			array('cargo_responsable, descripcion_cargo', 'length', 'max'=>60),
			array('dependencia_responsable, dependencia', 'length', 'max'=>90),
			array('fecha_inicio, nombres_responsable, apellidos_responsable, nombres, apellidos', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_proyecto, nombre_proyecto, objetivo_general, fecha_inicio, objetivo_historico, descripcion, id_persona_responsable, nombres_responsable, apellidos_responsable, nacionalidad_responsable, cedula_responsable, cargo_responsable, dependencia_responsable, id_persona, nombres, apellidos, nacionalidad, cedula, descripcion_cargo, dependencia', 'safe', 'on'=>'search'),
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
			'id_proyecto' => 'Id Proyecto',
			'nombre_proyecto' => 'Nombre Proyecto',
			'objetivo_general' => 'Objetivo General',
			'fecha_inicio' => 'Fecha Inicio',
			'objetivo_historico' => 'Objetivo Historico',
			'descripcion' => 'Descripcion',
			'id_persona_responsable' => 'Id Persona Responsable',
			'nombres_responsable' => 'Nombres Responsable',
			'apellidos_responsable' => 'Apellidos Responsable',
			'nacionalidad_responsable' => 'Nacionalidad Responsable',
			'cedula_responsable' => 'Cedula Responsable',
			'cargo_responsable' => 'Cargo Responsable',
			'dependencia_responsable' => 'Dependencia Responsable',
			'id_persona' => 'Id Persona',
			'nombres' => 'Nombres',
			'apellidos' => 'Apellidos',
			'nacionalidad' => 'Nacionalidad',
			'cedula' => 'Cedula',
			'descripcion_cargo' => 'Descripcion Cargo',
			'dependencia' => 'Dependencia',
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

		$criteria->compare('id_proyecto',$this->id_proyecto);
		$criteria->compare('nombre_proyecto',$this->nombre_proyecto,true);
		$criteria->compare('objetivo_general',$this->objetivo_general,true);
		$criteria->compare('fecha_inicio',$this->fecha_inicio,true);
		$criteria->compare('objetivo_historico',$this->objetivo_historico,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('id_persona_responsable',$this->id_persona_responsable);
		$criteria->compare('nombres_responsable',$this->nombres_responsable,true);
		$criteria->compare('apellidos_responsable',$this->apellidos_responsable,true);
		$criteria->compare('nacionalidad_responsable',$this->nacionalidad_responsable,true);
		$criteria->compare('cedula_responsable',$this->cedula_responsable);
		$criteria->compare('cargo_responsable',$this->cargo_responsable,true);
		$criteria->compare('dependencia_responsable',$this->dependencia_responsable,true);
		$criteria->compare('id_persona',$this->id_persona);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('dependencia',$this->dependencia,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswProyecto2 the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
