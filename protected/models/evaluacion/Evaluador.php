<?php

/**
 * This is the model class for table "evaluacion.evaluador".
 *
 * The followings are the available columns in table 'evaluacion.evaluador':
 * @property integer $id_evaluador
 * @property integer $cod_nomina
 * @property string $cargo
 * @property string $grado
 * @property integer $cod_clase
 * @property string $unidad_admtiva
 * @property integer $fk_persona
 * @property integer $fk_estatus
 * @property integer $fk_supervisor
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 * @property integer $fk_tipo_entidad
 * @property integer $fk_dependencia
 * @property string $dependencia_cruge
 *
 * The followings are the available model relations:
 * @property Revision[] $revisions
 * @property Maestro $fkEstatus
 * @property Supervisor $fkSupervisor
 * @property Evaluacion[] $evaluacions
 */
class Evaluador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.evaluador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cod_nomina, cargo, unidad_admtiva, fk_persona, fk_estatus, created_date, modified_date, created_by', 'required'),
			array('cod_nomina, cod_clase, fk_persona, fk_estatus, fk_supervisor, created_by, modified_by, fk_tipo_entidad, fk_dependencia', 'numerical', 'integerOnly'=>true),
			array('cargo, unidad_admtiva, dependencia_cruge', 'length', 'max'=>100),
			array('grado', 'length', 'max'=>10),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_evaluador, cod_nomina, cargo, grado, cod_clase, unidad_admtiva, fk_persona, fk_estatus, fk_supervisor, created_date, modified_date, created_by, modified_by, es_activo, fk_tipo_entidad, fk_dependencia, dependencia_cruge', 'safe', 'on'=>'search'),
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
			'revisions' => array(self::HAS_MANY, 'Revision', 'fk_evaluador'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkSupervisor' => array(self::BELONGS_TO, 'Supervisor', 'fk_supervisor'),
			'evaluacions' => array(self::HAS_MANY, 'Evaluacion', 'fk_evaluador'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_evaluador' => 'Id Evaluador',
			'cod_nomina' => 'Cod Nomina',
			'cargo' => 'Cargo',
			'grado' => 'Grado',
			'cod_clase' => 'Cod Clase',
			'unidad_admtiva' => 'Unidad Admtiva',
			'fk_persona' => 'Fk Persona',
			'fk_estatus' => 'Fk Estatus',
			'fk_supervisor' => 'Fk Supervisor',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'es_activo' => 'Es Activo',
			'fk_tipo_entidad' => 'Fk Tipo Entidad',
			'fk_dependencia' => 'Fk Dependencia',
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

		$criteria->compare('id_evaluador',$this->id_evaluador);
		$criteria->compare('cod_nomina',$this->cod_nomina);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('grado',$this->grado,true);
		$criteria->compare('cod_clase',$this->cod_clase);
		$criteria->compare('unidad_admtiva',$this->unidad_admtiva,true);
		$criteria->compare('fk_persona',$this->fk_persona);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('fk_supervisor',$this->fk_supervisor);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);
		$criteria->compare('fk_dependencia',$this->fk_dependencia);
		$criteria->compare('dependencia_cruge',$this->dependencia_cruge,true);
                

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Evaluador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
