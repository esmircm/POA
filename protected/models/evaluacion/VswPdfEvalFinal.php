<?php

/**
 * This is the model class for table "evaluacion.vsw_pdf_eval_final".
 *
 * The followings are the available columns in table 'evaluacion.vsw_pdf_eval_final':
 * @property integer $id_persona_evaluado
 * @property integer $fk_periodo
 * @property string $periodo_evaluacion
 * @property string $n_veces
 * @property string $apellidos_evaluado
 * @property string $nombres_evaluado
 * @property integer $cedula_evaluado
 * @property integer $cod_nomina_evaluado
 * @property integer $fk_cargo_evaluado
 * @property string $cargo_evaluado
 * @property integer $grado_evaluado
 * @property string $fk_tipo_clase
 * @property string $oficina_evaluado
 * @property string $telefono_evaluado
 * @property integer $id_evaluacion
 * @property integer $id_persona_evaluador
 * @property string $apellidos_evaluador
 * @property string $nombres_evaluador
 * @property integer $cedula_evaluador
 * @property integer $cod_nomina_evaluador
 * @property integer $fk_cargo_evaluador
 * @property string $cargo_evaluador
 * @property integer $grado_evaluador
 * @property string $oficina_evaluador
 * @property string $telefono_evaluador
 * @property string $apellidos_supervisor
 * @property string $nombres_supervisor
 * @property integer $cedula_supervisor
 * @property string $cargo_supervisor
 * @property integer $total_b
 * @property string $total_c
 * @property string $total_final
 * @property integer $id_comentario
 * @property string $comentario
 * @property string $fecha_evaluacion
 * @property string $esta_conforme
 * @property integer $fk_rango_act
 * @property string $rango_actuacion
 */
