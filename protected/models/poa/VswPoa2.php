<?php

/**
 * This is the model class for table "poa.vsw_poa2".
 *
 * The followings are the available columns in table 'poa.vsw_poa2':
 * @property integer $id_poa
 * @property string $poa
 * @property string $obj_general
 * @property string $obj_historico
 * @property string $descripcion
 * @property integer $id_accion
 * @property string $acciones
 * @property integer $actividades
 * @property string $actividad
 */
class VswPoa2 extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_poa2';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_poa, id_accion, actividades', 'numerical', 'integerOnly'=>true),
			array('poa', 'length', 'max'=>800),
			array('obj_general, obj_historico, descripcion', 'length', 'max'=>800),
			array('acciones', 'length', 'max'=>800),
			array('actividad', 'length', 'max'=>800),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_poa, poa, obj_general, obj_historico, descripcion, id_accion, acciones, actividades, actividad', 'safe', 'on'=>'search'),
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
			'id_poa' => 'Id Poa',
			'poa' => 'Poa',
			'obj_general' => 'Obj General',
			'obj_historico' => 'Obj Historico',
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

		$criteria->compare('id_poa',$this->id_poa);
		$criteria->compare('poa',$this->poa,true);
		$criteria->compare('obj_general',$this->obj_general,true);
		$criteria->compare('obj_historico',$this->obj_historico,true);
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
	 * @return VswPoa2 the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
