<?php

/**
 * This is the model class for table "poa.poa".
 *
 * The followings are the available columns in table 'poa.poa':
 * @property integer $id_poa
 * @property string $nombre
 * @property integer $fk_tipo_poa
 * @property string $descripcion
 * @property string $fecha_inicio
 * @property string $fecha_final
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 * @property integer $fk_unidad_medida
 * @property integer $cantidad
 * @property integer $fk_historico
 * @property integer $fk_nacional
 * @property integer $fk_estrategico
 * @property integer $fk_general
 * @property integer $fk_institucional
 * @property integer $fk_estrategico_mr
 *
 * The followings are the available model relations:
 * @property Acciones[] $acciones
 * @property Comentarios[] $comentarioses
 * @property EstatusPoa[] $estatusPoas
 * @property Responsable[] $responsables
 * @property Maestro $fkStatus
 * @property Maestro $fkTipoPoa
 * @property Maestro $fkUnidadMedida
 * @property Maestro $fkHistorico
 * @property Maestro $fkNacional
 * @property Maestro $fkEstrategico
 * @property Maestro $fkGeneral
 * @property Maestro $fkInstitucional
 * @property Maestro $fkEstrategicoMr
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
			array('nombre, fk_tipo_poa, created_by, created_date, modified_date, fk_status', 'required'),
			array('fk_tipo_poa, created_by, modified_by, fk_status, fk_unidad_medida, cantidad, fk_historico, fk_nacional, fk_estrategico, fk_general, fk_institucional, fk_estrategico_mr', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion', 'length', 'max'=>800),
			array('fecha_inicio, fecha_final, es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_poa, nombre, fk_tipo_poa, descripcion, fecha_inicio, fecha_final, created_by, created_date, modified_by, modified_date, fk_status, es_activo, fk_unidad_medida, cantidad, fk_historico, fk_nacional, fk_estrategico, fk_general, fk_institucional, fk_estrategico_mr', 'safe', 'on'=>'search'),
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
			'acciones' => array(self::HAS_MANY, 'Acciones', 'fk_poa'),
			'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_poa'),
			'estatusPoas' => array(self::HAS_MANY, 'EstatusPoa', 'fk_poa'),
			'responsables' => array(self::HAS_MANY, 'Responsable', 'fk_poa'),
			'fkStatus' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_status'),
			'fkTipoPoa' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_tipo_poa'),
			'fkUnidadMedida' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_unidad_medida'),
			'fkHistorico' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_historico'),
			'fkNacional' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_nacional'),
			'fkEstrategico' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_estrategico'),
			'fkGeneral' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_general'),
			'fkInstitucional' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_institucional'),
                        'fkEstrategicoMr' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_estrategico_mr'),
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
			'descripcion' => 'Descripcion',
			'fecha_inicio' => 'Fecha de Inicio',
			'fecha_final' => 'Fecha de Finalización',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
			'fk_unidad_medida' => 'Unidad de Medida',
			'cantidad' => 'Cantidad',
			'fk_historico' => 'Objetivo Historico',
			'fk_nacional' => 'Objetivo Nacional',
			'fk_estrategico' => 'Objetivo Estrategico',
			'fk_general' => 'Objetivo General',
			'fk_institucional' => 'Objetivo Institucional',
                        'fk_estrategico_mr' => 'Objetivo Estrategico',
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
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_inicio',$this->fecha_inicio,true);
		$criteria->compare('fecha_final',$this->fecha_final,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_historico',$this->fk_historico);
		$criteria->compare('fk_nacional',$this->fk_nacional);
		$criteria->compare('fk_estrategico',$this->fk_estrategico);
		$criteria->compare('fk_general',$this->fk_general);
		$criteria->compare('fk_institucional',$this->fk_institucional);
                $criteria->compare('fk_estrategico_mr',$this->fk_estrategico_mr);

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
