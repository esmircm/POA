<?php

/**
 * This is the model class for table "poa.vsw_actividades".
 *
 * The followings are the available columns in table 'poa.vsw_actividades':
 * @property integer $id_actividades
 * @property string $actividad
 * @property integer $cantidad
 * @property integer $fk_unidad_medida
 * @property string $unidad_medida
 * @property integer $fk_accion
 * @property integer $fk_poa
 */
class VswActividades extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_actividades';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_actividades, cantidad, fk_unidad_medida, fk_accion, fk_poa', 'numerical', 'integerOnly'=>true),
			array('actividad', 'length', 'max'=>800),
			array('unidad_medida', 'length', 'max'=>1000),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_actividades, actividad, cantidad, fk_unidad_medida, unidad_medida, fk_accion, fk_poa', 'safe', 'on'=>'search'),
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
			'id_actividades' => 'Id Actividades',
			'actividad' => 'Actividad',
			'cantidad' => 'Cantidad',
			'fk_unidad_medida' => 'Unidad de Medida',
			'unidad_medida' => 'Unidad de Medida',
			'fk_accion' => 'Fk Accion',
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

		$criteria->compare('id_actividades',$this->id_actividades);
		$criteria->compare('actividad',$this->actividad,true);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('unidad_medida',$this->unidad_medida,true);
		$criteria->compare('fk_accion',$this->fk_accion);
		$criteria->compare('fk_poa',$this->fk_poa);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function searchActividad($fk_accion)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_actividades',$this->id_actividades);
		$criteria->compare('actividad',$this->actividad,true);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('unidad_medida',$this->unidad_medida,true);
		$criteria->compare('fk_accion',$fk_accion);
		$criteria->compare('fk_poa',$this->fk_poa);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswActividades the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
