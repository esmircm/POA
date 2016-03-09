<?php

/**
 * This is the model class for table "poa.responsable".
 *
 * The followings are the available columns in table 'poa.responsable':
 * @property integer $id_responsable
 * @property integer $fk_persona_registro
 * @property integer $fk_dir_responsable
 * @property integer $fk_proyecto
 * @property integer $created_by
 * @property integer $modified_by
 * @property string $created_date
 * @property string $modified_date
 * @property boolean $es_activo
 * @property integer $fk_estatus
 *
 * The followings are the available model relations:
 * @property CrugeUser $fkDirResponsable
 * @property Maestro $fkEstatus
 * @property CrugeUser $fkPersonaRegistro
 * @property Proyecto $fkProyecto
 */
class Responsable extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.responsable';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_persona_registro, fk_dir_responsable, fk_proyecto, created_by, created_date, modified_date, fk_estatus', 'required'),
			array('fk_persona_registro, fk_dir_responsable, fk_proyecto, created_by, modified_by, fk_estatus', 'numerical', 'integerOnly'=>true),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_responsable, fk_persona_registro, fk_dir_responsable, fk_proyecto, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus', 'safe', 'on'=>'search'),
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
			'fkDirResponsable' => array(self::BELONGS_TO, 'CrugeUser', 'fk_dir_responsable'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkPersonaRegistro' => array(self::BELONGS_TO, 'CrugeUser', 'fk_persona_registro'),
			'fkProyecto' => array(self::BELONGS_TO, 'Proyecto', 'fk_proyecto'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_responsable' => 'Id Responsable',
			'fk_persona_registro' => 'Fk Persona Registro',
			'fk_dir_responsable' => 'Fk Dir Responsable',
			'fk_proyecto' => 'Fk Proyecto',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'es_activo' => 'Es Activo',
			'fk_estatus' => 'Fk Estatus',
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

		$criteria->compare('id_responsable',$this->id_responsable);
		$criteria->compare('fk_persona_registro',$this->fk_persona_registro);
		$criteria->compare('fk_dir_responsable',$this->fk_dir_responsable);
		$criteria->compare('fk_proyecto',$this->fk_proyecto);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_estatus',$this->fk_estatus);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Responsable the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
