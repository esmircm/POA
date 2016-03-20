<?php

/**
 * This is the model class for table "poa.acciones".
 *
 * The followings are the available columns in table 'poa.acciones':
 * @property integer $id_accion
 * @property string $nombre_accion
 * @property integer $fk_unidad_medida
 * @property integer $cantidad
 * @property integer $fk_ambito
 * @property integer $fk_poa
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 * @property string $meta
 * @property string $bien_servicio
 *
 * The followings are the available model relations:
 * @property Maestro $fkAmbito
 * @property Maestro $fkStatus
 * @property Maestro $fkUnidadMedida
 * @property Poa $fkPoa
 * @property Actividades[] $actividades
 */
class Acciones extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.acciones';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, created_date, modified_date, fk_status', 'required'),
			array('fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, modified_by, fk_status', 'numerical', 'integerOnly'=>true),
			array('nombre_accion, meta', 'length', 'max'=>500),
			array('bien_servicio', 'length', 'max'=>200),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_accion, nombre_accion, fk_unidad_medida, cantidad, fk_ambito, fk_poa, created_by, created_date, modified_by, modified_date, fk_status, es_activo, meta, bien_servicio', 'safe', 'on'=>'search'),
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
			'fkAmbito' => array(self::BELONGS_TO, 'Maestro', 'fk_ambito'),
			'fkStatus' => array(self::BELONGS_TO, 'Maestro', 'fk_status'),
			'fkUnidadMedida' => array(self::BELONGS_TO, 'Maestro', 'fk_unidad_medida'),
			'fkPoa' => array(self::BELONGS_TO, 'Poa', 'fk_poa'),
			'actividades' => array(self::HAS_MANY, 'Actividades', 'fk_accion'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_accion' => 'Id Accion',
			'nombre_accion' => 'Nombre de la Accion',
			'fk_unidad_medida' => 'Unidad de Medida',
			'cantidad' => 'Cantidad',
			'fk_ambito' => 'Ámbito',
			'fk_poa' => 'Fk Poa',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
			'es_activo' => 'Es Activo',
			'meta' => 'Meta',
			'bien_servicio' => 'Bien o Servicio',
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

		$criteria->compare('id_accion',$this->id_accion);
		$criteria->compare('nombre_accion',$this->nombre_accion,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_ambito',$this->fk_ambito);
		$criteria->compare('fk_poa',$this->fk_poa);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('meta',$this->meta,true);
		$criteria->compare('bien_servicio',$this->bien_servicio,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function searchAccion($fk_poa)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_accion',$this->id_accion);
		$criteria->compare('nombre_accion',$this->nombre_accion,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_ambito',$this->fk_ambito);
		$criteria->compare('fk_poa',$fk_poa);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('meta',$this->meta,true);
		$criteria->compare('bien_servicio',$this->bien_servicio,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function search_unidad_medida($id)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.
                $consulta = Yii::app()->db->createCommand()
                ->select('unidad_medida')
                ->from('poa.vsw_acciones')
                ->where('id_accion =' . $id)
                ->queryRow();
        
                $resultado = $consulta['unidad_medida'];
                return $resultado;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Acciones the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
