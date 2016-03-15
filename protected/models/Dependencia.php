<?php

/**
 * This is the model class for table "dependencia".
 *
 * The followings are the available columns in table 'dependencia':
 * @property integer $id_dependencia
 * @property string $cod_dependencia
 * @property string $dependencia_staff
 * @property string $vigente
 * @property string $fecha_fin
 * @property string $fecha_vigencia
 * @property string $localidad
 * @property integer $nivel_estructura
 * @property string $sede_diplomatica
 * @property integer $id_tipo_dependencia
 * @property integer $id_administradora_uel
 * @property integer $id_unidad_funcional
 * @property integer $id_grupo_organismo
 * @property integer $id_organismo
 * @property integer $id_dependencia_anterior
 * @property string $nombre
 * @property string $aprobacion_mpd
 * @property integer $id_sede
 * @property string $cod_cesta
 * @property integer $id_region
 * @property integer $id_estructura
 *
 * The followings are the available model relations:
 * @property Registrodocente[] $registrodocentes
 * @property Grupoorganismo $idGrupoOrganismo
 * @property Organismo $idOrganismo
 * @property Tipodependencia $idTipoDependencia
 * @property Administradorauel $idAdministradoraUel
 * @property Dependencia $idDependenciaAnterior
 * @property Dependencia[] $dependencias
 * @property Unidadfuncional $idUnidadFuncional
 * @property Sede $idSede
 * @property Trabajador[] $trabajadors
 * @property Trabajador[] $trabajadors1
 * @property Nominadiplomatico[] $nominadiplomaticos
 * @property Registrocargosaprobado[] $registrocargosaprobados
 * @property Clasificaciondependencia[] $clasificaciondependencias
 * @property Dependenciajudicial[] $dependenciajudicials
 * @property Conceptodependencia[] $conceptodependencias
 * @property Registrocargos[] $registrocargoses
 * @property Aperturaescolar[] $aperturaescolars
 */
