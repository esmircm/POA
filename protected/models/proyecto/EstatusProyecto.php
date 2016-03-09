<?php

/**
 * This is the model class for table "poa.estatus_proyecto".
 *
 * The followings are the available columns in table 'poa.estatus_proyecto':
 * @property integer $id_estatus_proyecto
 * @property integer $fk_estatus_proyecto
 * @property integer $fk_proyecto
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 * @property integer $fk_tipo_entidad
 *
 * The followings are the available model relations:
 * @property Proyecto $fkProyecto
 * @property Maestro $fkStatus
 * @property Maestro $fkEstatusProyecto
 */
class EstatusProyecto extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.estatus_proyecto';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_estatus_proyecto, fk_proyecto, created_by, created_date, modified_date, fk_status, fk_tipo_entidad', 'required'),
			array('fk_estatus_proyecto, fk_proyecto, created_by, modified_by, fk_status, fk_tipo_entidad', 'numerical', 'integerOnly'=>true),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_estatus_proyecto, fk_estatus_proyecto, fk_proyecto, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_tipo_entidad', 'safe', 'on'=>'search'),
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
			'fkProyecto' => array(self::BELONGS_TO, 'Proyecto', 'fk_proyecto'),
			'fkStatus' => array(self::BELONGS_TO, 'Maestro', 'fk_status'),
			'fkEstatusProyecto' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus_proyecto'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_estatus_proyecto' => 'Id Estatus Proyecto',
			'fk_estatus_proyecto' => 'Fk Estatus Proyecto',
			'fk_proyecto' => 'Fk Proyecto',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
			'fk_tipo_entidad' => 'Fk Tipo Entidad',
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

		$criteria->compare('id_estatus_proyecto',$this->id_estatus_proyecto);
		$criteria->compare('fk_estatus_proyecto',$this->fk_estatus_proyecto);
		$criteria->compare('fk_proyecto',$this->fk_proyecto);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return EstatusProyecto the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
