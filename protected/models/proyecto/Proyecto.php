<?php

/**
 * This is the model class for table "poa.proyecto".
 *
 * The followings are the available columns in table 'poa.proyecto':
 * @property integer $id_proyecto
 * @property string $nombre_proyecto
 * @property string $objetivo_general
 * @property string $descripcion
 * @property string $fecha_inicio
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 * @property string $objetivo_historico
 *
 * The followings are the available model relations:
 * @property Maestro $fkStatus
 * @property Acciones[] $acciones
 * @property Responsable[] $responsables
 * @property EstatusProyecto[] $estatusProyectos
 * @property Comentarios[] $comentarioses
 */
class Proyecto extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.proyecto';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre_proyecto, objetivo_general, created_by, created_date, modified_date, fk_status', 'required'),
			array('created_by, modified_by, fk_status', 'numerical', 'integerOnly'=>true),
			array('nombre_proyecto, objetivo_general, objetivo_historico', 'length', 'max'=>500),
			array('descripcion', 'length', 'max'=>1000),
			array('fecha_inicio, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_proyecto, nombre_proyecto, objetivo_general, descripcion, fecha_inicio, created_by, created_date, modified_by, modified_date, fk_status, es_activo, objetivo_historico', 'safe', 'on'=>'search'),
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
			'fkStatus' => array(self::BELONGS_TO, 'Maestro', 'fk_status'),
			'acciones' => array(self::HAS_MANY, 'Acciones', 'fk_proyecto'),
			'responsables' => array(self::HAS_MANY, 'Responsable', 'fk_proyecto'),
			'estatusProyectos' => array(self::HAS_MANY, 'EstatusProyecto', 'fk_proyecto'),
			'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_proyecto'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_proyecto' => 'Id Proyecto',
			'nombre_proyecto' => 'Nombre Proyecto',
			'objetivo_general' => 'Objetivo General',
			'descripcion' => 'Descripcion',
			'fecha_inicio' => 'Fecha Inicio',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
			'objetivo_historico' => 'Objetivo Historico',
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
		$criteria->compare('objetivo_general',$this->objetivo_general,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_inicio',$this->fecha_inicio,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('objetivo_historico',$this->objetivo_historico,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Proyecto the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
