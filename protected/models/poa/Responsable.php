<?php

/**
 * This is the model class for table "poa.responsable".
 *
 * The followings are the available columns in table 'poa.responsable':
 * @property integer $id_responsable
 * @property integer $fk_persona_registro
 * @property integer $fk_dir_responsable
 * @property integer $fk_poa
 * @property integer $created_by
 * @property integer $modified_by
 * @property string $created_date
 * @property string $modified_date
 * @property boolean $es_activo
 * @property integer $fk_estatus
 * @property integer $cod_dependencia_cruge
 * @property string $dependencia_cruge
 *
 * The followings are the available model relations:
 * @property CrugeUser $fkDirResponsable
 * @property Maestro $fkEstatus
 * @property CrugeUser $fkPersonaRegistro
 * @property Poa $fkPoa
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
			array('fk_persona_registro, fk_dir_responsable, fk_poa, created_by, created_date, modified_date, fk_estatus, cod_dependencia_cruge, dependencia_cruge', 'required'),
			array('fk_persona_registro, fk_dir_responsable, fk_poa, created_by, modified_by, fk_estatus, cod_dependencia_cruge', 'numerical', 'integerOnly'=>true),
			array('dependencia_cruge', 'length', 'max'=>200),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_responsable, fk_persona_registro, fk_dir_responsable, fk_poa, created_by, modified_by, created_date, modified_date, es_activo, fk_estatus, cod_dependencia_cruge, dependencia_cruge', 'safe', 'on'=>'search'),
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
			'fkEstatus' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_estatus'),
			'fkPersonaRegistro' => array(self::BELONGS_TO, 'CrugeUser', 'fk_persona_registro'),
			'fkPoa' => array(self::BELONGS_TO, 'Poa', 'fk_poa'),
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
			'fk_poa' => 'Fk Poa',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'es_activo' => 'Es Activo',
			'fk_estatus' => 'Fk Estatus',
			'cod_dependencia_cruge' => 'Cod Dependencia Cruge',
			'dependencia_cruge' => 'Dependencia Cruge',
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
		$criteria->compare('fk_poa',$this->fk_poa);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('cod_dependencia_cruge',$this->cod_dependencia_cruge);
		$criteria->compare('dependencia_cruge',$this->dependencia_cruge,true);

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
