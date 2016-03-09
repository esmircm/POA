<?php

/**
 * This is the model class for table "evaluacion.evaluados".
 *
 * The followings are the available columns in table 'evaluacion.evaluados':
 * @property integer $id_evaluado
 * @property string $cargo
 * @property string $grado
 * @property integer $cod_nomina
 * @property string $fecha_ingreso
 * @property string $tiempo_puesto
 * @property string $ubicacion_admtiva
 * @property string $estado
 * @property string $periodo_desde
 * @property string $periodo_hasta
 * @property integer $n_veces
 * @property integer $cod_clase
 * @property integer $fk_persona
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 * @property integer $fk_tipo_entidad
 * @property integer $fk_dependencia
 * @property integer $fk_periodo
 *
 * The followings are the available model relations:
 * @property Evaluacion[] $evaluacions
 * @property Maestro $fkEstatus
 * @property Persona $fkPersona
 * @property Maestro $fkPeriodo
 */
class Evaluados extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.evaluados';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cargo, fk_estatus, created_date, modified_date, created_by, es_activo, fk_periodo', 'required'),
			array('cod_nomina, n_veces, cod_clase, fk_persona, fk_estatus, created_by, modified_by, fk_tipo_entidad, fk_dependencia, fk_periodo', 'numerical', 'integerOnly'=>true),
			array('cargo, ubicacion_admtiva', 'length', 'max'=>100),
			array('grado', 'length', 'max'=>10),
			array('estado', 'length', 'max'=>50),
			array('fecha_ingreso, tiempo_puesto, periodo_desde, periodo_hasta', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_evaluado, cargo, grado, cod_nomina, fecha_ingreso, tiempo_puesto, ubicacion_admtiva, estado, periodo_desde, periodo_hasta, n_veces, cod_clase, fk_persona, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, fk_tipo_entidad, fk_dependencia, fk_periodo', 'safe', 'on'=>'search'),
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
			'evaluacions' => array(self::HAS_MANY, 'Evaluacion', 'fk_evaluado'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkPersona' => array(self::BELONGS_TO, 'Persona', 'fk_persona'),
			'fkPeriodo' => array(self::BELONGS_TO, 'Maestro', 'fk_periodo'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_evaluado' => 'Id Evaluado',
			'cargo' => 'Cargo',
			'grado' => 'Grado',
			'cod_nomina' => 'Cod Nomina',
			'fecha_ingreso' => 'Fecha Ingreso',
			'tiempo_puesto' => 'Tiempo Puesto',
			'ubicacion_admtiva' => 'Ubicacion Admtiva',
			'estado' => 'Estado',
			'periodo_desde' => 'Periodo Desde',
			'periodo_hasta' => 'Periodo Hasta',
			'n_veces' => 'N Veces',
			'cod_clase' => 'Cod Clase',
			'fk_persona' => 'Fk Persona',
			'fk_estatus' => 'Fk Estatus',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'es_activo' => 'Es Activo',
			'fk_tipo_entidad' => 'clave foránea con respecto a maestro, para determinar el tipo de oficina ',
			'fk_dependencia' => 'clave foránea con referencia a la oficina donde se encuentra adscrito',
			'fk_periodo' => 'Periodo',
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

		$criteria->compare('id_evaluado',$this->id_evaluado);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('grado',$this->grado,true);
		$criteria->compare('cod_nomina',$this->cod_nomina);
		$criteria->compare('fecha_ingreso',$this->fecha_ingreso,true);
		$criteria->compare('tiempo_puesto',$this->tiempo_puesto,true);
		$criteria->compare('ubicacion_admtiva',$this->ubicacion_admtiva,true);
		$criteria->compare('estado',$this->estado,true);
		$criteria->compare('periodo_desde',$this->periodo_desde,true);
		$criteria->compare('periodo_hasta',$this->periodo_hasta,true);
		$criteria->compare('n_veces',$this->n_veces);
		$criteria->compare('cod_clase',$this->cod_clase);
		$criteria->compare('fk_persona',$this->fk_persona);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);
		$criteria->compare('fk_dependencia',$this->fk_dependencia);
		$criteria->compare('fk_periodo',$this->fk_periodo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Evaluados the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
