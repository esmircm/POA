<?php

/**
 * This is the model class for table "poa.poa".
 *
 * The followings are the available columns in table 'poa.poa':
 * @property integer $id_poa
 * @property string $nombre
 * @property integer $fk_tipo_poa
 * @property string $obj_historico
 * @property string $obj_estrategico
 * @property string $obj_general
 * @property string $obj_institucional
 * @property string $descripcion
 * @property string $fecha_inicio
 * @property string $fecha_final
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Maestro $fkTipoPoa
 * @property Maestro $fkStatus
 * @property EstatusPoa[] $estatusPoas
 * @property Acciones[] $acciones
 * @property Comentarios[] $comentarioses
 * @property Responsable[] $responsables
 */
class Poa extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.poa';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, fk_tipo_poa, obj_general, created_by, created_date, modified_date, fk_status', 'required'),
			array('fk_tipo_poa, created_by, modified_by, fk_status', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>700),
			array('obj_historico, obj_estrategico, obj_general, obj_institucional, descripcion', 'length', 'max'=>800),
			array('fecha_inicio, fecha_final, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_poa, nombre, fk_tipo_poa, obj_historico, obj_estrategico, obj_general, obj_institucional, descripcion, fecha_inicio, fecha_final, created_by, created_date, modified_by, modified_date, fk_status, es_activo', 'safe', 'on'=>'search'),
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
			'fkTipoPoa' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_tipo_poa'),
			'fkStatus' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_status'),
			'estatusPoas' => array(self::HAS_MANY, 'EstatusPoa', 'fk_poa'),
			'acciones' => array(self::HAS_MANY, 'Acciones', 'fk_poa'),
			'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_poa'),
			'responsables' => array(self::HAS_MANY, 'Responsable', 'fk_poa'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_poa' => 'Id Poa',
			'nombre' => 'Nombre',
			'fk_tipo_poa' => 'Fk Tipo Poa',
			'obj_historico' => 'Objetivo Historico',
			'obj_estrategico' => 'Objetivo Estrategico',
			'obj_general' => 'Objetivo General',
			'obj_institucional' => 'Objetivo Institucional',
			'descripcion' => 'Descripcion',
			'fecha_inicio' => 'Fecha de Inicio',
			'fecha_final' => 'Fecha de Finalización',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
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
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('fk_tipo_poa',$this->fk_tipo_poa);
		$criteria->compare('obj_historico',$this->obj_historico,true);
		$criteria->compare('obj_estrategico',$this->obj_estrategico,true);
		$criteria->compare('obj_general',$this->obj_general,true);
		$criteria->compare('obj_institucional',$this->obj_institucional,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_inicio',$this->fecha_inicio,true);
		$criteria->compare('fecha_final',$this->fecha_final,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Poa the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
