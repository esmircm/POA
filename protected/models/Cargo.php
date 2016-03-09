<?php

/**
 * This is the model class for table "cargo".
 *
 * The followings are the available columns in table 'cargo':
 * @property integer $id_cargo
 * @property string $cod_cargo
 * @property integer $id_manual_cargo
 * @property string $tipo_cargo
 * @property integer $grado
 * @property integer $sub_grado
 * @property string $caucion
 * @property integer $id_serie_cargo
 * @property string $descripcion_cargo
 * @property integer $id_sitp
 * @property string $tiempo_sitp
 *
 * The followings are the available model relations:
 * @property Registrodocente[] $registrodocentes
 * @property Trabajador[] $trabajadors
 * @property Trabajador[] $trabajadors1
 * @property Primascargo[] $primascargos
 * @property Manualcargo $idManualCargo
 * @property Nominadiplomatico[] $nominadiplomaticos
 * @property Nominaconversion[] $nominaconversions
 * @property Registrocargosaprobado[] $registrocargosaprobados
 * @property Experienciacargo[] $experienciacargos
 * @property Experienciacargo[] $experienciacargos1
 * @property Profesioncargo[] $profesioncargos
 * @property Habilidadcargo[] $habilidadcargos
 * @property Adiestramientocargo[] $adiestramientocargos
 * @property Perfil[] $perfils
 * @property Registrocargos[] $registrocargoses
 * @property Dotacioncargo[] $dotacioncargos
 * @property Historialremun[] $historialremuns
 * @property Servicioexterior[] $servicioexteriors
 */
class Cargo extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'cargo';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_cargo, cod_cargo, id_manual_cargo, descripcion_cargo', 'required'),
			array('id_cargo, id_manual_cargo, grado, sub_grado, id_serie_cargo, id_sitp', 'numerical', 'integerOnly'=>true),
			array('cod_cargo', 'length', 'max'=>8),
			array('tipo_cargo, caucion', 'length', 'max'=>1),
			array('descripcion_cargo', 'length', 'max'=>60),
			array('tiempo_sitp', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_cargo, cod_cargo, id_manual_cargo, tipo_cargo, grado, sub_grado, caucion, id_serie_cargo, descripcion_cargo, id_sitp, tiempo_sitp', 'safe', 'on'=>'search'),
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
			'registrodocentes' => array(self::HAS_MANY, 'Registrodocente', 'id_cargo'),
			'trabajadors' => array(self::HAS_MANY, 'Trabajador', 'id_cargo_real'),
			'trabajadors1' => array(self::HAS_MANY, 'Trabajador', 'id_cargo'),
			'primascargos' => array(self::HAS_MANY, 'Primascargo', 'id_cargo'),
			'idManualCargo' => array(self::BELONGS_TO, 'Manualcargo', 'id_manual_cargo'),
			'nominadiplomaticos' => array(self::HAS_MANY, 'Nominadiplomatico', 'id_cargo'),
			'nominaconversions' => array(self::HAS_MANY, 'Nominaconversion', 'id_cargo'),
			'registrocargosaprobados' => array(self::HAS_MANY, 'Registrocargosaprobado', 'id_cargo'),
			'experienciacargos' => array(self::HAS_MANY, 'Experienciacargo', 'id_cargo'),
			'experienciacargos1' => array(self::HAS_MANY, 'Experienciacargo', 'id_cargo_requerido'),
			'profesioncargos' => array(self::HAS_MANY, 'Profesioncargo', 'id_cargo'),
			'habilidadcargos' => array(self::HAS_MANY, 'Habilidadcargo', 'id_cargo'),
			'adiestramientocargos' => array(self::HAS_MANY, 'Adiestramientocargo', 'id_cargo'),
			'perfils' => array(self::HAS_MANY, 'Perfil', 'id_cargo'),
			'registrocargoses' => array(self::HAS_MANY, 'Registrocargos', 'id_cargo'),
			'dotacioncargos' => array(self::HAS_MANY, 'Dotacioncargo', 'id_cargo'),
			'historialremuns' => array(self::HAS_MANY, 'Historialremun', 'id_cargo'),
			'servicioexteriors' => array(self::HAS_MANY, 'Servicioexterior', 'id_cargo'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_cargo' => 'Id Cargo',
			'cod_cargo' => 'Cod Cargo',
			'id_manual_cargo' => 'Id Manual Cargo',
			'tipo_cargo' => 'Tipo Cargo',
			'grado' => 'Grado',
			'sub_grado' => 'Sub Grado',
			'caucion' => 'Caucion',
			'id_serie_cargo' => 'Id Serie Cargo',
			'descripcion_cargo' => 'Cargo',
			'id_sitp' => 'Id Sitp',
			'tiempo_sitp' => 'Tiempo Sitp',
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

		$criteria->compare('id_cargo',$this->id_cargo);
		$criteria->compare('cod_cargo',$this->cod_cargo,true);
		$criteria->compare('id_manual_cargo',$this->id_manual_cargo);
		$criteria->compare('tipo_cargo',$this->tipo_cargo,true);
		$criteria->compare('grado',$this->grado);
		$criteria->compare('sub_grado',$this->sub_grado);
		$criteria->compare('caucion',$this->caucion,true);
		$criteria->compare('id_serie_cargo',$this->id_serie_cargo);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('id_sitp',$this->id_sitp);
		$criteria->compare('tiempo_sitp',$this->tiempo_sitp,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * @return CDbConnection the database connection used for this class
	 */
	public function getDbConnection()
	{
		return Yii::app()->db2;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Cargo the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
