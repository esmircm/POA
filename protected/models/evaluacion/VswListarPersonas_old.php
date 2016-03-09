<?php

/**
 * This is the model class for table "evaluacion.vsw_listar_personas".
 *
 * The followings are the available columns in table 'evaluacion.vsw_listar_personas':
 * @property integer $id_persona_evaluado
 * @property string $apellidos_evaluado
 * @property string $nombres_evaluado
 * @property integer $nac_evaluado
 * @property string $nacionalidad_evaluado
 * @property integer $cedula_evaluado
 * @property integer $id_sexo_evaluado
 * @property string $sexo_evaluado
 * @property integer $cod_nomina_evaluado
 * @property string $cargo_evaluado
 * @property integer $fk_tipo_entidad_evaluado
 * @property integer $fk_dependencia_evaluado
 * @property string $oficina_evaluado
 * @property integer $telefono_evaluado
 * @property integer $id_persona
 * @property integer $id_evaluacion
 * @property string $periodo_desde
 * @property string $periodo_hasta
 * @property string $apellidos
 * @property string $nombres
 * @property integer $fk_nacionalidad
 * @property string $nacionalidad
 * @property integer $cedula
 * @property integer $fk_sexo
 * @property string $sexo
 * @property integer $codigo_nomina
 * @property string $descripcion_cargo
 * @property integer $fk_tipo_entidad
 * @property integer $fk_dependencia
 * @property string $dependencia
 * @property integer $telef_oficina
 * @property string $obj_funcional
 * @property integer $fk_estatus_evaluacion
 * @property string $estatus
 * @property integer $id_comentario
 * @property string $comentario
 */