class Dependencia extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'dependencia';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_dependencia, cod_dependencia, id_administradora_uel, id_organismo, nombre, id_region', 'required'),
			array('id_dependencia, nivel_estructura, id_tipo_dependencia, id_administradora_uel, id_unidad_funcional, id_grupo_organismo, id_organismo, id_dependencia_anterior, id_sede, id_region, id_estructura', 'numerical', 'integerOnly'=>true),
			array('cod_dependencia', 'length', 'max'=>12),
			array('dependencia_staff, vigente, localidad, sede_diplomatica, aprobacion_mpd', 'length', 'max'=>1),
			array('nombre', 'length', 'max'=>90),
			array('cod_cesta', 'length', 'max'=>10),
			array('fecha_fin, fecha_vigencia', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_dependencia, cod_dependencia, dependencia_staff, vigente, fecha_fin, fecha_vigencia, localidad, nivel_estructura, sede_diplomatica, id_tipo_dependencia, id_administradora_uel, id_unidad_funcional, id_grupo_organismo, id_organismo, id_dependencia_anterior, nombre, aprobacion_mpd, id_sede, cod_cesta, id_region, id_estructura', 'safe', 'on'=>'search'),
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
			'registrodocentes' => array(self::HAS_MANY, 'Registrodocente', 'id_dependencia'),
			'idGrupoOrganismo' => array(self::BELONGS_TO, 'Grupoorganismo', 'id_grupo_organismo'),
			'idOrganismo' => array(self::BELONGS_TO, 'Organismo', 'id_organismo'),
			'idTipoDependencia' => array(self::BELONGS_TO, 'Tipodependencia', 'id_tipo_dependencia'),
			'idAdministradoraUel' => array(self::BELONGS_TO, 'Administradorauel', 'id_administradora_uel'),
			'idDependenciaAnterior' => array(self::BELONGS_TO, 'Dependencia', 'id_dependencia_anterior'),
			'dependencias' => array(self::HAS_MANY, 'Dependencia', 'id_dependencia_anterior'),
			'idUnidadFuncional' => array(self::BELONGS_TO, 'Unidadfuncional', 'id_unidad_funcional'),
			'idSede' => array(self::BELONGS_TO, 'Sede', 'id_sede'),
			'trabajadors' => array(self::HAS_MANY, 'Trabajador', 'id_dependencia'),
			'trabajadors1' => array(self::HAS_MANY, 'Trabajador', 'id_dependencia_real'),
			'nominadiplomaticos' => array(self::HAS_MANY, 'Nominadiplomatico', 'id_dependencia'),
			'registrocargosaprobados' => array(self::HAS_MANY, 'Registrocargosaprobado', 'id_dependencia'),
			'clasificaciondependencias' => array(self::HAS_MANY, 'Clasificaciondependencia', 'id_dependencia'),
			'dependenciajudicials' => array(self::HAS_MANY, 'Dependenciajudicial', 'id_dependencia'),
			'conceptodependencias' => array(self::HAS_MANY, 'Conceptodependencia', 'id_dependencia'),
			'registrocargoses' => array(self::HAS_MANY, 'Registrocargos', 'id_dependencia'),
			'aperturaescolars' => array(self::HAS_MANY, 'Aperturaescolar', 'id_dependencia'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_dependencia' => 'Id Dependencia',
			'cod_dependencia' => 'Cod Dependencia',
			'dependencia_staff' => 'Dependencia Staff',
			'vigente' => 'Vigente',
			'fecha_fin' => 'Fecha Fin',
			'fecha_vigencia' => 'Fecha Vigencia',
			'localidad' => 'Localidad',
			'nivel_estructura' => 'Nivel Estructura',
			'sede_diplomatica' => 'Sede Diplomatica',
			'id_tipo_dependencia' => 'Id Tipo Dependencia',
			'id_administradora_uel' => 'Id Administradora Uel',
			'id_unidad_funcional' => 'Id Unidad Funcional',
			'id_grupo_organismo' => 'Id Grupo Organismo',
			'id_organismo' => 'Id Organismo',
			'id_dependencia_anterior' => 'Id Dependencia Anterior',
			'nombre' => 'Ubicación Administrativa',
			'aprobacion_mpd' => 'Aprobacion Mpd',
			'id_sede' => 'Id Sede',
			'cod_cesta' => 'Cod Cesta',
			'id_region' => 'Id Region',
			'id_estructura' => 'Id Estructura',
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

		$criteria->compare('id_dependencia',$this->id_dependencia);
		$criteria->compare('cod_dependencia',$this->cod_dependencia,true);
		$criteria->compare('dependencia_staff',$this->dependencia_staff,true);
		$criteria->compare('vigente',$this->vigente,true);
		$criteria->compare('fecha_fin',$this->fecha_fin,true);
		$criteria->compare('fecha_vigencia',$this->fecha_vigencia,true);
		$criteria->compare('localidad',$this->localidad,true);
		$criteria->compare('nivel_estructura',$this->nivel_estructura);
		$criteria->compare('sede_diplomatica',$this->sede_diplomatica,true);
		$criteria->compare('id_tipo_dependencia',$this->id_tipo_dependencia);
		$criteria->compare('id_administradora_uel',$this->id_administradora_uel);
		$criteria->compare('id_unidad_funcional',$this->id_unidad_funcional);
		$criteria->compare('id_grupo_organismo',$this->id_grupo_organismo);
		$criteria->compare('id_organismo',$this->id_organismo);
		$criteria->compare('id_dependencia_anterior',$this->id_dependencia_anterior);
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('aprobacion_mpd',$this->aprobacion_mpd,true);
		$criteria->compare('id_sede',$this->id_sede);
		$criteria->compare('cod_cesta',$this->cod_cesta,true);
		$criteria->compare('id_region',$this->id_region);
		$criteria->compare('id_estructura',$this->id_estructura);

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
	 * @return Dependencia the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
