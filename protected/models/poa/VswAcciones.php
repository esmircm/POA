<?php

/**
 * This is the model class for table "poa.vsw_acciones".
 *
 * The followings are the available columns in table 'poa.vsw_acciones':
 * @property integer $id_accion
 * @property string $nombre_accion
 * @property integer $fk_unidad_medida
 * @property string $unidad_medida
 * @property integer $fk_ambito
 * @property string $ambito
 * @property string $meta
 * @property string $bien_servicio
 * @property integer $cantidad
 * @property integer $fk_poa
 */
class VswAcciones extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_acciones';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_accion, fk_unidad_medida, fk_ambito, cantidad, fk_poa', 'numerical', 'integerOnly'=>true),
			array('nombre_accion, meta', 'length', 'max'=>500),
			array('unidad_medida, ambito', 'length', 'max'=>1000),
			array('bien_servicio', 'length', 'max'=>200),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_accion, nombre_accion, fk_unidad_medida, unidad_medida, fk_ambito, ambito, meta, bien_servicio, cantidad, fk_poa', 'safe', 'on'=>'search'),
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
			'id_accion' => 'Id Accion',
			'nombre_accion' => 'Nombre Accion',
			'fk_unidad_medida' => 'Fk Unidad Medida',
			'unidad_medida' => 'Unidad Medida',
			'fk_ambito' => 'Fk Ambito',
			'ambito' => 'Ambito',
			'meta' => 'Meta',
			'bien_servicio' => 'Bien Servicio',
			'cantidad' => 'Cantidad',
			'fk_poa' => 'Fk Poa',
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

		$criteria->compare('id_accion',$this->id_accion);
		$criteria->compare('nombre_accion',$this->nombre_accion,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('unidad_medida',$this->unidad_medida,true);
		$criteria->compare('fk_ambito',$this->fk_ambito);
		$criteria->compare('ambito',$this->ambito,true);
		$criteria->compare('meta',$this->meta,true);
		$criteria->compare('bien_servicio',$this->bien_servicio,true);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_poa',$this->fk_poa);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswAcciones the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
