<?php

/**
 * This is the model class for table "poa.vsw_proyecto".
 *
 * The followings are the available columns in table 'poa.vsw_proyecto':
 * @property integer $id_proyecto
 * @property string $proyecto
 * @property string $objetivo_general
 * @property string $objetivo_historico
 * @property string $descripcion
 * @property integer $id_accion
 * @property string $acciones
 * @property integer $actividades
 * @property string $actividad
 */
class VswProyecto extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_proyecto';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_proyecto, id_accion, actividades', 'numerical', 'integerOnly'=>true),
			array('proyecto, objetivo_general, objetivo_historico, acciones', 'length', 'max'=>500),
			array('descripcion', 'length', 'max'=>1000),
			array('actividad', 'length', 'max'=>200),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_proyecto, proyecto, objetivo_general, objetivo_historico, descripcion, id_accion, acciones, actividades, actividad', 'safe', 'on'=>'search'),
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
			'proyecto' => 'Proyecto',
			'objetivo_general' => 'Objetivo General',
			'objetivo_historico' => 'Objetivo Historico',
			'descripcion' => 'Descripcion',
			'id_accion' => 'Id Accion',
			'acciones' => 'Acciones',
			'actividades' => 'Actividades',
			'actividad' => 'Actividad',
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
		$criteria->compare('proyecto',$this->proyecto,true);
		$criteria->compare('objetivo_general',$this->objetivo_general,true);
		$criteria->compare('objetivo_historico',$this->objetivo_historico,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('id_accion',$this->id_accion);
		$criteria->compare('acciones',$this->acciones,true);
		$criteria->compare('actividades',$this->actividades);
		$criteria->compare('actividad',$this->actividad,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswProyecto the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
