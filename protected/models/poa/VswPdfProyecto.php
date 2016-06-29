<?php

/**
 * This is the model class for table "poa.vsw_pdf_proyecto".
 *
 * The followings are the available columns in table 'poa.vsw_pdf_proyecto':
 * @property integer $id_poa
 * @property string $nombre_proyecto
 * @property string $nombre_accion
 * @property string $objetivo_general
 * @property string $objetivo_historico
 * @property integer $fk_unidad_medida
 * @property string $unidad_medida
 * @property string $actividad
 * @property integer $unidad_actividad
 * @property string $unidad_actividades
 */
class VswPdfProyecto extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_pdf_proyecto';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_poa, fk_unidad_medida, unidad_actividad', 'numerical', 'integerOnly'=>true),
			array('nombre_proyecto', 'length', 'max'=>800),
			array('nombre_accion', 'length', 'max'=>800),
			array('objetivo_general, objetivo_historico', 'length', 'max'=>800),
			array('unidad_medida, unidad_actividades', 'length', 'max'=>1000),
			array('actividad', 'length', 'max'=>800),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_poa, nombre_proyecto, nombre_accion, objetivo_general, objetivo_historico, fk_unidad_medida, unidad_medida, actividad, unidad_actividad, unidad_actividades', 'safe', 'on'=>'search'),
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
			'nombre_proyecto' => 'Nombre Proyecto',
			'nombre_accion' => 'Nombre Accion',
			'objetivo_general' => 'Objetivo General',
			'objetivo_historico' => 'Objetivo Historico',
			'fk_unidad_medida' => 'Fk Unidad Medida',
			'unidad_medida' => 'Unidad Medida',
			'actividad' => 'Actividad',
			'unidad_actividad' => 'Unidad Actividad',
			'unidad_actividades' => 'Unidad Actividades',
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
		$criteria->compare('nombre_proyecto',$this->nombre_proyecto,true);
		$criteria->compare('nombre_accion',$this->nombre_accion,true);
		$criteria->compare('objetivo_general',$this->objetivo_general,true);
		$criteria->compare('objetivo_historico',$this->objetivo_historico,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('unidad_medida',$this->unidad_medida,true);
		$criteria->compare('actividad',$this->actividad,true);
		$criteria->compare('unidad_actividad',$this->unidad_actividad);
		$criteria->compare('unidad_actividades',$this->unidad_actividades,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswPdfProyecto the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
