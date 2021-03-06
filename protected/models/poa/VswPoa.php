<?php

/**
 * This is the model class for table "poa.vsw_poa".
 *
 * The followings are the available columns in table 'poa.vsw_poa':
 * @property integer $id_poa
 * @property string $nombre
 * @property integer $fk_historico
 * @property string $obj_historico
 * @property integer $fk_nacional
 * @property string $obj_nacional
 * @property integer $fk_estrategico
 * @property string $obj_estrategico
 * @property integer $fk_general
 * @property string $obj_general
 * @property integer $fk_estrategico_mr
 * @property string $obj_estrategico_mr
 * @property integer $fk_institucional
 * @property string $obj_institucional
 * @property string $descripcion
 * @property string $fecha_inicio
 * @property string $fecha_final
 * @property integer $fk_unidad_medida
 * @property string $unidad_medida
 * @property integer $cantidad
 * @property integer $fk_tipo_poa
 * @property string $tipo_poa
 * @property integer $id_persona_responsable
 * @property string $nombres_responsable
 * @property string $apellidos_responsable
 * @property string $nacionalidad_responsable
 * @property integer $cedula_responsable
 * @property string $cargo_responsable
 * @property string $dependencia_responsable
 * @property integer $id_persona
 * @property string $nombres
 * @property string $apellidos
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $descripcion_cargo
 * @property string $dependencia
 * @property integer $codigo_dependencia
 * @property double $anio
 */
class VswPoa extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.vsw_poa';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_poa, fk_historico, fk_nacional, fk_estrategico, fk_general, fk_estrategico_mr, fk_institucional, fk_unidad_medida, cantidad, fk_tipo_poa, id_persona_responsable, cedula_responsable, id_persona, cedula, codigo_dependencia', 'numerical', 'integerOnly'=>true),
			array('anio', 'numerical'),
			array('nombre, descripcion', 'length', 'max'=>800),
			array('obj_historico, obj_nacional, obj_estrategico, obj_general, obj_estrategico_mr, obj_institucional, unidad_medida, tipo_poa', 'length', 'max'=>1000),
			array('nacionalidad_responsable, nacionalidad', 'length', 'max'=>1),
			array('cargo_responsable, descripcion_cargo', 'length', 'max'=>60),
			array('dependencia_responsable, dependencia', 'length', 'max'=>90),
			array('fecha_inicio, fecha_final, nombres_responsable, apellidos_responsable, nombres, apellidos', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_poa, nombre, fk_historico, obj_historico, fk_nacional, obj_nacional, fk_estrategico, obj_estrategico, fk_general, obj_general, fk_estrategico_mr, obj_estrategico_mr, fk_institucional, obj_institucional, descripcion, fecha_inicio, fecha_final, fk_unidad_medida, unidad_medida, cantidad, fk_tipo_poa, tipo_poa, id_persona_responsable, nombres_responsable, apellidos_responsable, nacionalidad_responsable, cedula_responsable, cargo_responsable, dependencia_responsable, id_persona, nombres, apellidos, nacionalidad, cedula, descripcion_cargo, dependencia, codigo_dependencia, anio', 'safe', 'on'=>'search'),
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
			'id_poa' => 'Id Poa',
			'nombre' => 'Nombre',
			'fk_historico' => 'Objetivo Historico',
			'obj_historico' => 'Objetivo Historico',
			'fk_nacional' => 'Objetivo Nacional',
			'obj_nacional' => 'Objetivo Nacional',
			'fk_estrategico' => 'Objetivo Estrategico',
			'obj_estrategico' => 'Objetivo Estrategico',
			'fk_general' => 'Objetivo General',
			'obj_general' => 'Objetivo General',
			'fk_estrategico_mr' => 'Objetivo Estrategico',
			'obj_estrategico_mr' => 'Objetivo Estrategico',
			'fk_institucional' => 'Objetivo Institucional',
			'obj_institucional' => 'Objetivo Institucional',
			'descripcion' => 'Descripción',
			'fecha_inicio' => 'Fecha Inicio',
			'fecha_final' => 'Fecha Final',
			'fk_unidad_medida' => 'Unidad de Medida',
			'unidad_medida' => 'Unidad de Medida',
			'cantidad' => 'Cantidad',
			'fk_tipo_poa' => 'Fk Tipo Poa',
			'tipo_poa' => 'Tipo Poa',
			'id_persona_responsable' => 'Id Persona Responsable',
			'nombres_responsable' => 'Nombres Responsable',
			'apellidos_responsable' => 'Apellidos Responsable',
			'nacionalidad_responsable' => 'Nacionalidad Responsable',
			'cedula_responsable' => 'Cedula Responsable',
			'cargo_responsable' => 'Cargo Responsable',
			'dependencia_responsable' => 'Dependencia Responsable',
			'id_persona' => 'Id Persona',
			'nombres' => 'Nombres',
			'apellidos' => 'Apellidos',
			'nacionalidad' => 'Nacionalidad',
			'cedula' => 'Cedula',
			'descripcion_cargo' => 'Descripcion Cargo',
			'dependencia' => 'Dependencia',
			'codigo_dependencia' => 'Codigo Dependencia',
			'anio' => 'Anio',
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
		$criteria->compare('fk_historico',$this->fk_historico);
		$criteria->compare('obj_historico',$this->obj_historico,true);
		$criteria->compare('fk_nacional',$this->fk_nacional);
		$criteria->compare('obj_nacional',$this->obj_nacional,true);
		$criteria->compare('fk_estrategico',$this->fk_estrategico);
		$criteria->compare('obj_estrategico',$this->obj_estrategico,true);
		$criteria->compare('fk_general',$this->fk_general);
		$criteria->compare('obj_general',$this->obj_general,true);
		$criteria->compare('fk_estrategico_mr',$this->fk_estrategico_mr);
		$criteria->compare('obj_estrategico_mr',$this->obj_estrategico_mr,true);
		$criteria->compare('fk_institucional',$this->fk_institucional);
		$criteria->compare('obj_institucional',$this->obj_institucional,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_inicio',$this->fecha_inicio,true);
		$criteria->compare('fecha_final',$this->fecha_final,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('unidad_medida',$this->unidad_medida,true);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_tipo_poa',$this->fk_tipo_poa);
		$criteria->compare('tipo_poa',$this->tipo_poa,true);
		$criteria->compare('id_persona_responsable',$this->id_persona_responsable);
		$criteria->compare('nombres_responsable',$this->nombres_responsable,true);
		$criteria->compare('apellidos_responsable',$this->apellidos_responsable,true);
		$criteria->compare('nacionalidad_responsable',$this->nacionalidad_responsable,true);
		$criteria->compare('cedula_responsable',$this->cedula_responsable);
		$criteria->compare('cargo_responsable',$this->cargo_responsable,true);
		$criteria->compare('dependencia_responsable',$this->dependencia_responsable,true);
		$criteria->compare('id_persona',$this->id_persona);
		$criteria->compare('nombres',$this->nombres,true);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('descripcion_cargo',$this->descripcion_cargo,true);
		$criteria->compare('dependencia',$this->dependencia,true);
		$criteria->compare('codigo_dependencia',$this->codigo_dependencia);
		$criteria->compare('anio',$this->anio);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswPoa the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
