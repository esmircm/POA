<?php

/**
 * This is the model class for table "poa.vsw_admin".
 *
 * The followings are the available columns in table 'poa.vsw_admin':
 * @property integer $id_proyecto
 * @property string $nombre_proyecto
 * @property integer $cod_dependencia_cruge
 * @property string $dependencia_cruge
 * @property integer $fk_estatus_proyecto
 * @property string $descripcion
 */
class VswAdmin extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_admin';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_proyecto, cod_dependencia_cruge, fk_estatus_proyecto', 'numerical', 'integerOnly'=>true),
			array('nombre_proyecto', 'length', 'max'=>500),
			array('dependencia_cruge', 'length', 'max'=>200),
			array('descripcion', 'length', 'max'=>1000),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_proyecto, nombre_proyecto, cod_dependencia_cruge, dependencia_cruge, fk_estatus_proyecto, descripcion', 'safe', 'on'=>'search'),
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
			'nombre_proyecto' => 'Nombre del Proyecto',
			'cod_dependencia_cruge' => 'Cod Dependencia Cruge',
			'dependencia_cruge' => 'Oficina',
			'fk_estatus_proyecto' => 'Estatus del Proyecto',
			'descripcion' => 'Descripcion',
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
		$criteria->compare('cod_dependencia_cruge',$this->cod_dependencia_cruge);
		$criteria->compare('dependencia_cruge',$this->dependencia_cruge,true);
		$criteria->compare('fk_estatus_proyecto',$this->fk_estatus_proyecto);
		$criteria->compare('descripcion',$this->descripcion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function search_admin($cruge_dependencia)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_proyecto',$this->id_proyecto);
		$criteria->compare('nombre_proyecto',$this->nombre_proyecto,true);
		$criteria->compare('cod_dependencia_cruge',$cruge_dependencia);
		$criteria->compare('dependencia_cruge',$this->dependencia_cruge,true);
		$criteria->compare('fk_estatus_proyecto',$this->fk_estatus_proyecto);
		$criteria->compare('descripcion',$this->descripcion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function search_planificacion($estatus)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_proyecto',$this->id_proyecto);
		$criteria->compare('nombre_proyecto',$this->nombre_proyecto,true);
		$criteria->compare('cod_dependencia_cruge',$this->cod_dependencia_cruge,true);
		$criteria->compare('dependencia_cruge',$this->dependencia_cruge,true);
		$criteria->compare('fk_estatus_proyecto',$estatus);
		$criteria->compare('descripcion',$this->descripcion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswAdmin the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
