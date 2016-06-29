<?php

/**
 * This is the model class for table "poa.maestro".
 *
 * The followings are the available columns in table 'poa.maestro':
 * @property integer $id_maestro
 * @property string $descripcion
 * @property integer $padre
 * @property integer $hijo
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property boolean $es_activo
 * @property string $descripcion2
 *
 * The followings are the available model relations:
 * @property Acciones[] $acciones
 * @property Acciones[] $acciones1
 * @property Acciones[] $acciones2
 * @property Actividades[] $actividades
 * @property Actividades[] $actividades1
 * @property Comentarios[] $comentarioses
 * @property Poa[] $poas
 * @property Poa[] $poas1
 * @property Poa[] $poas2
 * @property EstatusPoa[] $estatusPoas
 * @property EstatusPoa[] $estatusPoas1
 * @property Responsable[] $responsables
 * @property Rendimiento[] $rendimientos
 * @property Rendimiento[] $rendimientos1
 * @property Rendimiento[] $rendimientos2
 */
class MaestroPoa extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.maestro';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('padre, hijo, created_by, created_date, modified_date', 'required'),
			array('padre, hijo, created_by, modified_by', 'numerical', 'integerOnly'=>true),
			array('descripcion', 'length', 'max'=>1000),
			array('descripcion2', 'length', 'max'=>200),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_maestro, descripcion, padre, hijo, created_by, created_date, modified_by, modified_date, es_activo, descripcion2', 'safe', 'on'=>'search'),
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
			'acciones' => array(self::HAS_MANY, 'Acciones', 'fk_ambito'),
			'acciones1' => array(self::HAS_MANY, 'Acciones', 'fk_status'),
			'acciones2' => array(self::HAS_MANY, 'Acciones', 'fk_unidad_medida'),
			'actividades' => array(self::HAS_MANY, 'Actividades', 'fk_status'),
			'actividades1' => array(self::HAS_MANY, 'Actividades', 'fk_unidad_medida'),
			'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_status'),
			'poas' => array(self::HAS_MANY, 'Poa', 'fk_status'),
			'poas1' => array(self::HAS_MANY, 'Poa', 'fk_tipo_poa'),
			'poas2' => array(self::HAS_MANY, 'Poa', 'fk_unidad_medida'),
			'estatusPoas' => array(self::HAS_MANY, 'EstatusPoa', 'fk_estatus_poa'),
			'estatusPoas1' => array(self::HAS_MANY, 'EstatusPoa', 'fk_status'),
			'responsables' => array(self::HAS_MANY, 'Responsable', 'fk_estatus'),
			'rendimientos' => array(self::HAS_MANY, 'Rendimiento', 'fk_meses'),
			'rendimientos1' => array(self::HAS_MANY, 'Rendimiento', 'fk_status'),
			'rendimientos2' => array(self::HAS_MANY, 'Rendimiento', 'fk_tipo_entidad'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_maestro' => 'Id Maestro',
			'descripcion' => 'Descripcion',
			'padre' => 'Padre',
			'hijo' => 'Hijo',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'es_activo' => 'Es Activo',
                        'descripcion2' => 'Descripcion2',
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

		$criteria->compare('id_maestro',$this->id_maestro);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('padre',$this->padre);
		$criteria->compare('hijo',$this->hijo);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('es_activo',$this->es_activo);
                $criteria->compare('descripcion2',$this->descripcion2,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function search_medida()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_maestro',$this->id_maestro);
		$criteria->compare('descripcion',trim(mb_strtoupper($this->descripcion)), true);
		$criteria->compare('padre',35);
		$criteria->compare('hijo',$this->hijo);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('es_activo',TRUE);
                $criteria->compare('descripcion2',$this->descripcion2,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        /**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return MaestroPoa the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
