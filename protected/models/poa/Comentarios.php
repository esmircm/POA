<?php

/**
 * This is the model class for table "poa.comentarios".
 *
 * The followings are the available columns in table 'poa.comentarios':
 * @property integer $id_comentarios
 * @property string $comentarios
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 * @property integer $fk_poa
 * @property integer $fk_tipo_entidad
 *
 * The followings are the available model relations:
 * @property Maestro $fkStatus
 * @property Poa $fkPoa
 */
class Comentarios extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.comentarios';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('created_by, created_date, modified_date, fk_status, fk_poa, fk_tipo_entidad', 'required'),
			array('created_by, modified_by, fk_status, fk_poa, fk_tipo_entidad', 'numerical', 'integerOnly'=>true),
			array('comentarios', 'length', 'max'=>1000),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_comentarios, comentarios, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_poa, fk_tipo_entidad', 'safe', 'on'=>'search'),
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
			'fkStatus' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_status'),
			'fkPoa' => array(self::BELONGS_TO, 'Poa', 'fk_poa'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_comentarios' => 'Id Comentarios',
			'comentarios' => 'Comentarios',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
			'fk_poa' => 'Fk Poa',
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

		$criteria->compare('id_comentarios',$this->id_comentarios);
		$criteria->compare('comentarios',$this->comentarios,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_poa',$this->fk_poa);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Comentarios the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
