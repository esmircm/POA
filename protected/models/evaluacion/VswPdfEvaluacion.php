<?php

/**
 * This is the model class for table "evaluacion.vsw_pdf_evaluacion".
 *
 * The followings are the available columns in table 'evaluacion.vsw_pdf_evaluacion':
 * @property integer $id_persona
 * @property integer $id_evaluacion
 * @property string $periodo_desde
 * @property string $periodo_hasta
 * @property string $apellidos
 * @property string $nombres
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $sexo
 * @property integer $cod_nomina
 * @property string $cargo
 * @property string $unidad_admtiva
 * @property string $telef_oficina
 * @property string $obj_funcional
 * @property integer $id_evaluado
 * @property string $apellidos_evaluado
 * @property string $nombres_evaluado
 * @property string $nacionalidad_evaluado
 * @property integer $cedula_evaluado
 * @property string $sexo_evaluado
 * @property integer $cod_nomina_evaluado
 * @property string $cargo_evaluado
 * @property string $dep_evaluado
 * @property string $oficina_evaluado
 * @property string $telefono_evaluado
 * @property integer $dependencia
 * @property integer $fk_entidad
 * @property integer $fk_estatus_evaluacion
 * @property string $estatus
 * @property integer $id_comentario
 * @property string $comentario
 */
class VswPdfEvaluacion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_pdf_evaluacion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona, id_evaluacion, cedula, cod_nomina, id_evaluado, cedula_evaluado, cod_nomina_evaluado, dependencia, fk_entidad, fk_estatus_evaluacion, id_comentario', 'numerical', 'integerOnly'=>true),
			array('nacionalidad, sexo, nacionalidad_evaluado, sexo_evaluado', 'length', 'max'=>1),
			array('cargo, unidad_admtiva, cargo_evaluado, oficina_evaluado', 'length', 'max'=>100),
			array('telef_oficina, telefono_evaluado', 'length', 'max'=>15),
			array('obj_funcional', 'length', 'max'=>200),
			array('dep_evaluado', 'length', 'max'=>90),
			array('comentario', 'length', 'max'=>1000),
			array('periodo_desde, periodo_hasta, apellidos, nombres, apellidos_evaluado, nombres_evaluado, estatus', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona, id_evaluacion, periodo_desde, periodo_hasta, apellidos, nombres, nacionalidad, cedula, sexo, cod_nomina, cargo, unidad_admtiva, telef_oficina, obj_funcional, id_evaluado, apellidos_evaluado, nombres_evaluado, nacionalidad_evaluado, cedula_evaluado, sexo_evaluado, cod_nomina_evaluado, cargo_evaluado, dep_evaluado, oficina_evaluado, telefono_evaluado, dependencia, fk_entidad, fk_estatus_evaluacion, estatus, id_comentario, comentario', 'safe', 'on'=>'search'),
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
			'id_persona' => 'Id Persona',
			'id_evaluacion' => 'Id Evaluacion',
			'periodo_desde' => 'Periodo Desde',
			'periodo_hasta' => 'Periodo Hasta',
			'apellidos' => 'Apellidos',
			'nombres' => 'Nombres',
			'nacionalidad' => 'Nacionalidad',
			'cedula' => 'Cedula',
			'sexo' => 'Sexo',
			'cod_nomina' => 'Cod Nomina',
			'cargo' => 'Cargo',
			'unidad_admtiva' => 'Unidad Admtiva',
			'telef_oficina' => 'Telef Oficina',
			'obj_funcional' => 'Obj Funcional',
			'id_evaluado' => 'Id Evaluado',
			'apellidos_evaluado' => 'Apellidos Evaluado',
			'nombres_evaluado' => 'Nombres Evaluado',
			'nacionalidad_evaluado' => 'Nacionalidad Evaluado',
			'cedula_evaluado' => 'Cedula Evaluado',
			'sexo_evaluado' => 'Sexo Evaluado',
			'cod_nomina_evaluado' => 'Cod Nomina Evaluado',
			'cargo_evaluado' => 'Cargo Evaluado',
			'dep_evaluado' => 'Dep Evaluado',
			'oficina_evaluado' => 'Oficina Evaluado',
			'telefono_evaluado' => 'Telefono Evaluado',
			'dependencia' => 'Dependencia',
			'fk_entidad' => 'Fk Entidad',
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

		$criteria->compare('id_persona',$this->id_persona);
		$criteria->compare('id_evaluacion',$this->id_evaluacion);
		$criteria->compare('periodo_desde',$this->periodo_desde,true);
		$criteria->compare('periodo_hasta',$this->periodo_hasta,true);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('cod_nomina',$this->cod_nomina);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('unidad_admtiva',$this->unidad_admtiva,true);
		$criteria->compare('telef_oficina',$this->telef_oficina,true);
		$criteria->compare('obj_funcional',$this->obj_funcional,true);
		$criteria->compare('id_evaluado',$this->id_evaluado);
		$criteria->compare('apellidos_evaluado',$this->apellidos_evaluado,true);
		$criteria->compare('nombres_evaluado',$this->nombres_evaluado,true);
		$criteria->compare('nacionalidad_evaluado',$this->nacionalidad_evaluado,true);
		$criteria->compare('cedula_evaluado',$this->cedula_evaluado);
		$criteria->compare('sexo_evaluado',$this->sexo_evaluado,true);
		$criteria->compare('cod_nomina_evaluado',$this->cod_nomina_evaluado);
		$criteria->compare('cargo_evaluado',$this->cargo_evaluado,true);
		$criteria->compare('dep_evaluado',$this->dep_evaluado,true);
		$criteria->compare('oficina_evaluado',$this->oficina_evaluado,true);
		$criteria->compare('telefono_evaluado',$this->telefono_evaluado,true);
		$criteria->compare('dependencia',$this->dependencia);
		$criteria->compare('fk_entidad',$this->fk_entidad);
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
	 * @return VswPdfEvaluacion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