class VswListarPersonas extends CActiveRecord
{
    public $total_objetivos;
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_listar_personas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona_evaluado, total_objetivos, nac_evaluado, cedula_evaluado, id_sexo_evaluado, cod_nomina_evaluado, fk_tipo_entidad_evaluado, fk_dependencia_evaluado, telefono_evaluado, id_persona, id_evaluacion, fk_nacionalidad, cedula, fk_sexo, codigo_nomina, fk_tipo_entidad, fk_dependencia, telef_oficina, fk_estatus_evaluacion, id_comentario', 'numerical', 'integerOnly'=>true),
			array('apellidos_evaluado, nombres_evaluado, apellidos, nombres', 'length', 'max'=>50),
			array('cargo_evaluado, descripcion_cargo, obj_funcional', 'length', 'max'=>200),
			array('comentario', 'length', 'max'=>500),
			array('nacionalidad_evaluado, sexo_evaluado, oficina_evaluado, periodo_desde, periodo_hasta, nacionalidad, sexo, dependencia, estatus', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona_evaluado, total_objetivos, apellidos_evaluado, nombres_evaluado, nac_evaluado, nacionalidad_evaluado, cedula_evaluado, id_sexo_evaluado, sexo_evaluado, cod_nomina_evaluado, cargo_evaluado, fk_tipo_entidad_evaluado, fk_dependencia_evaluado, oficina_evaluado, telefono_evaluado, id_persona, id_evaluacion, periodo_desde, periodo_hasta, apellidos, nombres, fk_nacionalidad, nacionalidad, cedula, fk_sexo, sexo, codigo_nomina, descripcion_cargo, fk_tipo_entidad, fk_dependencia, dependencia, telef_oficina, obj_funcional, fk_estatus_evaluacion, estatus, id_comentario, comentario', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_persona_evaluado' => 'Id Persona Evaluado',
			'apellidos_evaluado' => 'Apellidos Evaluado',
			'nombres_evaluado' => 'Nombres Evaluado',
			'nac_evaluado' => 'Nac Evaluado',
			'nacionalidad_evaluado' => 'Nacionalidad Evaluado',
			'cedula_evaluado' => 'Cedula Evaluado',
			'id_sexo_evaluado' => 'Id Sexo Evaluado',
			'sexo_evaluado' => 'Sexo Evaluado',
			'cod_nomina_evaluado' => 'Cod Nomina Evaluado',
			'cargo_evaluado' => 'Cargo Evaluado',
			'fk_tipo_entidad_evaluado' => 'Fk Tipo Entidad Evaluado',
			'fk_dependencia_evaluado' => 'Fk Dependencia Evaluado',
			'oficina_evaluado' => 'Oficina Evaluado',
			'telefono_evaluado' => 'Telefono Evaluado',
			'id_persona' => 'Id Persona',
			'id_evaluacion' => 'Id Evaluacion',
			'periodo_desde' => 'Periodo Desde',
			'periodo_hasta' => 'Periodo Hasta',
			'apellidos' => 'Apellidos',
			'nombres' => 'Nombres',
			'fk_nacionalidad' => 'Fk Nacionalidad',
			'nacionalidad' => 'Nacionalidad',
			'cedula' => 'Cedula',
			'fk_sexo' => 'Fk Sexo',
			'sexo' => 'Sexo',
			'codigo_nomina' => 'Codigo Nomina',
			'descripcion_cargo' => 'Descripcion Cargo',
			'fk_tipo_entidad' => 'Fk Tipo Entidad',
			'fk_dependencia' => 'Fk Dependencia',
			'dependencia' => 'Dependencia',
			'telef_oficina' => 'Telef Oficina',
			'obj_funcional' => 'Obj Funcional',
			'fk_estatus_evaluacion' => 'Fk Estatus Evaluacion',
			'estatus' => 'Estatus',
			'id_comentario' => 'Id Comentario',
			'comentario' => 'Comentario',
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

		$criteria->compare('id_persona_evaluado',$this->id_persona_evaluado);
		$criteria->compare('apellidos_evaluado',$this->apellidos_evaluado,true);
		$criteria->compare('nombres_evaluado',$this->nombres_evaluado,true);
		$criteria->compare('nac_evaluado',$this->nac_evaluado);
		$criteria->compare('nacionalidad_evaluado',$this->nacionalidad_evaluado,true);
		$criteria->compare('cedula_evaluado',$this->cedula_evaluado);
		$criteria->compare('id_sexo_evaluado',$this->id_sexo_evaluado);
		$criteria->compare('sexo_evaluado',$this->sexo_evaluado,true);
		$criteria->compare('cod_nomina_evaluado',$this->cod_nomina_evaluado);
		$criteria->compare('cargo_evaluado',$this->cargo_evaluado,true);
		$criteria->compare('fk_tipo_entidad_evaluado',$this->fk_tipo_entidad_evaluado);
		$criteria->compare('fk_dependencia_evaluado',$this->fk_dependencia_evaluado);
		$criteria->compare('oficina_evaluado',$this->oficina_evaluado,true);
		$criteria->compare('telefono_evaluado',$this->telefono_evaluado);
		$criteria->compare('id_persona',$this->id_persona);
		$criteria->compare('id_evaluacion',$this->id_evaluacion);
		$criteria->compare('periodo_desde',$this->periodo_desde,true);
		$criteria->compare('periodo_hasta',$this->periodo_hasta,true);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('fk_nacionalidad',$this->fk_nacionalidad);
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('fk_sexo',$this->fk_sexo);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('codigo_nomina',$this->codigo_nomina);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('fk_tipo_entidad',$this->fk_tipo_entidad);
		$criteria->compare('fk_dependencia',$this->fk_dependencia);
		$criteria->compare('dependencia',$this->dependencia,true);
		$criteria->compare('telef_oficina',$this->telef_oficina);
		$criteria->compare('obj_funcional',$this->obj_funcional,true);
		$criteria->compare('fk_estatus_evaluacion',$this->fk_estatus_evaluacion);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('id_comentario',$this->id_comentario);
		$criteria->compare('comentario',$this->comentario,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswListarPersonas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
