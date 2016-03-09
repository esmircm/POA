<?php

/**
 * This is the model class for table "requisicion.pedido".
 *
 * The followings are the available columns in table 'requisicion.pedido':
 * @property integer $id_pedido
 * @property integer $fk_descripcion
 * @property integer $cantidad
 * @property integer $fk_datos_requisicion
 * @property integer $unid_medida
 * @property integer $created_by
 * @property integer $modified_by
 * @property string $created_date
 * @property string $modified_date
 * @property integer $fk_estatus
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property DatosRequisicion $fkDatosRequisicion
 * @property Maestro $fkDescripcion
 * @property Maestro $fkEstatus
 */
class Pedido extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'requisicion.pedido';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_descripcion, cantidad, unid_medida, created_by, created_date, modified_date, fk_estatus', 'required'),
			array('fk_descripcion, cantidad, fk_datos_requisicion, unid_medida, created_by, modified_by, fk_estatus', 'numerical', 'integerOnly'=>true),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_pedido, fk_descripcion, cantidad, fk_datos_requisicion, unid_medida, created_by, modified_by, created_date, modified_date, fk_estatus, es_activo', 'safe', 'on'=>'search'),
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
			'fkDatosRequisicion' => array(self::BELONGS_TO, 'DatosRequisicion', 'fk_datos_requisicion'),
			'fkDescripcion' => array(self::BELONGS_TO, 'Maestro', 'fk_descripcion'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_pedido' => 'Id Pedido',
			'fk_descripcion' => 'Fk Descripcion',
			'cantidad' => 'Cantidad',
			'fk_datos_requisicion' => 'Fk Datos Requisicion',
			'unid_medida' => 'Unid Medida',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'fk_estatus' => 'Fk Estatus',
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

		$criteria->compare('id_pedido',$this->id_pedido);
		$criteria->compare('fk_descripcion',$this->fk_descripcion);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_datos_requisicion',$this->fk_datos_requisicion);
		$criteria->compare('unid_medida',$this->unid_medida);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('es_activo',$this->es_activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Pedido the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