class VswPdfEvalFinal extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_pdf_eval_final';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_persona_evaluado, fk_periodo, cedula_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, grado_evaluado, id_evaluacion, id_persona_evaluador, cedula_evaluador, cod_nomina_evaluador, fk_cargo_evaluador, grado_evaluador, cedula_supervisor, total_b, id_comentario, fk_rango_act', 'numerical', 'integerOnly'=>true),
			array('cargo_evaluado, cargo_evaluador, cargo_supervisor', 'length', 'max'=>60),
			array('oficina_evaluado, oficina_evaluador', 'length', 'max'=>90),
			array('telefono_evaluado, telefono_evaluador', 'length', 'max'=>15),
			array('comentario', 'length', 'max'=>1000),
			array('periodo_evaluacion, n_veces, apellidos_evaluado, nombres_evaluado, fk_tipo_clase, apellidos_evaluador, nombres_evaluador, apellidos_supervisor, nombres_supervisor, total_c, total_final, fecha_evaluacion, esta_conforme, rango_actuacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_persona_evaluado, fk_periodo, periodo_evaluacion, n_veces, apellidos_evaluado, nombres_evaluado, cedula_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, cargo_evaluado, grado_evaluado, fk_tipo_clase, oficina_evaluado, telefono_evaluado, id_evaluacion, id_persona_evaluador, apellidos_evaluador, nombres_evaluador, cedula_evaluador, cod_nomina_evaluador, fk_cargo_evaluador, cargo_evaluador, grado_evaluador, oficina_evaluador, telefono_evaluador, apellidos_supervisor, nombres_supervisor, cedula_supervisor, cargo_supervisor, total_b, total_c, total_final, id_comentario, comentario, fecha_evaluacion, esta_conforme, fk_rango_act, rango_actuacion', 'safe', 'on'=>'search'),
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
			'fk_periodo' => 'Fk Periodo',
			'periodo_evaluacion' => 'Periodo Evaluacion',
			'n_veces' => 'N Veces',
			'apellidos_evaluado' => 'Apellidos Evaluado',
			'nombres_evaluado' => 'Nombres Evaluado',
			'cedula_evaluado' => 'Cedula Evaluado',
			'cod_nomina_evaluado' => 'Cod Nomina Evaluado',
			'fk_cargo_evaluado' => 'Fk Cargo Evaluado',
			'cargo_evaluado' => 'Cargo Evaluado',
			'grado_evaluado' => 'Grado Evaluado',
			'fk_tipo_clase' => 'Fk Tipo Clase',
			'oficina_evaluado' => 'Oficina Evaluado',
			'telefono_evaluado' => 'Telefono Evaluado',
			'id_evaluacion' => 'Id Evaluacion',
			'id_persona_evaluador' => 'Id Persona Evaluador',
			'apellidos_evaluador' => 'Apellidos Evaluador',
			'nombres_evaluador' => 'Nombres Evaluador',
			'cedula_evaluador' => 'Cedula Evaluador',
			'cod_nomina_evaluador' => 'Cod Nomina Evaluador',
			'fk_cargo_evaluador' => 'Fk Cargo Evaluador',
			'cargo_evaluador' => 'Cargo Evaluador',
			'grado_evaluador' => 'Grado Evaluador',
			'oficina_evaluador' => 'Oficina Evaluador',
			'telefono_evaluador' => 'Telefono Evaluador',
			'apellidos_supervisor' => 'Apellidos Supervisor',
			'nombres_supervisor' => 'Nombres Supervisor',
			'cedula_supervisor' => 'Cedula Supervisor',
			'cargo_supervisor' => 'Cargo Supervisor',
			'total_b' => 'Total B',
			'total_c' => 'Total C',
			'total_final' => 'Total Final',
			'id_comentario' => 'Id Comentario',
			'comentario' => 'Comentario',
			'fecha_evaluacion' => 'Fecha Evaluacion',
			'esta_conforme' => 'Esta Conforme',
			'fk_rango_act' => 'Fk Rango Act',
			'rango_actuacion' => 'Rango Actuacion',
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
		$criteria->compare('fk_periodo',$this->fk_periodo);
		$criteria->compare('periodo_evaluacion',$this->periodo_evaluacion,true);
		$criteria->compare('n_veces',$this->n_veces,true);
		$criteria->compare('apellidos_evaluado',$this->apellidos_evaluado,true);
		$criteria->compare('nombres_evaluado',$this->nombres_evaluado,true);
		$criteria->compare('cedula_evaluado',$this->cedula_evaluado);
		$criteria->compare('cod_nomina_evaluado',$this->cod_nomina_evaluado);
		$criteria->compare('fk_cargo_evaluado',$this->fk_cargo_evaluado);
		$criteria->compare('cargo_evaluado',$this->cargo_evaluado,true);
		$criteria->compare('grado_evaluado',$this->grado_evaluado);
		$criteria->compare('fk_tipo_clase',$this->fk_tipo_clase,true);
		$criteria->compare('oficina_evaluado',$this->oficina_evaluado,true);
		$criteria->compare('telefono_evaluado',$this->telefono_evaluado,true);
		$criteria->compare('id_evaluacion',$this->id_evaluacion);
		$criteria->compare('id_persona_evaluador',$this->id_persona_evaluador);
		$criteria->compare('apellidos_evaluador',$this->apellidos_evaluador,true);
		$criteria->compare('nombres_evaluador',$this->nombres_evaluador,true);
		$criteria->compare('cedula_evaluador',$this->cedula_evaluador);
		$criteria->compare('cod_nomina_evaluador',$this->cod_nomina_evaluador);
		$criteria->compare('fk_cargo_evaluador',$this->fk_cargo_evaluador);
		$criteria->compare('cargo_evaluador',$this->cargo_evaluador,true);
		$criteria->compare('grado_evaluador',$this->grado_evaluador);
		$criteria->compare('oficina_evaluador',$this->oficina_evaluador,true);
		$criteria->compare('telefono_evaluador',$this->telefono_evaluador,true);
		$criteria->compare('apellidos_supervisor',$this->apellidos_supervisor,true);
		$criteria->compare('nombres_supervisor',$this->nombres_supervisor,true);
		$criteria->compare('cedula_supervisor',$this->cedula_supervisor);
		$criteria->compare('cargo_supervisor',$this->cargo_supervisor,true);
		$criteria->compare('total_b',$this->total_b);
		$criteria->compare('total_c',$this->total_c,true);
		$criteria->compare('total_final',$this->total_final,true);
		$criteria->compare('id_comentario',$this->id_comentario);
		$criteria->compare('comentario',$this->comentario,true);
		$criteria->compare('fecha_evaluacion',$this->fecha_evaluacion,true);
		$criteria->compare('esta_conforme',$this->esta_conforme,true);
		$criteria->compare('fk_rango_act',$this->fk_rango_act);
		$criteria->compare('rango_actuacion',$this->rango_actuacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswPdfEvalFinal the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
